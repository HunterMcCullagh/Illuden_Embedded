This repository contains the embedded portion of our Capstone Project, with the final goal to create a dynamic lighting solution.

In this repo there are two main features, the LED Modules & the ESP32.

The LED Modules contain various light temperature LEDs, LED Drivers & an STM8S microcontroller that controls the LED drivers and acts as an I2C peripheral to receive data from the ESP32. There will be 50 modules attached at various angles on a mechanical frame to emit light in various directions. 

A screenshot of the inital prototype can be seen in the figure below, the end goal is to have all the components fit within the triangle shape.

![2D PCB](https://github.com/user-attachments/assets/bb245036-64c4-4bfe-9740-7deca733997b)

This is what the final design looked like 

![LED_board](https://github.com/user-attachments/assets/30dc1544-bf15-4e39-92e4-9ee8413e9a58)

The ESP32 in this project acts as a Bluetooth device for an iOS device to connect to with the app we are developing. Additionally, the ESP32 functions as an I2C controller that sends lighting commands to all the LED modules.
