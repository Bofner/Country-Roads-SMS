;----------------
; Constants
;----------------
.define STATION_WAGON_SPEED	$18

InitStationWagon:
;Station Wagon
    ld hl, stationWagon.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, stationWagon.width
    ;Sprite is 8x2 for 8x16
    ld (hl), $08                        
    inc hl                              ;ld hl, stationWagon.height
    ld (hl), $02                        
    inc hl                              ;ld hl, stationWagon.yPos
    ld (hl), 109
    inc hl                              ;ld hl, stationWagon.xPos
    ld (hl), $80
    inc hl                              ;ld hl, stationWagon.cc
    ld (hl), $0A
	ld hl, stationWagon.xFracPos
	ld (hl), $00
	inc hl                              ;ld hl, stationWagon.xFracPosHI
	ld (hl), $02
	inc hl								;ld hl, stationWagon.paletteSwapTimer
	ld (hl), $00
	inc hl								;ld hl, stationWagon.bumpy
	ld (hl), $00

	ret

;Deciphers xFracPos from special WORD into sprite coordinates for xPos for stationWagon
;Parameters: HL = stationWagon.xFracPos
;Affects: HL, DE, A, B, C
UpdateStationWagonPosition:
;Set X-Fractional-Position to Sprite position
	;ld hl, stationWagon.xFracPos     			;(HL) = WHOLE LO, FRAC
    ld a, (hl)
    srl a
    srl a
    srl a
    srl a                                       ;A = $Aa... A = 0, a = WHOLE LO
    inc hl                                      ;(HL) = UNUSED, WHOLE HI
    ld b, a
    ld a, (hl)
    sla a
    sla a
    sla a
    sla a                                       ;A = $Aa... A = WHOLE HI, a = 0
    or b                                        ;A = WHOLE HI, WHOLE LO
	ld d, $FF
    ld e, stationWagonStruct.xPos - (stationWagonStruct.xFracPos + 1) ;Get to stationWagon.xPos
    add hl, de   ;ld hl, stationWagon.xPos
    ld (hl), a

;Also update palette swap timer
	ld hl, stationWagon.paletteSwapTimer
	ld a, (hl)
	cp $02
	jp z, +
	cp $04
	jp z, ++
	inc (hl)
	jp BumpyTimer

+:
;Reset timer and swap color
	inc (hl)
	ld hl, $c01C | CRAMWrite
    call SetVDPAddress
    ld a, $2A
    out (VDPData), a
	ld hl, $c01D | CRAMWrite
    call SetVDPAddress
    ld a, $15
    out (VDPData), a
	jp BumpyTimer

++:
	ld (hl), $00
	ld hl, $c01C | CRAMWrite
    call SetVDPAddress
    ld a, $15
    out (VDPData), a
	ld hl, $c01D | CRAMWrite
    call SetVDPAddress
    ld a, $2A
    out (VDPData), a
	

BumpyTimer:
;Bumpy Timer
	ld hl, stationWagon.bumpyTimer
	ld a, (hl)
	cp $0A
	jr z, +
	cp $14
	jr z, ++
	inc (hl)
	ret

+:
	inc (hl)
	ld hl, stationWagon.yPos
	dec (hl)
	ret


++:
	ld (hl), $00
	ld hl, stationWagon.yPos
	inc (hl)
	
	ret