
;----------------
; Constants
;----------------
;Scroll Speeds
.define MOUNTAIN_SCROLL         $01
.define RIVER_SCROLL            $0C
.define HIGH_FIELD_SCROLL       $18
.define COUNTRY_ROAD_SCROLL     $24
.define LOW_FIELD_SCROLL        $30

;Object Locations
.define BUSH_0_XPOS             $08
.define BUSH_1_XPOS             $42
.define BUSH_2_XPOS             $98
.define BUSH_3_XPOS             $D6

;Object Locations
.define TREE_0_XPOS             $0C
.define TREE_1_XPOS             $53
.define TREE_2_XPOS             $8A
.define TREE_3_XPOS             $DA

UpdatePlantsPosition:
;Update plants to move with the background
;Bush 0
	ld hl, bush0.xPos
	ld a, (scrollX4)
	add a, BUSH_0_XPOS
	ld (hl), a
;Bush 1
	ld hl, bush1.xPos
	ld a, (scrollX4)
	add a, BUSH_1_XPOS
	ld (hl), a
;Bush 2
	ld hl, bush2.xPos
	ld a, (scrollX4)
	add a, BUSH_2_XPOS
	ld (hl), a
;Bush 3
	ld hl, bush3.xPos
	ld a, (scrollX4)
	add a, BUSH_3_XPOS
	ld (hl), a

;Tree 0
	ld hl, trunk0.xPos
	ld a, (scrollX2)
	add a, TREE_0_XPOS
	ld (hl), a
	ld hl, top0.xPos
	ld a, (scrollX2)
	add a, TREE_0_XPOS - 4
	ld (hl), a
;Tree 1
	ld hl, trunk1.xPos
	ld a, (scrollX2)
	add a, TREE_1_XPOS
	ld (hl), a
	ld hl, top1.xPos
	ld a, (scrollX2)
	add a, TREE_1_XPOS - 4
	ld (hl), a
;Tree 2
	ld hl, trunk2.xPos
	ld a, (scrollX2)
	add a, TREE_2_XPOS
	ld (hl), a
	ld hl, top2.xPos
	ld a, (scrollX2)
	add a, TREE_2_XPOS - 4
	ld (hl), a
;Tree 3
	ld hl, trunk3.xPos
	ld a, (scrollX2)
	add a, TREE_3_XPOS
	ld (hl), a
	ld hl, top3.xPos
	ld a, (scrollX2)
	add a, TREE_3_XPOS - 4
	ld (hl), a


	ret

InitBushes:
;Bush0
    ld hl, bush0.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, bush0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $02                        
    inc hl                              ;ld hl, bush0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, bush0.yPos
    ld (hl), 147
    inc hl                              ;ld hl, bush0.xPos
    ld (hl), BUSH_0_XPOS
    inc hl                              ;ld hl, bush0.cc
    ld (hl), $00
;Bush1
    ld hl, bush1.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, bush0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $02                        
    inc hl                              ;ld hl, bush0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, bush0.yPos
    ld (hl), 145
    inc hl                              ;ld hl, bush0.xPos
    ld (hl), BUSH_1_XPOS
    inc hl                              ;ld hl, bush0.cc
    ld (hl), $00
;Bush2
    ld hl, bush2.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, bush0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $02                        
    inc hl                              ;ld hl, bush0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, bush0.yPos
    ld (hl), 141
    inc hl                              ;ld hl, bush0.xPos
    ld (hl), BUSH_2_XPOS
    inc hl                              ;ld hl, bush0.cc
    ld (hl), $00
;Bush3
    ld hl, bush3.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, bush0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $02                        
    inc hl                              ;ld hl, bush0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, bush0.yPos
    ld (hl), 143
    inc hl                              ;ld hl, bush0.xPos
    ld (hl), BUSH_3_XPOS
    inc hl                              ;ld hl, bush0.cc
    ld (hl), $00

	ret

InitTrees:
;Tree Trunk 0
    ld hl, trunk0.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, trunk0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.yPos
    ld (hl), 84
    inc hl                              ;ld hl, trunk0.xPos
    ld (hl), TREE_0_XPOS
    inc hl                              ;ld hl, trunk0.cc
    ld (hl), $04
;Tree Top 0
	ld hl, top0.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, trunk0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $02                       
    inc hl                              ;ld hl, trunk0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.yPos
    ld a, (trunk0.yPos)
	sub a, $10
	ld (hl), a
    inc hl                              ;ld hl, trunk0.xPos
    ld (hl), TREE_0_XPOS - 4
    inc hl                              ;ld hl, trunk0.cc
    ld (hl), $06

;Tree Trunk 1
    ld hl, trunk1.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, trunk0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.yPos
    ld (hl), 77
    inc hl                              ;ld hl, trunk0.xPos
    ld (hl), TREE_1_XPOS
    inc hl                              ;ld hl, trunk0.cc
    ld (hl), $04
;Tree Top 1
	ld hl, top1.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, trunk0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $02                       
    inc hl                              ;ld hl, trunk0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.yPos
    ld a, (trunk1.yPos)
	sub a, $10
	ld (hl), a
    inc hl                              ;ld hl, trunk0.xPos
    ld (hl), TREE_1_XPOS - 4
    inc hl                              ;ld hl, trunk0.cc
    ld (hl), $06

;Tree Trunk 2
    ld hl, trunk2.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, trunk0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.yPos
    ld (hl), 89
    inc hl                              ;ld hl, trunk0.xPos
    ld (hl), TREE_2_XPOS
    inc hl                              ;ld hl, trunk0.cc
    ld (hl), $04
;Tree Top 2
	ld hl, top2.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, trunk0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $02                       
    inc hl                              ;ld hl, trunk0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.yPos
    ld a, (trunk2.yPos)
	sub a, $10
	ld (hl), a
    inc hl                              ;ld hl, trunk0.xPos
    ld (hl), TREE_2_XPOS - 4
    inc hl                              ;ld hl, trunk0.cc
    ld (hl), $06
;Tree Trunk 3
    ld hl, trunk3.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, trunk0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.yPos
    ld (hl), 81
    inc hl                              ;ld hl, trunk0.xPos
    ld (hl), TREE_3_XPOS
    inc hl                              ;ld hl, trunk0.cc
    ld (hl), $04
;Tree Top 3
	ld hl, top3.sprNum
    inc hl                              ;ld hl, spriteSize
    ld (hl), $10                        ;8x16
    inc hl                              ;ld hl, trunk0.width
    ;Sprite is 2x2 for 8x16
    ld (hl), $02                       
    inc hl                              ;ld hl, trunk0.height
    ld (hl), $01                        
    inc hl                              ;ld hl, trunk0.yPos
    ld a, (trunk3.yPos)
	sub a, $10
	ld (hl), a
    inc hl                              ;ld hl, trunk0.xPos
    ld (hl), TREE_3_XPOS - 4
    inc hl                              ;ld hl, trunk0.cc
    ld (hl), $06

	ret