#include <stdio.h>
#include <stdbool.h>

#include "pico/stdlib.h"
#include "pico/stdio_usb.h"

#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"

// ==== OLED ====
#include "oled_display.h"
#include "oled_context.h"

// ==== Sensor ====
#include "tarefa_bmp280.h"
#include "tarefa_display_sensor.h"

// ==== Núcleos ====
#define CORE0_MASK ((UBaseType_t)(1u << 0))
#define CORE1_MASK ((UBaseType_t)(1u << 1))

// ==== Prioridades ====
#define PRIO_SENSOR (tskIDLE_PRIORITY + 2)
#define PRIO_DISPLAY (tskIDLE_PRIORITY + 1)

// ==== Mutex global para OLED ====
// Definido em oled_context.c e declarado em oled_context.h
// Apenas referenciado aqui
extern SemaphoreHandle_t mutex_oled;

int main(void)
{
    stdio_init_all();
    // Aguarda brevemente conexão USB para logs aparecerem (timeout ~2s)
    {
        const uint32_t start = to_ms_since_boot(get_absolute_time());
        while (!stdio_usb_connected())
        {
            if ((to_ms_since_boot(get_absolute_time()) - start) > 2000) break;
            tight_loop_contents();
        }
    }

    printf("=== INICIANDO SISTEMA: SENSOR BMP280 + OLED ===\n");

    // Inicializa OLED
    if (!oled_init(&oled))
    {
        printf("Falha ao inicializar OLED!\n");
        while (true)
        {
            tight_loop_contents();
        }
    }

    // Cria mutex de proteção de display
    mutex_oled = xSemaphoreCreateMutex();
    configASSERT(mutex_oled != NULL);

    // Cria tarefas
    criar_tarefa_bmp280(PRIO_SENSOR, CORE0_MASK);
    criar_tarefa_display_sensor(PRIO_DISPLAY, CORE1_MASK);

    // Inicia agendador
    vTaskStartScheduler();

    // Nunca deve chegar aqui
    while (true)
    {
        tight_loop_contents();
    }
}
