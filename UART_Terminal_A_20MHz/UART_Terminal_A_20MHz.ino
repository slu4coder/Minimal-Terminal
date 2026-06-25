/**************************************************************************************
  *****                                                                           *****
  ***** ATmega328P UART & PS/2 Terminal Interface written by Carsten Herting 2021 *****
  *****                 Version 2.3 (original release: 02.06.2021)                *****
  ***** 21.08.2025: Added more baudrate options for 24/20/16MHz crystals          *****
  ***** 25.06.2026: Use default 20MHz crystal for use with Minimal UART CPU 3     *****
  *****                                                                           *****                                                                           
  *************************************************************************************
  This Atmega328P reads serial data from it's UART RX and transfers it to the 2nd
  ATmega328P handling VGA. PS/2 data is converted into ASCII and sent via UART TX.
  Set the fuse byte from 0xFF to 0xF0 to use an external TTL clock (provided by B).
  C0-C3: UART SPEED SCALER
  C4: PS/2 clock input, triggers a pin change interrupt
  C5: PS/2 dtat input, sampled at the rising edge of the PS/2 clock
  D0,1: UART RX, TX
  D2-7: bits 0-5 of transfer output to C0-5
  B0,1: bits 6-7 of transfer output to D6-7 via 1k resistors
  B2: DATA_NEW output to B0 input of 2nd µC
  See license at the end of this file.
*/

volatile byte ps2_scan = 0; // holds valid PS/2 scancode (set this to 0 after processing!)

const byte LookupScanToASCII[4 * 128] PROGMEM = // lookup table (in: PS/2 scancode, out: ASCII code)
{ 
/*
  0,0,0,0,0,0,0,0,          0,0,0,0,0,0,94,0,           0,0,0,0,0,113,49,0,         0,0,121,115,97,119,50,0,     // plain key
  0,99,120,100,101,52,51,0, 0,32,118,102,116,114,53,0,  0,110,98,104,103,122,54,0,  0,0,109,106,117,55,56,0,
  0,44,107,105,111,48,57,0, 0,46,45,108,0,112,0,0,      0,0,0,0,0,96,0,0,           0,0,10,43,0,35,0,0,
  0,60,0,0,0,0,8,0,         0,0,0,0,0,0,0,0,            0,127,0,0,0,0,27,0,         0,0,0,0,0,0,0,0,
  
  0,0,0,0,0,0,0,0,          0,0,0,0,0,0,248,0,          0,0,0,0,0,81,33,0,          0,0,89,83,65,87,34,0,        // with SHIFT
  0,67,88,68,69,36,0,0,     0,0,86,70,84,82,37,0,       0,78,66,72,71,90,38,0,      0,0,77,74,85,47,40,0,
  0,59,75,73,79,61,41,0,    0,58,95,76,0,80,63,0,       0,0,0,0,0,0,0,0,            0,0,0,42,0,39,0,0,
  0,62,0,0,0,0,0,0,         0,0,0,0,0,0,0,0,            0,0,0,0,0,0,0,0,            0,0,0,0,0,0,0,0,
  
  0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0,            0,0,0,0,0,64,0,0,           0,0,0,0,0,0,0,0,             // with ALT(GR)
  0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0,            0,0,0,0,0,0,0,0,            0,0,0,0,0,123,91,0,
  0,0,0,0,0,125,93,0,       0,0,0,0,0,0,92,0,           0,0,0,0,0,0,0,0,            0,0,0,126,0,0,0,0,
  0,124,0,0,0,0,0,0,        0,0,0,0,0,0,0,0,            0,0,0,0,0,0,0,0,            0,0,0,0,0,0,0,0,
  
  0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0,            0,0,0,0,0,0x11,0,0,         0,0,0,0x13,0x01,0,0,0,       // with CTRL(Strg)
  0,0x03,0x18,0,0,0,0,0,    0,0,0x16,0,0,0,0,0,         0,0x0e,0,0,0,0x1a,0,0,      0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,          0,0,0,0x0c,0,0,0,0,         0,0,0,0,0,0,0,0,            0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,          0,0,0,0,0,0,0,0,            0,0,0,0,0,0,0,0,            0,0,0,0,0,0,0,0,
*/

// US KEYBOARD LAYOUT (update sections 'PLAIN keys' and 'with SHIFT' for GERMAN KEYBOARD LAYOUT as shown below)

      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 0x09,    0,    0, // 0x0_ PLAIN keys
      0,    0,    0,    0,    0,  'q',  '1',    0,    0,    0,  'z',  's',  'a',  'w',  '2',    0, // 0x1_
      0,  'c',  'x',  'd',  'e',  '4',  '3',    0,    0,  ' ',  'v',  'f',  't',  'r',  '5',    0, // 0x2_
      0,  'n',  'b',  'h',  'g',  'y',  '6',    0,    0,    0,  'm',  'j',  'u',  '7',  '8',    0, // 0x3_
      0,  ',',  'k',  'i',  'o',  '0',  '9',    0,    0,  '.',  '/',  'l',  ';',  'p',  '-',    0, // 0x4_
      0,    0, '\'',    0,  '[',  '=',    0,    0,    0,    0,   10,  ']',    0, '\\',    0,    0, // 0x5_
      0,  '<',    0,    0,    0,    0,    8,    0,    0, 0xe6,    0, 0xe3, 0xe5,    0,    0,    0, // 0x6_
      0, 0xf0, 0xe2,    0, 0xe4, 0xe1,   27,    0,    0,    0, 0xe8,    0,    0, 0xe7,    0,    0, // 0x7_
// -------------------------------------------------------------------------------------------------------
// 0x_0  0x_1  0x_2  0x_3  0x_4  0x_5  0x_6  0x_7  0x_8  0x_9  0x_a  0x_b  0x_c  0x_d  0x_e  0x_f  // scan code

      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  '~',    0, // 0x0_ with SHIFT
      0,    0,    0,    0,    0,  'Q',  '!',    0,    0,    0,  'Z',  'S',  'A',  'W',  '@',    0, // 0x1_
      0,  'C',  'X',  'D',  'E',  '$',  '#',    0,    0,    0,  'V',  'F',  'T',  'R',  '%',    0, // 0x2_
      0,  'N',  'B',  'H',  'G',  'Y',  '^',    0,    0,    0,  'M',  'J',  'U',  '&',  '*',    0, // 0x3_
      0,  '<',  'K',  'I',  'O',  ')',  '(',    0,    0,  '>',  '?',  'L',  ':',  'P',  '_',    0, // 0x4_
      0,    0,  '"',    0,  '{',  '+',    0,    0,    0,    0,    0,  '}',    0,  '|',    0,    0, // 0x5_
      0,  '>',    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x6_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x7_
// -------------------------------------------------------------------------------------------------------
// 0x_0  0x_1  0x_2  0x_3  0x_4  0x_5  0x_6  0x_7  0x_8  0x_9  0x_a  0x_b  0x_c  0x_d  0x_e  0x_f  // scan code

      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x0_ with ALTGR(=ALT)
      0,    0,    0,    0,    0,  '@',    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x1_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x2_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  '{',  '[',    0, // 0x3_
      0,    0,    0,    0,    0,  '}',  ']',    0,    0,    0,    0,    0,    0,    0, '\\',    0, // 0x4_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  '~',    0,    0,    0,    0, // 0x5_
      0,  '|',    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x6_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x7_
// -------------------------------------------------------------------------------------------------------
// 0x_0  0x_1  0x_2  0x_3  0x_4  0x_5  0x_6  0x_7  0x_8  0x_9  0x_a  0x_b  0x_c  0x_d  0x_e  0x_f  // scan code

      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x0_ with CTRL(=STRG)       
      0,    0,    0,    0,    0, 0x11,    0,    0,    0,    0,    0, 0x13, 0x01,    0,    0,    0, // 0x1_
      0, 0x03, 0x18,    0,    0,    0,    0,    0,    0,    0, 0x16,    0, 0x14, 0x12,    0,    0, // 0x2_
      0, 0x0e,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x3_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 0x0c,    0,    0,    0,    0, // 0x4_         
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x5_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x6_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x7_
// -------------------------------------------------------------------------------------------------------
// 0x_0  0x_1  0x_2  0x_3  0x_4  0x_5  0x_6  0x_7  0x_8  0x_9  0x_a  0x_b  0x_c  0x_d  0x_e  0x_f  // scan code

/*
// GERMAN KEYBOARD LAYOUT (update sections 'PLAIN keys' and 'with SHIFT' with this code)

      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, 0x09,  '^',    0, // 0x0_ PLAIN keys
      0,    0,    0,    0,    0,  'q',  '1',    0,    0,    0,  'y',  's',  'a',  'w',  '2',    0, // 0x1_
      0,  'c',  'x',  'd',  'e',  '4',  '3',    0,    0,  ' ',  'v',  'f',  't',  'r',  '5',    0, // 0x2_
      0,  'n',  'b',  'h',  'g',  'z',  '6',    0,    0,    0,  'm',  'j',  'u',  '7',  '8',    0, // 0x3_
      0,  ',',  'k',  'i',  'o',  '0',  '9',    0,    0,  '.',  '-',  'l',    0,  'p',    0,    0, // 0x4_
      0,    0,    0,    0,    0,'\\'',    0,    0,    0,    0,   10,  '+',    0,  '#',    0,    0, // 0x5_
      0,  '<',    0,    0,    0,    0,    8,    0,    0, 0xe6,    0, 0xe3, 0xe5,    0,    0,    0, // 0x6_
      0, 0xf0, 0xe2,    0, 0xe4, 0xe1,   27,    0,    0,    0, 0xe8,    0,    0, 0xe7,    0,    0, // 0x7_
// -------------------------------------------------------------------------------------------------------
// 0x_0  0x_1  0x_2  0x_3  0x_4  0x_5  0x_6  0x_7  0x_8  0x_9  0x_a  0x_b  0x_c  0x_d  0x_e  0x_f  // scan code

      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x0_ with SHIFT
      0,    0,    0,    0,    0,  'Q',  '!',    0,    0,    0,  'Y',  'S',  'A',  'W',  '"',    0, // 0x1_
      0,  'C',  'X',  'D',  'E',  '$',    0,    0,    0,    0,  'V',  'F',  'T',  'R',  '%',    0, // 0x2_
      0,  'N',  'B',  'H',  'G',  'Z',  '&',    0,    0,    0,  'M',  'J',  'U',  '/',  '(',    0, // 0x3_
      0,  ';',  'K',  'I',  'O',  '=',  ')',    0,    0,  ':',  '_',  'L',    0,  'P',  '?',    0, // 0x4_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,  '*',    0,   39,    0,    0, // 0x5_
      0,  '>',    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x6_
      0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,    0, // 0x7_
// -------------------------------------------------------------------------------------------------------
// 0x_0  0x_1  0x_2  0x_3  0x_4  0x_5  0x_6  0x_7  0x_8  0x_9  0x_a  0x_b  0x_c  0x_d  0x_e  0x_f  // scan code
*/

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

  // 24MHz crystal -> 5: 500k, 11: 250k, 12: 230.4k, 23: 125k, 25: 115.2k, 47: 62.5k, 51: 57.6k, 77: 38.4k, 103: 28.8k, 155: 19.2k, 312: 9.6k
  // 20MHz crystal -> 4: 500k,  9: 250k,(10:230.4k), 19: 125k,(21:115.2k), 39: 62.5k,(42:57.6k), 64: 38.4k,  86: 28.8k, 129: 19.2k, 259: 9.6k
  // 16MHz crystal -> 3: 500k,  7: 250k, ----------, 15: 125k, ----------, 31: 62.5k, 34: 57.6k, 51: 38.4k,  68: 28.8k, 103: 19.2k, 207: 9.6k

  Serial.begin(250000, SERIAL_7N2);             // for 20MHz crystal (bit rate will be set correctly later)
  const uint16_t rate[8] = { 259, 86, 39, 19 }; // 9.6k, 38.4k, 62.5k, 125k
  bitWrite(UCSR0A, U2X0, 1); // enable double-speed (divider = 8)
  UBRR0 = rate[PINC & 0b00000011];              // set the bit rate
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
    static bool ALT = false;                   // state of some important keys of the PS2 keyboard
    static bool SHIFT = false;
    static bool CTRL = false;
    static bool released = false;              // indicating that the next key counts as 'released'
    switch (scan)
    {
      case 17: ALT = !released; released = false; break;             // ALT, ALTGR
      case 18: case 89: SHIFT = !released; released = false; break;  // SHIFT LEFT, SHIFT RIGHT     
      case 20: CTRL = !released; released = false; break;            // CTRL LEFT, CTRL RIGHT
      case 240: released = true; break;                              // key release indicator
      default:                                                       // PROCESS ANY OTHER KEYS
      {
        if (released == true) released = false;                      // ignore released keys
        else                                                         // key was pressed
        {
          switch (scan)
          {
            case 117: Serial.print("\e[A"); break; // cursor up
            case 114: Serial.print("\e[B"); break; // cursor down
            case 116: Serial.print("\e[C"); break; // cursor right              
            case 107: Serial.print("\e[D"); break; // cursor left
            case 108: Serial.print("\e[1~"); break; // pos1 / home
            case 105: Serial.print("\e[4~"); break; // end
            case 125: Serial.print("\e[5~"); break; // page up
            case 122: Serial.print("\e[6~"); break; // page dn        
            case 13: Serial.print("  "); break; // TAB = 2 SPACES
            default:
            {
              // select start index of lookup table according to the states of the special keys
              int start=0; if (SHIFT) start = 128; else if (ALT) start = 256; else if (CTRL) start = 384;
              
              char p = pgm_read_byte(&LookupScanToASCII[start + (scan & 127)]);
              if (p != 0) Serial.print(p);
            }            
          }
        }
        break;
      }
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
  Copyright (c) 2025, 2026 Carsten Herting (slu4)
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
