;Get here after coming from $0038
InterruptHandler:
;Check if we are at VBlank, Bit 7 tells us that
    ld a, (VDPStatus)
    bit 7, a                ;Z is set if bit is 0
    jp nz, VBlank           ;If bit 7 is 1, then we are at VBlank

;=========================================================
; HBlank
;=========================================================
HBlank:
	ld hl, (nextHBlankStep)		    ;\ JUMP to next step for HBLANK
	jp (hl)					        ;/

FirstHBlank:
;Scroll the mountains
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    ld a, (scrollX0)
	out (PORT_VDP_ADDRESS), a
	ld a, $88
	out (PORT_VDP_ADDRESS), a		;Set BG X-Scroll to whatever
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti

;---------------------------------

;The river
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    ld a, (scrollX1)
	out (PORT_VDP_ADDRESS), a
	ld a, $88
	out (PORT_VDP_ADDRESS), a		;Set BG X-Scroll to whatever
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti

;---------------------------------

;The top field
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    ld a, (scrollX2)
	out (PORT_VDP_ADDRESS), a
	ld a, $88
	out (PORT_VDP_ADDRESS), a		;Set BG X-Scroll to whatever
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti 

;---------------------------------
    
;Country Road
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    ld a, (scrollX3)
	out (PORT_VDP_ADDRESS), a
	ld a, $88
	out (PORT_VDP_ADDRESS), a		;Set BG X-Scroll to whatever
    exx
    ex af, af'
    ei
    reti

+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti

;---------------------------------

;Bottom field
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    ld a, (scrollX4)
	out (PORT_VDP_ADDRESS), a
	ld a, $88
	out (PORT_VDP_ADDRESS), a		;Set BG X-Scroll to whatever
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti
+:
    ld hl, +
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    exx
    ex af, af'
    ei
    reti

;---------------------------------

;Return to top
+:
    ld hl, FirstHBlank
    ld (nextHBlankStep), hl         ;Prepare the step for the next HBLANK
    ld a, (scrollX0)
	out (PORT_VDP_ADDRESS), a
	ld a, $88
	out (PORT_VDP_ADDRESS), a		;Set BG X-Scroll to something
    exx
    ex af, af'
    ei
    reti

;=========================================================
; VBlank
;=========================================================
;If we are on the last scanline
VBlank:
;We are at VBlank
    ld hl, VDPStatus
    bit 7, a                        ;A = VDPStatus already
    jr z, +
    set 7, (hl)                     ;Sprite collision 
+:
;Update frame count up to 60
    ld hl, frameCount               ;Update frame count
    ld a, 60                        ;Check if we are at 60
    cp (hl)
    jr nz, +                        ;If we are, then reset
ResetFrameCount:
    ld (hl), -1
+:
    inc (hl)                        ;Otherwise, increase

EndVBlank:
;Swap shadow registers and registers back
    exx
    ex af, af'
    ei
;Leave
    reti


