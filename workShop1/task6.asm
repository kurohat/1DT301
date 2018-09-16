;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 1DT301, Computer Technology I
; Date: 2018-09-14
; Author:
; Amata Anantaprayoon (aa224iu)
; Adell Tatrous (at222ux)
;
; Lab number: 1
; Title: How to use the PORTs. Digital input/output. Subroutine call.
;
; Hardware: STK600, CPU ATmega2560
;
; Function: creates a Johnson Counter in an infinite loop
; Input ports: N/A
;
; Output ports: PORTB.
;
; Subroutines: 
; Included files: m2560def.inc
;
; Other information:  Generated by delay loop calculator
; at http://www.bretmulvey.com/avrdelay.html
;
; Changes in program: 2018-09-14: Implementation
;                     2018-09-16: Edit comments
;
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


.include "m2560def.inc"
.def dataDir = r16
.def ledOn = r17
.def ledOff = r22

; Initialize SP, Stack Pointer
ldi r20, HIGH(RAMEND)			; R20 = high part of RAMEND address
out SPH,R20						; SPH = high part of RAMEND address
ldi R20, low(RAMEND) 			; R20 = low part of RAMEND address
out SPL,R20						; SPL= low part of RAMEND address

;set port B as output
ldi dataDir, 0xFF
out DDRB, dataDir

start:

; Delay 500 000 cycles
; 500ms at 1 MHz
    ldi  r18, 3
    ldi  r19, 138
    ldi  r20, 86
L1: dec  r20
    brne L1
    dec  r19
    brne L1
    dec  r18
    brne L1
    rjmp PC+1

;Lights LED0
ldi ledOn, 0b1111_1110
out PORTB, ledOn

;Load LedOff for backward "loop"
ldi ledOff, 0b0111_1111


forward:

    ldi  r18, 3
    ldi  r19, 138
    ldi  r20, 86
L2: dec  r20
    brne L2
    dec  r19
    brne L2
    dec  r18
    brne L2
    rjmp PC+1

lsl ledOn 		        ; shifts last bit to the left
out PORTB, ledOn
cpi ledOn, 0x00         ;compare ledOn with 0xFF
breq backward 	        ;IF ledOn = 0xFF jump to start

rjmp forward

backward:

    ldi  r18, 3
    ldi  r19, 138
    ldi  r20, 86
L3: dec  r20
    brne L3
    dec  r19
    brne L3
    dec  r18
    brne L3
    rjmp PC+1

out PORTB, ledOff
lsr ledOff
cpi ledOff, 0x00        ;compare ledOn with 0x00
breq start 	            ;IF ledOff = 0x00 jump to start

rjmp backward


