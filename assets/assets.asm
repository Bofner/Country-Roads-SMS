
;============================================================================================
; Constant Data
;============================================================================================
;BANK defines for easy switching around and readability
.define     SFSBank                 $0002
.define     LevelBank               $0003
.define     Music                   $0004


;Data for an all black palette
FadedPalette:
    .db $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 
FadedPaletteEnd:

; There are 11 registers, so 11 data
VDPInitData:
              .db %00010100             ; reg. 0

              .db %10100000             ; reg. 1

              .db $ff                   ; reg. 2, Name table at $3800

              .db $ff                   ; reg. 3 Always set to $ff

              .db $ff                   ; reg. 4 Always set to $ff

              .db $ff                   ; reg. 5 Address for SAT, $ff = SAT at $3f00 

              .db $ff                   ; reg. 6 Base address for sprite patterns

              .db $f0                   ; reg. 7 Overrscan Color at Sprite Palette 1   

              .db $00                   ; reg. 8 Horizontal Scroll

              .db $00                   ; reg. 9 Vertical Scroll

              .db $ff                   ; reg. 10 Raster line interrupt off
VDPInitDataEnd:


;============================================================================================
; STEELFINGER STUDIOS
;============================================================================================
.bank SFSBank
.org $0000
;========================================================
; Background
;========================================================
;----------------
; Palettes
;----------------
SteelFingerBGPalette:
    .include "..\\assets\\palettes\\backgrounds\\steelFinger_bgPal.inc"
SteelFingerBGPaletteEnd:
;----------------
; BG Tiles
;----------------
SteelFingerTiles:
    .include "..\\assets\\tiles\\backgrounds\\steelFingerStudios_tiles.inc"
SteelFingerTilesEnd:
;----------------
; BG Maps
;----------------
SteelFingerStudiosMap:
    .include "..\\assets\\maps\\steelFingerStudios_map.inc"
SteelFingerStudiosMapEnd:
;========================================================
; Sprites
;========================================================
SteelFingerSPRPalette:
    .include "..\\assets\\palettes\\sprites\\steelFinger_SprPal.inc"
SteelFingerSPRPaletteEnd:
;----------------
; Shimmer
;----------------
SteelFingerShimmerTiles:
    .include "..\\assets\\tiles\\sprites\\sfsShimmer\\sfsShimmer_tiles.inc" 
SteelFingerShimmerTilesEnd:


;============================================================================================
; Level Data
;============================================================================================
.bank LevelBank
.org $0000
;========================================================
; Background
;========================================================
;----------------
; Palettes
;----------------
CountryRoadBGPalette:
    .include "..\\assets\\palettes\\backgrounds\\countryRoad.inc"
CountryRoadBGPaletteEnd:
;----------------
; BG Tiles
;----------------
CountryRoadTiles:
    .include "..\\assets\\tiles\\backgrounds\\countryRoad.inc"
CountryRoadTilesEnd:
;----------------
; BG Maps
;----------------
CountryRoadMap:
    .include "..\\assets\\maps\\countryRoad.inc"
CountryRoadMapEnd:
;========================================================
; Sprite
;========================================================
;----------------
; Palette
;----------------
CountryRoadSPRPalette:
    .include "..\\assets\\palettes\\sprites\\countryRoad.inc"
CountryRoadSPRPaletteEnd:
;----------------
; Bush Tiles
;----------------
BushTiles:
    .include "..\\assets\\tiles\\sprites\\bush\\bush.inc"
BushTilesEnd:
;----------------
; Tree Tiles
;----------------
TreeTrunkTiles:
    .include "..\\assets\\tiles\\sprites\\treeTrunk\\treeTrunk.inc"
TreeTrunkTilesEnd:
TreeTopTiles:
    .include "..\\assets\\tiles\\sprites\\treeTop\\treeTop.inc"
TreeTopTilesEnd:
;----------------
; Station Wagon
;----------------
StationWagonTiles:
    .include "..\\assets\\tiles\\sprites\\stationWagon\\stationWagon.inc"
StationWagonTilesEnd:



;============================================================================================
; Level Data
;============================================================================================
.bank Music
.org $0000
CountryRoadsPSG:
    .incbin "..\\Audio\\countryRoads.bin"
