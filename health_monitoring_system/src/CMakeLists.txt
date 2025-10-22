add_executable(health_monitoring_system
    main.c
    i2c_config.c
    oled_display.c
    ssd1306_text.c
    tarefa_display_word_9.c
    numeros_display.c
    oled_animacoes.c
    numeros_medios.c
    digitos_medios_utils.c
    oled_context.c
    tarefa_led_verde.c
    tarefa_joystick_eventos.c
    dma_handlers.c
    digitos_grandes_utils.c 
    numeros_grandes.c 
    bmp280.c
    tarefa_bmp280.c
    tarefa_display_sensor.c
)

# Corrige a saída para build/ em vez de build/src/
set_target_properties(health_monitoring_system PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})

target_sources(health_monitoring_system PRIVATE
    ${FREERTOS_KERNEL_PATH}/portable/MemMang/heap_4.c
)

target_include_directories(health_monitoring_system PRIVATE
    ${CMAKE_CURRENT_LIST_DIR}
    ${CMAKE_CURRENT_LIST_DIR}/../inc

)

target_link_libraries(health_monitoring_system 
    pico_stdlib 
    FreeRTOS-Kernel
    hardware_adc
    hardware_i2c
    hardware_gpio
    hardware_dma 
    hardware_pwm 
    hardware_pio 
    hardware_clocks
)

pico_add_extra_outputs(health_monitoring_system)
