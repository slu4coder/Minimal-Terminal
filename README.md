# Minimal-Terminal
Minimal serial UART terminal with VGA and PS2 for up to 230400bps based upon ATmega328P.

This little gadget it ideally suited to be used together with the 'Minimal UART CPU System': https://github.com/slu4coder/Minimal-UART-CPU-System

EDIT: Augusto Baffa has added support for US-international keyboard map: https://github.com/abaffa/Minimal-Terminal

EDIT: Please note that this design makes use of overclocking the ATmega328P to 24MHz. Users have reported that while older ICs
      drive passive crystals at this frequency without any problems, newer lots may need an active 24MHz oscillator.

See the manual section 'Native Tool Chain / Terminal' for more information:
https://docs.google.com/document/d/1c2ZHtLd1BBAwcBAjBZZJmCA3AXpbpv80dlAtsMYpuF4/edit?usp=sharing
