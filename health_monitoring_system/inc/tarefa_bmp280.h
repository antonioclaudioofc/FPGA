#ifndef TAREFA_BMP280_H
#define TAREFA_BMP280_H

#include "FreeRTOS.h"

extern float g_temp_c;
extern float g_press_kpa;

void criar_tarefa_bmp280(UBaseType_t prio, UBaseType_t core_mask);

#endif
