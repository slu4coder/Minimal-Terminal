# Minimal Terminal 2026

This is my 'Minimal Serial UART Terminal' with a 50x30 character VGA display, PS2 keyboard readout (US, GER) and UART baudrates from 9600bps up to 500kbps. The design is based upon two ATmega328Ps and is described here: https://www.youtube.com/watch?v=jR-SqXLgBNo

<img width="659" height="520" alt="grafik" src="https://github.com/user-attachments/assets/63a6b7e5-4117-4aff-9aae-75278a1ac7fb" />

This is a free and non-commercial project. I am in no way associated with any activies selling the 'Minimal Terminal' as a product. Any such activity represents a license violation. Individual licenses apply for hardware and software parts. Please refer to the applicable documentations for detailed licensing information. 

The Minimal Terminal is now ready to be used together with the 'Minimal UART Computer 3': https://github.com/slu4coder/Minimal-UART-Computer-3

Augusto Baffa has added support for US-international keyboard map: https://github.com/abaffa/Minimal-Terminal

I use a 20MHz crystal for a 50 x 30 characters display (default). In this setup, the following baudrates are possible: 500k, 250k, 230.4, 125k, 115.2k, 39: 62.5k, 57.6k, 38.4k,  28.8k, 19.2k, 9.6k

From these, I have imlemented the following four baudrates as "selectable via jumper":

<img width="559" height="219" alt="grafik" src="https://github.com/user-attachments/assets/b69dac46-cf0f-458d-8890-93a509ee6c1c" />

Please note that per default the "1" and "2" values are pulled up, resulting in mode "3" or 125kbps. A jumper between GND and 5V *turns off* a value, respectively.

Optional (see source code for necessary modifications and baudrate possibilities):

o 16MHz crystal for a 40 x 30 characters display. 

o 24MHz crystal for a 60 x 30 characters display. Some users have reported that while older ICs
drive passive crystals at this frequency without problems, newer lots may need an active 24MHz oscillator.

See the Manual 'Minimal UART Computer 3', section 'Native Tool Chain / Terminal' for more information:
https://docs.google.com/document/d/1nIM-WRrVe7SzYY-DS1jcVHC4TCuIhlQ6LCHnZnEml7k/edit?usp=sharing

# Preparing the ATmega328 ICs

On a fresh ATmega328P, we set the low fuse byte from factory setting 0x62 (run on 8MHz internal oscillator) to
  
  ATmega328P ("I/O"): low fuse byte = 0xBF (use external oscillator, provide clock CLK0 on PB0)
  
  ATmega328P ("VGA"): low fuse byte = 0xF0 (use a provided external TTL clock)

1. Upload the sketch 'examples/ArduinoISP' into a spare Arduino Nano/Uno we’ll be using as a programmer.

2. Select 'Tools/Programmer/Arduino as ISP' (not ‘ArduinoISP’!).

On Windows: Open (or search for) the file: C:\Program Files (x86)\Arduino\hardware\arduino\avr\boards.txt

On Linux: Open (or search for) the file in a console with: sudo nano /usr/share/arduino/hardware/arduino/avr/boards.txt

3. We’ll hijack the configuration 'Arduino Nano' for our purpose:

Find the section: '## Arduino Nano w/ ATmega328P'. Change to: 'nano.menu.cpu.atmega328.bootloader.low_fuses=0xFF' and save the file (nano: Ctrl+O, Ctrl+X).

Close & reopen the Arduino IDE for the changes to become active.

Select target board: 'Arduino Nano', processor: 'AtMega328P'.

Connect the target's ISP to the programmer's ISP as shown below.

Select 'Tools/Burn bootloader' (takes ~5 seconds). Ignore errors for now. The fuse bytes are usually written as we’ve specified.

Upload the sketch into the TARGET with "Upload using Programmer", not the usual “Upload” or button.

Or use the serial upload connectors on the PCB with a breakout board if you've written a bootloader. Use a 16MHz crystal for programming.


PROGRAMMER (UNO/NANO)     TARGET (ATmega328P)

D13 (SCK) <-------------> Pin 19

D12 (MISO) <------------> Pin 18

D11 (MOSI) <------------> Pin 17

D10 (/RESET) <----------> Pin 1 <----- 10k ----> 5V

5V <--------------------> Pin 7

GND <-------------------> Pin 8

						  Pin 9 <----- 22p ----> GND

						  Pin 10 <---- 22p ----> GND

Pin 9/10: 16MHz crystal required for programming


o In case you write 0xF0 for external clock, the upload of the boot loader will not work,
	until you provide an external clock to IC pin 9.
  
o In case you write 0x62 the chip is running in factory setting (using its internal 8MHz oscillator at CPU clock 1MHz).

o In case you write 0xBF for CLK output on D8 (PB0, IC pin 14) verify with an LED and resistor.

o You can also upload a sketch into the ATmega328P with 'Sketch/Upload Using Programmer'.
