# Minimal Terminal

UPDATE: Minimal serial UART terminal with 50x30 character VGA and PS2 and bitrates up to 500000bps based upon 2xATmega328P.
This little gadget is ideally suited to be used together with the 'Minimal UART Computer 3': https://github.com/slu4coder/Minimal-UART-Computer-3
Augusto Baffa has added support for US-international keyboard map: https://github.com/abaffa/Minimal-Terminal

Use a 20MHz crystal for a 50 x 30 characters display (default).
Optional (see source code for necessary modifications).
Use a 16MHz crystal for a 40 x 30 characters display.
Use a 24MHz crystal for a 60 x 30 characters display (see code for necessary modifications). Some users have reported that while older ICs
drive passive crystals at this frequency without problems, newer lots may need an active 24MHz oscillator.

See the Manual 'Minimal UART Computer 3', section 'Native Tool Chain / Terminal' for more information:
https://docs.google.com/document/d/1nIM-WRrVe7SzYY-DS1jcVHC4TCuIhlQ6LCHnZnEml7k/edit?usp=sharing
