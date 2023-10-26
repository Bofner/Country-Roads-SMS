XX_InputCheck:
;Check for button inputs
    in a, $DC                       ;Send Joypad port 1 input data to register A
    ld (DCInput), a                 ;Save $DC input for later
    cpl                             ;If button is pressed, 1 indicates such
    and %00110000                   ;Mask off player 2 inputs and D-Pad
    rrca
    rrca
    rrca
    rrca                            ;Move the 2 button input pressed to 0th and 1st bit
;3 * N + ActionButtonJumpTable
    ld c, a
    add a, c
    add a, c                           ;3 * N 
    ld h, 0
    ld l, a
    ld de, ActionButtonJumpTable_XX
    add hl, de                      ;3 * N + ActionButtonJumpTable
    jp hl                           ;Jump to specific input subroutine
;All of the possiblities for the Jump table move on to DPadCheck

DPadCheck_XX:
;Check DPad
    ld a, (DCInput)                 ;Recall Joypad 1 input data
    cpl                             ;Invert the bits so 1 indicates a press
    and %00001111                   ;Make a mask to only look at the D-Pad
;3 * N + DPadJumpTable
    ld c, a
    add c
    add c                           ;3 * N 
    ld h, 0
    ld l, a
    ld de, DPadJumpTable_XX 
    add hl, de                      ;3 * N + DPadJumpTable
    jp hl                           ;Jump to specific input subroutine
;This RET is just for safety, as each possible jump has its own RET
    ret

ButtonOne_XX:
    jp DPadCheck_XX
    
	ret

ButtonTwo_XX:
    jp DPadCheck_XX

	ret


DPadUp_XX:

    ret


DPadDown_XX:

    ret

DPadRight_XX:
;Check if we are at the left boundary
    ld a, (stationWagon.xPos)
    cp $BD
    ret nc
    ld hl, stationWagon.xFracPos
    ld a, STATION_WAGON_SPEED
    ld b, a
    ld a, (hl)
    add a, b
    call c, StationWagonMoveCarryRight
    ld (hl), a

    ret
StationWagonMoveCarryRight:
    inc hl
    inc (hl)
    dec hl

    ret


DPadLeft_XX:
;Tail light
    ld hl, $c012 | CRAMWrite
    call SetVDPAddress
    ld a, $03
    out (VDPData), a
;Check if we are at the left boundary
    ld a, (stationWagon.xPos)
    cp $0C
    ret c
;If not at boundary, move left
    ld hl, stationWagon.xFracPos
    ld a, STATION_WAGON_SPEED
    ld b, a
    ld a, (hl)
    sub a, b
    call c, StationWagonMoveCarryLeft
    ld (hl), a

    ret
StationWagonMoveCarryLeft:
    inc hl
    dec (hl)
    dec hl

    ret


;==================================================
; Jump Tables
;==================================================
ActionButtonJumpTable_XX:
;If nothing is pressed, move on to check DPad
    jp DPadCheck_XX
;If button one is pressed, check where the cursor is, otherwise check if in options
    jp ButtonOne_XX               ;Left Button
    jp ButtonTwo_XX			   ;Right Button


DPadJumpTable_XX:
;If nothing is pressed, leave
    ret                         ;JP is 3 bytes...
    nop                         ;...RET is only 1...
    nop                         ;...So 2 NOPs are added for cushion
;If a direction is pressed, then jump to do the correct action
    jp DPadUp_XX                                                  	;Only UP is pressed
    jp DPadDown_XX                                                	;Only DOWN is pressed
;In the case that UP and DOWN are both pressed
    ret                         ;JP is 3 bytes...
    nop                         ;...RET is only 1...
    nop                         ;...So 2 NOPs are added for cushion
    jp DPadLeft_XX                                                         ;LEFT
    jp DPadLeft_XX                                              		;UP and LEFT are pressed
    jp DPadLeft_XX                                            		    ;LEFT & DOWN are pressed
;In the case that LEFT and UP and DOWN are pressed
    ret                         ;JP is 3 bytes...
    nop                         ;...RET is only 1...
    nop                         ;...So 2 NOPs are added for cushion
    jp DPadRight_XX                                             ;RIGHT
    jp DPadRight_XX                                             ;RIGHT & UP
    jp DPadRight_XX                                             ;RIGHT & DOWN
;In the case that RIGHT and UP and DOWN are pressed
    ret                         ;JP is 3 bytes...
    nop                         ;...RET is only 1...
    nop                         ;...So 2 NOPs are added for cushion   
;In the case that RIGHT and LEFT are pressed
    ret                         ;JP is 3 bytes...
    nop                         ;...RET is only 1...
    nop                         ;...So 2 NOPs are added for cushion   
;In the case that RIGHT and LEFT and UP are pressed
    ret                         ;JP is 3 bytes...
    nop                         ;...RET is only 1...
    nop                         ;...So 2 NOPs are added for cushion 
;In the case that RIGHT and LEFT and DOWN are pressed
    ret                         ;JP is 3 bytes...
    nop                         ;...RET is only 1...
    nop                         ;...So 2 NOPs are added for cushion   
;In the case that RIGHT and LEFT and DOWN and UP are pressed
    ret                         ;JP is 3 bytes...
    nop                         ;...RET is only 1...
    nop                         ;...So 2 NOPs are added for cushion     