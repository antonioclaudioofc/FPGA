// Mostra temperatura e pressão lidas pelo BMP280 no OLED
#include "tarefa_display_sensor.h"
#include "oled_display.h"
#include "pico/stdlib.h"
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include <stdio.h>

// Contexto compartilhado
extern ssd1306_t oled;
extern SemaphoreHandle_t mutex_oled;

// Valores produzidos pela tarefa do BMP280
extern float g_temp_c;
extern float g_press_kpa;

static void tarefa_display_sensor(void *pvParameters)
{
    (void)pvParameters;
    char linha1[32], linha2[32];

    for (;;)
    {
        // Monta strings a partir dos valores globais
        snprintf(linha1, sizeof(linha1), "Temp: %.2f C", g_temp_c);
        snprintf(linha2, sizeof(linha2), "Press: %.2f kPa", g_press_kpa);

        // Debug: mostra o que será desenhado
        printf("DISPLAY -> '%s' | '%s'\n", linha1, linha2);

        // Atualiza o OLED protegido pelo mutex
        if (xSemaphoreTake(mutex_oled, portMAX_DELAY) == pdTRUE)
        {
            oled_clear(&oled);
            ssd1306_draw_string(oled.ram_buffer, 0, 0, linha1, OLED_WIDTH, OLED_HEIGHT);
            ssd1306_draw_string(oled.ram_buffer, 0, 16, linha2, OLED_WIDTH, OLED_HEIGHT);
            oled_render(&oled);
            xSemaphoreGive(mutex_oled);
        }

        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}

void criar_tarefa_display_sensor(UBaseType_t prio, UBaseType_t core_mask)
{
    TaskHandle_t th = NULL;
    BaseType_t ok = xTaskCreate(tarefa_display_sensor, "DISP_SENS", 1024, NULL, prio, &th);
    configASSERT(ok == pdPASS);
    vTaskCoreAffinitySet(th, core_mask);
}
