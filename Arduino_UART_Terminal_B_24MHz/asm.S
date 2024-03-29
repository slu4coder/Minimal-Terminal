// ***************************************************************************
// *****                                                                 *****
// ***** AtMega328P UART ANSI Terminal with 60x25 Character VGA and PS/2 *****
// *****                                                                 *****
// *****        written by Carsten Herting 24.03.2021 Version 2.1        *****
// *****                                                                 *****
// ***************************************************************************
// Pin C0-5: terminal input bits 0-5
// Pin D0-7: parallel pixel output to 74166, in between: D6-7 terminal input bits 6-7
// Pin B0:   CLKO ATmega328 system clock output
// Pin B1:   DATA_NEW input handshake
// Pin B2:   /VSYNC VGA (timer1, every 1/60s, could also be done)
// Pin B3:   /PE low pulse (by hand inside ISR for 74166 /PE pixel shift register sync parallel load)
// Pin B4:   /HSYNC VGA (by hand inside ISR, every 32µs)
// Pin B5:   DATA_ACK output handshake
// See license at the end of this file.

#define WIDTH         60
#define HEIGHT        25

#define __SFR_OFFSET  0x00      // set the Special Function Register Offset from 0x20 to 0x00 in order to use the AVR PORT definitions
#include <avr/io.h>             // include PORTB, DDRD, ... symbols for easier register access

.global TIMER0_COMPA_vect       ; define this global to make the Arduino IDE integrate the ISR

.macro ONECHAR                  ;     Z: address of char data (MSB is fixed, LSB depends on char), X: current VRAM position (one line)
            ld    ZL, X+        ; 2   ZL = (X), X = X + 1
            lpm   r21, Z        ; 3   get font byte from program memory for current chr on current line
            out   PORTD, r21    ; 1   put data to shift register
            out   PORTB, r19    ; 1   /PE LOW (next CLOCK will load pixel data)
            out   PORTB, r18    ; 1   /PE HIGH (now CLOCK will pump out the pixels)
 .endm

; *******************************************************************
; *****                                                         *****
; ***** Assembler routine sending out pixel data for a scanline *****
; *****                                                         *****
; *******************************************************************
TIMER0_COMPA_vect:              ; ISR table entry is automatically generated by the AVR assembler
            push r1             ; save r1 and r0 (the compiler needs this?)
            push r0
            in r0, SREG         ; reads the AVR status register SREG 0x3f holding the complete flag state
            push r0             ; push it on the stack, too
            eor r1, r1          ; r1: 0

            push  r18           ; push content on stack, so we can use this register right away

            lds r18, TCNT2      ; timer TCNT2 jitter compensation
            cpi r18, 4
            breq .+8
            cpi r18, 3
            breq .+6
            cpi r18, 2
            breq .+4
            nop
            nop
            nop

            cbi PORTB, 4        ; start of sync pulse

            push  r19
            push  r20
            push  r21
            push  r22
            push  r23
            push  r24
            push  r25
            push  r26
            push  r27
            push  r30
            push  r31

            out DDRD, r1        ; r1=0: make D6-7 inputs (PORTD ist hier 0 vom Ende der letzten scanline => pull-ups sind aus)

            lds r20, vline      ; lade vline nach r20-21
            lds r21, vline+1
            movw r24, r20       ; copy register pair
            adiw r24, 1         ; erhöhe vline um 1
            sts vline+1, r25    ; speichere vline wieder
            sts vline, r24
            asr r21             ; divide vline by 2 and subtract 30
            ror r20
            subi r20, 30        ; r20: Pixellinie "lin"

            sbi PORTB, 4        ; end of sync pulse (after 1µ, should be 3,8µs but this buys valuable time here)

            in r23, PINB        ; first read in DATA_NEW state
            in r22, PINC        ; nun PINC auslesen
            andi r22, 0x3f      ; nur die unteren 6 bits verwenden            
            in r24, PIND        ; nun PIND auslesen
            andi r24, 0xc0      ; nur die oberen 2 bits verwenden
            or r22, r24         ; r22: transfer byte, r23: DATA_NEW

            ldi r24, 0xff
            out DDRD, r24       ; make D6-7 outputs

            mov r21, r20        ; calculate VRAM row address from lin
            lsr r21
            lsr r21
            lsr r21             ; lin>>3
            lds r24, start
            add r21, r24
            cpi r21, HEIGHT
            brcs lineokay
              subi r21, HEIGHT
lineokay:   ldi r25, WIDTH
            mul r25, r21        ; calculate * WIDTH => Ergebnis ist in r0-1
            movw r30, r0        ; r30-31 (Z): index of VRAM row
            eor r1, r1          ; r1: 0
            
            ldi XL, lo8(vram)
            ldi XH, hi8(vram)
            add XH, ZH          ; add VRAM row index to VRAM start address
            add XL, ZL
            adc XH, r1          ; r26-27 (X): VRAM row address

            mov r21, r20        ; get lin
            andi r21, 7         ; only use lowest 3 bits of lin to determin charset line

            ldi ZH, hi8(charset); charset must be aligned to 256 bytes
            add ZH, r21         ; now ZH points to the charset line

            in r18, PORTB       ; prepare the two different /PE states
            mov r19, r18        ; r18: B3=1
            andi r19, 0x30      ; r19: B3=0

            cpi r20, HEIGHT*8
            brcs drawPixels
              jmp regHandler

drawPixels: ldi r21, 36          ; shifts screen left BUT BE CAREFUL: if routine takes too long, it won't fit into a scanline!
wait:       dec r21
            brne wait

            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR

            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR

            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR

            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR

            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR

            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
            ONECHAR
             
regHandler: in r24, PORTB       ; load current state of own output bits (namely B5 and B1)
            eor r23, r24        ; r23 = PINB ^ PORTB
            sbrs r23, 1         ; skip next if bit B1 is set (i. e. DATA_NEW has changed)
              rjmp retreat
            ldi r23, 0b00100010 ; ???
            eor r24, r23        ; toggle bits
            out PORTB, r24      ; store bits in PORTB

            ldi r31, hi8(reg)   ; prepare Z for a load indirect
            lds r30, regin      ; load direct from data space: "regin" index = LSB
            st Z, r22           ; store "a" -> (Z)
            inc r30             ; regin++, transfer buffer wraps around
            sts regin, r30      ; store regin back to data space

retreat:    pop r31
            pop r30
            pop r27
            pop r26
            pop r25
            pop r24
            pop r23
            pop r22
            pop r21
            pop r20
            pop r19
            pop r18
            pop r0        ; restore the AVR status register SREG 0x3f value
            out SREG, r0  ; set the SREG back to what it was
            pop r0        ; restore r0, r1 
            pop r1
            reti          ; return from interrupt
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
