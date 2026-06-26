# UPDATE 2026: Minimal Terminal

<img width="659" height="520" alt="grafik" src="https://github.com/user-attachments/assets/63a6b7e5-4117-4aff-9aae-75278a1ac7fb" />

This is my 'Minimal Serial UART Terminal' with a 50x30 character VGA display, PS2 keyboard readout (US, GER) and UART bitrates up to 500kbps. The design is based upon 2xATmega328P and is described here: https://www.youtube.com/watch?v=jR-SqXLgBNo

This little gadget is now ideally suited to be used together with the 'Minimal UART Computer 3': https://github.com/slu4coder/Minimal-UART-Computer-3

Augusto Baffa has added support for US-international keyboard map: https://github.com/abaffa/Minimal-Terminal

Use a 20MHz crystal for a 50 x 30 characters display (default). The following baudrates are possible: 500k, 250k, 230.4, 125k, 115.2k, 39: 62.5k, 57.6k, 38.4k,  28.8k, 19.2k, 9.6k

From these, I have imlemented the following four baudrates as "selectable via jumper":

<img width="559" height="219" alt="grafik" src="https://github.com/user-attachments/assets/f1b360b0-aacc-482a-9ef2-7cb0e383012c" />

Please note that per default the "1" and "2" values are pulled up, resulting in the 3: 125kbps mode. A jumper between GND and 5V *turns off* a value, respectively.

Optional (see source code for necessary modifications and baudrate possibilities):

o 16MHz crystal for a 40 x 30 characters display. 

o 24MHz crystal for a 60 x 30 characters display. Some users have reported that while older ICs
drive passive crystals at this frequency without problems, newer lots may need an active 24MHz oscillator.

See the Manual 'Minimal UART Computer 3', section 'Native Tool Chain / Terminal' for more information:
https://docs.google.com/document/d/1nIM-WRrVe7SzYY-DS1jcVHC4TCuIhlQ6LCHnZnEml7k/edit?usp=sharing
