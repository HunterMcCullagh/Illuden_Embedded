#include <stdio.h>
#include <driver/i2c.h>
#include <string.h>
#include "i2c_driver.h"


#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#define I2C_MASTER_NUM I2C_NUM_0        // I2C port number
#define I2C_MASTER_SCL_IO 9           // GPIO for SCL was 19
#define I2C_MASTER_SDA_IO 8           // GPIO for SDA was 18
#define I2C_MASTER_FREQ_HZ 100000      // Frequency in Hz (100 kHz standard)
#define I2C_MASTER_TX_BUF_DISABLE 0    // Disable transmit buffer
#define I2C_MASTER_RX_BUF_DISABLE 0    // Disable receive buffer

#include "driver/gpio.h"

void configure_i2c_drive_strength() {
    gpio_set_drive_capability(I2C_MASTER_SDA_IO, GPIO_DRIVE_CAP_3); // Maximum drive strength
    gpio_set_drive_capability(I2C_MASTER_SCL_IO, GPIO_DRIVE_CAP_3); // Maximum drive strength
}


// Function to initialize the I2C driver
void i2c_master_init() {
    i2c_config_t i2c_conf = {
        .mode = I2C_MODE_MASTER,
        .sda_io_num = I2C_MASTER_SDA_IO,
        .sda_pullup_en = GPIO_PULLUP_ENABLE,
        .scl_io_num = I2C_MASTER_SCL_IO,
        .scl_pullup_en = GPIO_PULLUP_ENABLE,
        .master.clk_speed = I2C_MASTER_FREQ_HZ,
    };
    ESP_ERROR_CHECK(i2c_param_config(I2C_MASTER_NUM, &i2c_conf));
    ESP_ERROR_CHECK(i2c_driver_install(I2C_MASTER_NUM, i2c_conf.mode,
                                       I2C_MASTER_RX_BUF_DISABLE,
                                       I2C_MASTER_TX_BUF_DISABLE, 0));
}

// Function to scan for I2C peripherals
void i2c_scan() {
    printf("Scanning for I2C devices...\n");
    for (uint8_t addr = 1; addr < 127; addr++) {
        i2c_cmd_handle_t cmd = i2c_cmd_link_create();
        i2c_master_start(cmd);
        i2c_master_write_byte(cmd, (addr << 1) | I2C_MASTER_WRITE, true);
        i2c_master_stop(cmd);

        esp_err_t ret = i2c_master_cmd_begin(I2C_MASTER_NUM, cmd, pdMS_TO_TICKS(500));
        i2c_cmd_link_delete(cmd);

        if (ret == ESP_OK) {
            printf("Device found at address 0x%02X\n", addr);
        }
    }
    printf("I2C scan completed.\n");
}

esp_err_t LEDWriteRegs(uint8_t addr, uint8_t *data, size_t len)
{
    uint8_t writeBuf[len];  // First byte is the starting register
    memcpy(&writeBuf[0], data, len);

    return i2c_master_write_to_device(I2C_MASTER_NUM, addr, writeBuf, len, 1000);
}