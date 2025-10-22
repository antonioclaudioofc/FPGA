#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include "FreeRTOS.h"
#include "task.h"
#include <stdio.h>

#include "bmp280.h"
#include "tarefa_bmp280.h"

// Variáveis globais (compartilhadas com o display)
float g_temp_c = 0.0f;
float g_press_kpa = 0.0f;

void tarefa_bmp280(void *params)
{
    (void)params;

    i2c_init(I2C_PORT, 100 * 1000);
    gpio_set_function(I2C_SDA_PIN, GPIO_FUNC_I2C);
    gpio_set_function(I2C_SCL_PIN, GPIO_FUNC_I2C);
    gpio_pull_up(I2C_SDA_PIN);
    gpio_pull_up(I2C_SCL_PIN);

    bmp280_init();

    struct bmp280_calib_param calib;
    bmp280_get_calib_params(&calib);

    int32_t raw_temp, raw_press;

    const TickType_t delay = pdMS_TO_TICKS(1000); // 1 segundo

    for (;;)
    {
        bmp280_read_raw(&raw_temp, &raw_press);

        int32_t temp_cx100 = bmp280_convert_temp(raw_temp, &calib);
        int32_t press_pa = bmp280_convert_pressure(raw_press, raw_temp, &calib);

    g_temp_c = temp_cx100 / 100.0f;
    g_press_kpa = press_pa / 1000.0f;

    // Debug: imprime leituras
    printf("BMP280 -> Temp: %.2f C, Press: %.2f kPa\n", g_temp_c, g_press_kpa);

        vTaskDelay(delay);
    }
}

void criar_tarefa_bmp280(UBaseType_t prio, UBaseType_t core_mask)
{
    TaskHandle_t th = NULL;
    BaseType_t ok = xTaskCreate(tarefa_bmp280, "BMP280", 1024, NULL, prio, &th);
    configASSERT(ok == pdPASS);
    vTaskCoreAffinitySet(th, core_mask);
}
