/*
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "i2c_driver.h"
#include "adc_driver.h"

#define COMMAND_BYTE                0x00    //Position of command data
#define COMMAND_MASK                0xFF    //Byte Mask for command data
#define I2C_ADDRESS_MASK            0xFF    //Byte mask for I2C Address
#define LED_DATA_LENGTH             0x06    //length of LED data
#define LED_DATA_AND_ADDRESS_LENGTH 0x07    //length of LED data & I2C address
#define LED_DATA_BYTE_MASK          0xFF    //LED data byte mask
#define LED_DATA_2700K_POSITION     0x00    //
#define LED_DATA_5000K_POSITION     0x01    //
#define LED_DATA_6500K_POSITION     0x02    //
#define LED_DATA_RED_POSITION       0x03    //
#define LED_DATA_GREEN_POSITION     0x04    //
#define LED_DATA_BLUE_POSITION      0x05    //

#define SINGLE_WRITE_COMMAND        0x01    //Write data to single LED Module
#define MULTIPLE_WRITE_COMMAND      0x02    //Write unique data to multiple LED Modules
#define IDENTICAL_WRITE_COMMAND     0x03    //Write the same data to multiple LED Modules
#define SINGLE_READ_COMMAND         0x04    //Read the data from a single LED Module
#define FULL_READ_COMMAND           0x05    //Get the data from all the LED Modules
#define ADC_READ_COMMAND            0x06    //Get the data from the ADC


/* Attributes State Machine */
enum
{
    IDX_SVC,

    IDX_CHAR_READ,
    IDX_CHAR_VAL_READ,

    IDX_CHAR_WRITE,
    IDX_CHAR_VAL_WRITE,

    HRS_IDX_NB,
};

void process_app_data(uint8_t data[],int data_size);