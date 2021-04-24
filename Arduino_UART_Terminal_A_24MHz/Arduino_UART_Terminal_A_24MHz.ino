/**************************************************************************************
  *****                                                                           *****
  ***** Atmega328P UART & PS/2 Terminal Interface written by Carsten Herting 2021 *****
  *****                                                                           *****
  *************************************************************************************
  This Atmega328P reads serial data from it's UART RX and transfers it to the 2nd
  ATmega328P handling VGA. PS/2 data is converted into ASCII and sent away via UART TX.
  C0-C3: UART SPEED SCALER
  C4: PS/2 clock input, triggers a pin change interrupt
  C5: PS/2 dtat input, sampled at the rising edge of the PS/2 clock
  D0,1: UART RX, TX
  D2-7: bits 0-5 of transfer output to C0-5
  B0,1: bits 6-7 of transfer output to D6-7 via 1k resistors
  B2: DATA_NEW output to B0 input of 2nd µC
  See license at the end of this file.
*/

volatile byte ps2_scan = 0;                     // holds valid PS/2 scancode (set this to 0 after processing!)
const byte LookupScanToASCII[3][128] PROGMEM =  // lookup table (in: SHIFT/ALTGR keystate and PS/2 scancode, out: ASCII code)
{ 
  { 0,0,0,0,0,0,0,0,         0,0,0,0,0,9,94,0,         0,0,0,0,0,113,49,0,       0,0,121,115,97,119,50,0,     // w/o SHIFT or ALT(GR)
    0,99,120,100,101,52,51,0,0,32,118,102,116,114,53,0,0,110,98,104,103,122,54,0,0,0,109,106,117,55,56,0,
    0,44,107,105,111,48,57,0,0,46,45,108,0,112,0,0,    0,0,0,0,0,96,0,0,         0,0,10,43,0,35,0,0,
    0,60,0,0,0,0,8,0,        0,0,0,19,0,0,0,0,         0,0,18,0,20,17,27,0,      0,0,0,0,0,0,0,0          },
  { 0,0,0,0,0,0,0,0,         0,0,0,0,0,0,248,0,        0,0,0,0,0,81,33,0,        0,0,89,83,65,87,34,0,        // with SHIFT
    0,67,88,68,69,36,0,0,    0,0,86,70,84,82,37,0,     0,78,66,72,71,90,38,0,    0,0,77,74,85,47,40,0,
    0,59,75,73,79,61,41,0,   0,58,95,76,0,80,63,0,     0,0,0,0,0,0,0,0,          0,0,0,42,0,39,0,0,
    0,62,0,0,0,0,0,0,        0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0          },
  { 0,0,0,0,0,0,0,0,         0,0,0,0,0,0,0,0,          0,0,0,0,0,64,0,0,         0,0,0,0,0,0,0,0,             // with ALT(GR)
    0,0,0,0,0,0,0,0,         0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0,          0,0,0,0,0,123,91,0,
    0,0,0,0,0,125,93,0,      0,0,0,0,0,0,92,0,         0,0,0,0,0,0,0,0,          0,0,0,126,0,0,0,0,
    0,124,0,0,0,0,0,0,       0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0          }
};
  
void setup()
{
  DDRC = 0b00000000;       // C4-5: input CLK und DAT of PS/2 keyboard
  PORTC = 0b00001111;      // 20k pull-ups ON
  DDRB = 0b00000111;       // B0-1: transfer bits 6-7, B2: DATA_NEW output, B5: DATA_ACK input
  PORTB = 0;
  DDRD = 0b11111100;       // D0-1: UART RX/TX, D2-7: transfers bits 0-5
  PORTD = 0;
  noInterrupts();
    PCICR  |= 0b00000010;  // enable Port C 0b10 PCINT1
    PCMSK1 |= 0b00010000;  // input pin C4 (PS/2 CLK) löst PCI aus
  interrupts();   

  Serial.begin(230400, SERIAL_8N2);    // @24MHz 230400 can exactly be reached!
  int rate[4] = { 103, 51, 25, 12 };  
  bitWrite(UCSR0A, 1, HIGH);// switch off UART rate multiplier
  UBRR0 = rate[PINC & 0b00000011];
}

void loop()
{
  if (Serial.available())
  {
    byte a = Serial.read();
    PORTD = (a << 2);                          // D2-7 hold bits 0-5
    PORTB = ((PORTB & 0b00000100) ^ 0b00000100) | (a >> 6); // B0-1 hold bits 6-7, toggle B2
  }
  
  if (ps2_scan != 0)                           // check for PS2 input
  {    
    byte scan = ps2_scan; ps2_scan = 0;        // take the PS2 scan result and clear it
    static bool alt = false;                   // state of some important keys of the PS2 keyboard
    static bool shift = false;
    static bool released = false;              // indicating that the next key counts as 'released'

    switch (scan)
    {
      case 17: alt = !released; released = false; break;             // ALT, ALTGR
      case 18: case 89: shift = !released; released = false; break;  // SHIFT LEFT, SHIFT RIGHT     
      case 240: released = true; break;                              // key release indicator
      default:                                                       // PROCESS ANY OTHER KEYS
        if (released == true) released = false;                      // ignore released keys
        else                                                         // key was pressed
        {
          byte s=0; if (shift) s = 1; else if (alt) s = 2;           // select bank of lookup according the states of special keys
          char p = pgm_read_byte(&LookupScanToASCII[s][scan & 127]);
          if (p != 0) Serial.print(p);
        }
        break;
    }  
  }  
}

ISR(PCINT1_vect)
{  
  static uint16_t dat = 0;                        // shift the received bits from PS/2 keyboard in
  static uint8_t clk = 0;
  static uint32_t last = 0;
  if (bitRead(PINC, 4) == HIGH)                   // sampling keyboard data at the rising edge of the PS/2 clock                    
  {
    if (clk < 11)                                 // wait for an entire PS2 datum (start, stop, parits, 8 data bits)
    {
      uint32_t t = micros();
      if (t - last > 200) clk = 0;                // count from zero after a longer pause
      last = t;
      dat = dat>>1;                               // shift existing bits to the right
      if (bitRead(PINC, 5)) dat |= 0b10000000000;
      clk++;                                      // count the received bits
      if (clk == 11) { ps2_scan = byte(dat>>1); clk = 0; }   // full datum has been received => strip start, stop parity and store it
    }
  }
}

/*
-----------
MIT License
-----------
Copyright (c) 2021 Carsten Herting
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
