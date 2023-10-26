;==============================================================
;All Structs that are sprites MUST have the following
;==============================================================
.struct spriteStruct
    sprNum          db      ;The draw-number of the sprite 
    spriteSize      db      ;$08 or $10 for 8x8 or 8x16
    width           db      ;The width of the OBJ     
    height          db      ;The height of the OBJ
    yPos            db      ;The Y coord of the OBJ's top left corner
    xPos            db      ;The X coord of the OBJ's top left corner
    cc              db      ;The first character code for the OBJ 
    xCenter         db      ;The X coord of the OBJ's center
    yCenter         db      ;The Y coord of the OBJ's center
.endst


;==============================================================
; Station Wagon Structure
;==============================================================
.struct stationWagonStruct
    instanceof spriteStruct
    yFracPos                    dw          ;Fractional position $WHOLELO, FRAC $UNUSED, WHOLEHI
    xFracPos                    dw          ;
    paletteSwapTimer            db 
    bumpyTimer                  db
.endst


;==============================================================
;Used when writing sprite data to the buffers
;==============================================================
.struct spriteBufferTemporaryVariablesStruct
    spriteSize      db      ;$08 or $10
    width           db      ;Stores the width
    volatileHeight  db      ;Height value that changes
    height          db      ;Stores the height
    yPos            db      ;The Y coord of the OBJ (volatile)
    xPos            db      ;The X coord of the OBJ (volatile)
    volatileXPos    db      ;xPos, but it changes
    cc              db      ;The first character code for the OBJ (volatile)
.endst


;==============================================================
; Palette structure
;==============================================================
.struct paletteStruct
    color0      db
    color1      db
    color2      db
    color3      db
    color4      db
    color5      db
    color6      db
    color7      db
    color8      db
    color9      db
    colorA      db
    colorB      db
    colorC      db
    colorD      db
    colorE      db
    colorF      db
.endst
    



