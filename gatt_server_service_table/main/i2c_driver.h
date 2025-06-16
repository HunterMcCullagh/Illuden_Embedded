#ifndef I2C_DRIVER_H
#define I2C_DRIVER_H
#include <stdint.h>  // For uint8_t


void i2c_master_init(void);
void i2c_scan(void);
esp_err_t LEDWriteRegs(uint8_t addr, uint8_t *data, size_t len);


#endif