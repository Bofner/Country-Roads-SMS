;================================================================
; Country Road 
;================================================================
CountryRoadsSong:

;==============================================================
; Scene beginning
;==============================================================
    ld hl, sceneComplete
    ld (hl), $00

    inc hl                                  ;ld hl, sceneID
    ld (hl), $02

;Switch to correct bank for SFS Assets
    ld a, LevelBank
    ld ($FFFF), a

;Start off with no sprites
    ld hl, spriteCount
    ld (hl), $00

;==============================================================
; Memory (Structures, Variables & Constants) 
;==============================================================

;Structures and Variables
.enum postBoiler export
;Bushes
    bush0 instanceof spriteStruct
    bush1 instanceof spriteStruct
    bush2 instanceof spriteStruct
    bush3 instanceof spriteStruct
;Tree Trunks
    trunk0 instanceof spriteStruct
    trunk1 instanceof spriteStruct
    trunk2 instanceof spriteStruct
    trunk3 instanceof spriteStruct
;Tree Tops
    top0 instanceof spriteStruct
    top1 instanceof spriteStruct
    top2 instanceof spriteStruct
    top3 instanceof spriteStruct

;Station Wagon
    stationWagon instanceof stationWagonStruct

.ende

;----------------
; Constants
;----------------


;==============================================================
; Clear VRAM
;==============================================================
    call BlankScreen

    call ClearVRAM

    call ClearSATBuff

;==============================================================
; Load Palette
;==============================================================
;All black palette to be used once we are making things pretty
;Write current BG palette to currentPalette struct
    ld hl, currentBGPal.color0
    ld de, FadedPalette
    ld b, $10
    call PalBufferWrite

;Write current SPR palette to currentPalette struct
    ld hl, currentSPRPal.color0
    ld de, FadedPalette
    ld b, $10
    call PalBufferWrite


;Write target BG palette to targetPalette struct
    ld hl, targetBGPal.color0
    ld de, CountryRoadBGPalette
    ld b, $10
    call PalBufferWrite


;Write target SPR palette to targetPalette struct
    ld hl, targetSPRPal.color0
    ld de, CountryRoadSPRPalette
    ld b, $10
    call PalBufferWrite


;Actually update the palettes in VRAM
    call LoadBackgroundPalette
    call LoadSpritePalette

;==============================================================
; Load BG tiles 
;==============================================================
    ld hl, $0000 | VRAMWrite
    call SetVDPAddress
    ld hl, CountryRoadTiles
    ld bc, CountryRoadTilesEnd-CountryRoadTiles
    call CopyToVDP



;==============================================================
; Write background map
;==============================================================
    ld hl, $3800 | VRAMWrite
    call SetVDPAddress
    ld hl, CountryRoadMap
    ld bc, CountryRoadMapEnd-CountryRoadMap
    call CopyToVDP


;==============================================================
; Load Sprite tiles 
;==============================================================
;Bush
    ld hl, $2000 | VRAMWrite
    call SetVDPAddress
    ld hl, BushTiles
    ld bc, BushTilesEnd-BushTiles
    call CopyToVDP

;Tree Trunk
    ld hl, $2080 | VRAMWrite
    call SetVDPAddress
    ld hl, TreeTrunkTiles
    ld bc, TreeTrunkTilesEnd-TreeTrunkTiles
    call CopyToVDP

;Tree Top
    ld hl, $20C0 | VRAMWrite
    call SetVDPAddress
    ld hl, TreeTopTiles
    ld bc, TreeTopTilesEnd-TreeTopTiles
    call CopyToVDP

;Tree Top
    ld hl, $2140 | VRAMWrite
    call SetVDPAddress
    ld hl, StationWagonTiles
    ld bc, StationWagonTilesEnd-StationWagonTiles
    call CopyToVDP


;==============================================================
; Intialize our Variables
;==============================================================
    xor a
    
;Boilers
    ld hl, scrollX0          ;Set horizontal scroll to zero
    ld (hl), a              ;

    ld hl, scrollY          ;Set vertical scroll to zero
    ld (hl), a              ;

    ld hl, frameCount       ;Set frame count to 0
    ld (hl), a              ;   

;Set to 0 for smooth transition
    ld (scrollX0), a
    ld (scrollX1), a
    ld (scrollX0Frac), a
    ld (scrollX0Frac + 1), a
    ld (scrollX1Frac), a
    ld (scrollX1Frac + 1), a
    ld (scrollX2), a
    ld (scrollX2), a
    ld (scrollX2Frac), a
    ld (scrollX2Frac + 1), a
    ld (scrollX3Frac), a
    ld (scrollX3Frac + 1), a
    ld (scrollX4), a
    ld (scrollX4Frac), a
    ld (scrollX4Frac + 1), a
    ld (VDPStatus), a



;==============================================================
; Intialize our objects
;==============================================================

    call InitBushes

    call InitTrees

    call InitStationWagon

;=============================================================
; Set Scene
;=============================================================
    ld hl, sceneID
    ld (hl), $02


;==============================================================
; Turn on screen
;==============================================================
 ;(Maxim's explanation is too good not to use)
    ld a, %01100010
;           ||||||`- Zoomed sprites -> 16x16 pixels
;           |||||`-- Doubled sprites -> 8x16
;           ||||`--- Mega Drive mode 5 enable
;           |||`---- 30 row/240 line mode
;           ||`----- 28 row/224 line mode
;           |`------ VBlank interrupts
;            `------- Enable display    
    ld c, $81
    call UpdateVDPRegister

;Update Plants
    call UpdatePlantsPosition
;Bushes
    ld hl, bush0.sprNum
    call MultiUpdateSATBuff
    ld hl, bush1.sprNum
    call MultiUpdateSATBuff
    ld hl, bush2.sprNum
    call MultiUpdateSATBuff
    ld hl, bush3.sprNum
    call MultiUpdateSATBuff
;Trees
    ld hl, trunk0.sprNum
    call MultiUpdateSATBuff
    ld hl, top0.sprNum
    call MultiUpdateSATBuff
    ld hl, trunk1.sprNum
    call MultiUpdateSATBuff
    ld hl, top1.sprNum
    call MultiUpdateSATBuff
    ld hl, trunk2.sprNum
    call MultiUpdateSATBuff
    ld hl, top2.sprNum
    call MultiUpdateSATBuff
    ld hl, trunk3.sprNum
    call MultiUpdateSATBuff
    ld hl, top3.sprNum
    call MultiUpdateSATBuff

;Station Wagon
    ld hl, stationWagon.xFracPos
    call UpdateStationWagonPosition
    ld hl, stationWagon.sprNum
    call MultiUpdateSATBuff
    halt
    call UpdateSAT

;==============================================================
; Set Registers
;==============================================================
;HBlank
    ld a, $07                               ;$07 = HBlank every 8 scanlines
    ld c, $8A
    call UpdateVDPRegister

;Blank Left Column
    ld a, %00110100                         ;BIT 5 BLANK column
    ld c, $80
    call UpdateVDPRegister

    ei

;========================================================
; Game Logic
;========================================================

    call FadeIn

    ld hl, CountryRoadsPSG
    call PSGPlay 

LevelLoop:
;Start LOOP
    halt
;Prevent sprite scrambling if pause button is hit
    ld a,(VDPStatus)       ;Check if we are at VBlank
    or a
    jp p, LevelLoop        ;If not on VBlank, don't execute this code 

;Update Sprites, not sure if this should go before or after PSGFrame
    call UpdateSAT

;Work in the Music Bank
    ld a, Music
    ld ($FFFF), a
    call PSGFrame
    ;call PSGSFXFrame

;Work in the level Bank
    ld a, LevelBank
    ld ($FFFF), a

;Reset VBlank status
    ld hl, VDPStatus
    ld a, (hl)
    res 7, a
    ld (hl), a

;Update Plants
    call UpdatePlantsPosition

;Update Background scrolling
    call CountryUpdateBGParallax

;Bushes
    ld hl, bush0.sprNum
    call MultiUpdateSATBuff

    ld hl, bush1.sprNum
    call MultiUpdateSATBuff

    ;----------------------------------
    ; Timing Sensative Palette swaps
    ;----------------------------------
    ;Reset Tail Lights
        ld hl, $c012 | CRAMWrite
        call SetVDPAddress
        ld a, $02
        out (VDPData), a
    ;Check for inputs
        call XX_InputCheck
    ;Update Wagon position
        ld hl, stationWagon.xFracPos
        call UpdateStationWagonPosition
    ;----------------------------------
    ; Timing Sensative Palette swaps
    ;----------------------------------

    ld hl, bush2.sprNum
    call MultiUpdateSATBuff

    ld hl, bush3.sprNum
    call MultiUpdateSATBuff

;Trees
    ld hl, trunk0.sprNum
    call MultiUpdateSATBuff
    ld hl, top0.sprNum
    call MultiUpdateSATBuff

    ld hl, trunk1.sprNum
    call MultiUpdateSATBuff
    ld hl, top1.sprNum
    call MultiUpdateSATBuff

    ld hl, trunk2.sprNum
    call MultiUpdateSATBuff
    ld hl, top2.sprNum
    call MultiUpdateSATBuff

    ld hl, trunk3.sprNum
    call MultiUpdateSATBuff
    ld hl, top3.sprNum
    call MultiUpdateSATBuff

;Station Wagon

    ld hl, stationWagon.sprNum
    call MultiUpdateSATBuff


;End Loop
    jp LevelLoop



;Updates the scroll of the Parallax stars int he BG
;Parameters: None
;Affects:HL, BC, DE, A
CountryUpdateBGParallax:
;Update srcollX0 value (Mountains)
	ld hl, scrollX0Frac
    ld a, (hl)
    sub a, MOUNTAIN_SCROLL
    call c, BGScrollCarry
    ld (hl), a              ;Save new value
    inc hl
;Update scrollX1 value (River)
    inc hl                  ;ld hl, scrollX1Frac
    ld a, (hl)
    sub a, RIVER_SCROLL
    call c, BGScrollCarry
    ld (hl), a              ;Save new value
    inc hl
;Update scrollX2 value (Fields)
    inc hl                  ;ld hl, scrollX2Frac
    ld a, (hl)
    sub a, HIGH_FIELD_SCROLL
    call c, BGScrollCarry
    ld (hl), a              ;Save new value
    inc hl
;Update scrollX3 value (Country Road)
    inc hl                  ;ld hl, scrollX3Frac
    ld a, (hl)
    sub a, COUNTRY_ROAD_SCROLL
    call c, BGScrollCarry
    ld (hl), a              ;Save new value
    inc hl
;Update scrollX4 value  (Fields)
    inc hl                  ;ld hl, scrollX4Frac
    ld a, (hl)
    sub a, LOW_FIELD_SCROLL
    call c, BGScrollCarry
    ld (hl), a              ;Save new value
    inc hl
;Now update the VRAM buffer values
    ld hl, scrollX0Frac
    jp BGScrollConvertToPixels
BGScrollCarry:
    inc hl
    dec (hl)
    dec hl
    ret

BGScrollConvertToPixels
;Set Y-Fractional-Position to scrollX BG Pixel position 
    ;ld hl, scrollX0Frac                       ;(HL) = WHOLE LO, FRAC
    ld a, (hl)
    srl a
    srl a
    srl a
    srl a                                       ;A = $Aa... A = 0, a = WHOLE LO
    inc hl                                      ;(HL) = UNUSED, WHOLE HI
    push hl                                     ;Save scrollX0Frac HI for later
        ld b, a
        ld a, (hl)
        sla a
        sla a
        sla a
        sla a                                       ;A = $Aa... A = WHOLE HI, a = 0
        or b                                        ;A = WHOLE HI, WHOLE LO
        ld d, $FF                                   ;\
        ld e, scrollX0 - (scrollX0Frac + 1)         ; } ld hl, scrollX0
        add hl, de                                  ;/
        ld (hl), a 
        ld c, a                                     ;Save scrollX0
    pop hl                                     ;Recover scrollX0Frac HI
;Set scrollX1 BG X-scroll speed
    inc hl        ;ld hl, scrollX1Frac          ;(HL) = WHOLE LO, FRAC
    ld a, (hl)
    srl a
    srl a
    srl a
    srl a                                       ;A = $Aa... A = 0, a = WHOLE LO
    inc hl                                      ;(HL) = UNUSED, WHOLE HI
    push hl                                     ;Save scrollX1Frac HI for later
        ld b, a
        ld a, (hl)
        sla a
        sla a
        sla a
        sla a                                       ;A = $Aa... A = WHOLE HI, a = 0
        or b                                        ;A = WHOLE HI, WHOLE LO
        ld d, $FF       ;\
        ld e, scrollX1 - (scrollX1Frac + 1)         ; } ld hl, scrollX1
        add hl, de      ;/
        ld (hl), a 
        ld c, a                                     ;Save scrollX1
    pop hl                                     ;Recover scrollX1Frac HI
;Set srcollX2 BG X-scroll speed
    inc hl        ;ld hl, scrollX2Frac          ;(HL) = WHOLE LO, FRAC
    ld a, (hl)
    srl a
    srl a
    srl a
    srl a                                       ;A = $Aa... A = 0, a = WHOLE LO
    inc hl                                      ;(HL) = UNUSED, WHOLE HI
    push hl                                     ;Save scrollX1Frac HI for later
        ld b, a
        ld a, (hl)
        sla a
        sla a
        sla a
        sla a                                       ;A = $Aa... A = WHOLE HI, a = 0
        or b                                        ;A = WHOLE HI, WHOLE LO
        ld d, $FF       ;\
        ld e, scrollX2 - (scrollX2Frac + 1)         ; } ld hl, scrollX2
        add hl, de      ;/
        ld (hl), a 
        ld c, a                                     ;Save scrollX2
    pop hl                                     ;Recover scrollX2Frac HI
;Set srcollX3 BG X-scroll speed
    inc hl        ;ld hl, scrollX3Frac          ;(HL) = WHOLE LO, FRAC
    ld a, (hl)
    srl a
    srl a
    srl a
    srl a                                       ;A = $Aa... A = 0, a = WHOLE LO
    inc hl                                      ;(HL) = UNUSED, WHOLE HI
    push hl                                     ;Save scrollX3Frac HI for later
        ld b, a
        ld a, (hl)
        sla a
        sla a
        sla a
        sla a                                       ;A = $Aa... A = WHOLE HI, a = 0
        or b                                        ;A = WHOLE HI, WHOLE LO
        ld d, $FF       ;\
        ld e, scrollX3 - (scrollX3Frac + 1)         ; } ld hl, scrollX3
        add hl, de      ;/
        ld (hl), a 
        ld c, a                                     ;Save scrollX3
    pop hl                                     ;Recover scrollX3Frac HI
;Set srcollX4 BG X-scroll speed
    inc hl        ;ld hl, scrollX3Frac          ;(HL) = WHOLE LO, FRAC
    ld a, (hl)
    srl a
    srl a
    srl a
    srl a                                       ;A = $Aa... A = 0, a = WHOLE LO
    inc hl                                      ;(HL) = UNUSED, WHOLE HI
    push hl                                     ;Save scrollX4Frac HI for later
        ld b, a
        ld a, (hl)
        sla a
        sla a
        sla a
        sla a                                       ;A = $Aa... A = WHOLE HI, a = 0
        or b                                        ;A = WHOLE HI, WHOLE LO
        ld d, $FF       ;\
        ld e, scrollX4 - (scrollX4Frac + 1)         ; } ld hl, scrollX4
        add hl, de      ;/
        ld (hl), a 
        ld c, a                                     ;Save scrollX4
    pop hl                                     ;Recover scrollX4Frac HI


	ret

