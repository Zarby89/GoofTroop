
;BANK 01   

;Sprite Handlers (sort of sprite but they use less ram and can only have 2 per map) (Items with high byte 6X)
818000   LDA $1200 ;Handler Sprites?
818003   BEQ $81800D  
818005   LDA #$12 
818007   XBA 
818008   LDA #$00
81800A   JSR $801B ;Set Directpage to 1200

81800D   LDA $1220 ;Handler Sprites?
818010   BEQ $81801A  
818012   LDA #$12 
818014   XBA
818015   LDA #$20 
818017   JSR $801B ;Set Directpage to 1220
81801A   RTL

81801B   TCD
81801C   LDX $0A ;Load byte $0A of current DP either (1200 or 1220) (if same as sprite this is the ID)
81801E   JMP ($8021,X)

818021 
dw $802B ;0x00 Canon ball shooters (first castle room also other room)
dw $809A ;0x02 Big canon ball following path (castle level)
dw $80C7 ;0x04 Big jumping boulders on level4
dw $812C ;0x06 Jumping Fish Handler
dw $819C ;0x08 spawning barrel on conveyor? (triggered in that room)
  

;0x00 Canonball spawner
CanonBall_Spawner:
{
81802B   LDX $02  
81802D   JMP ($8030,X)
   
818030
dw $8034
dw $8055
}

CanonBall_Spawner_00:
{
818034   LDA #$02 
818036   STA $02 ;Increase Canon State? :thinking:
818038   LDA $0B ;Probably the handler parameter
81803A   LSR ;*2
81803B   TAX
81803C   LDY $9591,X ;839591, X  ["02" 15 02 0A FF B0 03 02 80 28 FF]
81803F   LDX $9591,Y  ;[02 15 "02" 0A FF B0 03 02 80 28 FF]  
818042   STX $19
818044   STY $1B
818046   INY
818047   LDA $9591,Y ;[15 02 (01)"0A" FF B0 03 02 80 (02)"28" FF 50 03 02 64 (03)"46" 00 90 01 02 5A (04)"03" 0A 00 48 01 00 (05)"80"]
81804A   STA $1C,X ;Technically X can't go higher than 1F (in this case 1E)
81804C   TYA
81804D   CLC
81804E   ADC #$06   
818050   TAY ;[02 15 02 0A FF B0 03 02 80 "28" FF]
818051   DEX
818052   BPL $818047 ;continue until count = -1
818054   RTS
}

CanonBall_Spawner_02:
{
818055   LDY $1B ;Load back the start of the array in 
818057   INY
818058   LDX $19  
81805A   STX $1A  
81805C   DEC $1C,X
81805E   BPL $818091  
818060   JSL GetNextEmptySprite; $808F73  
818064   BCS $818088  
818066   LDA #$03 
818068   STA $0000,X 
81806B   LDA #$12
81806D   STA $000A,X ;Set Sprite ID to 0x12 (Small Canon Ball) 
818070   LDA $9592,Y ;[02 0A "FF" B0 03 02 80] 
818073   STA $0011,X  
818076   LDA $9593,Y ;[02 0A FF "B0" 03 02 80]  
818079   STA $0014,X  
81807C   LDA $9594,Y ;[02 0A FF B0 "03" 02 80]   
81807F   STA $000D,X  
818082   LDA $9595,Y ;[02 0A FF B0 03 "02" 80]   
818085   STA $000B,X  
818088   SEP #$10 
81808A   LDA $9596,Y ;[02 0A FF B0 03 02 "80"]  
81808D   LDX $1A  
81808F   STA $1C,X ;timer??
818091   TYA
818092   CLC
818093   ADC #$06 
818095   TAY
818096   DEX
818097   BPL $81805A ;continue until count = -1
818099   RTS
}


;0x02 Big canon ball Spawner following path (castle level)
CanonBallPath_Spawner:
{
81809A   LDX $02                  
81809C   JMP ($809F,X)            

81809F dw $80A3                   
8180A1 dw $80AC              
}

CanonBallPath_Spawner_Init:
{
8180A3   LDA #$02                 
8180A5   STA $02                  
8180A7   LDA #$0A                 
8180A9   STA $1F ;Timer waiting when we enter the room before spawning rocks
8180AB   RTS                      
}

CanonBallPath_Spawner_Main:
{
8180AC   DEC $1F                  
8180AE   BNE $8180C6              
8180B0   JSL GetNextEmptySprite; $808F73  
8180B4   BCS $8180C0
8180B6   LDA #$03                 
8180B8   STA $0000,X ;Sprite is alive!
8180BB   LDA #$14                 
8180BD   STA $000A,X ;Set sprite to rock
8180C0   SEP #$10                 
8180C2   LDA #$90                 
8180C4   STA $1F ;Timer waiting between each rocks  
8180C6   RTS                      
}


;0x04 Boulders
Boulders_Spawner:
{
8180C7   LDX $02                  
8180C9   JMP ($80CC,X)            
  
8180CC
dw $80D0
dw $80E7
}   

Boulders_Spawner_Init:
{
8180D0   LDA #$02                 
8180D2   STA $02                  
8180D4   LDX #$02                 
8180D6   LDA #$00                 
8180D8   TAY                      
8180D9   LDA $95BF,Y              
8180DC   STA $1C,X                
8180DE   TYA                      
8180DF   CLC                      
8180E0   ADC #$06                 
8180E2   TAY                      
8180E3   DEX                      
8180E4   BPL $8180D9              
8180E6   RTS                      
}

Boulders_Spawner_Main:
{
8180E7   LDA #$00                 
8180E9   TAY                      
8180EA   LDX #$02                 
8180EC   STX $1B                  
8180EE   DEC $1C,X                
8180F0   BPL $818123              
8180F2   JSL GetNextEmptySprite; $808F73  
8180F6   BCS $81811A              
8180F8   LDA #$02                 
8180FA   STA $0000,X              
8180FD   LDA #$40
8180FF   STA $000A,X ;Set sprite ID to 0x40
818102   LDA $95C0,Y ;["DF", $FF, $48, $00, $78, $37]
818105   STA $0011,X
818108   LDA $95C1,Y ;[DF, "$FF", $48, $00, $78, $37]
81810B   STA $0012,X
81810E   LDA $95C2,Y ;[DF, $FF, "$48", $00, $78, $37]
818111   STA $0014,X
818114   LDA $95C3,Y ;[DF, $FF, $48, "$00", $78, $37]
818117   STA $000D,X
81811A   SEP #$10                 
81811C   LDA $95C4,Y ;[DF, $FF, $48, $00, "$78", $37]
81811F   LDX $1B                  
818121   STA $1C,X                
818123   TYA                      
818124   CLC                      
818125   ADC #$06                 
818127   TAY                      
818128   DEX                      
818129   BPL $8180EC              
81812B   RTS                      
}


;Jumping Fish Sprite HANDLER (not the actual fish)
;DB = 0x1200 here
81812C   LDX $02
81812E   JMP ($8131,X)

818131 
dw $8135 ;Init
dw $8157 ;Main

818135   LDA #$02 
818137   STA $02  
818139   LDA $0B ;0B ?
81813B   LSR
81813C   TAX
81813D   LDY $95D7,X  ;02?
818140   LDX $95D7,Y  ;0E?
818143   STX $16  
818145   STY $15  
818147   INY
818148   JSL GetRandomInt ;$808859  
81814C   STA $18,X ; = timer for the fish to go out
81814E   LDA #$01 
818150   STA $19,X ; hight byte timer for the fish to go out
818152   DEX
818153   DEX
818154   BPL $818148  
818156   RTS

818157   LDA $00AC ;Gamestate sort of?
81815A   BNE $81819B  
81815C   LDY $15 ;04?
81815E   INY 
81815F   LDX $16 ;02?

818161   STX $17 ;??
818163   REP #$20 
818165   DEC $18,X ;Decrease Timer in 16bit mode
818167   SEP #$20 
818169   BNE $818195 ;Branch if timer != 0  
81816B   JSL GetNextEmptySprite;$808F73  
81816F   BCS $818187 ;IF there's no space available set timer back  
818171   LDA #$03
818173   STA $0000,X ;set sprite alive
818176   LDA #$50 
818178   STA $000A,X  ;Set Sprite ID to 0x50
81817B   LDA $95D7,Y ;Bank 83
81817E   STA $0011,X ;X Position
818181   LDA $95D8,Y  
818184   STA $0014,X ;Y Position
818187   SEP #$10 
818189   JSL GetRandomInt ;$808859  
81818D   LDX $17  
81818F   STA $18,X ;Timer
818191   LDA #$01 
818193   STA $19,X ;Highbyte timer
818195   INY
818196   INY
818197   DEX
818198   DEX
818199   BPL $818161  
81819B   RTS

;0x08 spawning barrel on conveyor? (triggered in that room)

Barrel_Spawner:
{
81819C   LDX $02                  
81819E   JMP ($81A1,X)            
   
8181A1
dw $81A5 ;0x00
dw $81CE ;0x02
}



Barrel_Spawner_Init:
{
8181A5   LDX $03                  
8181A7   JMP ($81AA,X)            
   
8181AA 
dw $81AE ;0x00
dw $81C2 ;0x02
}


Barrel_Spawner_Init00:
{
8181AE   LDA #$02 
8181B0   STA $03 
8181B2   REP #$20 
8181B4   LDA #$0001 
8181B7   STA $1D 
8181B9   SEP #$20 
8181BB   LDA #$02 
8181BD   STA $1F 
8181BF   STZ $19 
8181C1   RTS                      
}

Barrel_Spawner_Init02:
{
8181C2   LDA $00FE                
8181C5   BEQ $8181CD 
8181C7   LDA #$02                 
8181C9   STA $02                  
8181CB   STZ $03                  
8181CD   RTS  
}                    


Barrel_Spawner_Main:
{
8181CE   LDA $00AC ;Check gamestate                
8181D1   BNE $8181F1              
8181D3   DEC $1F ;Decrease a timer
8181D5   BNE $8181EC
8181D7   LDA #$02
8181D9   STA $1F ;Set back the timer
8181DB   LDY $19                  
8181DD   INY                      
8181DE   CPY #$03                 
8181E0   BNE $8181E4              
8181E2   LDY #$00                 
8181E4   STY $19                  
8181E6   LDX $95F3,Y              
8181E9   JSR Barrel_Spawner_ConveyorPaletteShift ;$823C                
8181EC   LDX $03                  
8181EE   JSR ($81F2,X)            
8181F1   RTS                      

8181F2
dw $81F6
dw $8209 
}

Barrel_Spawner_Main00:
{
8181F6   REP #$20
8181F8   DEC $1D ;Another timer before going to next state?
8181FA   SEP #$20
8181FC   BNE $818208
8181FE   LDA #$02
818200   STA $03
818202   LDA #$06 ;Number of item to spawn
818204   STA $1C
818206   INC $1D
818208   RTS                      
}

Barrel_Spawner_Main02:
{
818209   DEC $1D                  
81820B   BNE $81823B
81820D   JSL GetNextEmptyLiftableSprite;$808F8E              
818211   BCS $818229
818213   LDA #$03
818215   STA $0000,X ;Set sprite to alive
818218   STZ $000A,X ;?? type of item?
81821B   STZ $000B,X ;sprite used 00 = barrel, 02 = pots, etc.. you can find that list in items.txt
81821E   LDA #$0C
818220   STA $0003,X
818223   SEP #$10
818225   DEC $1C
818227   BNE $818237
818229   SEP #$10
81822B   STZ $03
81822D   REP #$20
81822F   LDA #$01A0
818232   STA $1D
818234   SEP #$20
818236   RTS

818237   LDA #$20
818239   STA $1D
81823B   RTS
}                 

;Palette update for the conveyor (conveyor is just a palette shifting :scream:)
Barrel_Spawner_ConveyorPaletteShift:
{
81823C   REP #$31                 
81823E   LDY #$0080               
818241   TXA                      
818242   XBA                      
818243   LSR                      
818244   LSR                      
818245   LSR                      
818246   TAX                      
818247   LDA #$0010               
81824A   STA $1A                  
81824C   LDA $8AE400,X            
818250   STA $1E00,Y ;Palette buffer?
818253   INX                      
818254   INX                      
818255   INY                      
818256   INY                      
818257   DEC $1A                  
818259   BNE $81824C              
81825B   SEP #$30                 
81825D   RTS                      
}

;Sprite Update Routine... set the right bank/address for each sprites

SpriteMain_SetDirectPage:
{
81825E   LDA $0200
818261   BEQ $81826B ;Branch if there's no sprite at that spot goto next sprite 
818263   LDA #$02 
818265   XBA
818266   LDA #$00 
818268   JSR $8397

81826B   LDA $0250
81826E   BEQ $818278  
818270   LDA #$02 
818272   XBA
818273   LDA #$50 
818275   JSR $8397 

818278   LDA $02A0
81827B   BEQ $818285  
81827D   LDA #$02 
81827F   XBA
818280   LDA #$A0 
818282   JSR $8397

818285   LDA $02F0
818288   BEQ $818292  
81828A   LDA #$02 
81828C   XBA
81828D   LDA #$F0 
81828F   JSR $8397  

818292   LDA $0340
818295   BEQ $81829F  
818297   LDA #$03 
818299   XBA
81829A   LDA #$40 
81829C   JSR $8397  

81829F   LDA $0390
8182A2   BEQ $8182AC  
8182A4   LDA #$03 
8182A6   XBA
8182A7   LDA #$90 
8182A9   JSR $8397

8182AC   LDA $03E0
8182AF   BEQ $8182B9  
8182B1   LDA #$03 
8182B3   XBA
8182B4   LDA #$E0 
8182B6   JSR $8397    

8182B9   LDA $0430
8182BC   BEQ $8182C6  
8182BE   LDA #$04 
8182C0   XBA
8182C1   LDA #$30 
8182C3   JSR $8397

8182C6   LDA $0480
8182C9   BEQ $8182D3  
8182CB   LDA #$04 
8182CD   XBA
8182CE   LDA #$80 
8182D0   JSR $8397 

8182D3   LDA $04D0
8182D6   BEQ $8182E0  
8182D8   LDA #$04 
8182DA   XBA
8182DB   LDA #$D0 
8182DD   JSR $8397   

8182E0   LDA $0520
8182E3   BEQ $8182ED  
8182E5   LDA #$05 
8182E7   XBA
8182E8   LDA #$20 
8182EA   JSR $8397 

8182ED   LDA $0570
8182F0   BEQ $8182FA  
8182F2   LDA #$05 
8182F4   XBA
8182F5   LDA #$70 
8182F7   JSR $8397 

8182FA   LDA $05C0
8182FD   BEQ $818307  
8182FF   LDA #$05 
818301   XBA
818302   LDA #$C0 
818304   JSR $8397 

818307   LDA $0610
81830A   BEQ $818314  
81830C   LDA #$06 
81830E   XBA
81830F   LDA #$10 
818311   JSR $8397   

818314   LDA $0660
818317   BEQ $818321  
818319   LDA #$06 
81831B   XBA
81831C   LDA #$60 
81831E   JSR $8397 

818321   LDA $06B0
818324   BEQ $81832E  
818326   LDA #$06 
818328   XBA
818329   LDA #$B0 
81832B   JSR $8397  

81832E   LDA $0700
818331   BEQ $81833B  
818333   LDA #$07 
818335   XBA
818336   LDA #$00 
818338   JSR $8397 

81833B   LDA $0750
81833E   BEQ $818348  
818340   LDA #$07 
818342   XBA
818343   LDA #$50 
818345   JSR $8397 

818348   LDA $07A0
81834B   BEQ $818355  
81834D   LDA #$07 
81834F   XBA
818350   LDA #$A0 
818352   JSR $8397

818355   LDA $07F0
818358   BEQ $818362  
81835A   LDA #$07 
81835C   XBA
81835D   LDA #$F0 
81835F   JSR $8397 

818362   LDA $0840
818365   BEQ $81836F  
818367   LDA #$08 
818369   XBA
81836A   LDA #$40 
81836C   JSR $8397 

81836F   LDA $0890
818372   BEQ $81837C  
818374   LDA #$08 
818376   XBA
818377   LDA #$90 
818379   JSR $8397  

81837C   LDA $08E0
81837F   BEQ $818389  
818381   LDA #$08 
818383   XBA
818384   LDA #$E0 
818386   JSR $8397 

818389   LDA $0930 ;24 sprites total
81838C   BEQ $818396  
81838E   LDA #$09 
818390   XBA
818391   LDA #$30 
818393   JSR $8397
818396   RTL
}

SpriteMain:

818397   TCD
818398   LDX $0A  
81839A   JMP ($839D,X)

81839D
dw $8411 ;0x00 ;Edgehog
dw $8710 ;0x02 ;Bee
dw $89E5 ;0x04 ;Floor Spikes
dw $8A91 ;0x06 ;Snake
dw $8D93 ;0x08 ;Ghost
dw $8F9D ;0x0A ;Bat
dw $92A4 ;0x0C ;Pirates? type is designed by subtype
dw $83F3 ;0x0E ;Islander
dw $92BA ;0x10 ;Alive Armor
dw $95E8 ;0x12 ;small Cannon ball
dw $965E ;0x14 ;Big cannon ball following a path in the room
dw $96E1 ;0x16 ;Rolling pin spikes in level2
dw $9800 ;0x18 ;Moving spike up & down
dw $9880 ;0x1A ;Frog
dw $9B7A ;0x1C ;Fireball 
dw $9BE1 ;0x1E ;???? does damage when you touch it...? <- this is the only sprite i don't know
dw $9D07 ;0x20 ;Small canon on last level
dw $9D6F ;0x22 ;Canon
dw $A026 ;0x24 ;LEVEL 4 Boss
dw $A7FF ;0x26 ;LEVEL 3 BOSS (subtype 00 for red, subtype 02 for blue)
dw $B0BE ;0x28 ;Pirate Boss LEVEL1 Boss
dw $B506 ;0x2A ;Switches
dw $B624 ;0x2C ;Moving Bridge on level3? NOT SURE also breakable walls ?? canonball?
dw $B8CD ;0x2E ;Boss LEVEL 2
dw $BF9B ;0x30 ;Flamethrower projecile (red big pirate)
dw $C234 ;0x32 ;Switch triggering bridge on level3?, Switch activating conveyor (subtype 04)
dw $C28F ;0x34 ;Wall Switch?
dw $C2D4 ;0x36 ;pirates throwing barrels in BOSS LEVEL2
dw $C405 ;0x38 ;Moving rail platform
dw $C549 ;0x3A ;Final Boss PETE?
dw $D44D ;0x3C ;Pete Intro?
dw $D7FF ;0x3E ;Pirate sword projectile
dw $D8A8 ;0x40 ;Bouncing Rocks
dw $D94C ;0x42 ;Order Switch; also used for O P E N puzzle with subtype 02 (COLLISION ARE NOT PART OF SPRITE!!)
dw $DACE ;0x44 ;Timed Switch (used in ice)
dw $DC3D ;0x46 ;Moving wooden platform up & down
dw $DD59 ;0x48 ;moving platform with 9 arrows
dw $E035 ;0x4A ;Destroyable tile
dw $83F8 ;0x4C ;Minecart
dw $83FD ;0x4E ;Pete something?
dw $8402 ;0x50 ;Actual Fish
dw $8407 ;0x52 ;Rotating Canon with buttons
dw $840C ;0x54 ;Pirate Flag!
    
;Sprite 0x0E
8183F3   JSL $80DD90  
8183F7   RTS

;Sprite 0x4C Minecart
8183F8  JSL $80DE3D
8183FC  RTS
;Sprite 0x4E ?Pete?
8183FD  JSL $828000
818401  RTS

;Sprite 0x50 Fish
818402   JSL $82806E  
818406   RTS

;Sprite 0x52 Rotating Canon
818407  JSL $80E312
81840B  RTS

;Sprite 0x54 Pirate Flag
81840C   JSL $80E4D5  
818410   RTS

}

;818411 
;incsrc Sprites/Edgehog.asm
;====================================================================================================
;Sprite 0x00 - Edgehog
;DATA BANK IS SETTED on 0x83
;DIRECT PAGE IS SETTED on 0x0200
;====================================================================================================

818411 
Sprite_Edgehog:
{
818411  LDX $02 ;$0200
JMP Sprite_Edgehog_MainTable, X  ; ($8416,X)            
    
Sprite_Edgehog_MainTable: ; 818416
dw Sprite_Edgehog_Init ;$841E ;0x00 Init
dw $8455 ;0x02
dw $85F9 ;0x04
dw $8624 ;0x06

}

Sprite_Edgehog_Init:
{
81841E   LDA #$02
818420   STA $02 ;Set Sprite MainState to 02
818422   LDA #$01
818424   STA $00 ;Set Sprite to Alive
818426   STA $01
818428   STA $1C ;Set HP to 1
81842A   STA $1D ;Set LastHP to 1

81842C   LDA #$97 ;XSpeed
81842E   LDY #$6F ;YSpeed
818430   JSL Sprite_SetSpeeds ; 80BF9F

818434   LDA #$40
818436   STA $1A ;OAM Related?

818438   LDA #$3D
81843A   STA $1B ;Set Palettes/Properties (VHOOPPPT)

81843C   LDA $0D ;Often used as Direction
81843E   INC
81843F   LSR ;/2.5?
818440   AND #$03 
818442   TAY 
818443   LDX $9606,Y ;9606 = [00 00 00 01] ?
818446   STX $0E
818448   ASL
818449   TAX ;Use direction*2 to set the addresses for FrameAnimation
81844A   LDY $95F6,X 
81844D   LDA $95F7,X 
818450   JSL FrameAnimationNoTimer ; $8089A3              
818454   RTS                      
}

Sprite_Edgehog_02:
{
818455   LDA $1D
818457   CMP $1C
818459   BEQ $818464 ;Branch if HP is still same as lastHP
;Sprite is dying goto subroutine 04?
81845B   LDA #$04
81845D   STA $02
81845F   STZ $03
818461   JMP $85F9

;Sprite is still alive - MAIN
818464   LDA $00AC
818467   BNE $81846E
818469   LDX $03
81846B   JSR ($8473,X)            
81846E   JSL SpriteSaveDirectPage ; 8088CE              
818472   RTS                      
}

818473  .db ;$03
dw $8477
dw $8542      


818477   DEC $08 ;?Decrease animation Timer!
818479   BNE $818483 
81847B   LDA #$02                 
81847D   STA $03 ;Change substate1
81847F   LDA #$0A                 
818481   STA $04 ;Change substate2

818483   LDX $04                  
818485   JSR ($8489,X)            
818488   RTS                      


818489 
dw $8495 
dw $84B5 
dw $84CB 
dw $84E3
dw $84FC 
dw $84FD      


818495   JSL FrameAnimationTimer; 8089A9              
818499   STZ $3C                  
81849B   LDA $11                  
81849D   STA $3D                  
81849F   LDA $14                  
8184A1   STA $3E                  
8184A3   DEC $14                  
8184A5   LDX #$00                 
8184A7   JSR $8629                
8184AA   LDA $3B                  
8184AC   BEQ $8184B0              
8184AE   INC $3C                  
8184B0   LDA #$02                 
8184B2   STA $04                  
8184B4   RTS                      


8184B5   ASL $3C                  
8184B7   INC $14                  
8184B9   INC $14                  
8184BB   LDX #$03                 
8184BD   JSR $8629                
8184C0   LDA $3B                  
8184C2   BEQ $8184C6              
8184C4   INC $3C                  
8184C6   LDA #$04                 
8184C8   STA $04                  
8184CA   RTS                      
----------------         
--------sub start--------
8184CB   ASL $3C                  
8184CD   LDA $3E                  
8184CF   STA $14                  
8184D1   INC $11                  
8184D3   LDX #$00                 
8184D5   JSR $869D                
8184D8   LDA $3B                  
8184DA   BEQ $8184DE              
8184DC   INC $3C                  
8184DE   LDA #$06                 
8184E0   STA $04                  
8184E2   RTS                      
----------------         
--------sub start--------
8184E3   ASL $3C                  
8184E5   DEC $11                  
8184E7   DEC $11                  
8184E9   LDX #$03                 
8184EB   JSR $869D                
8184EE   LDA $3B                  
8184F0   BEQ $8184F4              
8184F2   INC $3C                  
8184F4   LDA #$08                 
8184F6   STA $04                  
8184F8   LDA $3D                  
8184FA   STA $11                  
--------sub start--------
8184FC   RTS                      
----------------         
--------sub start--------
8184FD   LDA #$00                 
8184FF   STA $04                  
818501   LDA $3C                  
818503   CMP #$0F                 
818505   BNE $81850C              
818507   LDA #$00                 
818509   STA $03                  
81850B   RTS                      
----------------         
81850C   LDA $3C                  
81850E   ASL                      
81850F   ASL                      
818510   ASL                      
818511   ASL                      
818512   STA $3C                  
818514   JSL $808859              
818518   AND #$0F                 
81851A   CLC                      
81851B   ADC $3C                  
81851D   TAX                      
81851E   LDA $967F,X              
818521   STA $0D                  
818523   INC                      
818524   LSR                      
818525   AND #$03                 
818527   TAY                      
818528   LDX $9606,Y              
81852B   STX $0E                  
81852D   ASL                      
81852E   TAX                      
81852F   LDY $95FE,X              
818532   LDA $95FF,X              
818535   JSL FrameAnimationNoTimer ; $8089A3              
818539   JSL Sprite_SetSpeedsAlt ; 80BFA3              
81853D   LDA #$0A
81853F   STA $3A
818541   RTS


818542   JSL FrameAnimationTimer ; 8089A9              
818546   JSL MoveSprite ; 80C007              
81854A   LDA $0D
81854C   ASL
81854D   TAX
81854E   JSR ($8564,X)
818551   DEC $3A                  
818553   LDA $3A                  
818555   CMP #$FF                 
818557   BNE $81855C              
818559   JMP $85DE                
81855C   LDA $3A                  
81855E   BNE $818563              
818560   JMP $85D4                
818563   RTS                      


818564  
dw $8574
dw $8594
dw $857C
dw $85A4
dw $8584 
dw $85C4 
dw $858C 
dw $85B4


818574  .db $A2 $00 $20 $29 $86 $4C $72 $86
81857C  .db $A2 $00 $20 $9D $86 $4C $FB $86
818584  .db $A2 $03 $20 $29 $86 $4C $88 $86
81858C  .db $A2 $03 $20 $9D $86 $4C $E5 $86
----------------         
--------sub start--------
818594   LDX #$00                 
818596   JSR $8629                
818599   JSR $8672                
81859C   LDX #$00                 
81859E   JSR $869D                
8185A1   JMP $86FB                
--------sub start--------
8185A4   LDX #$03                 
8185A6   JSR $8629                
8185A9   JSR $8688                
8185AC   LDX #$00                 
8185AE   JSR $869D                
8185B1   JMP $86FB                
--------unidentified--------
8185B4  .db $A2 $00 $20 $29 $86 $20 $72 $86
8185BC  .db $A2 $03 $20 $9D $86 $4C $E5 $86
8185C4  .db $A2 $03 $20 $29 $86 $20 $88 $86
8185CC  .db $A2 $03 $20 $9D $86 $4C $E5 $86
8185D4  .db $22 $59 $88 $80 $29 $0F $C9 $0E
8185DC  .db $30 $16              
----------------         
8185DE   LDA #$00                 
8185E0   STA $03                  
8185E2   LDA $0D                  
8185E4   INC                      
8185E5   LSR                      
8185E6   AND #$03                 
8185E8   ASL                      
8185E9   TAX                      
8185EA   LDY $95F6,X              
8185ED   LDA $95F7,X              
8185F0   JSL FrameAnimationNoTimer ; $8089A3              
8185F4   LDA #$0A                 
8185F6   STA $3A                  
8185F8   RTS                      

Sprite_Edgehog_Dying:
{
8185F9   LDX $03                  
8185FB   JSR ($8603,X)            
8185FE   JSL SpriteSaveDirectPage ; 8088CE              
818602   RTS   
}                   


818603  .db 
dw $8609
dw $8FC8
dw $FCA9 ;Shared Sprite Routine for moving sprite?

818609   LDA #$02
81860B   STA $03                  
81860D   LDA $0D                  
81860F   INC                      
818610   LSR                      
818611   AND #$03                 
818613   ASL                      
818614   TAX                      
818615   LDY $95F6,X              
818618   LDA $95F7,X              
81861B   JSL FrameAnimationNoTimer ; $8089A3              
81861F   LDA #$03                 
818621   STA $00                  
818623   RTS                      


818624 ;Kill Edgehog but why using a subroutine for it ... that's weird
JSL KillSprite ; 808F1E
RTS


;Part of Edgehog Sprite
818629   LDA #$02
81862B   STA $000C
81862E   STZ $3B                  
818630   LDA $14                  
818632   CLC                      
818633   ADC $9673,X              
818636   STA $0008                
818639   REP #$20                 
81863B   AND #$00F8               
81863E   ASL                      
81863F   ASL                      
818640   STA $0000                
818643   BEQ $818666              
818645   CMP #$0380               
818648   BEQ $818666              
81864A   REP #$31                 
81864C   LDA $11                  
81864E   ADC $9674,X              
818651   INX                      
818652   AND #$00FF               
818655   LSR                      
818656   LSR                      
818657   LSR                      
818658   CLC                      
818659   ADC $0000                
81865C   TAY                      
81865D   SEP #$20                 
81865F   LDA $1400,Y              
818662   CMP #$70                 
818664   BCC $818668              
818666   INC $3B                  
818668   ASL $3B                  
81866A   DEC $000C                
81866D   BNE $81864A              
81866F   SEP #$10                 
818671   RTS                      

;Part of edgehog sprite
818672   LDA $3B                  
818674   BEQ $818687              
818676   LDA $0008                
818679   EOR #$FF                 
81867B   AND #$07                 
81867D   INC                      
81867E   CLC                      
81867F   ADC $14                  
818681   STA $14                  
818683   LDA #$01                 
818685   STZ $3A                  
818687   RTS                      

;Part of edgehog sprite
818688   LDA $3B                  
81868A   BEQ $81869C              
81868C   LDA $0008                
81868F   AND #$07                 
818691   EOR #$FF                 
818693   CLC                      
818694   ADC $14                  
818696   STA $14                  
818698   LDA #$01                 
81869A   STZ $3A                  
81869C   RTS                      

;Part of edgehog sprite
81869D   LDA #$02                 
81869F   STA $000C                
8186A2   STZ $3B                  
8186A4   LDA $11                  
8186A6   CLC                      
8186A7   ADC $9679,X              
8186AA   STA $0006                
8186AD   LSR                      
8186AE   LSR                      
8186AF   LSR                      
8186B0   STA $0002                
8186B3   STZ $0003                
8186B6   LDA $0002                
8186B9   BEQ $8186D9              
8186BB   CMP #$20                 
8186BD   BEQ $8186D9              
8186BF   REP #$31                 
8186C1   LDA $14                  
8186C3   ADC $967A,X              
8186C6   INX                      
8186C7   AND #$00F8               
8186CA   ASL                      
8186CB   ASL                      
8186CC   ADC $0002                
8186CF   TAY                      
8186D0   SEP #$20                 
8186D2   LDA $1400,Y              
8186D5   CMP #$70                 
8186D7   BCC $8186DB              
8186D9   INC $3B                  
8186DB   ASL $3B                  
8186DD   DEC $000C                
8186E0   BNE $8186BF              
8186E2   SEP #$10                 
8186E4   RTS                      
----------------         
8186E5   LDA $3B                  
8186E7   BEQ $8186FA              
8186E9   LDA $0006                
8186EC   EOR #$FF                 
8186EE   AND #$07                 
8186F0   INC                      
8186F1   CLC                      
8186F2   ADC $11                  
8186F4   STA $11                  
8186F6   LDA #$01                 
8186F8   STZ $3A                  
8186FA   RTS                      
----------------         
8186FB   LDA $3B                  
8186FD   BEQ $81870F              
8186FF   LDA $0006                
818702   AND #$07                 
818704   EOR #$FF                 
818706   CLC                      
818707   ADC $11                  
818709   STA $11                  
81870B   LDA #$01                 
81870D   STZ $3A                  
81870F   RTS                      

;------------------------------------------

;Bee Sprite:? 
818710   LDX $02  
818712   JMP ($8715,X)
   
818715  
dw $871D ;0x00 ;Init Routine
dw $873A ;0x02 ;Main Routine?
dw $8931 ;0x04
dw $8971 ;0x06

Bee_Sprite_00:
{ 
81871D   LDA #$02 
81871F   STA $02 ;SpriteState1
818721   DEC
818722   STA $00 ;ID? Alive?, on 01?
818724   STA $01 ;SpriteState, ID, ALive? on 01
818726   STA $1C ;HP
818728   STA $1D ;Last HP
81872A   STA $33 ;??
81872C   LDA #$80 
81872E   STA $1A ;OAM Address
818730   LDA #$97 
818732   LDY #$8F 
818734   JSL $808942 ;?
818738   BRA $8187A3 
}

Bee_Sprite_02:
{ 
81873A   LDA $1D 
81873C   CMP $1C  
81873E   BEQ $818749 ;Check if HP == last HP  

;Kill sprite probably?
818740   LDA #$04 
818742   STA $02  
818744   STZ $03  
818746   JMP $8931

818749   LDA $00AC ;Check gamestate 
81874C   BNE $81875A ;Branch if game is not active?  

81874E   LDX $03  
818750   JSR ($875F,X)
818753   JSR $89A1
818756   JSL FrameAnimationTimer; 8089A9

81875A   JSL SpriteSaveDirectPage ; 8088CE  
81875E   RTS
} 
   
81875F
Bee_Main_Table:
{
dw $8769 ;0x00
dw $87F5 ;0x02
dw $88A3 ;0x04
dw $88E0 ;0x06
dw $8921 ;0x08
}

Bee_Main_00:
{
818769   DEC $3E  
81876B   BEQ $818770  
81876D   JMP $87F0 ;Return?

818770   JSR $87BB
818773   LDA $33  
818775   BNE $8187A0  
818777   STZ $3F  
818779   LDX #$00 
81877B   LDA $0100,X  
81877E   BEQ $81878B  
818780   JSR $8976
818783   BCC $81878B  
818785   INC $3F  
818787   LDA #$02 
818789   STA $03 ;SpriteState2
81878B   LDX #$80 
81878D   LDA $0100,X ;0180 ?
818790   BEQ $81879F ;Return
818792   JSR $8976


818795  .db $90 $08 $E6 $3F $E6 $3F $A9 $02
81879D  .db $85 $03  

81879F   RTS
}

8187A0   DEC $33  
8187A2   RTS

--------sub start--------
8187A3   LDA #$97 
8187A5   LDY #$97 
8187A7   JSL FrameAnimationNoTimer ; $8089A3  
8187AB   REP #$20 
8187AD   LDA #$0140   
8187B0   STA $37  
8187B2   LDA #$1000   
8187B5   STA $16  
8187B7   SEP #$20 
8187B9   STZ $3B  


--------sub start--------
8187BB   LDA $34  
8187BD   BEQ $8187C5  
8187BF   LDA $0D  
8187C1   EOR #$08 
8187C3   BRA $8187D4  
8187C5   JSL GetRandomInt ;$808859  
8187C9   AND #$0F 
8187CB   TAX
8187CC   LDA $97C2,X  
8187CF   CLC
8187D0   ADC $0D  
8187D2   AND #$0F 
8187D4   STA $0D  
8187D6   LSR
8187D7   LSR
8187D8   LSR
8187D9   STA $0E  
8187DB   LDA $0D  
8187DD   ASL
8187DE   ASL
8187DF   ASL
8187E0   ASL
8187E1   TAX
8187E2   LDA $38  
8187E4   LDY $37  
8187E6   JSL $809252  
8187EA   LDA #$04 
8187EC   STA $3E  
8187EE   STZ $34  
8187F0   JSL MoveSprite ; 80C007  
8187F4   RTS


8187F5   LDX $04  
8187F7   JMP ($87FA,X)
--------data--------     
8187FA
dw $87FE 
dw $8888

8187FE   LDA #$02 
818800   STA $04  
818802   REP #$10 
818804   LDA #$00 
818806   XBA
818807   LDA $3F  
818809   ASL
81880A   TAX
81880B   JMP ($880C,X)

81880C; JUMP ADDRESS SO X CAN NEVER BE 00!

81880E
dw $885D ;0x02
dw $8866 ;0x04
dw $8814 ;0x06

818814  .db $64 $39 $64 $3A
818818  .db $A2 $00 $00 $BD $00 $02 $F0 $16
818820  .db $BD $0A $02 $C9 $02 $D0 $0F $BD
818828  .db $3B $02 $F0 $0A $C9 $01 $D0 $04
818830  .db $E6 $3A $80 $02 $E6 $39 $C2 $20
818838  .db $8A $18 $69 $50 $00 $C9 $80 $07
818840  .db $AA $E2 $20 $B0 $D6 $A5 $39 $C5
818848  .db $3A $B0 $0B $E6 $3B $E6 $3B $AD
818850  .db $56 $01 $D0 $09 $80 $10 $E6 $3B
818858  .db $AD $56 $01 $D0 $09  
----------------   
81885D   LDA #$00 
81885F   STA $3C  
818861   LDX #$0100   
818864   BRA $81886D  
--------unidentified--------
818866  .db $A9 $80 $85 $3C $A2 $80 $01
----------------   
81886D   JSL $808B0E  
818871   LSR
818872   AND #$0F 
818874   STA $0D  
818876   LSR
818877   LSR
818878   LSR
818879   STA $0E  
81887B   LDA #$97 
81887D   LDY #$A9 
81887F   JSL FrameAnimationNoTimer ; $8089A3  
818883   LDA #$1E 
818885   STA $3D  
818887   RTS
----------------   
818888   DEC $3D  
81888A   BNE $8188A2  
81888C   LDA #$04 
81888E   STA $03  
818890   LDA #$1A 
818892   STA $3D  
818894   REP #$20 
818896   LDA #$0000   
818899   STA $37  
81889B   LDA #$0100   
81889E   STA $35  
8188A0   SEP #$20 
8188A2   RTS
----------------   
--------sub start--------
8188A3   REP #$20 
8188A5   LDA $16  
8188A7   SEC
8188A8   SBC $35  
8188AA   STA $16  
8188AC   LDA $35  
8188AE   SEC
8188AF   SBC #$000D   
8188B2   STA $35  
8188B4   SEP #$20 
8188B6   BPL $8188C1  
8188B8   LDA #$06 
8188BA   STA $03  
8188BC   LDA #$19 
8188BE   STA $3D  
8188C0   RTS
----------------   
8188C1   REP #$21 
8188C3   LDA $37  
8188C5   ADC #$0028   
8188C8   STA $37  
8188CA   SEP #$20 
8188CC   LDA $0D  
8188CE   ASL
8188CF   ASL
8188D0   ASL
8188D1   ASL
8188D2   TAX
8188D3   LDA $38  
8188D5   LDY $37  
8188D7   JSL $809252  
8188DB   JSL MoveSprite ; 80C007  
8188DF   RTS
----------------   
--------sub start--------
8188E0   REP #$20 
8188E2   LDA $35  
8188E4   SEC
8188E5   SBC #$000D   
8188E8   STA $35  
8188EA   LDA $16  
8188EC   SEC
8188ED   SBC $35  
8188EF   STA $16  
8188F1   CMP #$1000   
8188F4   SEP #$20 
8188F6   BCC $818901  
8188F8   LDA #$08 
8188FA   STA $03  
8188FC   LDA #$14 
8188FE   STA $3D  
818900   RTS
----------------   
818901   REP #$20 
818903   LDA $37  
818905   SEC
818906   SBC #$0028   
818909   STA $37  
81890B   SEP #$20 
81890D   LDA $0D  
81890F   ASL
818910   ASL
818911   ASL
818912   ASL
818913   TAX
818914   LDA $38  
818916   LDY $37  
818918   JSL $809252  
81891C   JSL MoveSprite ; 80C007  
818920   RTS
----------------   
--------sub start--------
818921   DEC $3D  
818923   BNE $818930  
818925   LDA #$0F 
818927   STA $33  
818929   JSR $87A3
81892C   STZ $03  
81892E   STZ $04  
818930   RTS
----------------   
818931   LDX $03  
818933   JSR ($893B,X)
818936   JSL SpriteSaveDirectPage ; 8088CE  
81893A   RTS
----------------   
--------data--------     
81893B  .db $41 $89 $88 $FC $A9 $FC
----------------   
--------sub start--------
818941   LDA #$02 
818943   STA $03  
818945   LDA #$97 
818947   LDY #$BB 
818949   JSL FrameAnimationNoTimer ; $8089A3  
81894D   LDA #$03 
81894F   STA $00  
818951   RTS
----------------   
--------unidentified--------
818952  .db $A5 $03 $D0 $EB $A9 $02 $85 $03
81895A  .db $A9 $02 $85 $00 $A9 $97 $A0 $BB
818962  .db $22 $A3 $89 $80 $C6 $08 $A9 $06
81896A  .db $85 $02 $22 $CE $88 $80 $60
----------------   
818971   JSL KillSprite ; 808F1E  
818975   RTS



--------sub start--------
818976   LDA $0100,X  
818979   BEQ $81899D  
81897B   REP #$21 
81897D   LDA $14  
81897F   ADC #$0020   
818982   SEC
818983   SBC $0114,X  
818986   CMP #$0041   
818989   BCS $81899D  
81898B   LDA $11  
81898D   CLC
81898E   ADC #$0020   
818991   SEC
818992   SBC $0111,X  
818995   CMP #$0041   
818998   BCS $81899D  
81899A   SEP #$21 
81899C   RTS
----------------   
81899D   CLC
81899E   SEP #$20 
8189A0   RTS
----------------   
--------sub start--------
8189A1   REP #$20 
8189A3   LDX #$00 
8189A5   LDA $11  
8189A7   SEC
8189A8   SBC #$0017   
8189AB   BMI $8189B5  
8189AD   CMP #$00D3   
8189B0   BCC $8189BF  
8189B2   SBC #$00D2   
8189B5   EOR #$FFFF   
8189B8   INC
8189B9   CLC
8189BA   ADC $11  
8189BC   STA $11  
8189BE   INX
8189BF   LDA $14  
8189C1   SEC
8189C2   SBC #$0024   
8189C5   BMI $8189CF  
8189C7   CMP #$00A9   
8189CA   BCC $8189D9  
8189CC   SBC #$00A8   
8189CF   EOR #$FFFF   
8189D2   INC
8189D3   CLC
8189D4   ADC $14  
8189D6   STA $14  
8189D8   INX
8189D9   SEP #$20 
8189DB   LDA $03  
8189DD   BNE $8189E4  
8189DF   DEX
8189E0   BMI $8189E4  
8189E2   INC $34  
8189E4   RTS

;Sprite 0x04 - Floor Spikes?
8189E5   LDA $02  
8189E7   BNE $8189FF  
8189E9   LDA #$02 
8189EB   STA $02  
8189ED   DEC
8189EE   STA $00  
8189F0   STZ $39  
8189F2   JSR $8A19
8189F5   LDA $0B  
8189F7   LSR
8189F8   TAX
8189F9   LDA $97D2,X  
8189FC   STA $0F  
8189FE   RTS
----------------   
8189FF   LDA $00AC
818A02   BNE $818A08  
818A04   DEC $0F  
818A06   BEQ $818A09  
818A08   RTS
----------------   
818A09   LDA $39  
818A0B   INC
818A0C   INC
818A0D   AND #$06 
818A0F   STA $39  
818A11   STZ $1F  
818A13   CMP #$04 
818A15   BNE $818A19  
818A17   STA $1F  
--------sub start--------
818A19   LDX $39  
818A1B   LDA $97D5,X  
818A1E   STA $3A  
818A20   LDA $97D6,X  
818A23   STA $0F  
818A25   LDA $0B  
818A27   ASL
818A28   ASL
818A29   TAX
818A2A   LDA $97DD,X  
818A2D   STA $3E  
818A2F   LDA $97DE,X  
818A32   STA $3F  
818A34   TXA
818A35   ADC $3A  
818A37   TAX
818A38   LDA $97DF,X  
818A3B   STA $3C  
818A3D   LDA $97E0,X  
818A40   STA $3D  
818A42   LDY #$00 
818A44   LDX $0041
818A47   LDA ($3C),Y  
818A49   INY
818A4A   STA $1900,X  
818A4D   INX
818A4E   REP #$20 
818A50   LDA $3E  
818A52   STA $1900,X  
818A55   SEP #$20 
818A57   INX
818A58   INX
818A59   LDA ($3C),Y  
818A5B   INY
818A5C   STA $3B  
818A5E   ASL
818A5F   STA $1900,X  
818A62   INX
818A63   LDA ($3C),Y  
818A65   STA $0000
818A68   INY
818A69   LDA ($3C),Y  
818A6B   INY
818A6C   STA $1900,X  
818A6F   INX
818A70   LDA $0000
818A73   STA $1900,X  
818A76   INX
818A77   DEC $3B  
818A79   BNE $818A69  
818A7B   STX $0041
818A7E   LDA ($3C),Y  
818A80   BEQ $818A90  
818A82   INY
818A83   REP #$21 
818A85   AND #$00FF   
818A88   ADC $3E  
818A8A   STA $3E  
818A8C   SEP #$20 
818A8E   BRA $818A44  
818A90   RTS


;0x06 Snake Sprite
Sprite_Snake:
{
818A91   LDX $02  
818A93   JMP ($8A96,X)
}

818A96
dw $8A9E ;0x00 Snake_Init
dw $8AD5 ;0x02
dw $8C45 ;0x04
dw $8C66 ;0x06

Sprite_Snake_Init:
{
818A9E   LDA #$02 
818AA0   STA $02  
818AA2   LDX $00B6 ;Load LEVEL
818AA5   LDA $9860,X ;Load value based on level [40,40,C0,40,C0]
818AA8   STA $1A
818AAA   LDA #$01
818AAC   STA $00 ;Set Sprite Alive on #$01 
818AAE   STA $01 ;Set SpriteState on #$01 
818AB0   STA $1C ;Set HP on 01
818AB2   STA $1D ;Set LastHP on 01 
818AB4   LDA #$3B 
818AB6   STA $1B ;Set OAM Related VHOOPPPT palette mainly
818AB8   LDA #$98 
818ABA   LDY #$31 
818ABC   JSL FrameAnimationNoTimer ; $8089A3 ;?
818AC0   LDA $0D  
818AC2   STA $0E  
}


818AC4   REP #$20 
818AC6   LDA #$0080   
818AC9   LDX $0D  
818ACB   BEQ $818AD0  
818ACD   LDA #$FF80   
818AD0   STA $28  
818AD2   SEP #$20 
818AD4   RTS


;Sprite_Main?_02
818AD5   LDA $1D  
818AD7   CMP $1C  
818AD9   BEQ $818AE4  
818ADB   LDA #$04 
818ADD   STA $02  
818ADF   STZ $03  
818AE1   JMP $8C45
818AE4   LDA $00AC
818AE7   BNE $818AEE  
818AE9   LDX $03  
818AEB   JSR ($8AF3,X)
818AEE   JSL SpriteSaveDirectPage ; 8088CE  
818AF2   RTS

 
818AF3  
dw $8B01 ;0x00  
dw $8B72 ;0x02
dw $8B86 ;0x04
dw $8BA1 ;0x06
dw $8BC2 ;0x08
dw $8C10 ;0x0A
dw $8C31 ;0x0C


818B01   JSL MoveHorizontal; $80C032  
818B05   JSL FrameAnimationTimer; 8089A9 ;Animation Timer
818B09   LDX $0D  
818B0B   JSR $8D2D
818B0E   JSR $8D4A
818B11   JSR $8D71
818B14   BCS $818B1A  
818B16   LDA $31  
818B18   BEQ $818B33  
818B1A   LDA $0D  
818B1C   EOR #$01 
818B1E   STA $0D  
818B20   LDA #$14 
818B22   STA $32  
818B24   LDA #$98 
818B26   LDY #$46 
818B28   JSL FrameAnimationNoTimer ; $8089A3 ;Animation thing
818B2C   LDA #$0A 
818B2E   STA $03  
818B30   STZ $30  
818B32   RTS


818B33   STZ $3F  
818B35   LDA #$FF 
818B37   STA $33  
818B39   STA $35  
818B3B   LDY #$00 
818B3D   LDX #$00 
818B3F   JSR $8C6B
818B42   BCC $818B51  
818B44   LDY #$00 
818B46   LDX #$00 
818B48   JSR $8CA8
818B4B   BCC $818B51  
818B4D   LDA #$02 
818B4F   STA $3F  
818B51   LDY #$80 
818B53   LDX #$02 
818B55   JSR $8C6B
818B58   BCC $818B69  
818B5A   LDY #$80 
818B5C   LDX #$02 
818B5E   JSR $8CA8
--------unidentified--------
818B61  .db $90 $06 $A5 $3F $09 $04 $85 $3F
----------------   
818B69   LDA $3F  
818B6B   BEQ $818B71  
818B6D   LDA #$04 
818B6F   STA $03  
818B71   RTS
----------------   
--------unidentified--------
818B72  .db $22 $A9 $89 $80 $C6 $32 $D0 $0B
818B7A  .db $A5 $0D $85 $0E $A9 $00 $85 $03
818B82  .db $4C $C4 $8A $60
----------------   
--------sub start--------
818B86   JSR $8CEA
818B89   JSR $8D21
818B8C   LDA #$0A 
818B8E   STA $32  
818B90   LDA #$98 
818B92   LDY #$46 
818B94   JSL FrameAnimationNoTimer ; $8089A3 ;Animation thing 
818B98   LDA #$0A 
818B9A   STA $03  
818B9C   LDA #$01 
818B9E   STA $30  
818BA0   RTS
----------------   
--------sub start--------
818BA1   DEC $32  
818BA3   BNE $818BC1  
818BA5   LDA #$98 
818BA7   LDY #$4C 
818BA9   JSL FrameAnimationNoTimer ; $8089A3 ;Animation thing
818BAD   REP #$20 
818BAF   LDA #$02C0   
818BB2   LDX $0D  
818BB4   BEQ $818BB9  
818BB6   LDA #$FD40   
818BB9   STA $28  
818BBB   SEP #$20 
818BBD   LDA #$08 
818BBF   STA $03  
818BC1   RTS
----------------   
--------sub start--------
818BC2   LDA $08  
818BC4   CMP #$01 
818BC6   BNE $818BD9  
818BC8   LDA #$14 
818BCA   STA $32  
818BCC   LDA #$98 
818BCE   LDY #$31 
818BD0   JSL FrameAnimationNoTimer ; $8089A3 ;Animation thing
--------unidentified--------
818BD4  .db $A9 $02 $85 $03 $60  
----------------   
818BD9   LDX #$02 
818BDB   LDA $0D  
818BDD   BEQ $818BE0  
818BDF   INX
818BE0   JSR $8D2D
818BE3   JSR $8D4A
818BE6   JSL MoveHorizontal; $80C032  
818BEA   JSL FrameAnimationTimer; 8089A9  
818BEE   JSR $8D71
818BF1   BCS $818BF7  
818BF3   LDA $31  
818BF5   BEQ $818C0F  
818BF7   LDA #$14 
818BF9   STA $32  
818BFB   LDA $0D  
818BFD   EOR #$01 
818BFF   STA $0D  
818C01   LDA #$98 
818C03   LDY #$46 
818C05   JSL FrameAnimationNoTimer ; $8089A3 ;Animation thing
818C09   LDA #$0A 
818C0B   STA $03  
818C0D   STZ $30  
818C0F   RTS
----------------   
--------sub start--------
818C10   DEC $32  
818C12   BNE $818C30  
818C14   LDA $0D  
818C16   STA $0E  
818C18   LDA #$98 
818C1A   LDY #$46 
818C1C   JSL FrameAnimationNoTimer ; $8089A3 ;Animation thing
818C20   LDY #$05 
818C22   LDX #$0C 
818C24   LDA $30  
818C26   BEQ $818C2C  
818C28   LDY #$1C 
818C2A   LDX #$06 
818C2C   STY $32  
818C2E   STX $03  
818C30   RTS
----------------   
--------sub start--------
818C31   DEC $32  
818C33   BNE $818C44  
818C35   LDA #$98 
818C37   LDY #$31 
818C39   JSL FrameAnimationNoTimer ; $8089A3 ;Animation thing
818C3D   JSR $8AC4
818C40   LDA #$00 
818C42   STA $03  
818C44   RTS
----------------   
818C45   LDX $03  
818C47   JSR ($8C4F,X)
818C4A   JSL SpriteSaveDirectPage ; 8088CE  
818C4E   RTS
----------------   
--------data--------     
818C4F  .db $55 $8C $88 $FC $A9 $FC
----------------   
--------sub start--------
818C55   LDA #$02 
818C57   STA $03  
818C59   LDA #$98 
818C5B   LDY #$53 
818C5D   JSL FrameAnimationNoTimer ; $8089A3  
818C61   LDA #$03 
818C63   STA $00  
818C65   RTS
----------------   
818C66   JSL KillSprite ; 808F1E  
818C6A   RTS
----------------   
--------sub start--------
818C6B   STZ $2F  
818C6D   LDA $0100,Y  
818C70   BEQ $818CA4  
818C72   REP #$21 
818C74   LDA $14  
818C76   ADC #$0010   
818C79   SEC
818C7A   SBC $0114,Y  
818C7D   CMP #$0021   
818C80   BCS $818CA4  
818C82   LDA $11  
818C84   CLC
818C85   ADC #$0030   
818C88   SEC
818C89   SBC $0111,Y  
818C8C   CMP #$0061   
818C8F   BCS $818CA4  
818C91   LDA $0111,Y  
818C94   SEC
818C95   SBC $11  
818C97   BCS $818C9F  
818C99   EOR #$FFFF   
818C9C   INC
818C9D   INC $2F  
818C9F   STA $33,X
818CA1   SEP #$21 
818CA3   RTS
----------------   
818CA4   CLC
818CA5   SEP #$20 
818CA7   RTS
----------------   
--------sub start--------
818CA8   REP #$20 
818CAA   LDA $11  
818CAC   SEC
818CAD   SBC $0111,Y  
818CB0   BPL $818CB6  
818CB2   EOR #$FFFF   
818CB5   INC
818CB6   LSR
818CB7   LSR
818CB8   LSR
818CB9   STA $3B  
818CBB   LDA $11  
818CBD   LSR
818CBE   LSR
818CBF   LSR
818CC0   STA $3C  
818CC2   LDA $14  
818CC4   AND #$00F8   
818CC7   ASL
818CC8   ASL
818CC9   ADC $3C  
818CCB   REP #$10 
818CCD   TAY
818CCE   SEP #$20 
818CD0   DEC $3B  
818CD2   BEQ $818CE7  
818CD4   LDA $2F  
818CD6   BNE $818CDB  
818CD8   INY
818CD9   BRA $818CDC  
--------unidentified--------
818CDB  .db $88  
----------------   
818CDC   LDA $1400,Y  
818CDF   BMI $818CE3  
818CE1   BRA $818CD0  
818CE3   SEP #$10 
818CE5   CLC
818CE6   RTS
----------------   
818CE7   SEP #$11 
818CE9   RTS
----------------   
--------sub start--------
818CEA   REP #$20 
818CEC   LDX $3F  
818CEE   JSR ($8CF2,X)
818CF1   SEP #$20 
818CF3   RTS
----------------   
--------data--------     
818CF4  .db $16 $8D  
----------------   
--------unidentified--------
818CF6  .db $03 $8D $FA $8C $A5 $33 $38 $E5
818CFE  .db $35 $F0 $0D $90 $13 $AD $91 $01
818D06  .db $85 $37 $AD $94 $01 $85 $39 $60
818D0E  .db $AD $56 $01 $29 $FF $00 $D0 $ED
----------------   
--------sub start--------
818D16   LDA $0111
818D19   STA $37  
818D1B   LDA $0114
818D1E   STA $39  
818D20   RTS
----------------   
--------sub start--------
818D21   STZ $0D  
818D23   LDA $37  
818D25   SEC
818D26   SBC $11  
818D28   BCS $818D2C  
818D2A   INC $0D  
818D2C   RTS
----------------   
--------sub start--------
818D2D   SEP #$30 
818D2F   STZ $31  
818D31   LDA $11  
818D33   CLC
818D34   ADC $985C,X  
818D37   STA $000A
818D3A   LDA $14  
818D3C   STA $000C
818D3F   JSL $808A86  
818D43   BPL $818D47  
818D45   INC $31  
818D47   SEP #$10 
818D49   RTS
----------------   
--------sub start--------
818D4A   LDA $0D  
818D4C   BEQ $818D60  
818D4E   LDA $31  
818D50   BEQ $818D5F  
818D52   LDA $000A
818D55   EOR #$FF 
818D57   AND #$07 
818D59   INC
818D5A   CLC
818D5B   ADC $11  
818D5D   STA $11  
818D5F   RTS
----------------   
818D60   LDA $31  
818D62   BEQ $818D70  
818D64   LDA $000A
818D67   AND #$07 
818D69   EOR #$FF 
818D6B   CLC
818D6C   ADC $11  
818D6E   STA $11  
818D70   RTS
----------------   
--------sub start--------
818D71   REP #$20 
818D73   LDA $11  
818D75   SEC
818D76   SBC #$000A   
818D79   BMI $818D83  
818D7B   CMP #$00ED   
818D7E   BCC $818D8F  
818D80   SBC #$00EC   
818D83   EOR #$FFFF   
818D86   INC
818D87   CLC
818D88   ADC $11  
818D8A   STA $11  
818D8C   SEP #$21 
818D8E   RTS
----------------   
818D8F   SEP #$20 
818D91   CLC
818D92   RTS

;0x08 Ghost Sprite
818D93   LDX $02  
818D95   JMP ($8D98,X)
--------data--------     
818D98  .db $A0 $8D $1C $8E $F4 $8E $22 $8F
----------------   
818DA0   LDA #$02 
818DA2   STA $02  
818DA4   LDA #$01 
818DA6   STA $00  
818DA8   STA $01  
818DAA   STA $1C  
818DAC   STA $1D  
818DAE   JSL GetRandomInt ;$808859  
818DB2   TAX
818DB3   AND #$07 
818DB5   CLC
818DB6   ADC #$06 
818DB8   STA $17  
818DBA   STZ $3F  
818DBC   LDA #$40 
818DBE   STA $3E  
818DC0   TXA
818DC1   BPL $818DC9  
818DC3   DEC $3F  
818DC5   LDA #$C0 
818DC7   STA $3E  
818DC9   STZ $37  
818DCB   TXA
818DCC   AND #$01 
818DCE   BEQ $818DD4  
818DD0   LDA #$80 
818DD2   STA $37  
818DD4   TXA
818DD5   AND #$03 
818DD7   ASL
818DD8   TAX
818DD9   LDA $9866,X  
818DDC   LDY $9865,X  
818DDF   JSL FrameAnimationNoTimer ; $8089A3  
818DE3   LDA $0D  
818DE5   ASL
818DE6   STA $0D  
818DE8   LSR
818DE9   LSR
818DEA   STA $0E  
818DEC   LDA #$3D 
818DEE   STA $1B  
818DF0   LDA #$C0 
818DF2   STA $1A  
818DF4   LDA $0B  
818DF6   LSR
818DF7   TAX
818DF8   LDA $990D,X  
818DFB   STA $35  
818DFD   LDA $9911,X  
818E00   STA $34  
818E02   STZ $36  
818E04   STZ $03  
818E06   LDA $35  
818E08   STA $3D  
818E0A   LDA $03  
818E0C   BEQ $818E11  
818E0E   JMP $8EA7
818E11   LDA $9866
818E14   LDY $9865
818E17   JSL FrameAnimationNoTimer ; $8089A3  
818E1B   RTS
----------------   
818E1C   LDA $1D  
818E1E   CMP $1C  
818E20   BEQ $818E34  
818E22   INC
818E23   BNE $818E2B  
818E25   LDA $1C  
818E27   STA $1D  
818E29   BRA $818E34  
818E2B   LDA #$04 
818E2D   STA $02  
818E2F   STZ $03  
818E31   JMP $8EF4
818E34   LDA $00AC
818E37   BNE $818E49  
818E39   LDX $03  
818E3B   JSR ($8E4E,X)
818E3E   JSR $8EDC
818E41   JSL MoveSprite ; 80C007  
818E45   JSL FrameAnimationTimer; 8089A9  
818E49   JSL SpriteSaveDirectPage ; 8088CE  
818E4D   RTS
----------------   
--------data--------     
818E4E  .db $52 $8E $9D $8E
----------------   
--------sub start--------
818E52   JSR $8F27
--------sub start--------
818E55   LDA #$FF 
818E57   STA $37  
818E59   LDA $0100
818E5C   BEQ $818E65  
818E5E   LDA $0160
818E61   BEQ $818E65  
818E63   STZ $37  
818E65   LDA $0180
818E68   BEQ $818E7C  
818E6A   LDA $01E0
818E6D   BEQ $818E7C  
818E6F   LDA $37  
818E71   BNE $818E78  
818E73   JSR $8F48
--------unidentified--------
818E76  .db $80 $04 $A9 $80 $85 $37
----------------   
818E7C   LDA $37  
818E7E   CMP #$FF 
818E80   BEQ $818E94  
818E82   LDA $03  
818E84   BNE $818E9C  
818E86   LDA #$98 
818E88   LDY #$8F 
818E8A   JSL FrameAnimationNoTimer ; $8089A3  
818E8E   LDA #$02 
818E90   STA $03  
818E92   BRA $818EA7  
818E94   STZ $03  
818E96   LDA $36  
818E98   BEQ $818E9C  
818E9A   DEC $36  
818E9C   RTS
----------------   
--------sub start--------
818E9D   DEC $3D  
818E9F   BNE $818ED3  
818EA1   JSR $8E55
818EA4   JMP $8E06
818EA7   LDA #$01 
818EA9   XBA
818EAA   LDA $37  
818EAC   REP #$10 
818EAE   TAX
818EAF   JSL $808B0E  
818EB3   CLC
818EB4   ADC #$02 
818EB6   LSR
818EB7   LSR
818EB8   AND #$07 
818EBA   SEC
818EBB   SBC $0D  
818EBD   AND #$07 
818EBF   BEQ $818ED3  
818EC1   CMP #$04 
818EC3   LDX $0D  
818EC5   INX
818EC6   BCC $818ECA  
818EC8   DEX
818EC9   DEX
818ECA   TXA
818ECB   AND #$07 
818ECD   STA $0D  
818ECF   LSR
818ED0   LSR
818ED1   STA $0E  
818ED3   LDA $36  
818ED5   CMP $34  
818ED7   BCS $818EDB  
818ED9   INC $36  
818EDB   RTS
----------------   
--------sub start--------
818EDC   LDA $36  
818EDE   ASL
818EDF   TAX
818EE0   LDA $0D  
818EE2   ASL
818EE3   ASL
818EE4   ASL
818EE5   ASL
818EE6   ASL
818EE7   PHA
818EE8   LDY $98CB,X  
818EEB   LDA $98CC,X  
818EEE   PLX
818EEF   JSL $809252  
818EF3   RTS
----------------   
818EF4   LDX $03  
818EF6   JSR ($8EFE,X)
818EF9   JSL SpriteSaveDirectPage ; 8088CE  
818EFD   RTS
----------------   
--------data--------     
818EFE  .db $02 $8F $13 $8F
----------------   
--------sub start--------
818F02   LDA #$02 
818F04   STA $03  
818F06   INC
818F07   STA $00  
818F09   STZ $1D  
818F0B   LDA #$98 
818F0D   LDY #$B5 
818F0F   JSL FrameAnimationNoTimer ; $8089A3  
--------sub start--------
818F13   JSL FrameAnimationTimer; 8089A9  
818F17   LDA $08  
818F19   CMP #$50 
818F1B   BNE $818F21  
818F1D   LDA #$06 
818F1F   STA $02  
818F21   RTS
----------------   
818F22   JSL KillSprite ; 808F1E  
818F26   RTS
----------------   
--------sub start--------
818F27   REP #$21 
818F29   LDA $3E  
818F2B   ADC $16  
818F2D   STA $16  
818F2F   SEP #$20 
818F31   LDA $17  
818F33   CMP #$06 
818F35   BCC $818F3B  
818F37   CMP #$11 
818F39   BCC $818F47  
818F3B   REP #$20 
818F3D   LDA $3E  
818F3F   EOR #$FFFF   
818F42   INC
818F43   STA $3E  
818F45   SEP #$20 
818F47   RTS
----------------   
--------unidentified--------
818F48  .db $64 $38 $64 $00 $C2 $10 $A2 $00
818F50  .db $02 $BD $0A $00 $C5 $0A $D0 $12
818F58  .db $BD $00 $00 $C9 $01 $D0 $0B $E6
818F60  .db $38 $BD $37 $00 $F0 $04 $C6 $38
818F68  .db $C6 $38 $C2 $21 $8A $69 $50 $00
818F70  .db $AA $E2 $20 $E0 $80 $09 $D0 $D9
818F78  .db $E2 $10 $64 $37 $A5 $38 $D0 $14
818F80  .db $22 $9A $91 $80 $08 $AD $00 $00
818F88  .db $85 $37 $28 $D0 $0D $64 $37 $AD
818F90  .db $56 $01 $D0 $06 $30 $04 $A9 $80
818F98  .db $85 $37 $E6 $00 $60 


;0x0A Bat Sprite
818F9D   LDX $02                  
818F9F   JMP ($8FA2,X)            
--------data--------     
818FA2  .db $AA $8F $0E $90      
----------------         
--------unidentified--------
818FA6  .db $2A $91 $4B $91      
----------------         
818FAA   LDA #$02                 
818FAC   STA $02                  
818FAE   LDA #$01                 
818FB0   STA $00                  
818FB2   STA $01                  
818FB4   STA $1C                  
818FB6   STA $1D                  
818FB8   LDA #$10                 
818FBA   STA $17                  
818FBC   LDA #$3D                 
818FBE   STA $1B                  
818FC0   LDA #$C0                 
818FC2   STA $1A                  
818FC4   STZ $0E                  
818FC6   STZ $3D                  
818FC8   LDA #$01                 
818FCA   STA $3E                  
--------sub start--------
818FCC   LDA $11                  
818FCE   STA $3A                  
818FD0   LDA $14                  
818FD2   STA $3B                  
818FD4   REP #$20                 
818FD6   LDA #$0030               
818FD9   STA $30                  
818FDB   SEP #$20                 
818FDD   LDA $0D                  
818FDF   ASL                      
818FE0   ASL                      
818FE1   ASL                      
818FE2   ASL                      
818FE3   TAX                      
818FE4   LDA $31                  
818FE6   LDY $30                  
818FE8   JSL $809252              
818FEC   LDA #$99                 
818FEE   LDY #$15                 
818FF0   JSL $8089A3              
818FF4   JSL $808859              
818FF8   AND #$0F                 
818FFA   STA $0D                  
818FFC   ASL                      
818FFD   ASL                      
818FFE   ASL                      
818FFF   ASL                      
819000   TAX                      
819001   LDA $31                  
819003   LDY $30                  
819005   JSL $809252              
819009   LDA #$0A                 
81900B   STA $3C                  
81900D   RTS                      
----------------         
81900E   LDA $1D                  
819010   CMP $1C                  
819012   BEQ $81901D              
819014   LDA #$04                 
819016   STA $02                  
819018   STZ $03                  
81901A   JMP $912A                
81901D   LDA $00AC                
819020   BNE $81902E              
819022   LDX $03                  
819024   JSR ($9033,X)            
819027   JSL $8089A9              
81902B   JSR $926D                
81902E   JSL $8088CE              
819032   RTS                      
----------------         
--------data--------     
819033 
dw $9037
dw $90A9     
----------------         
--------sub start--------
819037   JSL $80C007              
81903B   DEC $3C                  
81903D   BNE $81907C              
81903F   LDA $3A                  
819041   CLC                      
819042   ADC #$10                 
819044   SEC                      
819045   SBC $11                  
819047   CMP #$20                 
819049   BCS $819059              
81904B   LDA $3B                  
81904D   CLC                      
81904E   ADC #$10                 
819050   SEC                      
819051   SBC $14                  
819053   CMP #$20                 
819055   BCS $819059              
819057   BRA $819061              


819059  .db $A5 $0D $49 $08 $85 $0D $80 $08
     

819061   JSL $808859              
819065   AND #$0F                 
819067   STA $0D                  
819069   LDA $0D                  
81906B   ASL                      
81906C   ASL                      
81906D   ASL                      
81906E   ASL                      
81906F   TAX                      
819070   LDA $31                  
819072   LDY $30                  
819074   JSL $809252              
819078   LDA #$0A                 
81907A   STA $3C                  
81907C   STZ $39                  
81907E   LDX #$00                 
819080   LDA $0100,X              
819083   BEQ $819092              
819085   JSR $917D                
819088   BCC $819092              
81908A   LDA #$01                 
81908C   STA $39                  
81908E   LDA #$02                 
819090   STA $03                  
819092   LDX #$80                 
819094   LDA $0100,X              
819097   BEQ $8190A8              
819099   JSR $917D                


81909C  .db $90 $0A $A9 $02
8190A0  .db $05 $39 $85 $39 $A9 $02 $85 $03
8190A8  .db $60 

8190A9   LDX $04                  
8190AB   JMP ($90AE,X)            
--------data--------     
8190AE  .db $B2 $90 $F9 $90      
----------------         
8190B2   LDA #$02                 
8190B4   STA $04                  
8190B6   REP #$10                 
8190B8   LDA #$00                 
8190BA   XBA                      
8190BB   LDA $39                  
8190BD   ASL                      
8190BE   TAX                      
8190BF   JMP ($90C0,X) ;X Cant ever be 0x00 here
8190C0   
dw $90C0 ;0x00 <- this is part of of the jump this value should never be used!!
8190C2  
dw $90D2 ;0x02
dw $90DB ;0x04
dw $90C8 ;0x06

;This looks like code -never reached?
8190C8  .db $E2 $10 $22 $9A
8190CC  .db $91 $80 $C2 $10 $D0 $09
   
8190D2   LDA #$00                 
8190D4   STA $38                  
8190D6   LDX #$0100               
8190D9   BRA $8190E2              

;This looks like code -never reached?
8190DB  .db $A9 $80 $A2 $80 $01 $85 $38

8190E2   JSL $808B0E              
8190E6   INC                      
8190E7   LSR                      
8190E8   AND #$0F                 
8190EA   STA $0D                  
8190EC   LDA $31                  
8190EE   LDY $30                  
8190F0   LDA #$FF                 
8190F2   STA $36                  
8190F4   LDA #$0E                 
8190F6   STA $3C                  
8190F8   RTS                      

8190F9   DEC $3C                  
8190FB   BNE $819122              
8190FD   LDA #$0E                 
8190FF   STA $3C                  
819101   LDX $38                  
819103   JSR $917D                
819106   BCS $819110              
819108   JSR $8FCC                
81910B   STZ $03                  
81910D   STZ $04                  
81910F   RTS                      

819110   JSR $91A8                
819113   LDA $0D                  
819115   ASL                      
819116   ASL                      
819117   ASL                      
819118   ASL                      
819119   TAX                      
81911A   LDA $31                  
81911C   LDY $30                  
81911E   JSL $809252              
819122   JSR $91D6                
819125   JSL $80C007              
819129   RTS                      

81912A   LDX $03                  
81912C   JSR ($9134,X)            
81912F   JSL $8088CE              
819133   RTS                      
 
819134
dw $913A 
dw $FC88
dw $FCA9

81913A   LDA #$02                 
81913C   STA $03                  
81913E   LDA #$99                 
819140   LDY #$20                 
819142   JSL FrameAnimationNoTimer ; $8089A3             
819146   LDA #$03                 
819148   STA $00                  
81914A   RTS                      
     
81914B   JSL KillSprite ; 808F1E ;Kill current sprite              
81914F   RTS                      

819150  .db $C6 $3E $D0 $28 $A5 $3D $F0 $06
819158  .db $C9 $05 $F0 $08 $80 $0A $A9 $01
819160  .db $85 $3F $80 $04 $A9 $FF $85 $3F
819168  .db $A5 $3F $18 $65 $17 $85 $17 $A5
819170  .db $3F $18 $65 $3D $85 $3D $AA $BD
819178  .db $24 $99 $85 $3E $60 

81917D   LDA $0100,X              
819180   BEQ $8191A4              
819182   REP #$21                 
819184   LDA $14                  
819186   ADC #$0060               
819189   SEC                      
81918A   SBC $0114,X              
81918D   CMP #$00C1               
819190   BCS $8191A4              
819192   LDA $11                  
819194   CLC                      
819195   ADC #$0050               
819198   SEC                      
819199   SBC $0111,X              
81919C   CMP #$00A1               
81919F   BCS $8191A4              
8191A1   SEP #$21                 
8191A3   RTS                      
----------------         
8191A4   CLC                      
8191A5   SEP #$20                 
8191A7   RTS                      
----------------         
--------sub start--------
8191A8   REP #$10                 
8191AA   LDA $38                  
8191AC   BEQ $8191B3              
8191AE   LDX #$0180               
8191B1   BRA $8191B6              
8191B3   LDX #$0100               
8191B6   JSL $808B0E              
8191BA   INC                      
8191BB   LSR                      
8191BC   AND #$0F                 
8191BE   SEC                      
8191BF   SBC $0D                  
8191C1   BEQ $8191D5              
8191C3   AND #$0F                 
8191C5   CMP #$08                 
8191C7   BPL $8191CD              
8191C9   INC $0D                  
8191CB   BRA $8191CF              
8191CD   DEC $0D                  
8191CF   LDA $0D                  
8191D1   AND #$0F                 
8191D3   STA $0D                  
8191D5   RTS                      
----------------         
--------sub start--------
8191D6   LDA $36                  
8191D8   BMI $81920F              
8191DA   LDX $35                  
8191DC   LDA $0100,X              
8191DF   LDX $36                  
8191E1   SEC                      
8191E2   SBC $11,X                
8191E4   BEQ $81920A              
8191E6   CMP #$01                 
8191E8   BEQ $81920A              
8191EA   CMP #$FF                 
8191EC   BEQ $81920A              
8191EE   CMP #$FE                 
8191F0   BEQ $81920A              
8191F2   REP #$20                 
8191F4   LDA $30                  
8191F6   CMP #$0100               
8191F9   SEP #$20                 
8191FB   BEQ $819209              
8191FD   REP #$20                 
8191FF   LDA $30                  
819201   CLC                      
819202   ADC #$0008               
819205   STA $30                  
819207   SEP #$20                 
819209   RTS                      
----------------         
81920A   LDA #$FF                 
81920C   STA $36                  
81920E   RTS                      
----------------         
81920F   REP #$20                 
819211   LDA $30                  
819213   BEQ $819220              
819215   LDA $30                  
819217   SEC                      
819218   SBC #$0008               
81921B   STA $30                  
81921D   SEP #$20                 
81921F   RTS                      
----------------         
819220   SEP #$20                 
819222   LDX $38                  
819224   LDA $0111,X              
819227   SEC                      
819228   SBC $11                  
81922A   BPL $81922F              
81922C   EOR #$FF                 
81922E   INC                      
81922F   STA $3A                  
819231   LDA $0114,X              
819234   SEC                      
819235   SBC $14                  
819237   BPL $81923C              
819239   EOR #$FF                 
81923B   INC                      
81923C   CMP $3A                  
81923E   BCC $81924B              
819240   LDA #$03                 
819242   STA $36                  
819244   LDA $38                  
819246   CLC                      
819247   ADC #$14                 
819249   BRA $819252              
81924B   STZ $36                  
81924D   LDA $38                  
81924F   CLC                      
819250   ADC #$11                 
819252   STA $35                  
819254   REP #$10                 
819256   LDA $38                  
819258   BEQ $81925F              
81925A   LDX #$0180               
81925D   BRA $819262              
81925F   LDX #$0100               
819262   JSL $808B0E              
819266   INC                      
819267   LSR                      
819268   AND #$0F                 
81926A   STA $0D                  
81926C   RTS                      
----------------         
--------sub start--------
81926D   REP #$20                 
81926F   LDA $11                  
819271   SEC                      
819272   SBC #$0017               
819275   BMI $81927F              
819277   CMP #$00D3               
81927A   BCC $819288              
81927C   SBC #$00D0               
81927F   EOR #$FFFF               
819282   INC                      
819283   CLC                      
819284   ADC $11                  
819286   STA $11                  
819288   LDA $14                  
81928A   SEC                      
81928B   SBC #$0023               
81928E   BMI $819298              
819290   CMP #$00AB               
819293   BCC $8192A1              
819295   SBC #$00AA               
819298   EOR #$FFFF               
81929B   INC                      
81929C   CLC                      
81929D   ADC $14                  
81929F   STA $14                  
8192A1   SEP #$20                 
8192A3   RTS                      


;Sprite 0x0C - All Pirates
8192A4   LDX $0B  
8192A6   JSR ($92AA,X)
8192A9   RTS
    
8192AA
dw $E0E3 ;0x00 - Small Blue Pirate
dw $E795 ;0x02 - Green small pirate (jester?)
dw $E9A5 ;0x04 - Small red pirate
dw $E0E3 ;0x06 - <- same as 0x00
dw $ED10 ;0x08 - Yellowhat Big Blue Pirate 
dw $F2C4 ;0x0A - Purplehat Big Blue Pirate
dw $F52A ;0x0C - Greenhat Big Blue Pirate
dw $F7A2 ;0x0E - Red Big Pirate

;0x10 Alive Armor
8192BA   LDX $02  
8192BC   JMP ($92BF,X)
--------data--------     
8192BF  .db $C7 $92 $32 $93
----------------   
--------unidentified--------
8192C3  .db $13 $95 $E3 $95
----------------   
8192C7   LDA #$02 
8192C9   STA $02  
8192CB   STA $32  
8192CD   STZ $04  
8192CF   STZ $0E  
8192D1   DEC
8192D2   STA $01  
8192D4   STA $1C  
8192D6   STA $1D  
8192D8   LDA #$40 
8192DA   STA $1A  
8192DC   LDA #$01 
8192DE   STA $00  
8192E0   LDA #$99 
8192E2   LDY #$F3 
8192E4   JSL $80896D  
8192E8   LDA $0B  
8192EA   CMP #$08 
8192EC   BNE $8192F6  
8192EE   LDA #$04 
8192F0   STA $03  
8192F2   JSR $9370
--------unidentified--------
8192F5  .db $60  
----------------   
8192F6   LDX #$0E 
8192F8   STX $1E  
8192FA   CMP #$0A 
8192FC   BNE $819313  
8192FE   LDA #$04 
819300   STA $02  
819302   LDA #$0A 
819304   STA $03  
819306   LDA #$03 
819308   STA $00  
81930A   LDA #$99 
81930C   LDY #$ED 
81930E   JSL FrameAnimationNoTimer ; $8089A3  
--------unidentified--------
819312  .db $60  
----------------   
819313   TAX
819314   LSR
819315   TAY
819316   LDA $9B11,Y  
819319   STA $31  
81931B   LDA $99FA,X  
81931E   LDY $99F9,X  
819321   JSL Sprite_SetSpeeds ; 80BF9F  
819325   LDA $0D  
819327   STA $3A  
819329   ASL
81932A   ASL
81932B   STA $0D  
81932D   STZ $38  
81932F   JSR $9370
819332   LDA $1D  
819334   CMP $1C  
819336   BEQ $819348  
819338   INC
819339   BNE $81933F  
81933B   LDA $1C  
81933D   STA $1D  
81933F   LDA #$04 
819341   STA $02  
819343   STZ $03  
819345   JMP $9513
819348   LDA $00AC
81934B   BNE $819352  
81934D   LDX $03  
81934F   JSR ($9357,X)
819352   JSL SpriteSaveDirectPage ; 8088CE  
819356   RTS
----------------   
--------data--------     
819357  .db $5D $93  
----------------   
--------unidentified--------
819359  .db $D5 $93 $1C $94
----------------   
--------sub start--------
81935D   LDX $04  
81935F   JMP ($9362,X)
--------data--------     
819362  .db $6A $93 $79 $93
----------------   
--------unidentified--------
819366  .db $92 $93 $BA $93
----------------   
81936A   LDA #$02 
81936C   STA $04  
81936E   STZ $39  
--------sub start--------
819370   LDA #$99 
819372   LDY #$3C 
819374   JSL FrameAnimationNoTimer ; $8089A3  
819378   RTS
----------------   
819379   LDX #$00 
81937B   JSL $8091F6  
81937F   BCC $819391  
819381   LDA #$04 
819383   STA $04  
819385   JSL GetRandomInt ;$808859  
--------unidentified--------
819389  .db $29 $0F $AA $BD $01 $9B $85 $3E
----------------   
819391   RTS
----------------   
--------unidentified--------
819392  .db $C6 $3E $D0 $23 $A2 $00 $22 $F6
81939A  .db $91 $80 $B0 $04 $64 $04 $80 $17
8193A2  .db $AD $04 $00 $C9 $FF $D0 $07 $22
8193AA  .db $9A $91 $80 $AD $00 $00 $85 $3B
8193B2  .db $20 $D0 $94 $A9 $06 $85 $04 $60
8193BA  .db $A2 $01 $22 $F6 $91 $80 $B0 $F7
8193C2  .db $A9 $02 $85 $03 $64 $04 $A9 $01
8193CA  .db $85 $39 $A5 $3A $20 $02 $95 $22
8193D2  .db $A3 $BF $80 $A2 $03 $22 $F6 $91
8193DA  .db $80 $90 $01 $60 $20 $D0 $94 $22
8193E2  .db $A9 $89 $80 $A5 $08 $C5 $31 $D0
8193EA  .db $08 $A9 $01 $85 $08 $22 $A9 $89
8193F2  .db $80 $20 $50 $94 $AD $9F $00 $18
8193FA  .db $65 $25 $29 $03 $D0 $15 $C6 $32
819402  .db $D0 $06 $A9 $08 $85 $32 $64 $35
81940A  .db $A5 $35 $D0 $07 $20 $E0 $94 $22
819412  .db $A3 $BF $80 $22 $07 $C0 $80 $4C
81941A  .db $1E $E5 $A6 $04 $7C $21 $94 $25
819422  .db $94 $4F $94 $A9 $02 $85 $04 $A5
81942A  .db $11 $4A $4A $4A $8D $02 $00 $9C
819432  .db $03 $00 $C2 $30 $A5 $14 $29 $F8
81943A  .db $00 $0A $0A $6D $02 $00 $AA $A9
819442  .db $80 $80 $9D $FF $13 $9D $DF $13
81944A  .db $E2 $30 $4C $6E $93 $60 $A5 $33
819452  .db $D0 $2D $64 $37 $A5 $3A $0A $AA
81945A  .db $DA $BD $15 $AF $BC $16 $AF $20
819462  .db $CA $FD $F0 $02 $E6 $37 $FA $BD
81946A  .db $1D $AF $BC $1E $AF $20 $CA $FD
819472  .db $F0 $06 $A5 $37 $09 $02 $85 $37
81947A  .db $A5 $37 $0A $AA $7C $84 $94 $C6
819482  .db $33 $60 $8C $94 $9E $94 $B2 $94
81948A  .db $BD $94 $A5 $35 $F0 $0D $A9 $30
819492  .db $85 $33 $20 $E0 $94 $22 $A3 $BF
81949A  .db $80 $64 $35 $60 $4A $85 $34 $A5
8194A2  .db $3A $0A $0A $69 $02 $29 $0F $85
8194AA  .db $0D $22 $A3 $BF $80 $E6 $35 $60
8194B2  .db $4A $85 $34 $A5 $3A $0A $0A $E9
8194BA  .db $01 $80 $EA $A5 $0B $30 $0E $A5
8194C2  .db $34 $C9 $01 $D0 $02 $80 $B3 $C9
8194CA  .db $02 $D0 $02 $80 $AD $60 $A6 $3B
8194D2  .db $BD $00 $01 $C9 $01 $F0 $06 $68
8194DA  .db $68 $64 $03 $64 $04 $60 $A9 $01
8194E2  .db $EB $A5 $3B $C2 $10 $AA $22 $0E
8194EA  .db $8B $80 $48 $1A $4A $29 $0F $85
8194F2  .db $0D $68 $18 $69 $04 $4A $4A $4A
8194FA  .db $29 $03 $C5 $3A $F0 $12 $85 $3A
819502  .db $0A $AA $4A $4A $85 $0E $BD $44
81950A  .db $99 $BC $43 $99 $22 $A3 $89 $80
819512  .db $60 $A6 $03 $FC $1D $95 $22 $CE
81951A  .db $88 $80 $60 $2B $95 $55 $95 $69
819522  .db $95 $D6 $95 $E3 $95 $88 $FC $A9
81952A  .db $FC $A9 $02 $85 $03 $3A $85 $1C
819532  .db $A5 $0D $4A $85 $0E $A9 $99 $A0
81953A  .db $A5 $22 $A3 $89 $80 $A9 $04 $85
819542  .db $3D $A9 $02 $85 $39 $A9 $B0 $85
81954A  .db $3E $A9 $10 $85 $1E $A9 $2D $22
819552  .db $53 $9A $80 $AD $AC $00 $D0 $0E
81955A  .db $22 $A9 $89 $80 $A5 $08 $C9 $50
819562  .db $D0 $04 $A5 $3D $85 $03 $60 $AD
81956A  .db $AC $00 $D0 $67 $C6 $3E $D0 $17
819572  .db $A9 $99 $A0 $BA $22 $A3 $89 $80
81957A  .db $A9 $02 $85 $03 $3A $85 $39 $A9
819582  .db $06 $85 $3D $A9 $0E $85 $1E $A5
81958A  .db $38 $F0 $48 $A9 $02 $85 $03 $A9
819592  .db $08 $85 $3D $A9 $2D $22 $53 $9A
81959A  .db $80 $A9 $99 $A0 $D4 $22 $A3 $89
8195A2  .db $80 $22 $73 $8F $80 $B0 $2A $A9
8195AA  .db $03 $9D $00 $00 $A5 $0A $9D $0A
8195B2  .db $00 $A9 $0A $9D $0B $00 $A5 $0D
8195BA  .db $9D $0D $00 $4A $9D $0E $00 $C2
8195C2  .db $21 $A5 $11 $9D $11 $00 $A5 $14
8195CA  .db $69 $F6 $FF $9D $14 $00 $9E $02
8195D2  .db $00 $E2 $30 $60 $A9 $02 $85 $02
8195DA  .db $85 $03 $64 $38 $64 $39 $4C $C8
8195E2  .db $93 $22 $1E $8F $80 $60

;0x12 Small Canonball
8195E8   LDX $02  
8195EA   JMP ($95ED,X)
--------data--------     
8195ED  .db $F3 $95 $44 $96 $59 $96
----------------   
8195F3   LDA #$02 
8195F5   STA $02  
8195F7   DEC
8195F8   STA $00  
8195FA   STA $01  
8195FC   STA $0C  
8195FE   LDA $00B7
819601   CMP #$0B 
819603   BEQ $819607  
819605   STZ $0C  
819607   STZ $0E  
819609   LDY #$15 
81960B   LDA #$9B 
81960D   JSL $80896D  
819611   LDA #$40 
819613   STA $1A  
819615   LDA $0B  
819617   ASL
819618   ORA $0D  
81961A   ASL
81961B   ASL
81961C   TAX
81961D   REP #$20 
81961F   LDA $9B19,X  
819622   STA $28  
819624   LDA $9B1B,X  
819627   STA $2A  
819629   SEP #$20 
81962B   LDA $0D  
81962D   AND #$01 
81962F   ORA $0B  
819631   TAX
819632   LDA $9B51,X  
819635   STA $3F  
819637   LDX $0B  
819639   LDY $9B39,X  
81963C   LDA $9B3A,X  
81963F   JSL FrameAnimationNoTimer ; $8089A3  
819643   RTS
----------------   
819644   JSL FrameAnimationTimer; 8089A9  
819648   JSL MoveSprite ; 80C007  
81964C   JSL SpriteSaveDirectPage ; 8088CE  
819650   DEC $3F  
819652   BNE $819658  
819654   LDA #$04 
819656   STA $02  
819658   RTS
----------------   
819659   JSL KillSprite ; 808F1E  
81965D   RTS

;Sprite 0x14 Big Canonball following Path
81965E   LDX $02                  
819660   JMP ($9663,X)            
--------unidentified--------
819663  .db $6B $96              
----------------         
--------data--------     
819665  .db $9E $96              
----------------         
--------unidentified--------
819667  .db $DB $96 $E0 $96 $A9 $02 $85 $02
81966F  .db $3A $85 $00 $85 $01 $A9 $2B $85
819677  .db $1B $A9 $40 $85 $1A $A0 $BF $A9
81967F  .db $9B $22 $A3 $89 $80 $A9 $A0 $85
819687  .db $11 $64 $14 $64 $15 $64 $10 $64
81968F  .db $13 $64 $0E $64 $3F $A0 $97 $A9
819697  .db $9B $22 $9F $BF $80 $80 $26
----------------         
81969E   JSL SpriteSaveDirectPage ; 8088CE              
8196A2   JSL FrameAnimationTimer; 8089A9              
8196A6   LDA $3E                  
8196A8   BEQ $8196AE              
8196AA   DEC $3E                  
8196AC   BRA $8196B6              
8196AE   JSL MoveSprite ; 80C007              
8196B2   DEC $0F                  
8196B4   BEQ $8196B7              
8196B6   RTS                      
----------------         
8196B7   INC $3F                  
8196B9   LDA $3F                  
8196BB   CMP #$21                 
8196BD   BNE $8196C4              
8196BF   LDA #$04                 
8196C1   STA $02                  
8196C3   RTS                      
----------------         
8196C4   LDA $3F                  
8196C6   ASL                      
8196C7   TAX                      
8196C8   LDA $9B55,X              
8196CB   STA $0D                  
8196CD   LDA $9B56,X              
8196D0   STA $0F                  
8196D2   JSL Sprite_SetSpeedsAlt ; 80BFA3              
8196D6   LDA #$01                 
8196D8   STA $3E                  
8196DA   RTS                      
----------------         
--------unidentified--------
8196DB  .db $22 $1E $8F $80 $60 $60

;0x16 Rolling pin spikes

8196E1   LDX $02                  
8196E3   JMP ($96E6,X)            
--------data--------     
8196E6  .db $EA $96 $19 $97      
----------------         
8196EA   LDA #$02                 
8196EC   STA $02                  
8196EE   DEC                      
8196EF   STA $00                  
8196F1   STA $01                  
8196F3   STA $0E                  
8196F5   STA $0D                  
8196F7   STZ $2A                  
8196F9   STZ $2B                  
8196FB   JSL $808859              
8196FF   BMI $819707              
819701   LDA $0D                  
819703   EOR #$02                 
819705   STA $0D                  
819707   LDX #$05                 
819709   LDA $0B                  
81970B   BNE $81970F              
81970D   LDX #$04                 
81970F   STX $3A                  
819711   LDA #$37                 
819713   STA $1B                  
819715   LDA #$40                 
819717   STA $1A                  
819719   LDX $03                  
81971B   JSR ($9723,X)            
81971E   JSL SpriteSaveDirectPage ; 8088CE              
819722   RTS                      
----------------         
--------data--------     
819723  .db $29 $97 $51 $97 $79 $97
----------------         
--------sub start--------
819729   LDA #$02                 
81972B   STA $03                  
81972D   LDA $0D                  
81972F   EOR #$02                 
819731   STA $0D                  
819733   DEC                      
819734   TAX                      
819735   LDA $9BD0,X              
819738   LDY $9BCF,X              
81973B   JSL FrameAnimationNoTimer ; $8089A3              
81973F   LDA $0D                  
819741   DEC                      
819742   CLC                      
819743   ADC $0B                  
819745   TAX                      
819746   LDA $9C01,X              
819749   STA $28                  
81974B   LDA $9C02,X              
81974E   STA $29                  
819750   RTS                      
----------------         
--------sub start--------
819751   JSL FrameAnimationTimer; 8089A9              
819755   LDA $08                  
819757   CMP $3A                  
819759   BNE $819763              
81975B   LDA #$01                 
81975D   STA $08                  
81975F   JSL FrameAnimationTimer; 8089A9              
819763   JSL MoveSprite ; 80C007              
819767   LDA #$9C                 
819769   LDY #$09                 
81976B   LDX #$05                 
81976D   JSR $9782                
819770   BEQ $819778              
819772   LDA #$04                 
819774   STA $03                  
819776   STA $3D                  
819778   RTS                      
----------------         
--------sub start--------
819779   DEC $3D                  
81977B   BEQ $819729              
81977D   RTS                      
----------------         
--------unidentified--------
81977E  .db $20 $82 $97 $6B      
----------------         
--------sub start--------
819782   STX $0004                
819785   STA $0001                
819788   STY $0000                
81978B   REP #$31                 
81978D   LDA $0D                  
81978F   AND #$00FF               
819792   ADC $0000                
819795   TAY                      
819796   LDA $0000,Y              
819799   AND #$00FF               
81979C   CLC                      
81979D   ADC $0000                
8197A0   TAX                      
8197A1   SEP #$20                 
8197A3   LDA $0D                  
8197A5   LSR                      
8197A6   BCS $8197D2              
8197A8   LDA $0000,X              
8197AB   ADC $14                  
8197AD   STA $000C                
8197B0   LDA $0001,X              
8197B3   CLC                      
8197B4   ADC $11                  
8197B6   STA $000A                
8197B9   STX $0000                
8197BC   JSL $808A86              
--------unidentified--------
8197C0  .db $D0 $3B $C2 $10 $AE $00 $00 $E8
8197C8  .db $8E $00 $00 $CE $04 $00 $D0 $E0
8197D0  .db $80 $2B              
----------------         
8197D2   LDA $0000,X              
8197D5   CLC                      
8197D6   ADC $11                  
8197D8   STA $000A                
8197DB   LDA $0001,X              
8197DE   CLC                      
8197DF   ADC $14                  
8197E1   STA $000C                
8197E4   STX $0000                
8197E7   JSL $808A86              
8197EB   BNE $8197FD              
8197ED   REP #$10                 
8197EF   LDX $0000                
8197F2   INX                      
8197F3   STX $0000                
8197F6   DEC $0004                
8197F9   BNE $8197DB              
8197FB   BRA $8197FD              
8197FD   SEP #$10                 
8197FF   RTS                      



;0x18 Moving Spike Sprite 
819800   LDX $02                  
819802   JMP ($9805,X)            
     
819805  
dw $980D ;Init?
dw $983E 
dw $987E
dw $987F

Sprite_Spike_Init:
{
81980D   LDA #$02                 
81980F   STA $02                  
819811   DEC                      
819812   STA $00                  
819814   STA $01                  
819816   LDA #$3D                 
819818   STA $1B                  
81981A   LDA #$40                 
81981C   STA $1A                  
81981E   LDY #$52                 
819820   LDA #$9C                 
819822   JSL FrameAnimationNoTimer ; $8089A3              
819826   LDA $0B                  
819828   TAX                      
819829   LSR                      
81982A   TAY                      
81982B   LDA $9C19,Y              
81982E   STA $3D                  
819830   LSR                      
819831   STA $3E                  
819833   LDY $9C1C,X              
819836   LDA $9C1D,X              
819839   JSL Sprite_SetSpeeds ; 80BF9F 
81983D   RTS                      
}


81983E   LDA $00AC                
819841   BNE $819848              
819843   LDX $03                  
819845   JSR ($984D,X)            
819848   JSL SpriteSaveDirectPage ; 8088CE ;Set something from B9              
81984C   RTS  

 
81984D   
dw $9853 
dw $9868 
dw $9879

819853   LDA $0D                  
819855   INC                      
819856   INC                      
819857   AND #$03                 
819859   STA $0D                  
81985B   JSL Sprite_SetSpeedsAlt ; 80BFA3              
81985F   LDA #$05                 
819861   STA $3F                  
819863   LDA #$02                 
819865   STA $03                  
819867   RTS                      


819868   DEC $3E                  
81986A   BNE $819874              
81986C   LDA $3D                  
81986E   STA $3E                  
819870   LDA #$04                 
819872   STA $03                  
819874   JSL MoveSprite ; 80C007              
819878   RTS                      


819879   DEC $3F                  
81987B   BEQ $819853              
81987D   RTS                      

;??
81987E  .db $60 $60              


;0x1A sprite Frog
819880   LDX $02  
819882   JMP ($9885,X)
--------data--------     
819885  .db $8D $98 $52 $99 $E0 $9A $34 $9B
----------------   
81988D   LDX $0B  
81988F   JMP ($9892,X)
--------unidentified--------
819892  .db $98 $98  
----------------   
--------data--------     
819894  .db $98 $98  
----------------   
--------unidentified--------
819896  .db $C9 $98  
----------------   
819898   LDA #$02 
81989A   STA $02  
81989C   LDA $0D  
81989E   ASL
81989F   TAX
8198A0   AND #$04 
8198A2   STA $0E  
8198A4   LDY $9C5D,X  
8198A7   LDA $9C5E,X  
8198AA   JSL FrameAnimationNoTimer ; $8089A3  
8198AE   LDA #$01 
8198B0   STA $00  
8198B2   STA $01  
8198B4   STA $1C  
8198B6   STA $1D  
8198B8   LDA #$3F 
8198BA   STA $1B  
8198BC   LDA #$80 
8198BE   STA $1A  
8198C0   LDA #$9C 
8198C2   LDY #$93 
8198C4   JSL Sprite_SetSpeeds ; 80BF9F  
8198C8   RTS
----------------   
--------unidentified--------
8198C9  .db $AD $AC $00 $D0 $05 $A6 $03 $FC
8198D1  .db $D4 $98 $60 $DA $98 $06 $99 $32
8198D9  .db $99 $A9 $02 $85 $03 $20 $AE $98
8198E1  .db $A9 $03 $85 $00 $A5 $0D $0A $AA
8198E9  .db $29 $04 $85 $0E $BC $65 $9C $BD
8198F1  .db $66 $9C $22 $A3 $89 $80 $C6 $01
8198F9  .db $22 $59 $88 $80 $29 $0F $AA $BD
819901  .db $A3 $9C $85 $4E $60 $C6 $4E $D0
819909  .db $27 $22 $8E $8F $80 $B0 $17 $A9
819911  .db $03 $9D $00 $00 $A9 $10 $9D $0A
819919  .db $00 $9E $0B $00 $A5 $11 $9D $11
819921  .db $00 $A5 $14 $9D $14 $00 $E2 $10
819929  .db $A9 $04 $85 $03 $A9 $06 $85 $4E
819931  .db $60 $C6 $4E $D0 $1B $A9 $0F $22
819939  .db $53 $9A $80 $E6 $01 $A9 $01 $85
819941  .db $00 $20 $5D $9A $A9 $02 $85 $02
819949  .db $A9 $06 $85 $03 $A9 $02 $85 $04
819951  .db $60  
----------------   
819952   LDA $1D  
819954   CMP $1C  
819956   BEQ $819963  
819958   LDA #$04 
81995A   STA $02  
81995C   STZ $03  
81995E   STZ $04  
819960   JMP $9AE0
819963   LDA $00AC
819966   BNE $819970  
819968   LDX $03  
81996A   JSR ($9975,X)
81996D   JSR $9B39
819970   JSL SpriteSaveDirectPage ; 8088CE  
819974   RTS
----------------   
--------data--------     
819975  .db $7D $99 $86 $99 $98 $99 $31 $9A
----------------   
--------sub start--------
81997D   LDA #$02 
81997F   STA $03  
819981   LDA #$01 
819983   STA $4E  
819985   RTS
----------------   
--------sub start--------
819986   DEC $4E  
819988   BNE $819997  
81998A   JSL GetRandomInt ;$808859  
81998E   BMI $819995  
819990   LDA #$04 
819992   STA $03  
819994   RTS
----------------   
819995   STZ $03  
819997   RTS
----------------   
--------sub start--------
819998   LDX $0B  
81999A   JMP ($999D,X)
--------unidentified--------
81999D  .db $A3 $99  
----------------   
--------data--------     
81999F  .db $D6 $99  
----------------   
--------unidentified--------
8199A1  .db $D6 $99 $22 $59 $88 $80 $30 $04
8199A9  .db $A9 $01 $80 $02 $A9 $FF $18 $65
8199B1  .db $0D $29 $03 $85 $0D $AA $BD $59
8199B9  .db $9C $85 $0E $8A $0A $AA $BC $5D
8199C1  .db $9C $BD $5E $9C $22 $A3 $89 $80
8199C9  .db $22 $A3 $BF $80 $A9 $06 $85 $03
8199D1  .db $A9 $3C $85 $4E $60  
----------------   
8199D6   LDX $04  
8199D8   JMP ($99DB,X)
--------data--------     
8199DB  .db $DF $99 $FA $99
----------------   
8199DF   LDA #$02 
8199E1   STA $04  
8199E3   JSL GetRandomInt ;$808859  
8199E7   BMI $8199ED  
8199E9   LDA #$01 
8199EB   BRA $8199EF  
8199ED   LDA #$FF 
8199EF   STA $4D  
8199F1   LDA #$02 
8199F3   STA $4E  
8199F5   LDA #$01 
8199F7   STA $4F  
8199F9   RTS
----------------   
8199FA   DEC $4F  
8199FC   BNE $819A30  
8199FE   LDA #$04 
819A00   STA $4F  
819A02   LDA $4D  
819A04   CLC
819A05   ADC $0D  
819A07   AND #$03 
819A09   STA $0D  
819A0B   TAX
819A0C   LDA $9C59,X  
819A0F   STA $0E  
819A11   TXA
819A12   ASL
819A13   TAX
819A14   LDY $9C5D,X  
819A17   LDA $9C5E,X  
819A1A   JSL FrameAnimationNoTimer ; $8089A3  
819A1E   JSL Sprite_SetSpeedsAlt ; 80BFA3  
819A22   DEC $4E  
819A24   BNE $819A30  
819A26   LDA #$06 
819A28   STA $03  
819A2A   STZ $04  
819A2C   LDA #$3C 
819A2E   STA $4E  
819A30   RTS
----------------   
--------sub start--------
819A31   LDX $04  
819A33   JMP ($9A36,X)
--------data--------     
819A36  .db $3E $9A $79 $9A $C6 $9A $CF $9A
----------------   
819A3E   DEC $4E  
819A40   BNE $819A78  
819A42   JSL GetRandomInt ;$808859  
819A46   BMI $819A4D  
819A48   STZ $03  
819A4A   STZ $04  
819A4C   RTS
----------------   
819A4D   JSL GetRandomInt ;$808859  
819A51   AND #$0F 
819A53   TAX
819A54   LDA $9CB3,X  
819A57   STA $4C  
819A59   LDA #$02 
819A5B   STA $04  
--------sub start--------
819A5D   LDA #$1E 
819A5F   STA $4E  
819A61   LDA $0D  
819A63   ASL
819A64   TAX
819A65   LDY $9C65,X  
819A68   LDA $9C66,X  
819A6B   JSL FrameAnimationNoTimer ; $8089A3  
819A6F   REP #$20 
819A71   LDA #$0200   
819A74   STA $4A  
819A76   SEP #$20 
819A78   RTS
----------------   
819A79   DEC $4E  
819A7B   BNE $819AAF  
819A7D   LDA $0B  
819A7F   CMP #$04 
819A81   BNE $819A94  
819A83   JSL $808A66  
--------unidentified--------
819A87  .db $29 $F0 $C9 $F0 $D0 $07 $A9 $04
819A8F  .db $85 $02 $64 $03 $60  
----------------   
819A94   LDA $0D  
819A96   ASL
819A97   TAX
819A98   LDY $9C5D,X  
819A9B   LDA $9C5E,X  
819A9E   JSL FrameAnimationNoTimer ; $8089A3  
819AA2   STZ $16  
819AA4   STZ $17  
819AA6   LDA #$08 
819AA8   STA $4E  
819AAA   LDA #$04 
819AAC   STA $04  
819AAE   RTS
----------------   
819AAF   REP #$21 
819AB1   LDA $16  
819AB3   ADC $4A  
819AB5   STA $16  
819AB7   LDA $4A  
819AB9   SEC
819ABA   SBC #$0020   
819ABD   STA $4A  
819ABF   SEP #$20 
819AC1   JSL MoveSprite ; 80C007  
819AC5   RTS
----------------   
819AC6   DEC $4E  
819AC8   BNE $819ACE  
819ACA   LDA #$06 
819ACC   STA $04  
819ACE   RTS
----------------   
819ACF   DEC $4C  
819AD1   BNE $819AD8  
819AD3   STZ $03  
819AD5   STZ $04  
819AD7   RTS
----------------   
819AD8   JSR $9A5D
819ADB   LDA #$02 
819ADD   STA $04  
819ADF   RTS
----------------   
819AE0   LDX $03  
819AE2   JSR ($9AEA,X)
819AE5   JSL SpriteSaveDirectPage ; 8088CE  
819AE9   RTS
----------------   
--------data--------     
819AEA  .db $F0 $9A $88 $FC $A9 $FC
----------------   
--------sub start--------
819AF0   LDX $04  
819AF2   JMP ($9AF5,X)
--------data--------     
819AF5  .db $F9 $9A  
----------------   
--------unidentified--------
819AF7  .db $0A $9B  
----------------   
819AF9   LDA #$02 
819AFB   STA $03  
819AFD   LDA #$9C 
819AFF   LDY #$8D 
819B01   JSL FrameAnimationNoTimer ; $8089A3  
819B05   LDA #$03 
819B07   STA $00  
819B09   RTS
----------------   
--------unidentified--------
819B0A  .db $A9 $03 $85 $00 $22 $8E $8F $80
819B12  .db $B0 $19 $A9 $03 $9D $00 $00 $A9
819B1A  .db $10 $9D $0A $00 $A9 $02 $9D $0B
819B22  .db $00 $A5 $11 $9D $11 $00 $A5 $14
819B2A  .db $9D $14 $00 $E2 $10 $A9 $06 $85
819B32  .db $02 $60  
----------------   
819B34   JSL KillSprite ; 808F1E  
819B38   RTS
----------------   
--------sub start--------
819B39   REP #$20 
819B3B   LDA $11  
819B3D   SEC
819B3E   SBC #$0010   
819B41   BMI $819B4B  
819B43   CMP #$00E1   
819B46   BCC $819B59  
819B48   SBC #$00E0   
819B4B   EOR #$FFFF   
819B4E   INC
819B4F   CLC
819B50   ADC $11  
819B52   STA $11  
819B54   LDA #$0001   
819B57   STA $4C  
819B59   LDA $14  
819B5B   SEC
819B5C   SBC #$0020   
819B5F   BMI $819B69  
819B61   CMP #$00B1   
819B64   BCC $819B77  
819B66   SBC #$00B0   
819B69   EOR #$FFFF   
819B6C   INC
819B6D   CLC
819B6E   ADC $14  
819B70   STA $14  
819B72   LDA #$0001   
819B75   STA $4C  
819B77   SEP #$20 
819B79   RTS

;0x1C Fireball (from fireball shooter)
819B7A   LDX $02  
819B7C   JMP ($9B7F,X)
--------data--------     
819B7F  .db $87 $9B $B0 $9B $DC $9B
----------------   
--------unidentified--------
819B85  .db $DC $9B  
----------------   
819B87   LDA #$02 
819B89   STA $02  
819B8B   LDA #$01 
819B8D   STA $00  
819B8F   STA $01  
819B91   LDA #$33 
819B93   STA $1B  
819B95   LDA #$40 
819B97   STA $1A  
819B99   STZ $0E  
819B9B   LDA #$9C 
819B9D   LDY #$D5 
819B9F   JSL Sprite_SetSpeeds ; 80BF9F  
819BA3   LDA #$9C 
819BA5   LDY #$CB 
819BA7   JSL FrameAnimationNoTimer ; $8089A3  
819BAB   LDA #$3C 
819BAD   STA $3F  
819BAF   RTS
----------------   
819BB0   LDX $03  
819BB2   JSR ($9BBE,X)
819BB5   JSL FrameAnimationTimer; 8089A9  
819BB9   JSL SpriteSaveDirectPage ; 8088CE  
819BBD   RTS
----------------   
--------data--------     
819BBE  .db $C2 $9B $CF $9B
----------------   
--------sub start--------
819BC2   DEC $3F  
819BC4   BNE $819BCE  
819BC6   LDA #$02 
819BC8   STA $03  
819BCA   LDA #$80 
819BCC   STA $3F  
819BCE   RTS
----------------   
--------sub start--------
819BCF   JSL MoveSprite ; 80C007  
819BD3   DEC $3F  
819BD5   BNE $819BDB  
819BD7   LDA #$04 
819BD9   STA $02  
819BDB   RTS
----------------   
819BDC   JSL KillSprite ; 808F1E  
819BE0   RTS

;0x1E sort of unfinished drill Unknown Sprite - it does damage...

819BE1   LDX $02                  
819BE3   JMP ($9BE6,X)            
--------data--------     
819BE6 
dw $9BEE ;Init
dw $9C0C ;Main   
dw $9CF3 ;?? go to a RTS but there's code after
dw $9CF3 ;?? go to a RTS but there's code after   
      
819BEE   LDA #$02
819BF0   STA $02
819BF2   DEC
819BF3   STA $00
819BF5   LDA #$33
819BF7   STA $1B
819BF9   LDA #$C0
819BFB   STA $1A
819BFD   STZ $0E
819BFF   LDA #$9D
819C01   LDY #$29
819C03   JSL $8089A3
819C07   LDA #$04
819C09   STA $2A
819C0B   RTS

819C0C   LDX $03
819C0E   JSR ($9C16,X)            
819C11   JSL $8088CE              
819C15   RTS                      
   
819C16  
dw $9C24             
dw $9C59
dw $9C68
dw $9C75
dw $9CA3
dw $9CB0
dw $9CE2

;Subroutine Main 00
819C24   LDA $0B ;Subtype
819C26   BNE $819C44
819C28   LDX #$00 
819C2A   LDA $0100,X ;P1 state? (00 == dead)
819C2D   BEQ $819C34 
819C2F   JSR $9CF4 
819C32   BCC $819C41  ;Branch If Y distance > 0x20?
819C34   LDX #$80                 
819C36   LDA $0100,X ;??
819C39   BEQ $819C40 ;RTS
819C3B   JSR $9CF4                
819C3E   BCC $819C41   ;Branch If Y distance > 0x20?                
819C40   RTS                      

819C41   INC $00FC   
819C44   LDA $00FC   
819C47   BEQ $9C58   
819C49   LDA #$02    
819C4B   STA $03     
819C4D   LDA $0B     
819C4F   LSR A       
819C50   TAX         
819C51   LDA $9D5F,X 
819C54   STA $3F     
819C56   STZ $3E     
819C58   RTS         
----------------         
--------sub start--------
819C59   DEC $3F                  
819C5B   BNE $819C67              
819C5D   LDA #$04                 
819C5F   STA $03                  
819C61   LDA #$1E                 
819C63   STA $3F                  
819C65   INC $01                  
819C67   RTS                      
----------------         
--------sub start--------
819C68   DEC $3F                  
819C6A   BNE $819C67              
819C6C   LDA #$06                 
819C6E   STA $03                  
819C70   LDA #$02                 
819C72   STA $3F                  
819C74   RTS                      
----------------         
--------sub start--------
819C75   DEC $3F                  
819C77   BNE $819CA2              
819C79   LDA #$02                 
819C7B   STA $3F                  
819C7D   INC $3E                  
819C7F   LDA $3E                  
819C81   ASL                      
819C82   TAX                      
819C83   LDY $9D15,X              
819C86   LDA $9D16,X              
819C89   JSL FrameAnimationNoTimer ;8089A3              
819C8D   LDA $3E                  
819C8F   CMP #$09                 
819C91   BNE $819C9B              
819C93   LDA #$08                 
819C95   STA $03                  
819C97   LDA #$20
819C99   STA $3F                  
819C9B   LDA $14                  
819C9D   CLC                      
819C9E   ADC $2A                  
819CA0   STA $14                  
819CA2   RTS                      
----------------         
--------sub start--------
819CA3   DEC $3F                  
819CA5   BNE $819CAF              
819CA7   LDA #$0A                 
819CA9   STA $03                  
819CAB   LDA #$08                 
819CAD   STA $3F                  
819CAF   RTS                      
----------------         
--------sub start--------
819CB0   DEC $3F                  
819CB2   BNE $819CE1              
819CB4   LDA $3E                  
819CB6   BEQ $819CD4              
819CB8   LDA #$08                 
819CBA   STA $3F                  
819CBC   DEC $3E                  
819CBE   LDA $3E                  
819CC0   ASL                      
819CC1   TAX                      
819CC2   LDY $9D15,X              
819CC5   LDA $9D16,X              
819CC8   JSL $8089A3              
819CCC   LDA $14                  
819CCE   SEC                      
819CCF   SBC $2A                  
819CD1   STA $14                  
819CD3   RTS                      
----------------         
819CD4   LDA #$0C                 
819CD6   STA $03                  
819CD8   LDA $0B                  
819CDA   LSR                      
819CDB   TAX                      
819CDC   LDA $9D68,X              
819CDF   STA $3F                  
819CE1   RTS                      
----------------         
--------sub start--------
819CE2   STZ $01                  
819CE4   DEC $3F                  
819CE6   BNE $819CF2              
819CE8   LDA #$04                 
819CEA   STA $03                  
819CEC   INC $01                  
819CEE   LDA #$1E                 
819CF0   STA $3F                  
819CF2   RTS                      
----------------         
--------unidentified--------
819CF3  .db $60                  


;Reached if player1 or player2 are not dead
819CF4   LDA #$9F
819CF6   SEC
819CF7   SBC $0111,X ;Remove X from either X or Y player position
819CFA   CMP #$0E
819CFC   BCS $819D06  ;Branch If X distance > 0x0E?              
819CFE   LDA #$B0                 
819D00   SEC                      
819D01   SBC $0114,X              
819D04   CMP #$20  ; If X distance > 0x0E? (branch is after the RTS)
819D06   RTS                      


;0x20 small canon shooting
819D07   LDA $00AC                
819D0A   BNE $819D11              
819D0C   LDX $02                  
819D0E   JMP ($9D12,X)            
819D11   RTS                      
   
819D12
dw $9D16
dw $9D35    
----------------         
819D16   LDA #$9D                 
819D18   LDY #$79                 
819D1A   LDX #$02                 
819D1C   JSR $9782                
819D1F   BNE $819D34              
819D21   LDA #$02                 
819D23   STA $02                  
819D25   INC                      
819D26   STA $00                  
819D28   JSL $808859              
819D2C   AND #$07                 
819D2E   TAX                      
819D2F   LDA $9D71,X              
819D32   STA $3E                  
819D34   RTS                      
----------------         
819D35   DEC $3E                  
819D37   BNE $819D6E              
819D39   JSL $808F8E              
819D3D   BCS $819D6A              
819D3F   LDA #$03                 
819D41   STA $0000,X              
819D44   STA $0001,X              
819D47   STZ $0003,X              
819D4A   STZ $0002,X              
819D4D   STZ $000B,X              
819D50   LDA #$12                 
819D52   STA $000A,X              
819D55   LDA $11                  
819D57   STA $0011,X              
819D5A   STZ $0012,X              
819D5D   LDA $14                  
819D5F   STA $0014,X              
819D62   STZ $0015,X              
819D65   LDA $0D                  
819D67   STA $000D,X              
819D6A   SEP #$10                 
819D6C   STZ $02                  
819D6E   RTS                      


;0x22 Canon Sprite
819D6F   LDX $02  
819D71   JMP ($9D74,X)
--------data--------     
819D74  .db $7A $9D $D3 $9D
----------------   
--------unidentified--------
819D78  .db $F7 $9E  
----------------   
819D7A   LDA #$02 
819D7C   STA $02  
819D7E   LDX $00B6
819D81   CPX #$02 
819D83   BEQ $819D87  
819D85   LDA #$00 
819D87   STA $0C  
819D89   DEC
819D8A   STA $00  
819D8C   STA $01  
819D8E   LDA #$3B 
819D90   STA $1B  
819D92   LDA #$80 
819D94   STA $1A  
819D96   STZ $40  
819D98   LDA $0B  
819D9A   AND #$7F 
819D9C   TAX
819D9D   REP #$20 
819D9F   LDA $1144
819DA2   AND $9DE9,X  
819DA5   SEP #$20 
819DA7   BEQ $819DB2  
819DA9   INC $40  
819DAB   LDA #$04 
819DAD   STA $02  
819DAF   JMP $9F36
819DB2   LDY #$14 
819DB4   LDA $0B  
819DB6   AND #$7F 
819DB8   CMP #$0E 
819DBA   BCC $819DBE  
819DBC   LDY #$0A 
819DBE   STY $1C  
819DC0   STY $1D  
819DC2   LDX #$32 
819DC4   LDA $0B  
819DC6   BMI $819DCA  
819DC8   LDX #$50 
819DCA   STX $3E  
819DCC   LDA $0D  
819DCE   ASL
819DCF   STA $0D  
819DD1   BRA $819E1B  
819DD3   LDA $1D  
819DD5   CMP $1C  
819DD7   BEQ $819DE2  
819DD9   LDA #$04 
819DDB   STA $02  
819DDD   STZ $03  
819DDF   JMP $9EF7
819DE2   LDA $00AC
819DE5   BNE $819DEF  
819DE7   LDX $03  
819DE9   JSR ($9DF4,X)
819DEC   JSR $9EBF
819DEF   JSL SpriteSaveDirectPage ; 8088CE  
819DF3   RTS
 
819DF4  .db 
dw $9DF8
dw $9E3E

819DF8   DEC $3F  
819DFA   BNE $819E31  
819DFC   JSR $9ECD
819DFF   CLC
819E00   ADC #$02 
819E02   AND #$1F 
819E04   LSR
819E05   LSR
819E06   SEC
819E07   SBC $0D  
819E09   AND #$07 
819E0B   BEQ $819E1F  
819E0D   CMP #$04 
819E0F   LDX $0D  
819E11   INX
819E12   BCC $819E16  
819E14   DEX
819E15   DEX
819E16   TXA
819E17   AND #$07 
819E19   STA $0D  
819E1B   AND #$04 
819E1D   STA $0E  
819E1F   LDA $0D  
819E21   ASL
819E22   TAX
819E23   LDY $9D83,X  
819E26   LDA $9D84,X  
819E29   JSL FrameAnimationNoTimer ; $8089A3  
819E2D   LDA #$05 
819E2F   STA $3F  
819E31   DEC $3E  
819E33   LDA $3E  
819E35   CMP #$02 
819E37   BCS $819E3D  
819E39   LDA #$02 
819E3B   STA $03  
819E3D   RTS
----------------   
--------sub start--------
819E3E   JSR $9E50
819E41   JSL GetRandomInt ;$808859  
819E45   AND #$0F 
819E47   TAX
819E48   LDA $9DC1,X  
819E4B   STA $3E  
819E4D   STZ $03  
819E4F   RTS
----------------   
--------sub start--------
819E50   JSL $808F8E  
819E54   BCS $819EBC  
819E56   STZ $000A,X  
819E59   LDA #$06 
819E5B   STA $0003,X  
819E5E   LDA #$08 
819E60   STA $0004,X  
819E63   STA $0000,X  
819E66   LDA #$0A 
819E68   STA $000B,X  
819E6B   LDA $0D  
819E6D   STA $000D,X  
819E70   LDA #$00 
819E72   XBA
819E73   LDA $0D  
819E75   ASL
819E76   TAY
819E77   LDA $9DD1,Y  
819E7A   ADC $11  
819E7C   STA $0011,X  
819E7F   STA $10  
819E81   LDA $9DD2,Y  
819E84   ADC $14  
819E86   STA $0014,X  
819E89   STA $13  
819E8B   LDA #$0C 
819E8D   STA $0017,X  
819E90   LDA $0C  
819E92   STA $000C,X  
819E95   JSL $808FA9  
819E99   BCS $819EBC  
819E9B   LDA #$0A 
819E9D   STA $000A,X  
819EA0   STA $0000,X  
819EA3   LDA $10  
819EA5   STA $0011,X  
819EA8   LDA $13  
819EAA   ADC #$FA 
819EAC   STA $0014,X  
819EAF   LDA #$0C 
819EB1   STA $0017,X  
819EB4   SEP #$10 
819EB6   LDA #$08 
819EB8   JSL PlaySFX ;$809A53
819EBC   SEP #$10 
819EBE   RTS
----------------   
--------sub start--------
819EBF   LDX $0D  
819EC1   CPX $3D  
819EC3   BEQ $819ECC  
819EC5   STX $3D  
819EC7   LDA $9DE1,X  
819ECA   STA $1E  
819ECC   RTS
----------------   
--------sub start--------
819ECD   LDA #$FF 
819ECF   STA $37  
819ED1   LDA $0100
819ED4   BEQ $819ED8  
819ED6   STZ $37  
819ED8   LDA $0180
819EDB   BEQ $819EEA  
819EDD   LDA $37  
819EDF   BNE $819EE6  
819EE1   JSR $8F48
--------unidentified--------
819EE4  .db $80 $04 $A9 $80 $85 $37
----------------   
819EEA   LDA #$01 
819EEC   XBA
819EED   LDA $37  
819EEF   REP #$10 
819EF1   TAX
819EF2   JSL $808B0E  
819EF6   RTS
----------------   
--------unidentified--------
819EF7  .db $A6 $03 $FC $01 $9F $22 $CE $88
819EFF  .db $80 $60 $0F $9F $6A $9F $7A $9F
819F07  .db $83 $9F $93 $9F $A3 $9F $C0 $9F
819F0F  .db $A5 $1C $D0 $45 $85 $1D $20 $FE
819F17  .db $9F $A9 $0A $85 $03 $A9 $03 $85
819F1F  .db $00 $A9 $60 $85 $3C $85 $0C $A5
819F27  .db $0B $29 $7F $AA $C2 $20 $BD $E9
819F2F  .db $9D $0C $44 $11 $E2 $20 $60 $A9
819F37  .db $03 $85 $00 $85 $0E $A5 $0B $29
819F3F  .db $7F $4A $AA $BD $FB $9D $85 $03
819F47  .db $60 $A9 $02 $85 $01 $85 $02 $3A
819F4F  .db $85 $00 $64 $03 $A5 $3D $85 $0D
819F57  .db $60 $C5 $1D $F0 $EC $85 $1D $A9
819F5F  .db $03 $85 $00 $A9 $02 $85 $03 $A9
819F67  .db $18 $85 $3C $AD $AC $00 $D0 $0A
819F6F  .db $C6 $3C $F0 $D5 $A5 $3C $29 $03
819F77  .db $85 $01 $60 $A0 $BA $A9 $9D $22
819F7F  .db $A3 $89 $80 $60 $A5 $40 $D0 $43
819F87  .db $20 $7A $9F $A9 $0C $85 $03 $A9
819F8F  .db $30 $85 $41 $60 $EE $FA $00 $AD
819F97  .db $FA $00 $C9 $02 $D0 $5C $A5 $40
819F9F  .db $F0 $E6 $80 $27 $A5 $3C $C9 $58
819FA7  .db $D0 $03 $20 $FE $9F $C6 $3C $D0
819FAF  .db $09 $A9 $30 $22 $53 $9A $80 $4C
819FB7  .db $36 $9F $A5 $3C $29 $03 $85 $01
819FBF  .db $60 $C6 $41 $D0 $39 $A9 $21 $22
819FC7  .db $53 $9A $80 $AD $B7 $00 $C9 $0B
819FCF  .db $D0 $15 $A9 $80 $8D $13 $00 $A9
819FD7  .db $02 $8D $14 $00 $A9 $02 $8D $0A
819FDF  .db $00 $22 $B4 $C3 $82 $80 $13 $A9
819FE7  .db $DE $8D $13 $00 $A9 $01 $8D $14
819FEF  .db $00 $A9 $02 $8D $0A $00 $22 $B4
819FF7  .db $C3 $82 $A9 $04 $85 $03 $60 $22
819FFF  .db $8E $8F $80 $B0 $1B $A9 $03 $9D
81A007  .db $00 $00 $A9 $0C $9D $0A $00 $A9
81A00F  .db $04 $9D $0B $00 $A5 $11 $9D $11
81A017  .db $00 $A5 $14 $69 $08 $9D $14 $00
81A01F  .db $E2 $10 $60 $20 $50 $9E $6B 

;0x24 LEVEL 04 Boss
81A026   LDX $0B                  
81A028   JMP ($A02B,X)            
--------data--------     
81A02B  .db $35 $A0 $28 $A3 $28 $A3 $E9 $A5
81A033  .db $E9 $A5              
----------------         
81A035   LDX $02                  
81A037   JMP ($A03A,X)            
--------data--------     
81A03A  .db $42 $A0 $DD $A0      
----------------         
--------unidentified--------
81A03E  .db $23 $A3 $23 $A3      
----------------         
81A042   STZ $48                  
81A044   STZ $49                  
81A046   JSL $808F73              
81A04A   STX $4E                  
81A04C   LDA $48                  
81A04E   BNE $81A052              
81A050   STX $4C                  
81A052   STX $4A                  
81A054   LDA #$03                 
81A056   STA $0000,X              
81A059   LDA #$24                 
81A05B   STA $000A,X              
81A05E   LDA $48                  
81A060   BEQ $81A066              
81A062   LDA #$04                 
81A064   BRA $81A068              
81A066   LDA #$02                 
81A068   STA $000B,X              
81A06B   STZ $004C,X              
81A06E   REP #$20                 
81A070   LDA #$0840               
81A073   LDY $48                  
81A075   BNE $81A07A              
81A077   LDA #$0520               
81A07A   STA $004E,X              
81A07D   SEP #$30                 
81A07F   STZ $47                  
81A081   JSL $808F73              
81A085   LDA #$03                 
81A087   STA $0000,X              
81A08A   LDA #$24                 
81A08C   STA $000A,X              
81A08F   LDA #$06                 
81A091   STA $000B,X              
81A094   REP #$20                 
81A096   LDA $4C                  
81A098   LDY $48                  
81A09A   BEQ $81A09E              
81A09C   LDA $4E                  
81A09E   STA $004E,X              
81A0A1   LDA $4A                  
81A0A3   STA $004C,X              
81A0A6   SEP #$20                 
81A0A8   STX $4A                  
81A0AA   LDA $47                  
81A0AC   STA $004B,X              
81A0AF   LDA $48                  
81A0B1   STA $0042,X              
81A0B4   SEP #$10                 
81A0B6   INC $47                  
81A0B8   LDA $47                  
81A0BA   CMP #$09                 
81A0BC   BCC $81A081              
81A0BE   INC $48                  
81A0C0   LDA $48                  
81A0C2   CMP #$01                 
81A0C4   BEQ $81A046              
81A0C6   LDA #$08                 
81A0C8   STA $052B                
81A0CB   STA $084B                
81A0CE   LDA #$02                 
81A0D0   STA $02                  
81A0D2   LDA #$0A                 
81A0D4   STA $03                  
81A0D6   LDA #$C8                 
81A0D8   STA $47                  
81A0DA   STZ $42                  
81A0DC   RTS                      
----------------         
81A0DD   LDA $00A8                
81A0E0   BEQ $81A0E3              
81A0E2   RTS                      
----------------         
81A0E3   LDX $03                  
81A0E5   JMP ($A0E8,X)            
--------data--------     
81A0E8  .db $F4 $A0 $3E $A1 $5F $A1 $BB $A1
81A0F0  .db $34 $A2 $1C $A3      
----------------         
81A0F4   LDA #$02                 
81A0F6   STA $03                  
81A0F8   JSL $808859              
81A0FC   AND #$0F                 
81A0FE   INC                      
81A0FF   TAY                      
81A100   REP #$11                 
81A102   LDX $4C                  
81A104   LDA $0048,X              
81A107   LDX $4E                  
81A109   ADC $0048,X              
81A10C   CMP #$11                 
81A10E   BCC $81A125              
81A110   LDA $42                  
81A112   BEQ $81A116              
81A114   BRA $81A118              
81A116   LDX $4C                  
81A118   TYA                      
81A119   STA $004C,X              
81A11C   LDA $42                  
81A11E   INC                      
81A11F   AND #$01                 
81A121   STA $42                  
81A123   BRA $81A13B              
81A125   LDX $4C                  
81A127   LDA $0000,X              
81A12A   BEQ $81A130              
81A12C   TYA                      
81A12D   STA $004C,X              
81A130   LDX $4E                  
81A132   LDA $0000,X              
81A135   BEQ $81A13B              
81A137   TYA                      
81A138   STA $004C,X              
81A13B   SEP #$10                 
81A13D   RTS                      
----------------         
81A13E   REP #$10                 
81A140   LDX $4C                  
81A142   LDA $0000,X              
81A145   BEQ $81A14C              
81A147   LDA $004D,X              
81A14A   BNE $81A158              
81A14C   LDX $4E                  
81A14E   LDA $0000,X              
81A151   BEQ $81A15C              
81A153   LDA $004D,X              
81A156   BEQ $81A15C              
81A158   LDA #$04                 
81A15A   STA $03                  
81A15C   SEP #$10                 
81A15E   RTS                      
----------------         
81A15F   REP #$10                 
81A161   LDX $4C                  
81A163   LDA $0000,X              
81A166   BEQ $81A16D              
81A168   LDA $004D,X              
81A16B   BNE $81A1B8              
81A16D   LDX $4E                  
81A16F   LDA $0000,X              
81A172   BEQ $81A179              
81A174   LDA $004D,X              
81A177   BNE $81A1B8              
81A179   SEP #$10                 
81A17B   LDA #$06                 
81A17D   STA $03                  
81A17F   INC $00AC                
81A182   LDA #$80                 
81A184   STA $49                  
81A186   LDA #$25                 
81A188   JSL $809A53              
81A18C   STZ $3D                  
81A18E   LDA $0100                
81A191   BEQ $81A1A2              
81A193   CMP #$04                 
81A195   BEQ $81A1A2              
81A197   REP #$20                 
81A199   LDA $0114                
81A19C   STA $43                  
81A19E   SEP #$20                 
81A1A0   INC $3D                  
81A1A2   STZ $3E                  
81A1A4   LDA $0180                
81A1A7   BEQ $81A1B8              
81A1A9   CMP #$04                 
81A1AB   BEQ $81A1B8              
81A1AD   REP #$20                 
81A1AF   LDA $0194                
81A1B2   STA $45                  
81A1B4   SEP #$20                 
81A1B6   INC $3E                  
81A1B8   SEP #$10                 
81A1BA   RTS                      
----------------         
81A1BB   DEC $49                  
81A1BD   REP #$30                 
81A1BF   BNE $81A1CB              
81A1C1   LDA #$0008               
81A1C4   STA $03                  
81A1C6   LDA #$0000               
81A1C9   BRA $81A1D8              
81A1CB   LDX #$0001               
81A1CE   LDA $49                  
81A1D0   AND #$0002               
81A1D3   BEQ $81A1D7              
81A1D5   DEX                      
81A1D6   DEX                      
81A1D7   TXA                      
81A1D8   SEP #$10                 
81A1DA   STA $47                  
81A1DC   CLC                      
81A1DD   ADC #$03FF               
81A1E0   AND #$03FF               
81A1E3   STA $0076                
81A1E6   STA $007A                
81A1E9   SEP #$20                 
81A1EB   LDA $3D                  
81A1ED   BNE $81A203              
81A1EF   LDA $0100                
81A1F2   BEQ $81A20F              
81A1F4   CMP #$04                 
81A1F6   BEQ $81A20F              
81A1F8   REP #$20                 
81A1FA   LDA $0114                
81A1FD   STA $43                  
81A1FF   SEP #$20                 
81A201   INC $3D                  
81A203   REP #$20                 
81A205   LDA $47                  
81A207   CLC                      
81A208   ADC $43                  
81A20A   STA $0114                
81A20D   SEP #$20                 
81A20F   LDA $3E                  
81A211   BNE $81A227              
81A213   LDA $0180                
81A216   BEQ $81A233              
81A218   CMP #$04                 
81A21A   BEQ $81A233              
81A21C   REP #$20                 
81A21E   LDA $0194                
81A221   STA $45                  
81A223   SEP #$20                 
81A225   INC $3E                  
81A227   REP #$20                 
81A229   LDA $47                  
81A22B   CLC                      
81A22C   ADC $45                  
81A22E   STA $0194                
81A231   SEP #$20                 
81A233   RTS                      
----------------         
81A234   LDX $04                  
81A236   JMP ($A239,X)            
--------data--------     
81A239  .db $3F $A2 $47 $A2 $0F $A3
----------------         
81A23F   LDA #$02                 
81A241   STA $04                  
81A243   STZ $00AC                
81A246   RTS                      
----------------         
81A247   REP #$11                 
81A249   LDX $4C                  
81A24B   LDA $0048,X              
81A24E   LDX $4E                  
81A250   ADC $0048,X              
81A253   SEP #$10                 
81A255   TAX                      
81A256   LDA $9F97,X              
81A259   STA $47                  
81A25B   JSL $808859              
81A25F   AND #$1F                 
81A261   ASL                      
81A262   STA $48                  
81A264   JSL $808859              
81A268   AND #$07                 
81A26A   CLC                      
81A26B   ADC $47                  
81A26D   TAX                      
81A26E   LDA $9FA8,X              
81A271   STA $41                  
81A273   LDA $47                  
81A275   CMP $41                  
81A277   BNE $81A2C8              
81A279   LDX #$00                 
81A27B   LDA $0100                
81A27E   DEC                      
81A27F   BNE $81A283              
81A281   INX                      
81A282   INX                      
81A283   LDA $0180                
81A286   DEC                      
81A287   BNE $81A28D              
81A289   TXA                      
81A28A   ORA #$04                 
81A28C   TAX                      
81A28D   LDY #$00                 
81A28F   JMP ($A292,X)            
--------unidentified--------
81A292  .db $C8 $A2              
----------------         
--------data--------     
81A294  .db $A2 $A2              
----------------         
--------unidentified--------
81A296  .db $A0 $A2 $9A $A2 $22 $59 $88 $80
81A29E  .db $10 $02 $A0 $80      
----------------         
81A2A2   LDA $0111,Y              
81A2A5   CLC                      
81A2A6   ADC #$08                 
81A2A8   STA $000A                
81A2AB   STA $3F                  
81A2AD   LDA $0114,Y              
81A2B0   STA $000C                
81A2B3   STA $40                  
81A2B5   JSL $808A86              
81A2B9   AND #$F0                 
81A2BB   CMP #$30                 
81A2BD   BNE $81A2D4              
81A2BF   LDA $3F                  
81A2C1   SEC                      
81A2C2   SBC #$10                 
81A2C4   STA $3F                  
81A2C6   BRA $81A2D4              
81A2C8   LDX $48                  
81A2CA   LDA $9FC4,X              
81A2CD   STA $3F                  
81A2CF   LDA $9FC5,X              
81A2D2   STA $40                  
81A2D4   JSL $808F8E              
81A2D8   BCS $81A2FF              
81A2DA   LDA #$03                 
81A2DC   STA $0000,X              
81A2DF   LDA #$14                 
81A2E1   STA $000A,X              
81A2E4   LDA $3F                  
81A2E6   STA $0011,X              
81A2E9   LDA $40                  
81A2EB   STA $0014,X              
81A2EE   SEP #$10                 
81A2F0   INC $48                  
81A2F2   INC $48                  
81A2F4   LDA #$C0                 
81A2F6   TRB $48                  
81A2F8   DEC $47                  
81A2FA   BEQ $81A2FF              
81A2FC   JMP $A273                
81A2FF   SEP #$10                 
81A301   LDA #$04                 
81A303   STA $04                  
81A305   REP #$20                 
81A307   LDA #$0170               
81A30A   STA $47                  
81A30C   SEP #$20                 
81A30E   RTS                      
----------------         
81A30F   REP #$20                 
81A311   DEC $47                  
81A313   SEP #$20                 
81A315   BNE $81A31B              
81A317   STZ $03                  
81A319   STZ $04                  
81A31B   RTS                      
----------------         
81A31C   DEC $47                  
81A31E   BNE $81A322              
81A320   STZ $03                  
81A322   RTS                      
----------------         
--------unidentified--------
81A323  .db $22 $1E $8F $80 $60  
----------------         
81A328   LDX $02                  
81A32A   JMP ($A32D,X)            
--------data--------     
81A32D  .db $35 $A3 $6C $A3 $91 $A4 $E4 $A5
----------------         
81A335   LDA #$02                 
81A337   STA $02                  
81A339   LDA #$01                 
81A33B   STA $00                  
81A33D   STA $4C                  
81A33F   STA $1F                  
81A341   STZ $4D                  
81A343   STZ $0C                  
81A345   LDX #$29                 
81A347   LDA $0B                  
81A349   CMP #$02                 
81A34B   BEQ $81A34F              
81A34D   LDX #$2D                 
81A34F   STX $1B                  
81A351   LDA #$40                 
81A353   STA $1A                  
81A355   LDA #$07                 
81A357   LDX $00C7                
81A35A   BNE $81A35E              
81A35C   LDA #$0A                 
81A35E   STA $48                  
81A360   JSR $A3B5                
81A363   STZ $4B                  
81A365   LDA #$28                 
81A367   STA $1C                  
81A369   STA $1D                  
81A36B   RTS                      
----------------         
81A36C   LDA $1D                  
81A36E   CMP $1C                  
81A370   BEQ $81A392              
81A372   INC $1F                  
81A374   DEC $48                  
81A376   LDA $48                  
81A378   CMP #$05                 
81A37A   BCS $81A385              
81A37C   LDA #$04                 
81A37E   STA $02                  
81A380   STZ $03                  
81A382   JMP $A491                
81A385   LDA $43                  
81A387   STA $0D                  
81A389   LDA #$04                 
81A38B   STA $02                  
81A38D   STZ $46                  
81A38F   JMP $A491                
81A392   LDX $03                  
81A394   JSR ($A39C,X)            
81A397   JSL $8088CE              
81A39B   RTS                      
----------------         
--------data--------     
81A39C  .db $A6 $A3 $AF $A3 $29 $A4 $3A $A4
81A3A4  .db $60 $A4              
----------------         
--------sub start--------
81A3A6   LDA $4C                  
81A3A8   BEQ $81A3AE              
81A3AA   LDA #$02                 
81A3AC   STA $03                  
81A3AE   RTS                      
----------------         
--------sub start--------
81A3AF   LDA #$04                 
81A3B1   STA $03                  
81A3B3   INC $4D                  
--------sub start--------
81A3B5   DEC $4C                  
81A3B7   LDX $4C                  
81A3B9   LDA $0B                  
81A3BB   CMP #$02                 
81A3BD   BNE $81A3C4              
81A3BF   LDA $9EDE,X              
81A3C2   BRA $81A3C7              
81A3C4   LDA $9F2E,X              
81A3C7   INC $01                  
81A3C9   STA $0D                  
81A3CB   STA $43                  
81A3CD   LSR                      
81A3CE   ROR                      
81A3CF   ROR                      
81A3D0   TAX                      
81A3D1   LDA #$03                 
81A3D3   LDY #$00                 
81A3D5   JSL $809252              
81A3D9   LDX $0D                  
81A3DB   LDA $9E04,X              
81A3DE   STA $0E                  
81A3E0   TXA                      
81A3E1   ASL                      
81A3E2   TAX                      
81A3E3   LDA #$06                 
81A3E5   CMP $48                  
81A3E7   BMI $81A3F1              
81A3E9   LDY $9E10,X              
81A3EC   LDA $9E11,X              
81A3EF   BRA $81A3F7              
81A3F1   LDY $9E08,X              
81A3F4   LDA $9E09,X              
81A3F7   JSL $8089A3              
81A3FB   LDA $4C                  
81A3FD   ASL                      
81A3FE   ASL                      
81A3FF   TAX                      
81A400   LDA $0B                  
81A402   CMP #$02                 
81A404   BNE $81A414              
81A406   REP #$20                 
81A408   LDA $9EEE,X              
81A40B   STA $11                  
81A40D   LDA $9EF0,X              
81A410   STA $14                  
81A412   BRA $81A420              
81A414   REP #$20                 
81A416   LDA $9F3E,X              
81A419   STA $11                  
81A41B   LDA $9F40,X              
81A41E   STA $14                  
81A420   SEP #$20                 
81A422   STZ $4C                  
81A424   LDA #$0A                 
81A426   STA $49                  
81A428   RTS                      
----------------         
--------sub start--------
81A429   DEC $49                  
81A42B   BNE $81A435              
81A42D   LDA #$06                 
81A42F   STA $03                  
81A431   LDA #$32                 
81A433   STA $49                  
81A435   JSL $80C007              
81A439   RTS                      
----------------         
--------sub start--------
81A43A   DEC $49                  
81A43C   BNE $81A45F              
81A43E   LDA $0D                  
81A440   ASL                      
81A441   ASL                      
81A442   ASL                      
81A443   ASL                      
81A444   ASL                      
81A445   ASL                      
81A446   STA $47                  
81A448   LDY $48                  
81A44A   LDX $9F7A,Y              
81A44D   LDY $9F85,X              
81A450   LDA $9F86,X              
81A453   LDX $47                  
81A455   JSL $809252              
81A459   LDA #$08                 
81A45B   STA $03                  
81A45D   STZ $1F                  
81A45F   RTS                      
----------------         
--------sub start--------
81A460   JSL $80C007              
81A464   LDA $0D                  
81A466   AND #$01                 
81A468   REP #$21                 
81A46A   BEQ $81A479              
81A46C   LDA $11                  
81A46E   ADC #$0060               
81A471   CMP #$01C0               
81A474   BCS $81A486              
81A476   SEP #$20                 
81A478   RTS                      
----------------         
81A479   LDA $14                  
81A47B   ADC #$0060               
81A47E   CMP #$01B0               
81A481   BCS $81A486              
81A483   SEP #$20                 
81A485   RTS                      
----------------         
81A486   SEP #$20                 
81A488   STZ $03                  
81A48A   STZ $01                  
81A48C   STZ $4D                  
81A48E   INC $1F                  
81A490   RTS                      
----------------         
81A491   LDA $48                  
81A493   CMP #$05                 
81A495   BCS $81A49A              
81A497   JMP $A51E                
81A49A   LDX $46                  
81A49C   JSR ($A4A4,X)            
81A49F   JSL $8088CE              
81A4A3   RTS                      
----------------         
--------data--------     
81A4A4  .db $AE $A4 $CD $A4 $DD $A4 $FE $A4
81A4AC  .db $09 $A5              
----------------         
--------sub start--------
81A4AE   LDA #$02                 
81A4B0   STA $46                  
81A4B2   LDA $1C                  
81A4B4   STA $1D                  
81A4B6   INC $4B                  
81A4B8   INC $4B                  
81A4BA   LDA $0D                  
81A4BC   ASL                      
81A4BD   TAX                      
81A4BE   LDY $9E18,X              
81A4C1   LDA $9E19,X              
81A4C4   JSL $8089A3              
81A4C8   LDA #$04                 
81A4CA   STA $47                  
81A4CC   RTS                      
----------------         
--------sub start--------
81A4CD   DEC $47                  
81A4CF   BNE $81A4D6              
81A4D1   LDA #$04                 
81A4D3   STA $46                  
81A4D5   RTS                      
----------------         
81A4D6   LDA $47                  
81A4D8   AND #$01                 
81A4DA   STA $01                  
81A4DC   RTS                      
----------------         
--------sub start--------
81A4DD   REP #$10                 
81A4DF   LDX $4E                  
81A4E1   LDA $0047,X              
81A4E4   DEC                      
81A4E5   BNE $81A4FB              
81A4E7   LDA #$06                 
81A4E9   STA $46                  
81A4EB   INC $0048,X              
81A4EE   LDA #$01                 
81A4F0   STA $49                  
81A4F2   REP #$21                 
81A4F4   LDA $4E                  
81A4F6   SBC #$004F               
81A4F9   STA $4E                  
81A4FB   SEP #$30                 
81A4FD   RTS                      
----------------         
--------sub start--------
81A4FE   DEC $49                  
81A500   BNE $81A508              
81A502   LDA #$08                 
81A504   STA $46                  
81A506   DEC $4B                  
81A508   RTS                      
----------------         
--------sub start--------
81A509   LDA #$02                 
81A50B   STA $02                  
81A50D   STZ $4B                  
81A50F   LDA $0D                  
81A511   LSR                      
81A512   ROR                      
81A513   ROR                      
81A514   TAX                      
81A515   LDA #$04                 
81A517   LDY #$04                 
81A519   JSL $809252              
81A51D   RTS                      
----------------         
81A51E   LDX $03                  
81A520   JSR ($A528,X)            
81A523   JSL $8088CE              
81A527   RTS                      
----------------         
--------data--------     
81A528  .db $2E $A5 $86 $A5 $A7 $A5
----------------         
--------sub start--------
81A52E   LDA #$02                 
81A530   STA $03                  
81A532   LDA #$01                 
81A534   STA $01                  
81A536   LDA #$03                 
81A538   STA $00                  
81A53A   LDA $0B                  
81A53C   CMP #$02                 
81A53E   BEQ $81A560              
81A540   CMP #$04                 
81A542   BEQ $81A560              
81A544   LDX #$39                 
81A546   LDA $42                  
81A548   BEQ $81A54C              
81A54A   LDX #$3D                 
81A54C   STX $1B                  
81A54E   REP #$10                 
81A550   LDX $4E                  
81A552   LDA $000D,X              
81A555   SEP #$10                 
81A557   LDX $4B                  
81A559   CLC                      
81A55A   ADC $A004,X              
81A55D   STA $0D                  
81A55F   RTS                      
----------------         
81A560   LDX #$39                 
81A562   LDA $0B                  
81A564   CMP #$02                 
81A566   BEQ $81A56A              
81A568   LDX #$3D                 
81A56A   STX $1B                  
81A56C   LDA $0D                  
81A56E   ASL                      
81A56F   TAX                      
81A570   LDY $9E18,X              
81A573   LDA $9E19,X              
81A576   JSL $8089A3              
81A57A   INC $00FC                
81A57D   STZ $48                  
81A57F   LSR $0D                  
81A581   ROR $0D                  
81A583   ROR $0D                  
81A585   RTS                      
----------------         
--------sub start--------
81A586   LDA #$01                 
81A588   STA $01                  
81A58A   LDA #$04                 
81A58C   STA $03                  
81A58E   LDA #$A0                 
81A590   STA $3E                  
81A592   LDA #$03                 
81A594   STA $3F                  
81A596   LDA #$12                 
81A598   JSL $809A53              
81A59C   LDX $0D                  
81A59E   LDA #$04                 
81A5A0   LDY #$00                 
81A5A2   JSL $809252              
81A5A6   RTS                      
----------------         
--------sub start--------
81A5A7   JSL $80C007              
81A5AB   REP #$21                 
81A5AD   LDA $16                  
81A5AF   ADC $3E                  
81A5B1   STA $16                  
81A5B3   LDA $3E                  
81A5B5   SEC                      
81A5B6   SBC #$001E               
81A5B9   STA $3E                  
81A5BB   SEP #$20                 
81A5BD   LDA $17                  
81A5BF   BPL $81A5E3              
81A5C1   LDA #$06                 
81A5C3   STA $02                  
81A5C5   STZ $17                  
81A5C7   STZ $01                  
81A5C9   LDA $0B                  
81A5CB   CMP #$02                 
81A5CD   BEQ $81A5D4              
81A5CF   CMP #$04                 
81A5D1   BEQ $81A5D4              
81A5D3   RTS                      
----------------         
81A5D4   LDA $00FC                
81A5D7   CMP #$02                 
81A5D9   BNE $81A5E3              
81A5DB   LDA #$02                 
81A5DD   STA $00A8                
81A5E0   INC $00AC                
81A5E3   RTS                      
----------------         
81A5E4   JSL $808F1E              
81A5E8   RTS                      
----------------         
81A5E9   LDX $02                  
81A5EB   JMP ($A5EE,X)            
--------data--------     
81A5EE  .db $F6 $A5 $1D $A6 $3D $A7 $FA $A7
----------------         
81A5F6   LDA #$02                 
81A5F8   STA $02                  
81A5FA   LDA #$01                 
81A5FC   STA $00                  
81A5FE   STA $1F                  
81A600   STZ $0C                  
81A602   LDX #$29                 
81A604   LDA $42                  
81A606   BEQ $81A60A              
81A608   LDX #$2D                 
81A60A   STX $1B                  
81A60C   LDA #$40                 
81A60E   STA $1A                  
81A610   LDA #$FF                 
81A612   STA $0D                  
81A614   STZ $48                  
81A616   STZ $47                  
81A618   STZ $1C                  
81A61A   STZ $1D                  
81A61C   RTS                      
----------------         
81A61D   REP #$10                 
81A61F   LDX $4E                  
81A621   LDA $000D,X              
81A624   STA $43                  
81A626   LDA $0048,X              
81A629   CMP #$05                 
81A62B   SEP #$10                 
81A62D   BCS $81A63C              
81A62F   LDA $43                  
81A631   STA $0D                  
81A633   LDA #$04                 
81A635   STA $02                  
81A637   STZ $03                  
81A639   JMP $A73D                
81A63C   LDA $48                  
81A63E   BEQ $81A649              
81A640   LDA #$04                 
81A642   STA $02                  
81A644   STZ $46                  
81A646   JMP $A73D                
81A649   LDX $03                  
81A64B   JSR ($A653,X)            
81A64E   JSL $8088CE              
81A652   RTS                      
----------------         
--------data--------     
81A653  .db $55 $A6              
----------------         
--------sub start--------
81A655   REP #$10                 
81A657   LDA $0D                  
81A659   STA $4A                  
81A65B   LDX $4E                  
81A65D   LDA $004D,X              
81A660   STA $01                  
81A662   BNE $81A667              
81A664   SEP #$10                 
81A666   RTS                      
----------------         
81A667   LDA $000D,X              
81A66A   STA $0D                  
81A66C   LDA $004B,X              
81A66F   SEP #$10                 
81A671   BEQ $81A6CE              
81A673   DEC                      
81A674   BEQ $81A6F0              
81A676   LDA $47                  
81A678   BEQ $81A6A0              
81A67A   DEC $47                  
81A67C   LDA $0B                  
81A67E   CMP #$06                 
81A680   BNE $81A6A0              
81A682   LDA $0D                  
81A684   ASL                      
81A685   TAX                      
81A686   LDA $47                  
81A688   AND #$01                 
81A68A   BEQ $81A694              
81A68C   LDY $9E68,X              
81A68F   LDA $9E69,X              
81A692   BRA $81A69A              
81A694   LDY $9E70,X              
81A697   LDA $9E71,X              
81A69A   JSL $8089A3              
81A69E   BRA $81A714              
81A6A0   LDX $0D                  
81A6A2   LDA $9E04,X              
81A6A5   STA $0E                  
81A6A7   LDA $0B                  
81A6A9   CMP #$06                 
81A6AB   BEQ $81A6AF              
81A6AD   BRA $81A6BC              
81A6AF   TXA                      
81A6B0   ASL                      
81A6B1   TAX                      
81A6B2   LDY $9E68,X              
81A6B5   LDA $9E69,X              
81A6B8   JSL $8089A3              
81A6BC   REP #$10                 
81A6BE   LDX $4C                  
81A6C0   LDA $0047,X              
81A6C3   SEP #$10                 
81A6C5   DEC                      
81A6C6   BNE $81A714              
81A6C8   LDA #$04                 
81A6CA   STA $47                  
81A6CC   BRA $81A714              
81A6CE   LDA $0B                  
81A6D0   CMP #$06                 
81A6D2   BEQ $81A6EA              
81A6D4   LDX $0D                  
81A6D6   LDA $9E04,X              
81A6D9   STA $0E                  
81A6DB   TXA                      
81A6DC   ASL                      
81A6DD   TAX                      
81A6DE   LDY $9EC4,X              
81A6E1   LDA $9EC5,X              
81A6E4   JSL $8089A3              
81A6E8   BRA $81A714              
81A6EA   LDA $0D                  
81A6EC   CMP $4A                  
81A6EE   BEQ $81A710              
81A6F0   LDX $0D                  
81A6F2   LDA $9E04,X              
81A6F5   STA $0E                  
81A6F7   TXA                      
81A6F8   ASL                      
81A6F9   ASL                      
81A6FA   ASL                      
81A6FB   STA $49                  
81A6FD   LDA $4B                  
81A6FF   AND #$03                 
81A701   ASL                      
81A702   CLC                      
81A703   ADC $49                  
81A705   TAX                      
81A706   LDY $9E48,X              
81A709   LDA $9E49,X              
81A70C   JSL $8089A3              
81A710   JSL $8089A9              
81A714   REP #$30                 
81A716   LDX $4C                  
81A718   LDA $0011,X              
81A71B   STA $11                  
81A71D   LDA $0014,X              
81A720   STA $14                  
81A722   SEP #$30                 
81A724   LDA $0D                  
81A726   ASL                      
81A727   ASL                      
81A728   TAX                      
81A729   REP #$21                 
81A72B   LDA $9F8B,X              
81A72E   ADC $11                  
81A730   STA $11                  
81A732   LDA $9F8D,X              
81A735   CLC                      
81A736   ADC $14                  
81A738   STA $14                  
81A73A   SEP #$20                 
81A73C   RTS                      
----------------         
81A73D   REP #$10                 
81A73F   LDX $4E                  
81A741   LDA $0048,X              
81A744   CMP #$05                 
81A746   SEP #$10                 
81A748   BCS $81A74D              
81A74A   JMP $A51E                
81A74D   LDX $46                  
81A74F   JSR ($A757,X)            
81A752   JSL $8088CE              
81A756   RTS                      
----------------         
--------data--------     
81A757  .db $5D $A7 $91 $A7 $B4 $A7
----------------         
--------sub start--------
81A75D   LDA #$02                 
81A75F   STA $46                  
81A761   LDA #$03                 
81A763   STA $00                  
81A765   LDA #$01                 
81A767   STA $01                  
81A769   LDX #$39                 
81A76B   LDA $42                  
81A76D   BEQ $81A771              
81A76F   LDX #$3D                 
81A771   STX $1B                  
81A773   LDA $0D                  
81A775   INC                      
81A776   INC                      
81A777   AND #$03                 
81A779   STA $0D                  
81A77B   LSR                      
81A77C   ROR                      
81A77D   ROR                      
81A77E   TAX                      
81A77F   LDA #$01                 
81A781   LDY #$80                 
81A783   JSL $809252              
81A787   REP #$20                 
81A789   LDA #$0300               
81A78C   STA $44                  
81A78E   SEP #$20                 
81A790   RTS                      
----------------         
--------sub start--------
81A791   REP #$21                 
81A793   LDA $44                  
81A795   SBC #$001F               
81A798   STA $44                  
81A79A   CLC                      
81A79B   ADC $16                  
81A79D   STA $16                  
81A79F   BPL $81A7AD              
81A7A1   LDA #$0004               
81A7A4   STA $46                  
81A7A6   STZ $16                  
81A7A8   LDA #$0200               
81A7AB   STA $44                  
81A7AD   SEP #$20                 
81A7AF   JSL $80C007              
81A7B3   RTS                      
----------------         
--------sub start--------
81A7B4   REP #$21                 
81A7B6   LDA $44                  
81A7B8   SBC #$001F               
81A7BB   STA $44                  
81A7BD   CLC                      
81A7BE   ADC $16                  
81A7C0   STA $16                  
81A7C2   BPL $81A7CB              
81A7C4   STZ $16                  
81A7C6   LDA #$0200               
81A7C9   STA $44                  
81A7CB   SEP #$20                 
81A7CD   JSL $80C007              
81A7D1   LDA $0D                  
81A7D3   AND #$01                 
81A7D5   REP #$21                 
81A7D7   BEQ $81A7E6              
81A7D9   LDA $11                  
81A7DB   ADC #$0010               
81A7DE   CMP #$0120               
81A7E1   BCS $81A7F3              
81A7E3   SEP #$20                 
81A7E5   RTS                      
----------------         
81A7E6   LDA $14                  
81A7E8   ADC #$0010               
81A7EB   CMP #$0100               
81A7EE   BCS $81A7F3              
81A7F0   SEP #$20                 
81A7F2   RTS                      
----------------         
81A7F3   SEP #$20                 
81A7F5   LDA #$06                 
81A7F7   STA $02                  
81A7F9   RTS                      
----------------         
81A7FA   JSL $808F1E              
81A7FE   RTS                      

;Sprite 0x26 LEVEL 3 Boss (Skeletons)
81A7FF   LDX $02                  
81A801   JMP ($A804,X)            
--------data--------     
81A804  .db 
dw $A80C
dw $A8C2 
dw $AEE7

81A80A  .db $06 $B0              
----------------         
81A80C   LDA #$02                 
81A80E   STA $02                  
81A810   DEC                      
81A811   STA $00                  
81A813   STA $0C                  
81A815   LDA #$40                 
81A817   STA $1A                  
81A819   STZ $28                  
81A81B   STZ $0E                  
81A81D   LDX $0B                  
81A81F   JMP ($A822,X)            
--------data--------     
81A822  .db $2C $A8 $2A $A8 $9F $A8 $A5 $A8
----------------         
81A82A   LDX #$05                 
81A82C   LDA $A190,X              
81A82F   STA $1B                  
81A831   REP #$20                 
81A833   LDA $A191,X              
81A836   STA $3C                  
81A838   LDA $A193,X              
81A83B   STA $11                  
81A83D   SEP #$20                 
81A83F   INC $01                  
81A841   INC $01                  
81A843   LDY #$14                 
81A845   LDA #$A0                 
81A847   JSL $8089A3              
81A84B   LDA #$30                 
81A84D   STA $1C                  
81A84F   STA $1D                  
81A851   LDA #$20                 
81A853   STA $1E                  
81A855   LDA $0D                  
81A857   STA $0F                  
81A859   LDA #$10                 
81A85B   STA $03                  
81A85D   STZ $2C                  
81A85F   JSL $808F73              
81A863   BCS $81A87A              
81A865   LDA #$03                 
81A867   STA $0000,X              
81A86A   LDA #$4E                 
81A86C   STA $000A,X              
81A86F   LDA #$04                 
81A871   STA $000B,X              
81A874   REP #$20                 
81A876   TDC                      
81A877   STA $0030,X              
81A87A   SEP #$30                 
81A87C   JSL $808F73              
81A880   STX $36                  
81A882   LDA #$03                 
81A884   STA $0000,X              
81A887   LDA #$26                 
81A889   STA $000A,X              
81A88C   LDA $0B                  
81A88E   CLC                      
81A88F   ADC #$04                 
81A891   STA $000B,X              
81A894   LDA $11                  
81A896   STA $0011,X              
81A899   STZ $0035,X              
81A89C   SEP #$10                 
81A89E   RTS                      
----------------         
81A89F   LDA #$3B                 
81A8A1   STA $1B                  
81A8A3   BRA $81A8A9              
81A8A5   LDA #$39                 
81A8A7   STA $1B                  
81A8A9   LDY #$C2                 
81A8AB   LDA #$A0                 
81A8AD   JSL $8089A3              
81A8B1   LDA #$48                 
81A8B3   STA $14                  
81A8B5   LDA #$18                 
81A8B7   STA $17                  
81A8B9   STZ $12                  
81A8BB   STZ $15                  
81A8BD   LDA #$24                 
81A8BF   STA $1E                  
81A8C1   RTS                      
----------------         
81A8C2   LDX $0B                  
81A8C4   JSR ($A8CC,X)            
81A8C7   JSL $8088CE              
81A8CB   RTS                      
----------------         
--------data--------     
81A8CC  .db $D4 $A8 $D4 $A8 $C3 $AE $C3 $AE
----------------         
--------sub start--------
81A8D4   LDA $1D                  
81A8D6   CMP $1C                  
81A8D8   BEQ $81A8E3              
81A8DA   LDA #$04                 
81A8DC   STA $02                  
81A8DE   STZ $2D                  
81A8E0   JMP $AEE7                
81A8E3   LDA #$01                 
81A8E5   STA $01                  
81A8E7   LDA $2C                  
81A8E9   BEQ $81A8F1              
81A8EB   DEC $2C                  
81A8ED   AND #$01                 
81A8EF   STA $01                  
81A8F1   LDX $03                  
81A8F3   JMP ($A8F6,X)            
--------data--------     
81A8F6  .db $08 $A9 $23 $A9 $5E $A9 $CF $A9
81A8FE  .db $D9 $AB $11 $AC $91 $AD $C5 $AD
81A906  .db $EC $AD              
----------------         
81A908   LDA #$02                 
81A90A   STA $03                  
81A90C   JSL $808859              
81A910   AND #$0F                 
81A912   TAX                      
81A913   LDA $A0DA,X              
81A916   TAX                      
81A917   LSR                      
81A918   LSR                      
81A919   LSR                      
81A91A   LSR                      
81A91B   STA $3E                  
81A91D   TXA                      
81A91E   AND #$0F                 
81A920   STA $3F                  
81A922   RTS                      
----------------         
81A923   LDA $1C                  
81A925   CMP #$19                 
81A927   BCC $81A953              
81A929   LDA #$04                 
81A92B   STA $03                  
81A92D   LDA #$44                 
81A92F   STA $3C                  
81A931   LDA #$A0                 
81A933   LDY #$28                 
81A935   JSL $8089A3              
81A939   LDA #$03                 
81A93B   STA $00                  
81A93D   REP #$20                 
81A93F   LDA #$0100               
81A942   LDX $0F                  
81A944   BEQ $81A949              
81A946   LDA #$FF00               
81A949   STA $28                  
81A94B   LDA #$02E0               
81A94E   STA $3A                  
81A950   SEP #$20                 
81A952   RTS                      
----------------         
81A953   LDA #$06                 
81A955   STA $03                  
81A957   LDA #$01                 
81A959   STA $3C                  
81A95B   STZ $3D                  
81A95D   RTS                      
----------------         
81A95E   LDX $04                  
81A960   JSR ($A976,X)            
81A963   ASL $01                  
81A965   REP #$10                 
81A967   LDX $36                  
81A969   LDA $11                  
81A96B   STA $0011,X              
81A96E   LDA $17                  
81A970   STA $0017,X              
81A973   SEP #$10                 
81A975   RTS                      
----------------         
--------data--------     
81A976  .db $7A $A9 $B4 $A9      
----------------         
--------sub start--------
81A97A   DEC $3C                  
81A97C   BNE $81A999              
81A97E   LDA #$02                 
81A980   STA $04                  
81A982   LDA #$A0                 
81A984   LDY #$31                 
81A986   JSL $8089A3              
81A98A   LDA #$07                 
81A98C   STA $3C                  
81A98E   STZ $16                  
81A990   STZ $17                  
81A992   LDA $0F                  
81A994   EOR #$01                 
81A996   STA $0F                  
81A998   RTS                      
----------------         
81A999   REP #$21                 
81A99B   LDA $16                  
81A99D   ADC $3A                  
81A99F   STA $16                  
81A9A1   LDA $3A                  
81A9A3   SEC                      
81A9A4   SBC #$0016               
81A9A7   STA $3A                  
81A9A9   SEP #$20                 
81A9AB   LDA $0F                  
81A9AD   STA $0D                  
81A9AF   JSL $80C032              
81A9B3   RTS                      
----------------         
--------sub start--------
81A9B4   DEC $3C                  
81A9B6   BNE $81A9CA              
81A9B8   LDA #$A0                 
81A9BA   LDY #$14                 
81A9BC   JSL $8089A3              
81A9C0   LDA #$01                 
81A9C2   STA $00                  
81A9C4   LDA #$08                 
81A9C6   STA $03                  
81A9C8   STZ $04                  
81A9CA   JSL $8089A9              
81A9CE   RTS                      
----------------         
81A9CF   LDX $04                  
81A9D1   JMP ($A9D4,X)            
--------data--------     
81A9D4  .db $DA $A9 $0A $AA $88 $AB
----------------         
81A9DA   DEC $3C                  
81A9DC   BNE $81AA09              
81A9DE   LDA $3D                  
81A9E0   CMP #$0A                 
81A9E2   BCC $81A9F2              
81A9E4   LDA #$02                 
81A9E6   STA $04                  
81A9E8   REP #$10                 
81A9EA   LDX $36                  
81A9EC   INC $0035,X              
81A9EF   SEP #$10                 
81A9F1   RTS                      
----------------         
81A9F2   LDX $3D                  
81A9F4   LDA $A136,X              
81A9F7   STA $3C                  
81A9F9   LDA $3D                  
81A9FB   ASL                      
81A9FC   TAX                      
81A9FD   LDY $A122,X              
81AA00   LDA $A123,X              
81AA03   JSL $8089A3              
81AA07   INC $3D                  
81AA09   RTS                      
----------------         
81AA0A   LDX $05                  
81AA0C   JMP ($AA0F,X)            
--------data--------     
81AA0F  .db $19 $AA $62 $AA $C8 $AA $EF $AA
81AA17  .db $65 $AB              
----------------         
81AA19   LDA #$02                 
81AA1B   STA $05                  
81AA1D   DEC                      
81AA1E   STA $01                  
81AA20   LDA #$18                 
81AA22   STA $17                  
81AA24   LDA #$22                 
81AA26   STA $1E                  
81AA28   JSR $B00B                
81AA2B   STA $0D                  
81AA2D   ASL                      
81AA2E   ASL                      
81AA2F   ASL                      
81AA30   TAX                      
81AA31   LDA #$01                 
81AA33   STA $34                  
81AA35   LDY #$00                 
81AA37   STY $33                  
81AA39   JSL $809252              
81AA3D   LDA $0D                  
81AA3F   CLC                      
81AA40   ADC #$04                 
81AA42   LSR                      
81AA43   LSR                      
81AA44   LSR                      
81AA45   AND #$03                 
81AA47   TAY                      
81AA48   LDX $A010,Y              
81AA4B   STX $0E                  
81AA4D   ASL                      
81AA4E   TAX                      
81AA4F   LDY $A008,X              
81AA52   LDA $A009,X              
81AA55   JSL $8089A3              
81AA59   LDA #$E6                 
81AA5B   STA $3C                  
81AA5D   LDA #$04                 
81AA5F   STA $3D                  
81AA61   RTS                      
----------------         
81AA62   DEC $3C                  
81AA64   BNE $81AA6B              
81AA66   LDA #$04                 
81AA68   STA $05                  
81AA6A   RTS                      
----------------         
81AA6B   DEC $3D                  
81AA6D   BNE $81AAA2              
81AA6F   LDA #$04                 
81AA71   STA $3D                  
81AA73   REP #$10                 
81AA75   LDA #$01                 
81AA77   XBA                      
81AA78   LDA $31                  
81AA7A   TAX                      
81AA7B   JSL $808B0E              
81AA7F   SEC                      
81AA80   SBC $0D                  
81AA82   AND #$1F                 
81AA84   BEQ $81AA94              
81AA86   CMP #$16                 
81AA88   LDX $0D                  
81AA8A   INX                      
81AA8B   BCC $81AA8F              
81AA8D   DEX                      
81AA8E   DEX                      
81AA8F   TXA                      
81AA90   AND #$1F                 
81AA92   STA $0D                  
81AA94   LDA $0D                  
81AA96   ASL                      
81AA97   ASL                      
81AA98   ASL                      
81AA99   TAX                      
81AA9A   LDA $34                  
81AA9C   LDY $33                  
81AA9E   JSL $809252              
81AAA2   LDA $30                  
81AAA4   INC                      
81AAA5   AND #$1F                 
81AAA7   STA $30                  
81AAA9   CLC                      
81AAAA   ADC #$04                 
81AAAC   LSR                      
81AAAD   LSR                      
81AAAE   LSR                      
81AAAF   AND #$03                 
81AAB1   TAY                      
81AAB2   LDX $A010,Y              
81AAB5   STX $0E                  
81AAB7   ASL                      
81AAB8   TAX                      
81AAB9   LDY $A008,X              
81AABC   LDA $A009,X              
81AABF   JSL $8089A3              
81AAC3   JSL $80C007              
81AAC7   RTS                      
----------------         
81AAC8   REP #$21                 
81AACA   LDA $33                  
81AACC   BNE $81AAD5              
81AACE   SEP #$20                 
81AAD0   LDA #$06                 
81AAD2   STA $05                  
81AAD4   RTS                      
----------------         
81AAD5   SBC #$000F               
81AAD8   STA $33                  
81AADA   SEP #$20                 
81AADC   LDA $0D                  
81AADE   ASL                      
81AADF   ASL                      
81AAE0   ASL                      
81AAE1   TAX                      
81AAE2   LDA $34                  
81AAE4   LDY $33                  
81AAE6   JSL $809252              
81AAEA   JSL $80C007              
81AAEE   RTS                      
----------------         
81AAEF   REP #$20                 
81AAF1   LDA $33                  
81AAF3   CMP #$0200               
81AAF6   BEQ $81AAFE              
81AAF8   CLC                      
81AAF9   ADC #$0010               
81AAFC   STA $33                  
81AAFE   LDA $11                  
81AB00   CLC                      
81AB01   ADC #$0003               
81AB04   REP #$11                 
81AB06   LDX $36                  
81AB08   SEC                      
81AB09   SBC $0011,X              
81AB0C   CMP #$0004               
81AB0F   BCS $81AB29              
81AB11   LDA $14                  
81AB13   CLC                      
81AB14   ADC #$0002               
81AB17   LDX $36                  
81AB19   SEC                      
81AB1A   SBC $0014,X              
81AB1D   CMP #$0004               
81AB20   BCS $81AB29              
81AB22   SEP #$30                 
81AB24   LDA #$08                 
81AB26   STA $05                  
81AB28   RTS                      
----------------         
81AB29   SEP #$20                 
81AB2B   JSL $808B0E              
81AB2F   STA $0D                  
81AB31   LDA $30                  
81AB33   CLC                      
81AB34   ADC #$01                 
81AB36   AND #$1F                 
81AB38   STA $30                  
81AB3A   LSR                      
81AB3B   LSR                      
81AB3C   INC                      
81AB3D   LSR                      
81AB3E   AND #$03                 
81AB40   TAY                      
81AB41   LDX $A010,Y              
81AB44   STX $0E                  
81AB46   ASL                      
81AB47   TAX                      
81AB48   LDY $A008,X              
81AB4B   LDA $A009,X              
81AB4E   JSL $8089A3              
81AB52   LDA $0D                  
81AB54   ASL                      
81AB55   ASL                      
81AB56   ASL                      
81AB57   TAX                      
81AB58   LDA $34                  
81AB5A   LDY $33                  
81AB5C   JSL $809252              
81AB60   JSL $80C007              
81AB64   RTS                      
----------------         
81AB65   LDA $31                  
81AB67   BEQ $81AB70              
81AB69   LDA $00FC                
81AB6C   AND #$FD                 
81AB6E   BRA $81AB75              
81AB70   LDA $00FC                
81AB73   AND #$FE                 
81AB75   STA $00FC                
81AB78   LDA #$04                 
81AB7A   STA $04                  
81AB7C   STZ $05                  
81AB7E   LDA #$01                 
81AB80   STA $3C                  
81AB82   STZ $3D                  
81AB84   INC                      
81AB85   STA $01                  
81AB87   RTS                      
----------------         
81AB88   LDA $1C                  
81AB8A   BNE $81AB96              
81AB8C   LDA #$04                 
81AB8E   STA $02                  
81AB90   JSR $B09D                
--------unidentified--------
81AB93  .db $4C $91 $AF          
----------------         
81AB96   DEC $3C                  
81AB98   BNE $81ABBF              
81AB9A   LDA $3D                  
81AB9C   CMP #$08                 
81AB9E   BMI $81ABA7              
81ABA0   LDA #$08                 
81ABA2   STA $03                  
81ABA4   STZ $04                  
81ABA6   RTS                      
----------------         
81ABA7   LDA $3D                  
81ABA9   TAX                      
81ABAA   LDA $A11A,X              
81ABAD   STA $3C                  
81ABAF   LDA $3D                  
81ABB1   ASL                      
81ABB2   TAX                      
81ABB3   LDY $A10A,X              
81ABB6   LDA $A10B,X              
81ABB9   JSL $8089A3              
81ABBD   INC $3D                  
81ABBF   STZ $17                  
81ABC1   LDA #$20                 
81ABC3   STA $1E                  
81ABC5   REP #$10                 
81ABC7   LDX $36                  
81ABC9   STZ $0035,X              
81ABCC   LDA $0011,X              
81ABCF   STA $11                  
81ABD1   LDA $0014,X              
81ABD4   STA $14                  
81ABD6   SEP #$10                 
81ABD8   RTS                      
----------------         
81ABD9   LDX $04                  
81ABDB   JMP ($ABDE,X)            
--------data--------     
81ABDE  .db $E2 $AB $F3 $AB      
----------------         
81ABE2   LDA #$02                 
81ABE4   STA $04                  
81ABE6   JSL $808859              
81ABEA   AND #$0F                 
81ABEC   TAX                      
81ABED   LDA $A0EA,X              
81ABF0   STA $3C                  
81ABF2   RTS                      
----------------         
81ABF3   DEC $3C                  
81ABF5   BNE $81AC0C              
81ABF7   DEC $3E                  
81ABF9   BEQ $81AC02              
81ABFB   LDA #$02                 
81ABFD   STA $03                  
81ABFF   STZ $04                  
81AC01   RTS                      
----------------         
81AC02   LDA #$0A                 
81AC04   STA $03                  
81AC06   STZ $04                  
81AC08   LDA #$FF                 
81AC0A   STA $34                  
81AC0C   JSL $8089A9              
81AC10   RTS                      
----------------         
81AC11   LDX $04                  
81AC13   JMP ($AC16,X)            
--------data--------     
81AC16  .db $1A $AC $7A $AD      
----------------         
81AC1A   LDA $0B                  
81AC1C   BNE $81AC22              
81AC1E   LDA #$04                 
81AC20   BRA $81AC24              
81AC22   LDA #$07                 
81AC24   CMP $00FF                
81AC27   BMI $81AC38              
81AC29   JSL $808F8E              
81AC2D   BCS $81AC38              
81AC2F   STX $38                  
81AC31   SEP #$10                 
81AC33   LDX $0B                  
81AC35   JMP ($AC46,X)            
81AC38   SEP #$10                 
81AC3A   LDA #$0E                 
81AC3C   STA $03                  
81AC3E   LDA #$02                 
81AC40   STA $04                  
81AC42   DEC                      
81AC43   STA $3C                  
81AC45   RTS                      
----------------         
--------data--------     
81AC46  .db $4A $AC $D2 $AC      
----------------         
81AC4A   LDA #$03                 
81AC4C   STA $3C                  
81AC4E   LDA $34                  
81AC50   BMI $81AC6F              
81AC52   LDA #$03                 
81AC54   STA $3D                  
81AC56   JSL $808859              
81AC5A   AND #$0F                 
81AC5C   TAX                      
81AC5D   LDA $A140,X              
81AC60   CMP $34                  
81AC62   BNE $81AC79              
81AC64   DEC $3D                  
81AC66   BNE $81AC56              
81AC68   LDA $34                  
81AC6A   CLC                      
81AC6B   ADC #$14                 
81AC6D   BRA $81AC79              
81AC6F   JSL $808859              
81AC73   AND #$0F                 
81AC75   TAX                      
81AC76   LDA $A140,X              
81AC79   STA $34                  
81AC7B   JSR $B00B                
81AC7E   LSR                      
81AC7F   STA $2F                  
81AC81   REP #$10                 
81AC83   LDX $38                  
81AC85   STA $000D,X              
81AC88   LDA $34                  
81AC8A   STA $000F,X              
81AC8D   LDA #$03                 
81AC8F   STA $0000,X              
81AC92   LDA #$06                 
81AC94   STA $000A,X              
81AC97   LDA $0B                  
81AC99   STA $000B,X              
81AC9C   LDA $11                  
81AC9E   STA $0011,X              
81ACA1   REP #$20                 
81ACA3   TDC                      
81ACA4   STA $0032,X              
81ACA7   SEP #$20                 
81ACA9   SEP #$10                 
81ACAB   INC $00FF                
81ACAE   DEC $3C                  
81ACB0   BNE $81ACB5              
81ACB2   JMP $AD67                
81ACB5   JSL $808F8E              
81ACB9   BCC $81ACBE              
81ACBB   JMP $AD67                
81ACBE   LDA $3C                  
81ACC0   DEC                      
81ACC1   BEQ $81ACC8              
81ACC3   LDA $2F                  
81ACC5   DEC                      
81ACC6   BRA $81ACCB              
81ACC8   LDA $2F                  
81ACCA   INC                      
81ACCB   AND #$0F                 
81ACCD   STA $000D,X              
81ACD0   BRA $81AC88              
81ACD2   LDA #$02                 
81ACD4   STA $3C                  
81ACD6   LDA $34                  
81ACD8   BMI $81AD01              
81ACDA   LDA #$03                 
81ACDC   STA $3D                  
81ACDE   JSL $808859              
81ACE2   AND #$0F                 
81ACE4   CLC                      
81ACE5   ADC $33                  
81ACE7   TAX                      
81ACE8   LDA $A160,X              
81ACEB   CMP $34                  
81ACED   BNE $81AD1A              
81ACEF   DEC $3D                  
81ACF1   BNE $81ACDE              
81ACF3   LDA $34                  
81ACF5   CMP #$12                 
81ACF7   BEQ $81ACFD              
81ACF9   INC                      
81ACFA   INC                      
81ACFB   BRA $81AD1A              
--------unidentified--------
81ACFD  .db $A9 $00 $80 $19      
----------------         
81AD01   JSL $808859              
81AD05   AND #$0F                 
81AD07   TAX                      
81AD08   LDA $A150,X              
81AD0B   STA $33                  
81AD0D   JSL $808859              
81AD11   AND #$0F                 
81AD13   CLC                      
81AD14   ADC $33                  
81AD16   TAX                      
81AD17   LDA $A160,X              
81AD1A   STA $34                  
81AD1C   REP #$10                 
81AD1E   LDX $38                  
81AD20   STZ $000E,X              
81AD23   LDA $33                  
81AD25   STA $000D,X              
81AD28   LDA $34                  
81AD2A   STA $000F,X              
81AD2D   LDA #$03                 
81AD2F   STA $0000,X              
81AD32   LDA #$06                 
81AD34   STA $000A,X              
81AD37   LDA $0B                  
81AD39   STA $000B,X              
81AD3C   LDA $11                  
81AD3E   STA $0011,X              
81AD41   REP #$20                 
81AD43   TDC                      
81AD44   STA $0032,X              
81AD47   SEP #$20                 
81AD49   INC $00FF                
81AD4C   DEC $3C                  
81AD4E   BEQ $81AD67              
81AD50   JSL $808F8E              
81AD54   BCS $81AD67              
81AD56   LDA #$01                 
81AD58   STA $000E,X              
81AD5B   LDA $33                  
81AD5D   STA $000D,X              
81AD60   LDA $34                  
81AD62   STA $000F,X              
81AD65   BRA $81AD2D              
81AD67   SEP #$10                 
81AD69   LDA #$02                 
81AD6B   STA $04                  
81AD6D   LDA #$A0                 
81AD6F   LDY #$60                 
81AD71   JSL $8089A3              
81AD75   LDA #$2A                 
81AD77   STA $3C                  
81AD79   RTS                      
----------------         
81AD7A   DEC $3C                  
81AD7C   BNE $81AD8C              
81AD7E   LDA #$A0                 
81AD80   LDY #$14                 
81AD82   JSL $8089A3              
81AD86   LDA #$0C                 
81AD88   STA $03                  
81AD8A   STZ $04                  
81AD8C   JSL $8089A9              
81AD90   RTS                      
----------------         
81AD91   LDX $04                  
81AD93   JMP ($AD96,X)            
--------data--------     
81AD96  .db $9A $AD $AB $AD      
----------------         
81AD9A   LDA #$02                 
81AD9C   STA $04                  
81AD9E   JSL $808859              
81ADA2   AND #$0F                 
81ADA4   TAX                      
81ADA5   LDA $A0EA,X              
81ADA8   STA $3C                  
81ADAA   RTS                      
----------------         
81ADAB   DEC $3C                  
81ADAD   BNE $81ADC0              
81ADAF   DEC $3F                  
81ADB1   BEQ $81ADBA              
81ADB3   LDA #$0A                 
81ADB5   STA $03                  
81ADB7   STZ $04                  
81ADB9   RTS                      
----------------         
81ADBA   LDA #$0E                 
81ADBC   STA $03                  
81ADBE   STZ $04                  
81ADC0   JSL $8089A9              
81ADC4   RTS                      
----------------         
81ADC5   LDX $04                  
81ADC7   JMP ($ADCA,X)            
--------data--------     
81ADCA  .db $CE $AD $DF $AD      
----------------         
81ADCE   LDA #$02                 
81ADD0   STA $04                  
81ADD2   JSL $808859              
81ADD6   AND #$0F                 
81ADD8   TAX                      
81ADD9   LDA $A0FA,X              
81ADDC   STA $3C                  
81ADDE   RTS                      
----------------         
81ADDF   DEC $3C                  
81ADE1   BNE $81ADE7              
81ADE3   STZ $03                  
81ADE5   STZ $04                  
81ADE7   JSL $8089A9              
81ADEB   RTS                      
----------------         
81ADEC   INC $01                  
81ADEE   LDX $04                  
81ADF0   JMP ($ADF3,X)            
--------data--------     
81ADF3  .db $FF $AD $3B $AE $6F $AE $8C $AE
81ADFB  .db $99 $AE $B9 $AE      
----------------         
81ADFF   REP #$20                 
81AE01   DEC $3C                  
81AE03   SEP #$20                 
81AE05   BNE $81AE3A              
81AE07   LDA #$02                 
81AE09   STA $04                  
81AE0B   LDA $0B                  
81AE0D   BNE $81AE1C              
81AE0F   REP #$20                 
81AE11   LDA #$0200               
81AE14   STA $28                  
81AE16   SEP #$20                 
81AE18   LDA #$44                 
81AE1A   BRA $81AE27              
81AE1C   REP #$20                 
81AE1E   LDA #$FE00               
81AE21   STA $28                  
81AE23   SEP #$20                 
81AE25   LDA #$44                 
81AE27   STA $3C                  
81AE29   LDA #$A0                 
81AE2B   LDY #$28                 
81AE2D   JSL $8089A3              
81AE31   REP #$20                 
81AE33   LDA #$02E0               
81AE36   STA $3A                  
81AE38   SEP #$20                 
81AE3A   RTS                      
----------------         
81AE3B   DEC $3C                  
81AE3D   BNE $81AE54              
81AE3F   LDA #$04                 
81AE41   STA $04                  
81AE43   LDA #$A0                 
81AE45   LDY #$31                 
81AE47   JSL $8089A3              
81AE4B   LDA #$07                 
81AE4D   STA $3C                  
81AE4F   STZ $16                  
81AE51   STZ $17                  
81AE53   RTS                      
----------------         
81AE54   REP #$21                 
81AE56   LDA $16                  
81AE58   ADC $3A                  
81AE5A   STA $16                  
81AE5C   LDA $3A                  
81AE5E   SEC                      
81AE5F   SBC #$0016               
81AE62   STA $3A                  
81AE64   SEP #$20                 
81AE66   LDA $0F                  
81AE68   STA $0D                  
81AE6A   JSL $80C032              
81AE6E   RTS                      
----------------         
81AE6F   DEC $3C                  
81AE71   BNE $81AE8B              
81AE73   LDA #$A0                 
81AE75   LDY #$14                 
81AE77   JSL $8089A3              
81AE7B   LDA #$06                 
81AE7D   STA $04                  
81AE7F   LDA $0B                  
81AE81   BNE $81AE87              
81AE83   LDA #$88                 
81AE85   BRA $81AE89              
81AE87   LDA #$28                 
81AE89   STA $3C                  
81AE8B   RTS                      
----------------         
81AE8C   DEC $3C                  
81AE8E   BNE $81AE98              
81AE90   LDA #$08                 
81AE92   STA $04                  
81AE94   LDA #$CA                 
81AE96   STA $3C                  
81AE98   RTS                      
----------------         
81AE99   LDA $0B                  
81AE9B   BNE $81AEB4              
81AE9D   JSL $808FA9              
81AEA1   BCS $81AEB2              
81AEA3   LDA #$02                 
81AEA5   STA $0000,X              
81AEA8   LDA #$1C                 
81AEAA   STA $000A,X              
81AEAD   LDA #$04                 
81AEAF   STA $000B,X              
81AEB2   SEP #$10                 
81AEB4   LDA #$0A                 
81AEB6   STA $04                  
81AEB8   RTS                      
----------------         
81AEB9   LDA $00FE                
81AEBC   BEQ $81AEC2              
81AEBE   STZ $03                  
81AEC0   STZ $04                  
81AEC2   RTS                      
----------------         
--------sub start--------
81AEC3   LDX $03                  
81AEC5   JMP ($AEC8,X)            
--------data--------     
81AEC8  .db $CE $AE $D7 $AE $DE $AE
----------------         
81AECE   LDA $35                  
81AED0   BEQ $81AED6              
81AED2   LDA #$02                 
81AED4   STA $03                  
81AED6   RTS                      
----------------         
81AED7   LDA #$04                 
81AED9   STA $03                  
81AEDB   INC $01                  
81AEDD   RTS                      
----------------         
81AEDE   LDA $35                  
81AEE0   BNE $81AEE6              
81AEE2   STZ $03                  
81AEE4   STZ $01                  
81AEE6   RTS                      
----------------         
81AEE7   LDA $1D                  
81AEE9   CMP $1C                  
81AEEB   BEQ $81AEEF              
81AEED   STZ $2D                  
81AEEF   LDA $03                  
81AEF1   CMP #$06                 
81AEF3   BNE $81AF06              
81AEF5   LDA $04                  
81AEF7   CMP #$02                 
81AEF9   BEQ $81AF53              
81AEFB   CMP #$04                 
81AEFD   BNE $81AF06              
81AEFF   LDA $05                  
81AF01   BNE $81AF06              
81AF03   JSR $B09D                
81AF06   LDA $1C                  
81AF08   BNE $81AF0D              
81AF0A   JMP $AF91                
81AF0D   LDX $2D                  
81AF0F   JSR ($AF17,X)            
81AF12   JSL $8088CE              
81AF16   RTS                      
----------------         
--------data--------     
81AF17  .db $1B $AF $36 $AF      
----------------         
--------sub start--------
81AF1B   LDA $1C                  
81AF1D   STA $1D                  
81AF1F   LDA #$2A                 
81AF21   JSL $809A53              
81AF25   LDA #$12                 
81AF27   STA $2C                  
81AF29   LDA #$02                 
81AF2B   STA $2D                  
81AF2D   LDA #$A0                 
81AF2F   LDY #$43                 
81AF31   JSL $8089A3              
81AF35   RTS                      
----------------         
--------sub start--------
81AF36   JSL $8089A9              
81AF3A   LDA $2C                  
81AF3C   AND #$01                 
81AF3E   STA $01                  
81AF40   DEC $2C                  
81AF42   BNE $81AF52              
81AF44   LDA #$02                 
81AF46   STA $02                  
81AF48   STZ $2D                  
81AF4A   LDA #$A0                 
81AF4C   LDY #$14                 
81AF4E   JSL $8089A3              
81AF52   RTS                      
----------------         
81AF53   LDA $05                  
81AF55   BNE $81AF65              
81AF57   LDA #$18                 
81AF59   STA $17                  
81AF5B   LDA #$01                 
81AF5D   STA $34                  
81AF5F   LDY #$00                 
81AF61   STY $33                  
81AF63   STZ $0E                  
81AF65   LDA #$10                 
81AF67   STA $2C                  
81AF69   LDA $0D                  
81AF6B   ASL                      
81AF6C   ASL                      
81AF6D   ASL                      
81AF6E   STA $0D                  
81AF70   LDA $1C                  
81AF72   STA $1D                  
81AF74   LDA #$2A                 
81AF76   JSL $809A53              
81AF7A   LDA #$A0                 
81AF7C   LDY #$D5                 
81AF7E   JSL $8089A3              
81AF82   LDA #$10                 
81AF84   STA $30                  
81AF86   LDA #$02                 
81AF88   STA $02                  
81AF8A   LDA #$04                 
81AF8C   STA $05                  
81AF8E   STZ $2D                  
81AF90   RTS                      


81AF91   LDX $2D                  
81AF93   JMP ($AF96,X)            
--------data--------     
81AF96  .db $9A $AF $D5 $AF      
----------------         
81AF9A   LDA #$02                 
81AF9C   STA $2D                  
81AF9E   LDA #$03                 
81AFA0   STA $00                  
81AFA2   LDA $1C                  
81AFA4   STA $1D                  
81AFA6   LDA $00FD                
81AFA9   BEQ $81AFAE              
81AFAB   INC $00A8                
81AFAE   INC $00FD                
81AFB1   LDA #$B4                 
81AFB3   STA $2C                  
81AFB5   JSL $808F8E              
81AFB9   BCS $81AFD2              
81AFBB   LDA #$03                 
81AFBD   STA $0000,X              
81AFC0   LDA #$0C                 
81AFC2   STA $000A,X              
81AFC5   STZ $000B,X              
81AFC8   LDA $11                  
81AFCA   STA $0011,X              
81AFCD   LDA $14                  
81AFCF   STA $0014,X              
81AFD2   SEP #$10                 
81AFD4   RTS                      
----------------         
81AFD5   LDA $2C                  
81AFD7   AND #$01                 
81AFD9   STA $01                  
81AFDB   DEC $2C                  
81AFDD   BNE $81AFFB              
81AFDF   LDA $00FD                
81AFE2   CMP #$02                 
81AFE4   BNE $81AFEB              
81AFE6   LDA #$02                 
81AFE8   STA $00A8                
81AFEB   LDA #$06                 
81AFED   STA $02                  
81AFEF   REP #$10                 
81AFF1   LDX $36                  
81AFF3   LDA #$06                 
81AFF5   STA $0002,X              
81AFF8   SEP #$10                 
81AFFA   RTS                      
----------------         
81AFFB   LDA $2C                  
81AFFD   CMP #$AE                 
81AFFF   BEQ $81AFB5              
81B001   JSL $8088CE              
81B005   RTS                      
----------------         
81B006   JSL $808F1E              
81B00A   RTS                      
----------------         
--------sub start--------
81B00B   STZ $32                  
81B00D   LDX #$00                 
81B00F   LDA $0100,X              
81B012   BEQ $81B018              
81B014   LDA #$01                 
81B016   STA $32                  
81B018   LDX #$80                 
81B01A   LDA $0100,X              
81B01D   BEQ $81B025              
81B01F   LDA #$02                 
81B021   ORA $32                  
81B023   STA $32                  
81B025   LDA $32                  
81B027   ASL                      
81B028   TAX                      
81B029   REP #$10                 
81B02B   LDA #$10                 
81B02D   STA $30                  
81B02F   JMP ($B030,X)            
--------data--------     
81B032  .db $83 $B0              
----------------         
--------unidentified-------- ;Never Reached??
81B034  .db $67 $B0 $38 $B0 $A5 $03 $C9 $0A
81B03C  .db $F0 $09 $AD $FC $00 $3A $F0 $23
81B044  .db $3A $F0 $3C $E2 $10 $22 $9A $91
81B04C  .db $80 $C2 $10 $F0 $2D $A9 $01 $EB
81B054  .db $AD $00 $00 $85 $31 $AA $A5 $03
81B05C  .db $C9 $0A $F0 $38 $AD $00 $00 $F0
81B064  .db $2B $80 $0D $A9 $80 $85 $31 $A2
81B06C  .db $80 $01 $A5 $03 $C9 $0A $F0 $24
81B074  .db $AD $FC $00 $09 $02 $8D $FC $00
81B07C  .db $80 $1A $AD $56 $01 $D0 $E4
----------------         
81B083   LDA #$00                 
81B085   STA $31                  
81B087   LDX #$0100               
81B08A   LDA $03                  
81B08C   CMP #$0A                 
81B08E   BEQ $81B098              
81B090   LDA $00FC                
81B093   ORA #$01                 
81B095   STA $00FC                
81B098   JSL $808B0E              
81B09C   RTS                      

81B09D   LDA #$A0                 
81B09F   LDY #$43                 
81B0A1   JSL $8089A3              
81B0A5   STZ $17                  
81B0A7   REP #$10                 
81B0A9   LDX $36                  
81B0AB   STZ $0035,X              
81B0AE   LDA $0011,X              
81B0B1   STA $11                  
81B0B3   LDA $0014,X              
81B0B6   STA $14                  
81B0B8   STZ $0001,X              
81B0BB   SEP #$10                 
81B0BD   RTS                      

;Code for BOSS1  
81B0BE   LDX $02 ;Sprite Index Maybe?
81B0C0   JMP ($B0C3,X)
--------data--------     
81B0C3
dw $B0CB ;00 ;INITS ROUTINES?
dw $B1BA ;02 ;NORMAL BOSS1 ROUTINE?
dw $B456 ;04 ;NORMAL ROUTINE FOR BOSS1
dw $B4BC ;06 ;Boss1 Loop
----------------   
81B0CB   LDX $03  
81B0CD   JMP ($B0D0,X)
--------data--------     
81B0D0
;[$02] Sprites Init routines ?
dw $B0D6 ;Sprite Init 00
dw $B11C ;Sprite Init 02
dw $B13A ;Sprite Init 04
----------------   
81B0D6   JSL $808EE9  
81B0DA   BCS $81B117  
81B0DC   LDA #$02
81B0DE   STA $03 ;Set Sprite State
81B0E0   DEC
81B0E1   STA $00 ;Is sprite alive or active? if non-zero then yes
81B0E3   STA $1F ;??
81B0E5   STA $1C ;Set HP to 01, Spawning Sprite function?
81B0E7   STA $1D ;Set Cmp HP to 01
81B0E9   STZ $42 ;??
81B0EB   STZ $30 ;?? 
81B0ED   STZ $44 ;?? 
81B0EF   LDA #$2F 
81B0F1   STA $1B ;VHOOPPPC OAM 
81B0F3   LDA #$06 
81B0F5   STA $22 ;Where GFX is Written to/from?
81B0F7   LDA #$30
81B0F9   STA $3A ;?? 
81B0FB   JSL $808A53 ;Set OAM data
81B0FF   LDA $B32A 
81B102   LDY $B329 
81B105   JSL $8089D7  
81B109   JSL $808A21 ;Set OAM Data
81B10D   LDA #$01 
81B10F   STA $0E ;?
81B111   LDA $00F8 
81B114   BNE $81B159  
81B116   RTS

;81B117
JSL $808F0F
RTS
 
81B11C   LDA #$04
81B11E   STA $03 ;Set Init routine to 04  
81B120   LDA $25 ;OAM Related
81B122   BNE $81B139  
81B124   JSL $808FA9  
81B128   BCS $81B137  
81B12A   LDA #$02 
81B12C   STA $0000,X  
81B12F   LDA #$1C 
81B131   STA $000A,X  
81B134   STZ $000B,X  
81B137   SEP #$10 
81B139   RTS 

;[$03] INIT ROUTINE 04 = Intro substate
81B13A   LDX $04 ;Sprite State?
81B13C   JSR ($B148,X)
81B13F   JSL $808A25  
81B143   JSL SpriteSaveDirectPage ; 8088CE  
81B147   RTS
----------------   
;INTRO ROUTINE FOR BOSS1     
;81B148
dw $B150 ;00
dw $B183 ;02
dw $B197 ;04
dw $B1A8 ;06
----------------   
;Sprite State 00
81B150   LDX $25 ;OAM Related
81B152   LDA $00FE ;Load Boss State <- 
81B155   CMP #$08 
81B157   BNE $81B162 ;<- IF != 08 Play intro 
81B159   LDA #$02 
81B15B   STA $02 ;We are leaving the intro  
81B15D   STZ $03  
81B15F   STZ $04  
81B161   RTS
----------------   
81B162   AND $80B8,X  
81B165   BEQ $81B182  
81B167   LDA #$02 
81B169   STA $04 ;Set Sprite state on state 02
81B16B   STA $01 
81B16D   TXA
81B16E   ASL
81B16F   TAX
81B170   LDA $A250,X  
81B173   STA $11 ;X Position
81B175   LDA $A251,X  
81B178   STA $14 ;Y Position 
81B17A   LDA #$E0 
81B17C   STA $17 ;Height
81B17E   LDA #$10 
81B180   STA $43 ;Set 43 i think this is a height timer for next routine?
81B182   RTS
----------------   
;Sprite State 02 ;INTRO_ExitingHole
81B183   REP #$21 
81B185   LDA $16 ;height of the sprite
81B187   ADC #$0180 ;+0x180
81B18A   STA $16 ;height of the sprite
81B18C   SEP #$20 
81B18E   DEC $43
81B190   BNE $81B196 ;if $43 != 0 do not change state yet
81B192   LDA #$04 
81B194   STA $04 ;Set Sprite State on state 04
81B196   RTS
----------------   
;Sprite State 04 lINTRO_InitEnteringHole
81B197   LDA $00FE ;<- check if we are in intro mode
81B19A   BEQ $81B1A0 
81B19C   CMP #$08 
81B19E   BNE $81B196 ;IF we're not on the intro anymore just return 
81B1A0   LDA #$06 
81B1A2   STA $04 ;Go sprite state 06
81B1A4   LDA #$06 
81B1A6   STA $43 ;Height Timer?

;Fall directly in 06 state the same frame
;Sprite State 06 ;INTRO_EnteringBackHole
81B1A8   REP #$21 
81B1AA   LDA $16 ;height of the sprite
81B1AC   SBC #$03FF ;-0x03FF
81B1AF   STA $16 ;height of the sprite
81B1B1   SEP #$20
81B1B3   DEC $43
81B1B5   BNE $81B1B9  
81B1B7   STZ $04 ;Set Sprite State to 00 when fully entered in hole
81B1B9   RTS 

;Sprite SubRoutine2  
81B1BA   LDA $1D ;Check if last hp
81B1BC   CMP $1C ;are still the same as current HP  
81B1BE   BEQ $81B1C9 ;Branch do not end the sprite
;------------------------------
;Kill the sprite?
81B1C0   LDA #$04 
81B1C2   STA $02  
81B1C4   STZ $03  
81B1C6   JMP $B456 
;------------------------------
81B1C9   LDA $00AC; What is $AC !!   
81B1CC   BNE $81B1DB  
81B1CE   LDX $03  
81B1D0   JSR ($B1DC,X)
81B1D3   JSL $808A25  
81B1D7   JSL SpriteSaveDirectPage ; 8088CE  
81B1DB   RTS
----------------   
;Normal Boss1 Routines :    
81B1DC
dw $B1E8 ;00 ;DecideWhatToDoRoutine?
dw $B266 ;02 ;Pop Out and Back In Routine without Items
dw $B29A ;04 ;Pop Out and Back In Routine fake barrel
dw $B2ED ;06 ;Pop Out and Back In Routine throwing random item
dw $B3AA ;08 ;Going Down
dw $B3E3 ;0A ;Going UP or Wait?  
----------------   
;Boss1_Normal_00
81B1E8   DEC $3A ;Wait Timer before sprite actually do something i think
81B1EA   BNE $81B265  
81B1EC   LDA #$14 
81B1EE   STA $3A ;Set timer back to 0x14 for next routine
81B1F0   STZ $38 ;??
81B1F2   SEP #$10
81B1F4   LDA $38 ;??
81B1F6   CMP #$01 
81B1F8   BEQ $81B265 ;if == 01 a condition to the timer
81B1FA   INC $38
81B1FC   JSL GetRandomInt;$808859; GetRandomInt
81B200   AND #$1F 
81B202   TAX
81B203   LDY $A19A,X ;??
81B206   REP #$10 
81B208   LDX #$0200   
81B20B   LDA $0000,X ;Byte00 of the sprite?
81B20E   BEQ $81B21D ;
81B210   LDA $000A,X ;Byte0A of the sprite?
81B213   CMP #$28 
81B215   BNE $81B21D  
81B217   TYA
81B218   CMP $0037,X 
81B21B   BEQ $81B1F2  
81B21D   REP #$21 
81B21F   TXA
81B220   ADC #$0050   
81B223   TAX
81B224   SEP #$20 
81B226   CPX #$0980   
81B229   BNE $81B20B  
81B22B   SEP #$10 
81B22D   STY $37 ;??
81B22F   LDA $A1BA,Y  
81B232   STA $11 ; XPosition  
81B234   LDA $A1BB,Y  
81B237   STA $14 ; YPosition
81B239   LDA #$E0 
81B23B   STA $17 ; ZPosition 
81B23D   JSL GetRandomInt;$808859 ;GetRandomInt  
81B241   AND #$0F 
81B243   TAX 
81B244   LDA $00FC ;Boss related Variable!!
81B247   BNE $81B24E ;if FC != 0
81B249   LDA $A1C8,X ;Load from that table if FC == 0 contains some 02,04,06 
81B24C   BRA $81B251  
81B24E   LDA $A1D8,X ;Load from that table if FC !=0 contains few 04, mostly filled with 06
81B251   STA $03 ;Change Sprite State to randomly selected from table
81B253   STA $01 ;?? 
81B255   STZ $04 ;Another State 
81B257   STZ $1F ;??
81B259   STZ $30 ;??
81B25B   STZ $32 ;??  
81B25D   STZ $3D ;Timer Related?  
81B25F   LDA #$FF 
81B261   STA $34 ;??
81B263   STZ $44 ;??
81B265   RTS
----------------   
--------sub start--------
81B266   LDX $04  
81B268   JMP ($B26B,X)
--------data--------     
81B26B ;[$03 = 02] Routine
dw $B26F ;00 Wait Routine going out? then fall on 02 after wait
dw $B28A ;02 Wait Routine going BackIn then fall on 00 after wait

;00 WaitRoutineGoingOut? 
81B26F   LDA $B32A
81B272   LDY $B329
81B275   JSL $8089D7 ;??  
81B279   LDA #$20
81B27B   STA $3C ;Timer
81B27D   LDA #$C0
81B27F   STA $3E ;Z
81B281   STZ $3F ;Z
81B283   LDA #$1E
81B285   STA $3B ;??
81B287   JMP $B3A0 ;Set $03 to 08 ? and $04 to 02 while 3B is != 0

;02 ?    
81B28A   DEC $3C ;Wait for timer to reach 00
81B28C   BNE $81B299
81B28E   LDA #$FE 
81B290   STA $3F
81B292   LDA #$80
81B294   STA $3E ;Set 3E to #$FE80
81B296   JMP $B3DF
81B299   RTS
----------------   
81B29A   LDX $04  
81B29C   JMP ($B29F,X)

 ;[$03 = 04] Routine   
81B29F 
$B2A3 ;00 goup
$B2DF ;02 godown    
;00     
81B2A3   LDA $B32A
81B2A6   LDY $B329
81B2A9   JSL $8089D7 ; ??   
81B2AD   JSL GetRandomInt;$808859  
81B2B1   AND #$0F 
81B2B3   TAX
81B2B4   REP #$20 
81B2B6   LDA #$1990   
81B2B9   AND $80C0,X ;Bitwise Table?
81B2BC   SEP #$20 
81B2BE   BEQ $81B2CE  
81B2C0   INC $3D ; ??  
81B2C2   STZ $34 ; ??   
81B2C4   LDA $B60B
81B2C7   LDY $B60A
81B2CA   JSL $8089D7 ; ??   
81B2CE   LDA #$30 
81B2D0   STA $3C ;Timer Related   
81B2D2   LDA #$C0 
81B2D4   STA $3E ; ??   
81B2D6   STZ $3F ; ??   
81B2D8   LDA #$20 
81B2DA   STA $3B ; ??   
81B2DC   JMP $B3A0 ;Fall on the go up routine
;02
81B2DF   DEC $3C ;Decrease Timer 
81B2E1   BNE $81B2EC ;if timer != 0 
81B2E3   STZ $3E ;Z Speed?
81B2E5   LDA #$FD 
81B2E7   STA $3F ;Z Speed?  
81B2E9   JMP $B3DF ;Moving down i think
81B2EC   RTS
----------------   
;Routine pirate poping out and throwing an item
81B2ED   LDX $04  
81B2EF   JMP ($B2F2,X)
;Subroutines 
81B2F2
dw $B2F8
dw $B333
dw $B383
----------------   
81B2F8   JSL GetRandomInt;$808859  
81B2FC   AND #$1F 
81B2FE   TAX
81B2FF   LDA $A1E8,X  
81B302   STA $36  
81B304   LDA $A208,X  
81B307   STA $35  
81B309   SEC
81B30A   SBC #$08 
81B30C   STA $33  
81B30E   LDA $A228,X ;This is the ITEM Array
81B311   STA $34 ;Set the ITEM
81B313   BMI $81B31D ;Branch if Minus ;donot have item
   ;if item is positive
81B315   LDA $B60B
81B318   LDY $B60A
81B31B   BRA $81B323
   ;if item == negative (bit 7 setted)    
81B31D   LDA $B32A
81B320   LDY $B329
81B323   JSL $8089D7 ;Might be sprite spawn routine?
81B327   LDA #$01 
81B329   STA $3F  
81B32B   STZ $3E  
81B32D   LDA #$18 
81B32F   STA $3B  
81B331   BRA $81B3A0 ;Goto goup/down routine

81B333   DEC $36  
81B335   BNE $81B382  
81B337   LDA $44  
81B339   BEQ $81B37E  
81B33B   LDA $B60B
81B33E   LDY $B60A
81B341   JSL $8089D7  
81B345   JSR $B412
81B348   STA $000D,X  
81B34B   LDA #$02 
81B34D   STA $0002,X  
81B350   LDA #$06 
81B352   STA $0003,X  
81B355   LDA #$04 
81B357   STA $09  
81B359   LDA #$37 
81B35B   LDY $000B,X  
81B35E   CPY #$001A   
81B361   BNE $81B365  
81B363   LDA #$3B 
81B365   STA $001B,X  
81B368   LDA $0014,X  
81B36B   CLC
81B36C   ADC #$0E 
81B36E   STA $0014,X  
81B371   LDA #$20 
81B373   STA $0017,X  
81B376   LDA #$FF 
81B378   STA $34 ;Nullify the item
81B37A   STZ $44  
81B37C   SEP #$10 
81B37E   LDA #$04 
81B380   STA $04  
81B382   RTS
----------------   
81B383   DEC $35  
81B385   BNE $81B38F  
81B387   LDA #$FD 
81B389   STA $3F  
81B38B   STZ $3E  
81B38D   BRA $81B3DF  
81B38F   LDA $35  
81B391   CMP $33  
81B393   BNE $81B39F  
81B395   LDA $B32A
81B398   LDY $B329
81B39B   JSL $8089D7  
81B39F   RTS

;PiratesBoss Part of 02 Routine:  
81B3A0   LDA $03 ;??
81B3A2   STA $39 ;Save current sprite state
81B3A4   LDA #$08
81B3A6   STA $03 ;Set State to 08 but that's stored in $39 and restored further
81B3A8   STZ $30 ;??

;PirateBoss Part of 08 Routine: (Wait routine until $3B == 0)
81B3AA   DEC $3B ;??
81B3AC   BNE $81B3C8 ;While $3B != 0 we stay in state #$08 ?
81B3AE   LDA $39  
81B3B0   STA $03 ;Restore previously saved state
81B3B2   LDA #$02
81B3B4   STA $04 ;State04 to #$02
81B3B6   LDA $34 ; ??
81B3B8   BMI $81B3C7  
81B3BA   JSR $B4D1
81B3BD   LDA $B5EC
81B3C0   LDY $B5EB
81B3C3   JSL $8089D7  
81B3C7   RTS

;IF 3B != 0
81B3C8   REP #$20 
81B3CA   LDA $16 ;Z Position
81B3CC   ADC $3E ;Increase Z Position (go up)
81B3CE   STA $16 ;Z Position
81B3D0   SEP #$21 
81B3D2   LDA #$E0 
81B3D4   SBC $17;remove z Position from #$E0 ??
81B3D6   EOR #$FF 
81B3D8   INC ;+1
81B3D9   LSR ;>> 1
81B3DA   ADC #$02 
81B3DC   STA $30 ; ??
81B3DE   RTS 

;PirateBoss Part of 02 Routine  
81B3DF   LDA #$0A 
81B3E1   STA $03 ;Set State to #$0A so loop until Z Position is done moving then $03 = 00
;PirateBoss Part of 0A Routine 
81B3E3   REP #$21 
81B3E5   LDA $16 ;Z Position
81B3E7   ADC $3E ;
81B3E9   STA $16 ;Z Position 
81B3EB   SEP #$20 
81B3ED   XBA
81B3EE   CMP #$E0
81B3F0   BCS $81B410 ;IF Z >= E0
81B3F2   STZ $30 ;??
81B3F6   BEQ $81B40A  
81B3F8   STZ $44  
81B3FA   LDA #$04 
81B3FC   STA $09 ;??    
81B3FE   PHD ;PHD!!!!!!! WHAT ; hope i didn't missed any other
81B3FF   LDA $32
81B401   XBA
81B402   LDA $31
81B404   TCD 
81B405   JSL $808F4C ;Not sure yet
81B409   PLD ;Set it back to $0200
81B40A   LDA #$E0 ; set height to that position if we're lower?
81B40C   STA $17  
81B40E   STZ $03 ;Set State to 00
81B410   BRA $81B3D2 ;Basically remove the remains of Z and return
--------sub start--------
81B412   LDA #$FF 
81B414   STA $0000
81B417   LDA $0100
81B41A   BEQ $81B41F  
81B41C   STZ $0000
81B41F   LDA $0180
81B422   BEQ $81B434  
81B424   LDA $0000
81B427   BNE $81B42F  
81B429   JSL $80919A  
--------unidentified--------
81B42D  .db $80 $05 $A9 $80 $8D $00 $00
----------------   
81B434   LDA #$01 
81B436   XBA
81B437   LDA $0000
81B43A   REP #$10 
81B43C   TAX
81B43D   JSL $808B0E  
81B441   REP #$10 
81B443   LDX $31  
81B445   INC
81B446   LSR
81B447   CMP #$08 
81B449   BNE $81B44E  
81B44B   LDA #$01 
81B44D   RTS
----------------   
81B44E   BCC $81B453  
81B450   LDA #$02 
81B452   RTS
----------------   
81B453   LDA #$00 
81B455   RTS
;Sprite SubRoutine4
81B456   LDX $03
81B458   JSR ($B464,X)
81B45B   JSL $808A25  
81B45F   JSL SpriteSaveDirectPage ; 8088CE  
81B463   RTS
----------------   
--------data--------     
81B464
dw $B46A ;00
dw $FC88 ;02
dw $FCA9 ;04
----------------   
;Init Sprite Routine?
81B46A   LDA #$02 
81B46C   STA $03 ;Goto next state
81B46E   INC
81B46F   STA $00 ;Set IsAlive to #$03
81B471   STZ $1C ;?? Sprite HP to 00
81B473   STZ $1D ;?? Sprite HP Cmp to 00
81B475   STZ $0D ;Direction
81B477   STZ $17 ;Height
81B479   LDA #$B5 
81B47B   LDY #$58 
81B47D   JSL $8089D7 ;OAM Related
81B481   LDA $44 ;Sprite Work RAM
81B483   BEQ $81B4A4

81B485   REP #$10 ;X/Y 16 bit
81B487   LDA #$04 
81B489   STA $09 ;??
81B48B   LDX $31 ;??
81B48D   LDA #$06
81B48F   STA $0002,X 
81B492   STZ $0003,X  
81B495   LDA $000B,X  
81B498   CMP #$1A 
81B49A   BNE $81B4A2  
81B49C   LDA $002C,X  
81B49F   STA $001A,X  
81B4A2   SEP #$10

81B4A4   INC $00F8
81B4A7   LDA $00F8
81B4AA   CMP #$07 ;IF #$F8 == 07 
81B4AC   BNE $81B4B5  
81B4AE   LDA #$02 
81B4B0   STA $00A8  ;then boss is over !?
81B4B3   BRA $81B4B9

81B4B5   CMP #$04 
81B4B7   BCC $81B4BB  
81B4B9   INC $42 ;Increase boss AI ?
81B4BB   RTS
;Sprite Subroutine4     
81B4BC   JSL $808F0F  
81B4C0   LDA $42 ;Sprite Variable $42 
81B4C2   BNE $81B4CD  
81B4C4   STZ $42  
81B4C6   STZ $12  
81B4C8   STZ $15  
81B4CA   JMP $B0BE ;Boss1 Code
81B4CD   INC $00FC ;Sprite died so increase FC
81B4D0   RTS
----------------   
--------sub start--------
81B4D1   JSL $808F8E  
81B4D5   BCS $81B500  
81B4D7   INC $44  
81B4D9   STX $31  
81B4DB   LDA #$12 
81B4DD   STA $09  
81B4DF   STZ $000A,X  
81B4E2   LDA #$02 
81B4E4   STA $0004,X  
81B4E7   STA $0000,X  
81B4EA   LDA $34 ;Set $0B to item index
81B4EC   STA $000B,X  
81B4EF   LDA #$80 
81B4F1   STA $000D,X  
81B4F4   LDA $11  
81B4F6   STA $0011,X  
81B4F9   LDA $14  
81B4FB   STA $0014,X  
81B4FE   BRA $81B503  
--------unidentified--------
81B500  .db $7A $64 $3D    
----------------   
81B503   SEP #$10 
81B505   RTS

;0x2A Switches
81B506   LDX $02  
81B508   JMP ($B50B,X)
--------data--------     
81B50B  
dw $B513
dw $B596
dw $B5A2
dw $B61F
----------------   
81B513   LDA #$02 
81B515   STA $02  
81B517   DEC
81B518   STA $00  
81B51A   STA $1C  
81B51C   LDA $11 ;X SPR Pos
81B51E   LSR
81B51F   LSR
81B520   LSR
81B521   STA $4E
81B523   STZ $4F  
81B525   REP #$20 
81B527   LDA $14 ;Y SPR Pos
81B529   AND #$00F8   
81B52C   ASL
81B52D   ASL
81B52E   ADC $4E  
81B530   ADC #$57DF   
81B533   STA $4E
81B535   STA $0010 ; Tilemap pos
81B538   SEP #$20 
81B53A   LDA $0B ;Type to load the GFX i think
81B53C   TAX
81B53D   LDA $A256,X  
81B540   STA $4C  
81B542   LDA $A257,X  
81B545   STA $4D  
81B547   LDA $0B  
81B549   LSR
81B54A   ADC $0B  
81B54C   ADC $0B  
81B54E   TAX
81B54F   LDA $A262,X  
81B552   STA $43  
81B554   AND #$0F 
81B556   STA $4B  
81B558   LDA $A25E,X  
81B55B   STA $40  
81B55D   LDA $A25F,X  
81B560   STA $41  
81B562   LDA $A260,X  
81B565   STA $42  
81B567   LDA $A261,X  
81B56A   STA $44  
81B56C   BMI $81B57F  
81B56E   TAY
81B56F   LSR
81B570   LSR
81B571   LSR
81B572   TAX
81B573   TYA
81B574   AND #$07 
81B576   TAY
81B577   LDA $1144,X  
81B57A   AND $80B8,Y  
81B57D   BNE $81B586  
81B57F   LDA $4C  
81B581   JSL $808D7B  
81B585   RTS
----------------   
--------unidentified--------
81B586  .db $A5 $4D $22 $7B $8D $80 $AD $FC
81B58E  .db $00 $F0 $51 $22 $1E $8F $80 $60
----------------   
81B596   LDA $1C  
81B598   BNE $81B585  
81B59A   LDA #$04 
81B59C   STA $02  
81B59E   LDA #$03 
81B5A0   STA $00  
81B5A2   LDA #$07 ;Switch Pressed sound
81B5A4   JSL PlaySFX ;$809A53

81B5A8   LDA $4E    
81B5AA   STA $0010  
81B5AD   LDA $4F    
81B5AF   STA $0011  
81B5B2   LDA $4D    
81B5B4   JSL $808D7B
81B5B8   INC $00F8  
81B5BB   LDA $00F8  
81B5BE   CMP $4B    
81B5C0   BNE $B5F8  
81B5C2   LDA $44    
81B5C4   BMI $B5D8  


81B5C6   TAY
81B5C7   LSR
81B5C8   LSR
81B5C9   LSR
81B5CA   TAX
81B5CB   TYA
81B5CC   AND #$07
81B5CE   TAY
81B5CF   LDA $1144, X
81B5D2   ORA $80B8, Y
81B5D5   STA $1144, X

81B5D8   LDA $43    
81B5DA   BMI $B5FD  
81B5DC   LDA #$21   
81B5DE   JSL $809A53
81B5E2   INC $00FC  
81B5E5   LDA $40    
81B5E7   STA $0013  
81B5EA   LDA $41    
81B5EC   STA $0014  
81B5EF   LDA $42    
81B5F1   STA $000A  
81B5F4   JSL $82C3B4
81B5F8   JSL $808F1E
81B5FC   RTS        
  
81B6FD   $22 $8E $8F
81B600  .db $80 $B0 $11 $A9 $0E $9D $0A $00
81B608  .db $A9 $03 $9D $00 $00 $C2 $20 $A5
81B610  .db $40 $9D $28 $00 $E2 $30 $A9 $06
81B618  .db $85 $02 $A9 $78 $85 $0F $60 $C6
81B620  .db $0F $F0 $BF $60

;Sprite 0x2C Moving Bridge on level3? NOT SURE also breakable walls
81B624   LDX $02 ;Load Routine
81B626   JMP ($B629,X)

81B629 
dw $B631 ; Init
dw $B6B0
dw $B83C 
dw $B8C8

 
81B631   LDX $0B ; Param
81B633   JMP ($B636,X)

81B636 
dw $B640 ;0x00 
dw $B640 ;0x02
dw $B65C ;0x04 
dw $B66C ;0x06
dw $B68B ;0x08 ;Door closing back at the castle entrance

81B640   LDA $1144
81B643   AND $A27D,X ;Check if RAM is setted
81B646   BEQ $81B650  
81B648   JSR $B886 ; Explode the wall if ram is setted already
81B64B   JSL KillSprite ; 808F1E  
81B64F   RTS
 
81B650   LDA #$02 
81B652   STA $02  
81B654   DEC
81B655   STA $00  
81B657   STA $1C  
81B659   STA $1D  
81B65B   RTS

81B65C  .db $AD $44 $11 $3D $7D $A2 $F0 $03
81B664  .db $20 $86 $B8 $22 $1E $8F $80 $60
  
81B66C   LDA #$01 
81B66E   STA $01  
81B670   LDA #$03 
81B672   STA $00  
81B674   LDA #$40 
81B676   STA $1A  
81B678   LDA #$27 
81B67A   STA $1B  
81B67C   STZ $0E  
81B67E   LDA #$A3 
81B680   LDY #$33 
81B682   JSL FrameAnimationNoTimer ; $8089A3  
81B686   LDA #$02 
81B688   STA $02  
81B68A   RTS

 ;Door closing it back at the castle entrance
81B68B   LDA $1144
81B68E   BIT #$01 
81B690   BEQ $81B695 ;if RAM is unsetted
81B692   JMP $B8C8 ; Kill the sprite!

81B695   LDA #$02 
81B697   STA $02  
81B699   INC $1144
81B69C   STZ $009E
81B69F   REP #$20 
81B6A1   STZ $4207
81B6A4   LDA #$00D2   
81B6A7   STA $4209
81B6AA   SEP #$20 
81B6AC   INC $009D
81B6AF   RTS
----------------   
81B6B0   LDX $0B  
81B6B2   JMP ($B6B5,X)

81B6B5  
dw $B6BF ;0x00
dw $B6BF ;0x02
dw $B6BF ;0x04
dw $B6CF ;0x06
dw $B82A ;0x08 ;Door closing back at the castle entrance
----------------   
81B6BF   LDA $1D  
81B6C1   CMP $1C  
81B6C3   BEQ $81B6CE  
81B6C5   LDA #$04 
81B6C7   STA $02  
81B6C9   STZ $03  
81B6CB   JMP $B83C
81B6CE   RTS
----------------   
81B6CF   LDX $03  
81B6D1   JSR ($B6D9,X)
81B6D4   JSL SpriteSaveDirectPage ; 8088CE  
81B6D8   RTS
----------------   
--------data--------     
81B6D9  .db $E1 $B6 $EF $B6 $F1 $B7 $0B $B8
----------------   
--------sub start--------
81B6E1   LDA $00FE
81B6E4   BEQ $81B6EE  
81B6E6   LDA #$02 
81B6E8   STA $03  
81B6EA   LDA #$10 
81B6EC   STA $3F  
81B6EE   RTS
----------------   
--------sub start--------
81B6EF   LDX $04  
81B6F1   JMP ($B6F4,X)
--------data--------     
81B6F4  .db $FC $B6 $2D $B7 $B6 $B7 $E8 $B7
----------------   
81B6FC   LDX $05  
81B6FE   JMP ($B701,X)
--------data--------     
81B701  .db $05 $B7 $15 $B7
----------------   
81B705   DEC $3F  
81B707   BNE $81B714  
81B709   LDA #$02 
81B70B   STA $05  
81B70D   INC $00AC
81B710   LDA #$3C 
81B712   STA $3F  
81B714   RTS
----------------   
81B715   DEC $3F  
81B717   BNE $81B72C  
81B719   LDA #$02 
81B71B   STA $04  
81B71D   STZ $05  
81B71F   LDA #$08 
81B721   STA $3F  
81B723   STZ $3C  
81B725   STZ $3D  
81B727   LDA #$20 
81B729   STA $4202
81B72C   RTS
----------------   
81B72D   LDA $3F  
81B72F   STA $4203
81B732   NOP
81B733   NOP
81B734   NOP
81B735   NOP
81B736   REP #$21 
81B738   LDA $4216
81B73B   LDX $3C  
81B73D   BNE $81B744  
81B73F   ADC #$500C   
81B742   BRA $81B747  
81B744   ADC #$5012   
81B747   STA $23  
81B749   SEP #$20 
81B74B   LDA #$12 
81B74D   CLC
81B74E   ADC $3C  
81B750   STA $25  
81B752   LDA $3C  
81B754   BNE $81B75A  
81B756   LDA #$06 
81B758   BRA $81B75C  
81B75A   LDA #$02 
81B75C   STA $26  
81B75E   STA $3E  
81B760   LDX #$04 
81B762   LDA #$00 
81B764   LDY $3D  
81B766   BEQ $81B76A  
81B768   ADC #$08 
81B76A   CLC
81B76B   LDY $3C  
81B76D   BEQ $81B771  
81B76F   ADC #$06 
81B771   TAY
81B772   LDA $A33C,Y  
81B775   STA $23,X
81B777   INX
81B778   INY
81B779   DEC $3E  
81B77B   BNE $81B772  
81B77D   REP #$20 
81B77F   TDC
81B780   CLC
81B781   ADC #$0023   
81B784   STA $0010
81B787   SEP #$20 
81B789   JSL $8085BE  
81B78D   LDA $3C  
81B78F   BEQ $81B798  
81B791   STZ $3C  
81B793   LDA #$04 
81B795   STA $04  
81B797   RTS
----------------   
81B798   REP #$31 
81B79A   LDY #$0004   
81B79D   LDA $23  
81B79F   SBC #$4FFF   
81B7A2   STA $23  
81B7A4   TAX
81B7A5   STZ $1400,X  
81B7A8   INX
81B7A9   INX
81B7AA   DEY
81B7AB   BNE $81B7A5  
81B7AD   SEP #$30 
81B7AF   LDA #$40 
81B7B1   STA $3C  
81B7B3   JMP $B72D
81B7B6   LDA $3F  
81B7B8   CMP #$15 
81B7BA   BEQ $81B7D7  
81B7BC   INC $3F  
81B7BE   LDA $3D  
81B7C0   BEQ $81B7C6  
81B7C2   STZ $3D  
81B7C4   BRA $81B7C8  
81B7C6   INC $3D  
81B7C8   LDA #$05 
81B7CA   STA $3E  
81B7CC   LDA #$1E 
81B7CE   JSL PlaySFX ;$809A53
81B7D2   LDA #$06 
81B7D4   STA $04  
81B7D6   RTS
----------------   
81B7D7   LDA #$1E 
81B7D9   JSL PlaySFX ;$809A53
81B7DD   LDA #$1E 
81B7DF   STA $3F  
81B7E1   LDA #$04 
81B7E3   STA $03  
81B7E5   STZ $04  
81B7E7   RTS
----------------   
81B7E8   DEC $3E  
81B7EA   BNE $81B7F0  
81B7EC   LDA #$02 
81B7EE   STA $04  
81B7F0   RTS
----------------   
--------sub start--------
81B7F1   DEC $3F  
81B7F3   BNE $81B80A  
81B7F5   LDA #$06 
81B7F7   STA $03  
81B7F9   REP #$20 
81B7FB   LDA #$FF80   
81B7FE   STA $2A  
81B800   SEP #$20 
81B802   LDA #$64 
81B804   STA $3F  
81B806   LDA #$01 
81B808   STA $3E  
81B80A   RTS
----------------   
--------sub start--------
81B80B   DEC $3F  
81B80D   BNE $81B817  
81B80F   STZ $00AC
81B812   STZ $00FE
81B815   STZ $03  
81B817   DEC $3E  
81B819   BNE $81B825  
81B81B   LDA #$0D 
81B81D   STA $3E  
81B81F   LDA #$05 
81B821   JSL PlaySFX ;$809A53
81B825   JSL $80C048  
81B829   RTS
----------------   
81B82A   LDA $00AC ;Check if we are on a transition
81B82D   BEQ $81B830 ;not on transition anymore 
81B82F   RTS

81B830   LDA #$20 
81B832   JSL PlaySFX ;$809A53 ;Play the SFX to close the door
81B836   STZ $009D
81B839   JMP $B8C8 ; Kill the sprite !

81B83C   LDX $03  
81B83E   JMP ($B841,X)
--------data--------     
81B841
dw $B847
dw $B87A
dw $B8B5 ; Explode the wall and Set RAM
----------------   
81B847   LDA #$01 
81B849   STA $01  
81B84B   STZ $0E  
81B84D   LDA $0B  
81B84F   BEQ $81B865  
81B851   LDA #$13 
81B853   JSL PlaySFX ;$809A53
81B857   LDA #$39 
81B859   STA $1B  
81B85B   LDA #$80 
81B85D   STA $1A  
81B85F   LDA #$A2 
81B861   LDY #$B8 
81B863   BRA $81B871  
--------unidentified--------
81B865  .db $A9 $39 $85 $1B $A9 $C0 $85 $1A
81B86D  .db $A9 $A2 $A0 $86
----------------   
81B871   JSL FrameAnimationNoTimer ; $8089A3  
81B875   LDA #$02 
81B877   STA $03  
81B879   RTS
----------------   
81B87A   LDA #$04 
81B87C   STA $03  
81B87E   LDX $0B  
81B880   LDA $A27D,X  
81B883   TSB $1144
--------sub start--------
81B886   LDX $0B  
81B888   LDA $A272,X  
81B88B   STA $0013
81B88E   LDA $A273,X  
81B891   STA $0014
81B894   LDA $A27C,X  
81B897   STA $000A
81B89A   JSL $82C3B4  ; Update Tilemap
81B89E   LDA $0B  
81B8A0   CMP #$02 
81B8A2   BNE $81B8B4  
81B8A4   LDX #$18 
81B8A6   REP #$20 
81B8A8   LDA #$500E   
81B8AB   STA $0010
81B8AE   SEP #$20 
81B8B0   JSL $808DC7 ;Set A DMA ? for Something tile object it seems ? 
81B8B4   RTS
----------------   
81B8B5   LDA $08  
81B8B7   CMP #$70 
81B8B9   BNE $81B8BF  
81B8BB   LDA #$06 
81B8BD   STA $02  
81B8BF   JSL FrameAnimationTimer; 8089A9  
81B8C3   JSL SpriteSaveDirectPage ; 8088CE  
81B8C7   RTS
----------------   
81B8C8   JSL KillSprite ; 808F1E  
81B8CC   RTS

;0x2E Level 2 Boss     
81B8CD   LDX $02                  
81B8CF   JMP ($B8D2,X)            

81B8D2 
dw $B8DA
dw $B95A
dw $BEC4
dw $BF87  


81B8DA   LDX $03                  
81B8DC   JMP ($B8DF,X)            
--------data--------     
81B8DF  .db $E3 $B8 $4B $B9      
----------------         
81B8E3   LDA #$02                 
81B8E5   STA $03                  
81B8E7   STA $01                  
81B8E9   DEC                      
81B8EA   STA $00                  
81B8EC   LDA #$39                 
81B8EE   STA $1B                  
81B8F0   STZ $0E                  
81B8F2   LDA #$40                 
81B8F4   STA $1A                  
81B8F6   STZ $31                  
81B8F8   STZ $32                  
81B8FA   LDA #$30                 
81B8FC   STA $1C                  
81B8FE   STA $1D                  
81B900   LDA #$1C                 
81B902   STA $1E                  
81B904   JSL GetEmptySprite ; 808F73              
81B908   BCS $81B920              
81B90A   LDA #$30                 
81B90C   STA $000A,X              
81B90F   STA $0000,X              
81B912   LDA #$04                 
81B914   STA $000B,X              
81B917   STZ $000C,X              
81B91A   REP #$20                 
81B91C   TDC                      
81B91D   STA $0043,X              
81B920   SEP #$30                 
81B922   JSL GetEmptySprite ; 808F73              
81B926   BCS $81B93C              
81B928   LDA #$03                 
81B92A   STA $0000,X              
81B92D   DEC                      
81B92E   STA $000B,X              
81B931   LDA #$4E                 
81B933   STA $000A,X              
81B936   REP #$20                 
81B938   TDC                      
81B939   STA $0030,X              
81B93C   SEP #$30                 
81B93E   LDA #$10                 
81B940   STA $41                  
81B942   LDA #$A0                 
81B944   STA $3E                  
81B946   LDA #$00                 
81B948   STA $3F                  
81B94A   RTS                      
----------------         
81B94B   REP #$20                 
81B94D   DEC $3E                  
81B94F   SEP #$20                 
81B951   BNE $81B959              
81B953   LDA #$02                 
81B955   STA $02                  
81B957   STZ $03                  
81B959   RTS                      
----------------         
81B95A   LDA $1D                  
81B95C   CMP $1C                  
81B95E   BEQ $81B98E              
81B960   INC                      
81B961   BNE $81B969              
81B963   LDA $1C                  
81B965   STA $1D                  
81B967   BRA $81B98E              

;Taking damage routine
81B969   LDA $03                  
81B96B   CMP #$06                 
81B96D   BNE $81B985              
81B96F   LDA $04                  
81B971   CMP #$06                 
81B973   BCC $81B985              
81B975   CMP #$0E                 
81B977   BCS $81B985              
81B979   LDA $1C                  
81B97B   BEQ $81B985              
81B97D   STA $1D                  
81B97F   LDA #$24                 
81B981   STA $32                  
81B983   BRA $81B98E              
81B985   LDA #$04                 
81B987   STA $02                  
81B989   STZ $2D                  
81B98B   JMP $BEC4                


81B98E   LDX $03                  
81B990   JSR ($B9D0,X)            
81B993   LDA $03                  
81B995   BEQ $81B9CB              
81B997   CMP #$06                 
81B999   BCS $81B9CB              
81B99B   LDA $14                  
81B99D   CLC                      
81B99E   ADC #$18                 
81B9A0   LDY $0100                
81B9A3   DEY                      
81B9A4   BNE $81B9AB              
81B9A6   CMP $0114                
81B9A9   BCS $81B9B6              
81B9AB   LDY $0180                
81B9AE   DEY                      
81B9AF   BNE $81B9CB              
81B9B1   CMP $0194                
81B9B4   BCC $81B9CB              
81B9B6   LDA $03                  
81B9B8   CMP #$06                 
81B9BA   BNE $81B9C5              
81B9BC   LDA #$39                 
81B9BE   STA $1B                  
81B9C0   LDA #$02                 
81B9C2   JSR $BDB3                
--------unidentified--------
81B9C5  .db $A9 $08 $85 $03 $64 $04
----------------         
81B9CB   JSL SpriteSaveDirectPage ; 8088CE              
81B9CF   RTS                      
----------------         
--------data--------     
81B9D0  .db $DA $B9 $55 $BA $FD $BA $CB $BB
----------------         
--------unidentified--------
81B9D8  .db $F2 $BD              
----------------         
--------sub start--------
81B9DA   LDX $04                  
81B9DC   JMP ($B9DF,X)            
--------data--------     
81B9DF  .db $E5 $B9 $05 $BA $45 $BA
----------------         
81B9E5   LDA #$02                 
81B9E7   STA $04                  
81B9E9   LDA #$A4                 
81B9EB   LDY #$12                 
81B9ED   JSL FrameAnimationNoTimer ; $8089A3              
81B9F1   STZ $3E                  
81B9F3   LDA #$02                 
81B9F5   STA $3F                  
81B9F7   STZ $2A                  
81B9F9   STZ $2B                  
81B9FB   LDA #$FD                 
81B9FD   STA $29                  
81B9FF   LDA #$01                 
81BA01   STA $12                  
81BA03   STA $31                  
81BA05   JSL MoveSprite ; 80C007              
81BA09   REP #$21                 
81BA0B   LDA $16                  
81BA0D   ADC $3E                  
81BA0F   STA $16                  
81BA11   LDA $3E                  
81BA13   SEC                      
81BA14   SBC #$0017               
81BA17   STA $3E                  
81BA19   SEP #$20                 
81BA1B   LDA $17                  
81BA1D   BPL $81BA44              
81BA1F   LDA #$04                 
81BA21   STA $04                  
81BA23   STZ $17                  
81BA25   JSL $808FA9              
81BA29   BCS $81BA3A              
81BA2B   LDA #$02                 
81BA2D   STA $0000,X              
81BA30   LDA #$1C                 
81BA32   STA $000A,X              
81BA35   LDA #$02                 
81BA37   STA $000B,X              
81BA3A   SEP #$10                 
81BA3C   LDA #$A3                 
81BA3E   LDY #$4C                 
81BA40   JSL FrameAnimationNoTimer ; $8089A3              
81BA44   RTS                      
----------------         
81BA45   LDA $00FE                
81BA48   BEQ $81BA54              
81BA4A   LDA #$02                 
81BA4C   STA $03                  
81BA4E   STZ $04                  
81BA50   STZ $3C                  
81BA52   STZ $3B                  
81BA54   RTS                      
----------------         
--------sub start--------
81BA55   LDX $04                  
81BA57   JMP ($BA5A,X)            
--------data--------     
81BA5A  .db $5E $BA $C4 $BA      
----------------         
81BA5E   JSL $808859              
81BA62   AND #$0F                 
81BA64   TAX                      
81BA65   LDA $A41E,X              
81BA68   BEQ $81BA75              
81BA6A   STA $03                  
81BA6C   STZ $04                  
81BA6E   STZ $3B                  
81BA70   LDA #$04                 
81BA72   STA $39                  
81BA74   RTS                      
----------------         
81BA75   LDA $3B                  
81BA77   CMP #$03                 
81BA79   BNE $81BA87              
81BA7B   JSL $808859              
81BA7F   AND #$0F                 
81BA81   TAX                      
81BA82   LDA $A44E,X              
81BA85   BRA $81BA6A              
81BA87   LDA #$A4                 
81BA89   LDY #$5E                 
81BA8B   JSL Sprite_SetSpeeds ; 80BF9F              
81BA8F   JSL $808859              
81BA93   AND #$0F                 
81BA95   TAX                      
81BA96   LDA $A42E,X              
81BA99   STA $3D                  
--------sub start--------
81BA9B   LDA $3C                  
81BA9D   BEQ $81BAA1              
81BA9F   BRA $81BAA7              
81BAA1   JSL $808859              
81BAA5   BMI $81BAB1              
81BAA7   LDA $0D                  
81BAA9   EOR #$01                 
81BAAB   STA $0D                  
81BAAD   JSL $80BFA5              
--------sub start--------
81BAB1   LDA #$02                 
81BAB3   STA $04                  
81BAB5   LDA #$A3                 
81BAB7   LDY #$58                 
81BAB9   JSL FrameAnimationNoTimer ; $8089A3              
81BABD   INC $3B                  
81BABF   LDA #$02                 
81BAC1   STA $31                  
81BAC3   RTS                      
----------------         
81BAC4   JSL FrameAnimationTimer; 8089A9              
81BAC8   JSL MoveSprite ; 80C007              
81BACC   DEC $3D                  
81BACE   BNE $81BAD4              
81BAD0   STZ $3C                  
81BAD2   BRA $81BA5E              
81BAD4   LDA $11                  
81BAD6   LDX $29                  
81BAD8   BPL $81BAE4              
81BADA   CMP #$38                 
81BADC   BCS $81BAFC              
81BADE   LDA #$38                 
81BAE0   STA $11                  
81BAE2   BRA $81BAEC              
81BAE4   CMP #$C8                 
81BAE6   BCC $81BAFC              
81BAE8   LDA #$C7                 
81BAEA   STA $11                  
81BAEC   JSL $808859              
81BAF0   AND #$0F                 
81BAF2   TAX                      
81BAF3   LDA $A43E,X              
81BAF6   STA $03                  
81BAF8   STZ $04                  
81BAFA   INC $3C                  
81BAFC   RTS                      
----------------         
--------sub start--------
81BAFD   LDX $04                  
81BAFF   JMP ($BB02,X)            
--------data--------     
81BB02  .db $08 $BB $17 $BB $46 $BB
----------------         
81BB08   LDA #$A4                 
81BB0A   LDY #$66                 
81BB0C   JSL Sprite_SetSpeeds ; 80BF9F              
81BB10   JSR $BA9B                
81BB13   LDA #$10                 
81BB15   STA $3D                  
81BB17   JSL MoveSprite ; 80C007              
81BB1B   JSL FrameAnimationTimer; 8089A9              
81BB1F   LDA $08                  
81BB21   CMP #$02                 
81BB23   BNE $81BB2D              
81BB25   LDA #$01                 
81BB27   STA $08                  
81BB29   JSL FrameAnimationTimer; 8089A9              
81BB2D   DEC $3D                  
81BB2F   BNE $81BB43              
81BB31   LDA #$A3                 
81BB33   LDY #$8A                 
81BB35   JSL FrameAnimationNoTimer ; $8089A3              
81BB39   LDA #$04                 
81BB3B   STA $04                  
81BB3D   STZ $3C                  
81BB3F   LDA #$03                 
81BB41   STA $31                  
81BB43   JMP $BAD4                
81BB46   JSL FrameAnimationTimer; 8089A9              
81BB4A   LDA $08                  
81BB4C   CMP #$60                 
81BB4E   BNE $81BBB2              
81BB50   LDA #$02                 
81BB52   STA $08                  
81BB54   JSL FrameAnimationTimer; 8089A9              
81BB58   JSR $9ECD                
81BB5B   STA $38                  
81BB5D   JSL $808859              
81BB61   AND #$0F                 
81BB63   TAX                      
81BB64   LDA $A490,X              
81BB67   CLC                      
81BB68   ADC $38                  
81BB6A   AND #$1F                 
81BB6C   STA $38                  
81BB6E   JSL GetEmptySprite ; 808F73              
81BB72   BCS $81BBB2              
81BB74   LDA #$30                 
81BB76   STA $000A,X              
81BB79   STA $0000,X              
81BB7C   STZ $0002,X              
81BB7F   STZ $0003,X              
81BB82   STZ $0004,X              
81BB85   LDA $14                  
81BB87   STA $0014,X              
81BB8A   STZ $0015,X              
81BB8D   LDA $11                  
81BB8F   DEC                      
81BB90   DEC                      
81BB91   STA $0011,X              
81BB94   STZ $0012,X              
81BB97   LDA #$1A                 
81BB99   STA $0017,X              
81BB9C   LDA #$00                 
81BB9E   STA $000B,X              
81BBA1   LDA $38                  
81BBA3   ASL                      
81BBA4   ASL                      
81BBA5   ASL                      
81BBA6   STA $000D,X              
81BBA9   STZ $31                  
81BBAB   LDA $37                  
81BBAD   STA $0037,X              
81BBB0   SEP #$10                 
81BBB2   CMP #$50                 
81BBB4   BNE $81BBCA              
81BBB6   DEC $39                  
81BBB8   BEQ $81BBC4              
81BBBA   LDA #$04                 
81BBBC   STA $03                  
81BBBE   JSR $BAB1                
81BBC1   JMP $BB13                
81BBC4   LDA #$02                 
81BBC6   STA $03                  
81BBC8   STZ $04                  
81BBCA   RTS                      
----------------         
--------sub start--------
81BBCB   LDX $04                  
81BBCD   JMP ($BBD0,X)            
--------data--------     
81BBD0  .db $E2 $BB $05 $BC $32 $BC
----------------         
--------unidentified--------
81BBD6  .db $51 $BC              
----------------         
--------data--------     
81BBD8  .db $7E $BC $E1 $BC $26 $BD $65 $BD
81BBE0  .db $9A $BD              
----------------         
81BBE2   LDA #$02                 
81BBE4   STA $04                  
81BBE6   STZ $28                  
81BBE8   STZ $29                  
81BBEA   LDA #$00                 
81BBEC   STA $2A                  
81BBEE   LDA #$01                 
81BBF0   STA $2B                  
--------sub start--------
81BBF2   LDA #$02                 
81BBF4   STA $31                  
81BBF6   STZ $3E                  
81BBF8   LDA #$04                 
81BBFA   STA $3F                  
81BBFC   LDA #$A4                 
81BBFE   LDY #$12                 
81BC00   JSL FrameAnimationNoTimer ; $8089A3              
81BC04   RTS                      
----------------         
81BC05   JSL MoveSprite ; 80C007              
81BC09   REP #$21                 
81BC0B   LDA $16                  
81BC0D   ADC $3E                  
81BC0F   STA $16                  
81BC11   LDA $3E                  
81BC13   SEC                      
81BC14   SBC #$0088               
81BC17   STA $3E                  
81BC19   SEP #$20                 
81BC1B   LDA $17                  
81BC1D   BPL $81BC31              
81BC1F   STZ $17                  
81BC21   LDA #$A3                 
81BC23   LDY #$A2                 
81BC25   JSL FrameAnimationNoTimer ; $8089A3              
81BC29   LDA #$04                 
81BC2B   STA $04                  
81BC2D   LDA #$30                 
81BC2F   STA $34                  
81BC31   RTS                      
----------------         
81BC32   DEC $34                  
81BC34   BNE $81BC4C              
81BC36   LDA #$A3                 
81BC38   LDY #$AE                 
81BC3A   JSL FrameAnimationNoTimer ; $8089A3              
81BC3E   LDA #$06                 
81BC40   STA $04                  
81BC42   LDA #$05                 
81BC44   STA $31                  
81BC46   LDA #$1E                 
81BC48   STA $1E                  
81BC4A   BRA $81BC51              
81BC4C   LDA #$04                 
81BC4E   STA $31                  
81BC50   RTS                      
----------------         
81BC51   LDA #$08                 
81BC53   STA $04                  
81BC55   JSR $9ECD                
81BC58   INC                      
81BC59   LSR                      
81BC5A   CMP #$06                 
81BC5C   BCS $81BC60              
81BC5E   LDA #$06                 
81BC60   CMP #$0B                 
81BC62   BCC $81BC66              
81BC64   LDA #$0A                 
81BC66   ASL                      
81BC67   ASL                      
81BC68   ASL                      
81BC69   ASL                      
81BC6A   STA $35                  
81BC6C   LDA #$0A                 
81BC6E   STA $39                  
81BC70   JSL $808859              
81BC74   AND #$80                 
81BC76   STA $2C                  
81BC78   LDA #$05                 
81BC7A   STA $34                  
81BC7C   BRA $81BC92              
81BC7E   JSR $BF8C                
81BC81   DEC $34                  
81BC83   BNE $81BCDE              
81BC85   DEC $39                  
81BC87   BNE $81BC78              
81BC89   LDA #$02                 
81BC8B   STA $34                  
81BC8D   LDA #$0A                 
81BC8F   STA $04                  
81BC91   RTS                      
----------------         
81BC92   JSL GetEmptySprite ; 808F73              
81BC96   BCS $81BCDC              
81BC98   LDA #$30                 
81BC9A   STA $000A,X              
81BC9D   STA $0000,X              
81BCA0   STZ $0002,X              
81BCA3   STZ $0003,X              
81BCA6   STZ $0004,X              
81BCA9   LDA $14                  
81BCAB   CLC                      
81BCAC   ADC #$08                 
81BCAE   STA $0014,X              
81BCB1   STA $0032,X              
81BCB4   STZ $0015,X              
81BCB7   LDA $11                  
81BCB9   STA $0011,X              
81BCBC   STA $0031,X              
81BCBF   STZ $0012,X              
81BCC2   LDA #$10                 
81BCC4   STA $0017,X              
81BCC7   LDA #$02                 
81BCC9   STA $000B,X              
81BCCC   LDA $35                  
81BCCE   STA $000D,X              
81BCD1   LDA $2C                  
81BCD3   STA $0035,X              
81BCD6   REP #$20                 
81BCD8   TDC                      
81BCD9   STA $0043,X              
81BCDC   SEP #$30                 
81BCDE   JMP $BD4F                
81BCE1   DEC $34                  
81BCE3   BNE $81BD23              
81BCE5   LDA #$01                 
81BCE7   STA $01                  
81BCE9   LDA #$0C                 
81BCEB   STA $04                  
81BCED   REP #$10                 
81BCEF   LDX #$0200               
81BCF2   LDY #$0000               
81BCF5   LDA $000A,X              
81BCF8   CMP #$30                 
81BCFA   BNE $81BD0D              
81BCFC   LDA $000B,X              
81BCFF   CMP #$02                 
81BD01   BNE $81BD0D              
81BD03   LDA #$04                 
81BD05   STA $0004,X              
81BD08   TYA                      
81BD09   STA $0033,X              
81BD0C   INY                      
81BD0D   REP #$21                 
81BD0F   TXA                      
81BD10   ADC #$0050               
81BD13   TAX                      
81BD14   SEP #$20                 
81BD16   CPX #$0980               
81BD19   BNE $81BCF5              
81BD1B   SEP #$10                 
81BD1D   LDA #$F0                 
81BD1F   STA $34                  
81BD21   STZ $35                  
81BD23   JMP $BD4F                
81BD26   JSR $BF8C                
81BD29   REP #$20                 
81BD2B   DEC $34                  
81BD2D   SEP #$20                 
81BD2F   BNE $81BD4F              
81BD31   LDA #$0E                 
81BD33   STA $04                  
81BD35   LDA #$01                 
81BD37   STA $01                  
81BD39   STZ $32                  
81BD3B   STZ $28                  
81BD3D   STZ $29                  
81BD3F   LDA #$00                 
81BD41   STA $2A                  
81BD43   LDA #$FF                 
81BD45   STA $2B                  
81BD47   JSR $BBF2                
81BD4A   LDA #$02                 
81BD4C   JMP $BDB3                
81BD4F   LDA $32                  
81BD51   BEQ $81BD64              
81BD53   DEC $32                  
81BD55   BNE $81BD5D              
81BD57   LDA #$01                 
81BD59   STA $01                  
81BD5B   BRA $81BD64              
--------unidentified--------
81BD5D  .db $AD $9F $00 $29 $03 $85 $01
----------------         
81BD64   RTS                      
----------------         
81BD65   JSL MoveSprite ; 80C007              
81BD69   JSL FrameAnimationTimer; 8089A9              
81BD6D   REP #$21                 
81BD6F   LDA $16                  
81BD71   ADC $3E                  
81BD73   STA $16                  
81BD75   LDA $3E                  
81BD77   SEC                      
81BD78   SBC #$0088               
81BD7B   STA $3E                  
81BD7D   SEP #$20                 
81BD7F   LDA $17                  
81BD81   BPL $81BD99              
81BD83   STZ $17                  
81BD85   LDA #$10                 
81BD87   STA $04                  
81BD89   LDA #$10                 
81BD8B   STA $34                  
81BD8D   LDA #$A3                 
81BD8F   LDY #$4C                 
81BD91   JSL FrameAnimationNoTimer ; $8089A3              
81BD95   LDA #$01                 
81BD97   STA $31                  
81BD99   RTS                      
----------------         
81BD9A   JSL FrameAnimationTimer; 8089A9              
81BD9E   DEC $34                  
81BDA0   BNE $81BDB2              
81BDA2   LDA #$54                 
81BDA4   STA $14                  
81BDA6   LDA #$02                 
81BDA8   STA $02                  
81BDAA   STA $03                  
81BDAC   STZ $04                  
81BDAE   LDA #$1C                 
81BDB0   STA $1E                  
81BDB2   RTS                      
----------------         
81BDB3   STA $4F                  
81BDB5   REP #$10                 
81BDB7   LDX #$0200               
81BDBA   LDA $0000,X              
81BDBD   BEQ $81BDE1              
81BDBF   LDA $000A,X              
81BDC2   CMP #$30                 
81BDC4   BNE $81BDE1              
81BDC6   LDA $4F                  
81BDC8   BMI $81BDD9              
81BDCA   CMP $000B,X              
81BDCD   BNE $81BDE1              
81BDCF   REP #$20                 
81BDD1   TDC                      
81BDD2   CMP $0043,X              
81BDD5   SEP #$20                 
81BDD7   BNE $81BDE1              
81BDD9   LDA #$04                 
81BDDB   STA $0002,X              
81BDDE   STZ $0003,X              
81BDE1   REP #$21                 
81BDE3   TXA                      
81BDE4   ADC #$0050               
81BDE7   TAX                      
81BDE8   SEP #$20                 
81BDEA   CPX #$0980               
81BDED   BNE $81BDBA              
81BDEF   SEP #$10                 
81BDF1   RTS                      

;????????????
81BDF2 $A6 $04 $7C
81BDF5  .db $F7 $BD $FD $BD $7F $BE $C3 $BE
81BDFD  .db $A9 $02 $85 $04 $A9 $02 $20 $B3
81BE05  .db $BD $A9 $A3 $A0 $BA $22 $A3 $89
81BE0D  .db $80 $22 $9A $91 $80 $AE $00 $00
81BE15  .db $A0 $00 $BD $11 $01 $C5 $11 $B0
81BE1D  .db $01 $C8 $84 $0D $A9 $A4 $A0 $6E
81BE25  .db $22 $9F $BF $80 $A9 $38 $85 $3D
81BE2D  .db $64 $31 $A9 $01 $85 $2E $64 $2F
81BE35  .db $A5 $2E $D0 $02 $64 $2F $C9 $0B
81BE3D  .db $D0 $02 $E6 $2F $0A $A8 $22 $73
81BE45  .db $8F $80 $B0 $33 $A9 $30 $9D $0A
81BE4D  .db $00 $9D $00 $00 $9E $02 $00 $9E
81BE55  .db $03 $00 $9E $04 $00 $A9 $06 $9D
81BE5D  .db $0B $00 $A5 $11 $18 $79 $76 $A4
81BE65  .db $9D $11 $00 $A5 $14 $18 $79 $77
81BE6D  .db $A4 $9D $14 $00 $E2 $10 $A6 $2E
81BE75  .db $E8 $A5 $2F $F0 $02 $CA $CA $86
81BE7D  .db $2E $60 $A5 $11 $C9 $38 $B0 $06
81BE85  .db $A9 $38 $85 $11 $80 $08 $C9 $C8
81BE8D  .db $90 $0E $A9 $C7 $85 $11 $A5 $0D
81BE95  .db $49 $01 $85 $0D $22 $A3 $BF $80
81BE9D  .db $20 $35 $BE $22 $07 $C0 $80 $22
81BEA5  .db $A9 $89 $80 $A5 $08 $C9 $75 $D0
81BEAD  .db $0A $A9 $05 $85 $08 $A9 $23 $22
81BEB5  .db $53 $9A $80 $C6 $3D $D0 $06 $A9
81BEBD  .db $02 $85 $03 $64 $04 $60 $60 $AD
81BEC5  .db $A8 $00 $F0 $04 $A6 $03 $80 $02
81BECD  .db $A6 $2D $FC $D7 $BE $22 $CE $88
81BED5  .db $80 $60 $E1 $BE $41 $BF $6A $BF
81BEDD  .db $88 $FC $A9 $FC $A9 $1C $64 $1E
81BEE5  .db $64 $31 $A5 $1C $D0 $18 $A9 $04
81BEED  .db $85 $2D $A9 $10 $85 $40 $A9 $02
81BEF5  .db $20 $B3 $BD $85 $1D $A9 $A4 $A0
81BEFD  .db $06 $22 $A3 $89 $80 $60 $85 $1D
81BF05  .db $A9 $A3 $A0 $EE $22 $A3 $89 $80
81BF0D  .db $A5 $03 $C9 $06 $D0 $29 $A5 $04
81BF15  .db $C9 $02 $D0 $1D $C2 $20 $A5 $3E
81BF1D  .db $49 $FF $FF $1A $85 $3E $E2 $20
81BF25  .db $A9 $0E $85 $04 $A9 $02 $85 $02
81BF2D  .db $A9 $00 $85 $2A $A9 $FF $85 $2B
81BF35  .db $60 $C9 $0E $D0 $02 $80 $ED $A9
81BF3D  .db $02 $85 $2D $60 $22 $A9 $89 $80
81BF45  .db $A5 $08 $C9 $50 $D0 $1E $A5 $03
81BF4D  .db $C9 $06 $D0 $10 $A5 $04 $C9 $04
81BF55  .db $D0 $0A $A9 $A3 $A0 $A2 $22 $A3
81BF5D  .db $89 $80 $80 $C8 $A9 $02 $85 $03
81BF65  .db $64 $04 $80 $C0 $60 $C6 $40 $D0
81BF6D  .db $0C $A9 $06 $85 $03 $64 $0D $A9
81BF75  .db $02 $8D $A8 $00 $60 $A5 $40 $29
81BF7D  .db $07 $D0 $06 $A5 $0E $49 $01 $85
81BF85  .db $0E $60 $22 $CE $88 $80 $60 $C6
81BF8D  .db $41 $D0 $0A $A9 $10 $85 $41 $A9
81BF95  .db $22 $22 $53 $9A $80 $60 


;0x30
81BF9B   LDX $02                  
81BF9D   JMP ($BFA0,X)            
--------data--------     
81BFA0  .db $A8 $BF $E7 $BF $06 $C2 $2F $C2
----------------         
81BFA8   LDA #$02                 
81BFAA   STA $02                  
81BFAC   STA $01                  
81BFAE   DEC                      
81BFAF   STA $00                  
81BFB1   LDA #$A4                 
81BFB3   LDY #$C0                 
81BFB5   LDX $0B                  
81BFB7   STX $03                  
81BFB9   BNE $81BFBF              
81BFBB   LDA #$A4                 
81BFBD   LDY #$A0                 
81BFBF   JSL $8089A3              
81BFC3   LDA #$39                 
81BFC5   LDY $00B6                
81BFC8   CPY #$04                 
81BFCA   BNE $81BFD5              
81BFCC   LDY $00B7                
81BFCF   CPY #$18                 
81BFD1   BNE $81BFD5              
81BFD3   LDA #$3D                 
81BFD5   STA $1B                  
81BFD7   LDA #$40                 
81BFD9   STA $1A                  
81BFDB   STZ $0E                  
81BFDD   LDA $0B                  
81BFDF   CMP #$06                 
81BFE1   BNE $81BFE6              
81BFE3   JMP $C17E                
81BFE6   RTS                      
----------------         
81BFE7   LDX $03                  
81BFE9   JMP ($BFEC,X)            
--------unidentified--------
81BFEC  .db $F8 $BF ;Never Used? maybe the level2 boss?
----------------         
--------data--------     
81BFEE  .db $6A $C0 $28 $C1      
----------------         
--------unidentified--------
81BFF2  .db $7E $C1              
----------------         
--------data--------     
81BFF4  .db $B4 $C1 $EB $C1      



81BFF8   LDX $04                  
81BFFA   JSR ($C002,X)            
81BFFD   JSL $8088CE              
81C001   RTS                      
----------------         
--------data--------     
81C002  .db $08 $C0 $27 $C0 $5B $C0
----------------         
--------sub start--------
81C008   LDA #$02                 
81C00A   STA $04                  
81C00C   DEC                      
81C00D   STA $01                  
81C00F   LDA #$20                 
81C011   STA $3E                  
81C013   STZ $3F                  
81C015   LDA #$01                 
81C017   LDY #$C0                 
81C019   LDX $0D                  
81C01B   JSL $809252              
81C01F   LDY #$A0                 
81C021   LDA #$A4                 
81C023   JSL $8089A3              
--------sub start--------
81C027   JSL $8089A9              
81C02B   JSL $80C007              
81C02F   LDA $14                  
81C031   CMP #$E8                 
81C033   BCS $81C052              
81C035   REP #$21                 
81C037   LDA $16                  
81C039   ADC $3E                  
81C03B   STA $16                  
81C03D   LDA $3E                  
81C03F   SEC                      
81C040   BMI $81C047              
81C042   SBC #$0003               
81C045   BRA $81C04A              
81C047   SBC #$0002               
81C04A   STA $3E                  
81C04C   SEP #$20                 
81C04E   LDA $17                  
81C050   BPL $81C05A              
81C052   LDA #$04                 
81C054   STA $04                  
81C056   LDA #$03                 
81C058   STA $3D                  
81C05A   RTS                      
----------------         
--------sub start--------
81C05B   DEC $3D                  
81C05D   BNE $81C063              
81C05F   LDA #$06                 
81C061   STA $02                  
81C063   LDA $3D                  
81C065   AND #$01                 
81C067   STA $01                  
81C069   RTS                      
        
81C06A   LDX $04                  
81C06C   JSR ($C074,X)            
81C06F   JSL $8088CE              
81C073   RTS                      
     
81C074  .db $7A $C0 $9D $C0 $A6 $C0


81C07A   LDA $A4DF                
81C07D   LDY $A4DE                
81C080   LDX $0D                  
81C082   JSL $809252              
81C086   LDA #$01                 
81C088   STA $2F                  
81C08A   STZ $2E                  
81C08C   STZ $34                  
81C08E   STZ $2D                  
81C090   LDA #$02                 
81C092   STA $04                  
81C094   LDA #$A4                 
81C096   LDY #$C0                 
81C098   JSL $8089A3              
81C09C   RTS                      
----------------         
--------sub start--------
81C09D   JSL $8089A9              
81C0A1   JSL $80C007              
81C0A5   RTS                      
----------------         
--------sub start--------
81C0A6   LDA $2E                  
81C0A8   BNE $81C11D              
81C0AA   INC $2D                  
81C0AC   DEC $2F                  
81C0AE   BNE $81C11D              
81C0B0   LDA $34                  
81C0B2   LSR                      
81C0B3   TAX                      
81C0B4   INC $34                  
81C0B6   LDA $A51D,X              
81C0B9   BCS $81C0BF              
81C0BB   LSR                      
81C0BC   LSR                      
81C0BD   LSR                      
81C0BE   LSR                      
81C0BF   AND #$0F                 
81C0C1   BNE $81C0DA              
81C0C3   LDA $35                  
81C0C5   CLC                      
81C0C6   ADC #$80                 
81C0C8   STA $35                  
81C0CA   LDX $33                  
81C0CC   LDA $A513,X              
81C0CF   INC                      
81C0D0   STA $2E                  
81C0D2   STZ $2D                  
81C0D4   LDA #$01                 
81C0D6   STA $2F                  
81C0D8   BRA $81C0FD              
81C0DA   BIT #$08                 
81C0DC   BEQ $81C0F1              
81C0DE   LDX $33                  
81C0E0   LDA #$0E                 
81C0E2   SEC                      
81C0E3   SBC $A513,X              
81C0E6   INC                      
81C0E7   STA $2E                  
81C0E9   STZ $2D                  
81C0EB   LDA #$01                 
81C0ED   STA $2F                  
81C0EF   BRA $81C0FD              
81C0F1   STA $2F                  
81C0F3   DEC $0D                  
81C0F5   LDA $35                  
81C0F7   BPL $81C0FD              
81C0F9   INC $0D                  
81C0FB   INC $0D                  
81C0FD   LDA $31                  
81C0FF   STA $11                  
81C101   STZ $12                  
81C103   LDA $32                  
81C105   STA $14                  
81C107   STZ $15                  
81C109   LDA $33                  
81C10B   ASL                      
81C10C   TAX                      
81C10D   LDA $A4E1,X              
81C110   LDY $A4E0,X              
81C113   LDX $0D                  
81C115   JSL $809252              
81C119   JSL $80C007              
81C11D   LDA $2D                  
81C11F   BNE $81C123              
81C121   DEC $2E                  
81C123   JSL $8089A9              
81C127   RTS                      
----------------         
81C128   LDX $04                  
81C12A   JSR ($C136,X)            
81C12D   LDA $3B                  
81C12F   BNE $81C135              
81C131   JSL $8088CE              
81C135   RTS                      
----------------         
--------data--------     
81C136  .db $3A $C1 $45 $C1      
----------------         
--------sub start--------
81C13A   LDA #$02                 
81C13C   STA $01                  
81C13E   STZ $12                  
81C140   STZ $15                  
81C142   JMP $C086                
--------sub start--------
81C145   STZ $3B                  
81C147   REP #$10                 
81C149   LDX $43                  
81C14B   LDA #$00                 
81C14D   XBA                      
81C14E   LDA $0031,X              
81C151   BNE $81C157              
81C153   INC $3B                  
81C155   BRA $81C177              
81C157   ASL                      
81C158   ADC $0031,X              
81C15B   TAY                      
81C15C   REP #$20                 
81C15E   LDA $A501,Y              
81C161   ADC $0011,X              
81C164   STA $11                  
81C166   LDA $0014,X              
81C169   INC                      
81C16A   STA $14                  
81C16C   SEP #$20                 
81C16E   LDA $A503,Y              
81C171   CLC                      
81C172   ADC $0017,X              
81C175   STA $17                  
81C177   SEP #$10                 
81C179   JSL $8089A9              
81C17D   RTS                      
----------------         
--------unidentified-------- ;Unknown yet ??
81C17E  .db $A6 $04 $FC $88 $C1 $22 $CE $88
81C186  .db $80 $60 $8C $C1 $99 $C1 $A9 $A4
81C18E  .db $A0 $CE $22 $A3 $89 $80 $A9 $02
81C196  .db $85 $04 $60 $22 $A9 $89 $80 $A5
81C19E  .db $08 $C9 $03 $D0 $08 $A9 $01 $85
81C1A6  .db $08 $22 $A9 $89 $80 $C9 $53 $D0
81C1AE  .db $04 $A9 $06 $85 $02 $60
----------------         
81C1B4   LDA $00AC                
81C1B7   BNE $81C1BE              
81C1B9   LDX $04                  
81C1BB   JSR ($C1C3,X)            
81C1BE   JSL $8088CE              
81C1C2   RTS                      
----------------         
--------data--------     
81C1C3  .db $C7 $C1 $D6 $C1      
----------------         
--------sub start--------
81C1C7   LDA #$38                 
81C1C9   STA $42                  
81C1CB   LDA #$A4                 
81C1CD   LDY #$F4                 
81C1CF   JSL $80BF9F              
81C1D3   JMP $C090                
--------sub start--------
81C1D6   JSL $80C007              
81C1DA   JSL $8089A9              
81C1DE   DEC $42                  
81C1E0   BNE $81C1EA              
81C1E2   LDA #$04                 
81C1E4   STA $02                  
81C1E6   STZ $03                  
81C1E8   STZ $04                  
81C1EA   RTS                      
----------------         
81C1EB   LDA $00AC                
81C1EE   BNE $81C1F5              
81C1F0   LDX $04                  
81C1F2   JSR ($C1FA,X)            
81C1F5   JSL $8088CE              
81C1F9   RTS                      
----------------         
--------data--------     
81C1FA  .db $FE $C1 $01 $C2      
----------------         
--------sub start--------
81C1FE   JMP $C090                
--------sub start--------
81C201   JSL $8089A9              
81C205   RTS                      
----------------         
81C206   LDX $03                  
81C208   JSR ($C210,X)            
81C20B   JSL $8088CE              
81C20F   RTS                      
----------------         
--------data--------     
81C210  .db $14 $C2 $20 $C2      
----------------         
--------sub start--------
81C214   LDA #$02                 
81C216   STA $03                  
81C218   LDA #$A4                 
81C21A   LDY #$D2                 
81C21C   JSL $8089A3              
--------sub start--------
81C220   JSL $8089A9              
81C224   LDA $08                  
81C226   CMP #$50                 
81C228   BNE $81C22E              
81C22A   LDA #$06                 
81C22C   STA $02                  
81C22E   RTS                      
----------------         
81C22F   JSL $808F1E              
81C233   RTS                      


;Sprite 0x32 Ground switch that trigger conveyor/bridge
81C234   LDX $02  
81C236   JMP ($C239,X)
--------data--------     
81C239  .db $41 $C2 $60 $C2 $6C $C2
----------------   
--------unidentified--------
81C23F  .db $8E $C2  
----------------   
81C241   LDA #$02 
81C243   STA $02  
81C245   DEC
81C246   STA $00  
81C248   STA $1C  
81C24A   LDA $0B  
81C24C   ASL
81C24D   TAX
81C24E   REP #$20 
81C250   LDA $A55A,X  
81C253   STA $0010
81C256   SEP #$20 
81C258   LDA $A55C,X  
81C25B   JSL $808D7B  
81C25F   RTS
----------------   
81C260   LDA $1C  
81C262   BNE $81C25F  
81C264   LDA #$04 
81C266   STA $02  
81C268   LDA #$03 
81C26A   STA $00  
81C26C   LDA #$07 
81C26E   JSL PlaySFX ;$809A53
81C272   LDA $0B  
81C274   ASL
81C275   TAX
81C276   REP #$20 
81C278   LDA $A55A,X  
81C27B   STA $0010
81C27E   SEP #$20 
81C280   LDA $A55D,X  
81C283   JSL $808D7B  
81C287   JSL KillSprite ; 808F1E  
81C28B   INC $00FE
81C28E   RTS

;Sprite 0x34 Wall Switch?
81C28F   LDA $02                  
81C291   BNE $81C2A3              
81C293   LDA #$01                 
81C295   STA $02                  
81C297   STA $00                  
81C299   STA $1C                  
81C29B   STA $1D                  
81C29D   LDA $1144                
81C2A0   BMI $81C2A9              
81C2A2   RTS                      
----------------         
81C2A3   LDA $1D                  
81C2A5   CMP $1C                  
81C2A7   BEQ $81C2D3              
81C2A9   LDX #$00                 
81C2AB   LDA $8AF0E0,X            
81C2AF   STA $1E80,X              
81C2B2   INX                      
81C2B3   CPX #$20                 
81C2B5   BCC $81C2AB              
81C2B7   LDA #$80                 
81C2B9   TSB $1144                
81C2BC   LDA #$0E                 
81C2BE   STA $0013                
81C2C1   LDA #$00                 
81C2C3   STA $0014                
81C2C6   LDA #$00                 
81C2C8   STA $000A                
81C2CB   JSL $82C3B4              
81C2CF   JSL $808F3B              
81C2D3   RTS                      

;0x36 BOSS2 small Pirate Throwing Barrel      
81C2D4   LDX $02                  
81C2D6   JMP ($C2D9,X)            
--------data--------     
81C2D9
dw $C2DD
dw $C324     
----------------         
81C2DD   JSL $808EE9              
81C2E1   BCS $81C31F              
81C2E3   LDA #$02                 
81C2E5   STA $02                  
81C2E7   DEC                      
81C2E8   STA $01                  
81C2EA   STA $00                  
81C2EC   LDA #$04                 
81C2EE   STA $03                  
81C2F0   LDA #$37                 
81C2F2   STA $1B                  
81C2F4   LDA #$0A                 
81C2F6   STA $22                  
81C2F8   JSL $808A53              
81C2FC   LDA #$A5                 
81C2FE   LDY #$66                 
81C300   JSL $8089D7              
81C304   JSL $808A21              
81C308   LDX #$FF                 
81C30A   LDA $0D                  
81C30C   STA $0E                  
81C30E   BEQ $81C312              
81C310   LDX #$01                 
81C312   STX $12                  
81C314   LDA #$76                 
81C316   STA $18                  
81C318   LDA #$A5                 
81C31A   STA $19                  
81C31C   JMP $C3CA                
--------unidentified--------
81C31F  .db $22 $0F $8F $80 $60  
----------------         
81C324   LDA $00AC                
81C327   BNE $81C337              
81C329   LDA $00A8                
81C32C   BNE $81C337              
81C32E   LDX $03                  
81C330   JSR ($C33C,X)            
81C333   JSL $808A25              
81C337   JSL $8088CE              
81C33B   RTS                      
----------------         
--------unidentified--------
81C33C  .db $46 $C3              
----------------         
--------data--------     
81C33E  .db $6B $C3 $CA $C3      
----------------         
--------unidentified--------
81C342  .db $E7 $C3 $F4 $C3 $C6 $3F $D0 $20
81C34A  .db $A9 $02 $85 $03 $A9 $A5 $A0 $6F
81C352  .db $22 $D7 $89 $80 $A9 $30 $85 $3F
81C35A  .db $C2 $10 $A6 $3D $A9 $02 $9D $02
81C362  .db $00 $A9 $0A $9D $03 $00 $E2 $10
81C36A  .db $60                  
----------------         
--------sub start--------
81C36B   LDA $3F                  
81C36D   BNE $81C3C7              
81C36F   LDA #$A5                 
81C371   LDY #$66                 
81C373   JSL $8089D7              
81C377   LDX #$02                 
81C379   JSL $8091F6              
81C37D   BCC $81C3C9              
81C37F   STZ $03                  
81C381   JSL $808859              
--------unidentified--------
81C385  .db $A0 $00 $29 $0F $C9 $04 $90 $02
81C38D  .db $A0 $01 $84 $3C $22 $8E $8F $80
81C395  .db $B0 $2E $86 $3D $9E $0A $00 $A9
81C39D  .db $02 $9D $04 $00 $9D $05 $00 $9D
81C3A5  .db $00 $00 $A5 $3C $9D $36 $00 $9E
81C3AD  .db $0B $00 $A5 $0D $9D $0D $00 $A5
81C3B5  .db $11 $9D $11 $00 $A5 $14 $18 $69
81C3BD  .db $08 $9D $14 $00 $A9 $10 $85 $3F
81C3C5  .db $E2 $10 $C6 $3F      
----------------         
81C3C9   RTS                      


81C3CA   LDA $16E6                
81C3CD   BNE $81C3E6              
81C3CF   LDA $1726                
81C3D2   BNE $81C3E6              
81C3D4   LDA $16FA                
81C3D7   BNE $81C3E6              
81C3D9   LDA $173A                
81C3DC   BNE $81C3E6              
81C3DE   LDA #$06                 
81C3E0   STA $03                  
81C3E2   LDA #$FF                 
81C3E4   STA $3F                  
81C3E6   RTS                      
----------------         
--------unidentified--------
81C3E7  .db $C6 $3F $D0 $08 $A9 $08 $85 $03
81C3EF  .db $A9 $10 $85 $3F $60 $22 $CC $BF
81C3F7  .db $80 $C6 $3F $D0 $08 $A9 $02 $85
81C3FF  .db $03 $A9 $10 $85 $3F $60



;0x38 Moving Rail Platform
81C405   LDX $02                  
81C407   JMP ($C40A,X)            
--------data--------     
81C40A  
dw $C40E
dw $C42F      
----------------         
81C40E   LDA #$02                 
81C410   STA $02                  
81C412   DEC                      
81C413   STA $00                  
81C415   STA $01                  
81C417   STZ $3D                  
81C419   STZ $3E                  
81C41B   STZ $3F                  
81C41D   LDA #$80                 
81C41F   STA $1A                  
81C421   LDA #$3D                 
81C423   STA $1B                  
81C425   LDY #$7E                 
81C427   LDA #$A5                 
81C429   JSL $8089A3              
81C42D   BRA $81C481              
81C42F   LDA $00AC                
81C432   BNE $81C439              
81C434   LDX $03                  
81C436   JSR ($C43E,X)            
81C439   JSL $8088DF              
81C43D   RTS                      
   
81C43E 
dw $C446 
dw $C453      
dw $C486 
dw $C493    

81C446   JSR $C4C4                
81C449   DEC $0F                  
81C44B   BNE $81C47C              
81C44D   LDA #$02                 
81C44F   STA $03                  
81C451   BRA $81C468              

81C453   JSR $C4C4                
81C456   JSL $80C007              
81C45A   DEC $0F                  
81C45C   BNE $81C47C              
81C45E   LDA $3D                  
81C460   CMP #$04                 
81C462   BEQ $81C47D              
81C464   INC                      
81C465   INC                      
81C466   STA $3D                  
81C468   LDX $3D                  
81C46A   LDA $A585,X ;Set Direction
81C46D   STA $0D                  
81C46F   LDA $A586,X              
81C472   STA $0F                  
81C474   LDY #$8B                 
81C476   LDA #$A5                 
81C478   JSL $80BF9F              
81C47C   RTS                      

81C47D  .db $A9 $04 $85 $03      
      
81C481   LDA #$78 ;Set waiting time after reaching end
81C483   STA $0F                  
81C485   RTS                      


 
81C486  .db $20 $C4 $C4 $C6 $0F $D0 $EF $A9 $06
81C48F  .db $85 $03 $80 $13 $20 $C4 $C4 $22
81C497  .db $07 $C0 $80 $C6 $0F $D0 $1E $A5
81C49F  .db $3D $F0 $1B $3A $3A $85 $3D $A6
81C4A7  .db $3D $BD $85 $A5 $49 $02 $85 $0D
81C4AF  .db $BD $86 $A5 $85 $0F $A0 $8B $A9
81C4B7  .db $A5 $22 $9F $BF $80 $60 

81C4BD   STZ $03
81C4BF   LDA #$78  ;Set waiting time after reaching start
81C4C1   STA $0F
81C4C3   RTS

81C4C4   LDY #$00                 
81C4C6   LDX #$00                 
81C4C8   JSR $C4CF                
81C4CB   LDY #$80                 
81C4CD   LDX #$01                 
--------sub start--------
81C4CF   LDA $0100,Y              
81C4D2   AND #$03                 
81C4D4   BEQ $81C546              
81C4D6   LDA $3E,X                
81C4D8   BNE $81C4FA              
81C4DA   LDA $11                  
81C4DC   CLC                      
81C4DD   ADC #$0B                 
81C4DF   SEC                      
81C4E0   SBC $0111,Y              
81C4E3   CMP #$17                 
81C4E5   BCS $81C546              
81C4E7   LDA $14                  
81C4E9   CLC                      
81C4EA   ADC #$0D                 
81C4EC   SEC                      
81C4ED   SBC $0114,Y              
81C4F0   CMP #$1B                 
81C4F2   BCS $81C546              
81C4F4   LDA #$01                 
81C4F6   STA $3E,X                
81C4F8   BRA $81C514              

81C4FA      $A5 $11 $18 $69 $15
81C4FF  .db $38 $F9 $11 $01 $C9 $2B $B0 $3F
81C507  .db $A5 $14 $18 $69 $13 $38 $F9 $14
81C50F  .db $01 $C9 $27 $B0 $32 $A5 $03 $29
81C517  .db $02 $F0 $26 $C2 $21 $B9 $10 $01
81C51F  .db $65 $28 $99 $10 $01 $B9 $13 $01
81C527  .db $18 $65 $2A $99 $13 $01 $E2 $20
81C52F  .db $A5 $0D $0B $0A $AA $A9 $01 $EB
81C537  .db $98 $5B $22 $C6 $91 $82 $7B $A8
81C53F  .db $2B $A9 $01 $99 $44 $01 $60 $74
81C547  .db $3E $60 

81C549   LDX $02                  
81C54B   JMP ($C54E,X)            
--------data--------     
81C54E  .db $54 $C5 $E0 $C5      
----------------         
--------unidentified--------
81C552  .db $19 $D1              
----------------         

81C554   LDA #$02                 
81C556   STA $02                  
81C558   STA $119B                
81C55B   STA $01                  
81C55D   DEC                      
81C55E   STA $00                  
81C560   LDA #$38                 
81C562   STA $1C                  
81C564   STA $1D                  
81C566   STZ $0E                  
81C568   LDA #$06                 
81C56A   STA $3B                  
81C56C   STA $1F                  
81C56E   STZ $3C                  
81C570   STZ $3E                  
81C572   STZ $2F                  
81C574   LDA #$12                 
81C576   STA $1E                  
81C578   LDA #$0C                 
81C57A   STA $22                  
81C57C   STZ $1A                  
81C57E   LDA #$3F                 
81C580   STA $1B                  
81C582   JSL $808A53              
81C586   LDA #$A5                 
81C588   LDY #$D8                 
81C58A   JSL $8089D7              
81C58E   JSL $808A21              
81C592   LDA #$02                 
81C594   STA $34                  
81C596   STZ $35                  
81C598   JSL $808F73              
81C59C   BCS $81C5B3              
81C59E   LDA #$03                 
81C5A0   STA $0000,X              
81C5A3   LDA #$3C                 
81C5A5   STA $000A,X              
81C5A8   LDA $35                  
81C5AA   STA $000B,X              
81C5AD   REP #$20                 
81C5AF   TDC                      
81C5B0   STA $0036,X              
81C5B3   SEP #$31                 
81C5B5   LDA #$08                 
81C5B7   STA $35                  
81C5B9   DEC $34                  
81C5BB   BNE $81C598              
81C5BD   JSL $808F73              
81C5C1   BCS $81C5D7              
81C5C3   LDA #$03                 
81C5C5   STA $0000,X              
81C5C8   DEC                      
81C5C9   STA $000B,X              
81C5CC   LDA #$4E                 
81C5CE   STA $000A,X              
81C5D1   REP #$20                 
81C5D3   TDC                      
81C5D4   STA $0030,X              
81C5D7   SEP #$30                 
81C5D9   LDA #$30                 
81C5DB   JSL $808660              
81C5DF   RTS                      
----------------         
81C5E0   LDA $1C                  
81C5E2   CMP $1D                  
81C5E4   BNE $81C5E9              
81C5E6   JMP $C675                
81C5E9   STA $1D                  
81C5EB   LDA $00C8                
81C5EE   BEQ $81C5F7              
81C5F0   STZ $00C8                
81C5F3   JSL $809A29              
81C5F7   LDA $1C                  
81C5F9   BNE $81C60A              
81C5FB   LDA #$04                 
81C5FD   STA $02                  
81C5FF   LDA #$02                 
81C601   STA $03                  
81C603   STZ $04                  
81C605   STA $1F                  
81C607   JMP $D119                
81C60A   REP #$20                 
81C60C   LDA $06                  
81C60E   CMP #$A5AA               
81C611   BEQ $81C62C              
81C613   CMP #$A613               
81C616   BEQ $81C62C              
81C618   CMP #$A620               
81C61B   BEQ $81C62C              
81C61D   CMP #$A62D               
81C620   BEQ $81C62C              
81C622   CMP #$A693               
81C625   BEQ $81C62C              
81C627   CMP #$A6A2               
81C62A   BNE $81C632              
81C62C   SEP #$20                 
81C62E   INC $2F                  
81C630   BRA $81C66F              
81C632   SEP #$20                 
81C634   LDA $4F                  
81C636   BNE $81C640              
81C638   LDA #$02                 
81C63A   STA $40                  
81C63C   STZ $41                  
81C63E   BRA $81C65E              
--------unidentified--------
81C640  .db $3A $D0 $0A $A9 $06 $85 $40 $A9
81C648  .db $1A $85 $41 $80 $11 $3A $D0 $1F
81C650  .db $A5 $14 $C9 $50 $B0 $E2 $A9 $08
81C658  .db $85 $40 $85 $41 $80 $00
----------------         
81C65E   LDA #$04                 
81C660   STA $02                  
81C662   STZ $03                  
81C664   STZ $04                  
81C666   STA $1F                  
81C668   LDA #$18                 
81C66A   STA $3E                  
81C66C   JMP $D119                
--------unidentified--------
81C66F  .db $A9 $18 $85 $3E $85 $1F
----------------         
81C675   LDX $03                  
81C677   JSR ($C69E,X)            
81C67A   JSL $808A25              
81C67E   JSL $8088CE              
81C682   LDA $3E                  
81C684   BEQ $81C69D              
81C686   LDA #$01                 
81C688   STA $01                  
81C68A   DEC $3E                  
81C68C   BNE $81C694              
81C68E   STZ $1F                  
81C690   STZ $2F                  
81C692   BRA $81C69D              
81C694   LDA $009F                
81C697   AND #$03                 
81C699   BNE $81C69D              
81C69B   STA $01                  
81C69D   RTS                      
----------------         
--------data--------     
81C69E  .db $AC $C6 $D6 $C7 $26 $C9 $36 $CA
81C6A6  .db $59 $CD $8D $CE $80 $CF
----------------         
--------sub start--------
81C6AC   LDX $04                  
81C6AE   JMP ($C6B1,X)            
--------data--------     
81C6B1  .db $BD $C6 $F1 $C6 $0D $C7 $65 $C7
81C6B9  .db $97 $C7 $CA $C7      
----------------         
81C6BD   LDA #$02                 
81C6BF   STA $04                  
81C6C1   LDA #$78                 
81C6C3   STA $30                  
81C6C5   REP #$20                 
81C6C7   LDA #$0080               
81C6CA   STA $11                  
81C6CC   LDA #$FFF0               
81C6CF   STA $14                  
81C6D1   STZ $28                  
81C6D3   LDA #$0140               
81C6D6   STA $2A                  
81C6D8   LDA #$8080               
81C6DB   STA $0014EE              
81C6DF   STA $0014F0              
81C6E3   STA $00176E              
81C6E7   STA $001770              
81C6EB   SEP #$20                 
81C6ED   LDA #$08                 
81C6EF   STA $2E                  
81C6F1   DEC $30                  
81C6F3   BNE $81C70C              
81C6F5   JSR $D26B                
81C6F8   LDA #$3C                 
81C6FA   STA $30                  
81C6FC   LDA #$04                 
81C6FE   STA $04                  
81C700   LDA #$20                 
81C702   JSL $809A53              
81C706   LDA #$2E                 
81C708   JSL $808667              
81C70C   RTS                      
----------------         
81C70D   JSR $D253                
81C710   LDA $30                  
81C712   CMP #$10                 
81C714   BCS $81C72C              
81C716   JSL $80C007              
81C71A   JSL $8089DE              
81C71E   LDA $08                  
81C720   CMP $3B                  
81C722   BCS $81C72C              
81C724   LDA #$01                 
81C726   STA $08                  
81C728   JSL $8089DE              
81C72C   DEC $30                  
81C72E   BNE $81C757              
81C730   LDA #$06                 
81C732   STA $04                  
81C734   LDA #$70                 
81C736   STA $30                  
81C738   LDA #$0E                 
81C73A   STA $0013                
81C73D   LDA #$00                 
81C73F   STA $0014                
81C742   LDA #$00                 
81C744   STA $000A                
81C747   JSL $82C3B4              
81C74B   LDA #$08                 
81C74D   JSL $809A53              
81C751   LDA #$2C                 
81C753   JSL $808667              
81C757   LDA $30                  
81C759   CMP #$28                 
81C75B   BCC $81C764              
81C75D   AND #$0F                 
81C75F   BNE $81C764              
81C761   JSR $D26B                
81C764   RTS                      
----------------         
81C765   JSL $80C007              
81C769   JSL $8089DE              
81C76D   LDA $08                  
81C76F   CMP $3B                  
81C771   BCS $81C77B              
81C773   LDA #$01                 
81C775   STA $08                  
81C777   JSL $8089DE              
81C77B   JSR $D253                
81C77E   DEC $30                  
81C780   BNE $81C796              
81C782   LDA #$08                 
81C784   STA $04                  
81C786   LDA #$30                 
81C788   STA $30                  
81C78A   LDA #$21                 
81C78C   JSL $809A53              
81C790   LDA #$2D                 
81C792   JSL $808667              
81C796   RTS                      
----------------         
81C797   JSL $8089DE              
81C79B   JSR $D3B0                
81C79E   DEC $30                  
81C7A0   BNE $81C7C9              
81C7A2   LDA #$0A                 
81C7A4   STA $04                  
81C7A6   STZ $1F                  
81C7A8   STZ $00C8                
81C7AB   JSL $809A29              
81C7AF   JSR $D262                
81C7B2   JSL $808FA9              
81C7B6   BCS $81C7C7              
81C7B8   LDA #$02                 
81C7BA   STA $0000,X              
81C7BD   LDA #$1C                 
81C7BF   STA $000A,X              
81C7C2   LDA #$06                 
81C7C4   STA $000B,X              
81C7C7   SEP #$10                 
81C7C9   RTS                      
----------------         
81C7CA   LDA $00FE                
81C7CD   BEQ $81C7D5              
81C7CF   LDA #$02                 
81C7D1   STA $03                  
81C7D3   STZ $04                  
81C7D5   RTS                      
----------------         
--------sub start--------
81C7D6   LDX $04                  
81C7D8   JMP ($C7DB,X)            
--------data--------     
81C7DB  .db $E7 $C7 $4E $C8 $5E $C8 $D9 $C8
81C7E3  .db $0F $C9 $1F $C9      
----------------         
81C7E7   STZ $4F                  
81C7E9   JSL $808859              
81C7ED   AND #$0F                 
81C7EF   TAX                      
81C7F0   REP #$20                 
81C7F2   LDA $80C0,X              
81C7F5   AND #$2482               
81C7F8   SEP #$20                 
81C7FA   BEQ $81C801              
81C7FC   LDA #$02                 
81C7FE   STA $04                  
81C800   RTS                      
----------------         
81C801   LDA $14                  
81C803   CMP #$88                 
81C805   BCC $81C810              
81C807   CMP #$98                 
81C809   BCS $81C810              
81C80B   LDA #$04                 
81C80D   STA $03                  
81C80F   RTS                      
----------------         
81C810   STZ $3C                  
81C812   JSL $808859              
81C816   AND #$0F                 
81C818   STA $34                  
81C81A   JSR $FE4B                
81C81D   LDX $0000                
81C820   LDY $34                  
81C822   LDA $14                  
81C824   CMP $0114,X              
81C827   BCC $81C82E              
81C829   LDA $A73F,Y              
81C82C   BRA $81C849              
81C82E   ADC #$1F                 
81C830   CMP $0114,X              
81C833   BCC $81C83A              
81C835   LDA $A74F,Y              
81C838   BRA $81C849              
81C83A   ADC #$1F                 
81C83C   CMP $0114,X              
81C83F   BCC $81C846              
81C841   LDA $A75F,Y              
81C844   BRA $81C849              
81C846   LDA $A76F,Y              
81C849   STA $03                  
81C84B   STZ $04                  
81C84D   RTS                      
----------------         
81C84E   LDA #$04                 
81C850   STA $04                  
81C852   LDA #$0A                 
81C854   STA $30                  
81C856   LDA #$A5                 
81C858   LDY #$B8                 
81C85A   JSL $8089D7              
81C85E   DEC $30                  
81C860   BNE $81C8D8              
81C862   LDA #$06                 
81C864   STA $04                  
81C866   LDA #$A5                 
81C868   LDY #$AA                 
81C86A   JSL $8089D7              
81C86E   LDA $3C                  
81C870   BEQ $81C891              
81C872   DEC $3D                  
81C874   BNE $81C878              
81C876   STZ $3C                  
81C878   LDY #$02                 
81C87A   JSL $808859              
--------unidentified--------
81C87E  .db $29 $0F $C9 $04 $B0 $02 $A0 $06
81C886  .db $98 $A6 $11 $E0 $80 $B0 $25 $49
81C88E  .db $04 $80 $21          
----------------         
81C891   JSL $808859              
81C895   AND #$0F                 
81C897   TAX                      
81C898   LDA $A797,X              
81C89B   BPL $81C8B2              
81C89D   JSR $FE4B                
81C8A0   LDA #$01                 
81C8A2   XBA                      
81C8A3   LDA $0000                
81C8A6   REP #$10                 
81C8A8   TAX                      
81C8A9   JSL $808B0E              
81C8AD   LSR                      
81C8AE   INC                      
81C8AF   LSR                      
81C8B0   AND #$07                 
81C8B2   ASL                      
81C8B3   ASL                      
81C8B4   ASL                      
81C8B5   ASL                      
81C8B6   ASL                      
81C8B7   STA $0D                  
81C8B9   JSL $808859              
81C8BD   AND #$0F                 
81C8BF   TAX                      
81C8C0   LDA $A77F,X              
81C8C3   STA $31                  
81C8C5   TAX                      
81C8C6   LDA $A790,X              
81C8C9   LDY $A78F,X              
81C8CC   LDX $0D                  
81C8CE   JSL $809252              
81C8D2   LDA #$05                 
81C8D4   STA $3A                  
81C8D6   STZ $39                  
81C8D8   RTS                      
----------------         
81C8D9   JSL $80C007              
81C8DD   JSR $D28B                
81C8E0   REP #$21                 
81C8E2   LDA $16                  
81C8E4   ADC $39                  
81C8E6   STA $16                  
81C8E8   LDA $39                  
81C8EA   SEC                      
81C8EB   SBC #$0030               
81C8EE   STA $39                  
81C8F0   SEP #$20                 
81C8F2   LDA $17                  
81C8F4   BPL $81C90E              
81C8F6   LDA #$2C                 
81C8F8   JSL $809A53              
81C8FC   STZ $17                  
81C8FE   LDA #$08                 
81C900   STA $04                  
81C902   LDA #$A5                 
81C904   LDY #$B8                 
81C906   JSL $8089D7              
81C90A   LDA #$08                 
81C90C   STA $30                  
81C90E   RTS                      
----------------         
81C90F   DEC $30                  
81C911   BNE $81C91E              
81C913   LDA #$0A                 
81C915   STA $04                  
81C917   LDA #$10                 
81C919   STA $30                  
81C91B   JMP $D262                
81C91E   RTS                      
----------------         
81C91F   DEC $30                  
81C921   BNE $81C925              
81C923   STZ $04                  
81C925   RTS                      
----------------         
--------sub start--------
81C926   LDX $04                  
81C928   JMP ($C92B,X)            
--------data--------     
81C92B  .db $37 $C9 $63 $C9 $A4 $C9 $E4 $C9
81C933  .db $01 $CA $25 $CA      
----------------         
81C937   LDA #$02                 
81C939   STA $04                  
81C93B   LDA #$A5                 
81C93D   LDY #$C9                 
81C93F   JSL $8089D7              
81C943   JSL $808859              
81C947   AND #$0F                 
81C949   TAX                      
81C94A   LDA $A7E7,X              
81C94D   STA $30                  
81C94F   JSL $808859              
81C953   AND #$1F                 
81C955   STA $31                  
81C957   LDA #$1E                 
81C959   STA $32                  
81C95B   LDA #$17                 
81C95D   STA $33                  
81C95F   LDA #$10                 
81C961   STA $2E                  
81C963   JSL $8089DE              
81C967   JSR $D392                
81C96A   JSR $D253                
81C96D   DEC $32                  
81C96F   BNE $81C999              
81C971   JSL $808859              
81C975   AND #$0F                 
81C977   TAX                      
81C978   LDA $A817,X              
81C97B   STA $32                  
81C97D   LDX $31                  
81C97F   LDA $A7F7,X              
81C982   STA $43                  
81C984   TXA                      
81C985   INC                      
81C986   AND #$1F                 
81C988   STA $31                  
81C98A   JSR $D410                
81C98D   DEC $30                  
81C98F   BNE $81C999              
81C991   LDA #$04                 
81C993   STA $04                  
81C995   LDA #$10                 
81C997   STA $30                  
81C999   DEC $33                  
81C99B   BNE $81C9A3              
81C99D   INC $1F                  
81C99F   LDA #$14                 
81C9A1   STA $1E                  
81C9A3   RTS                      
----------------         
81C9A4   JSL $8089DE              
81C9A8   JSR $D392                
81C9AB   JSR $D253                
81C9AE   DEC $30                  
81C9B0   BNE $81C9E3              
81C9B2   LDA #$06                 
81C9B4   STA $04                  
81C9B6   REP #$20                 
81C9B8   LDA #$0080               
81C9BB   STA $34                  
81C9BD   LDA #$0070               
81C9C0   STA $37                  
81C9C2   SEP #$20                 
81C9C4   REP #$10                 
81C9C6   LDX #$0223               
81C9C9   JSL $808B0E              
81C9CD   CMP #$08                 
81C9CF   BNE $81C9D3              
81C9D1   LDA #$07                 
81C9D3   CMP #$18                 
81C9D5   BNE $81C9D9              
81C9D7   LDA #$19                 
81C9D9   STA $0D                  
81C9DB   LDA #$A6                 
81C9DD   LDY #$BF                 
81C9DF   JSL $80BF9F              
81C9E3   RTS                      
----------------         
81C9E4   JSL $80C007              
81C9E8   JSL $8089DE              
81C9EC   JSR $D392                
81C9EF   JSR $D253                
81C9F2   LDA $14                  
81C9F4   CMP #$72                 
81C9F6   BCS $81CA00              
81C9F8   LDA #$08                 
81C9FA   STA $04                  
81C9FC   LDA #$24                 
81C9FE   STA $30                  
81CA00   RTS                      
----------------         
81CA01   JSL $8089DE              
81CA05   JSR $D3B0                
81CA08   DEC $30                  
81CA0A   BNE $81CA24              
81CA0C   LDA #$0A                 
81CA0E   STA $04                  
81CA10   STZ $00C8                
81CA13   JSL $809A29              
81CA17   STZ $1F                  
81CA19   JSR $D262                
81CA1C   LDA #$12                 
81CA1E   STA $1E                  
81CA20   LDA #$50                 
81CA22   STA $30                  
81CA24   RTS                      
----------------         
81CA25   DEC $30                  
81CA27   BNE $81CA35              
81CA29   LDA #$02                 
81CA2B   STA $03                  
81CA2D   STZ $04                  
81CA2F   INC $3C                  
81CA31   LDA #$04                 
81CA33   STA $3D                  
81CA35   RTS                      
----------------         
--------sub start--------
81CA36   LDX $04                  
81CA38   JMP ($CA3B,X)            
--------data--------     
81CA3B  .db $59 $CA $91 $CA $FB $CA $2D $CB
81CA43  .db $41 $CB $56 $CB $00 $CC $11 $CC
81CA4B  .db $26 $CC $77 $CC $A2 $CC $DA $CC
81CA53  .db $FE $CC $06 $CD $43 $CD
----------------         
81CA59   LDA #$02                 
81CA5B   STA $4F                  
81CA5D   LDA $03                  
81CA5F   STA $40                  
81CA61   LDA #$08                 
81CA63   STA $41                  
81CA65   REP #$20                 
81CA67   LDA #$0500               
81CA6A   STA $39                  
81CA6C   LDA #$0024               
81CA6F   STA $4B                  
81CA71   LDA #$00C8               
81CA74   STA $47                  
81CA76   LDA #$0038               
81CA79   STA $49                  
81CA7B   SEP #$20                 
81CA7D   LDA #$49                 
81CA7F   STA $4D                  
81CA81   LDA #$02                 
81CA83   STA $04                  
81CA85   LDA #$A5                 
81CA87   LDY #$B8                 
81CA89   JSL $8089D7              
81CA8D   LDA #$10                 
81CA8F   STA $30                  
81CA91   DEC $30                  
81CA93   BEQ $81CA98              
81CA95   JMP $CAFA                
81CA98   LDA #$04                 
81CA9A   STA $04                  
81CA9C   LDA #$A5                 
81CA9E   LDY #$AA                 
81CAA0   JSL $8089D7              
81CAA4   STZ $34                  
81CAA6   REP #$20                 
81CAA8   LDA $47                  
81CAAA   SEC                      
81CAAB   SBC $11                  
81CAAD   SEP #$20                 
81CAAF   BPL $81CAB6              
81CAB1   INC $34                  
81CAB3   EOR #$FF                 
81CAB5   INC                      
81CAB6   JSR $D3CD                
81CAB9   LDX $34                  
81CABB   BEQ $81CACB              
81CABD   XBA                      
81CABE   TYA                      
81CABF   REP #$20                 
81CAC1   EOR #$FFFF               
81CAC4   INC                      
81CAC5   STA $28                  
81CAC7   SEP #$20                 
81CAC9   BRA $81CACF              
81CACB   STY $28                  
81CACD   STA $29                  
81CACF   STZ $34                  
81CAD1   REP #$20                 
81CAD3   LDA $49                  
81CAD5   SEC                      
81CAD6   SBC $14                  
81CAD8   SEP #$20                 
81CADA   BPL $81CAE1              
81CADC   INC $34                  
81CADE   EOR #$FF                 
81CAE0   INC                      
81CAE1   JSR $D3CD                
81CAE4   LDX $34                  
81CAE6   BEQ $81CAF6              
81CAE8   XBA                      
81CAE9   TYA                      
81CAEA   REP #$20                 
81CAEC   EOR #$FFFF               
81CAEF   INC                      
81CAF0   STA $2A                  
81CAF2   SEP #$20                 
81CAF4   BRA $81CAFA              
81CAF6   STY $2A                  
81CAF8   STA $2B                  
81CAFA   RTS                      
----------------         
81CAFB   JSL $80C007              
81CAFF   REP #$21                 
81CB01   LDA $16                  
81CB03   ADC $39                  
81CB05   STA $16                  
81CB07   LDA $39                  
81CB09   SEC                      
81CB0A   SBC $4B                  
81CB0C   STA $39                  
81CB0E   SEP #$20                 
81CB10   LDA $17                  
81CB12   BPL $81CB2C              
81CB14   LDA #$2C                 
81CB16   JSL $809A53              
81CB1A   STZ $17                  
81CB1C   LDA #$06                 
81CB1E   STA $04                  
81CB20   LDA #$A5                 
81CB22   LDY #$B8                 
81CB24   JSL $8089D7              
81CB28   LDA #$08                 
81CB2A   STA $30                  
81CB2C   RTS                      
----------------         
81CB2D   DEC $30                  
81CB2F   BNE $81CB40              
81CB31   LDA $40                  
81CB33   STA $03                  
81CB35   LDA $41                  
81CB37   STA $04                  
81CB39   JSR $D262                
81CB3C   LDA #$20                 
81CB3E   STA $30                  
81CB40   RTS                      
----------------         
81CB41   DEC $30                  
81CB43   BNE $81CB55              
81CB45   LDA #$0A                 
81CB47   STA $04                  
81CB49   LDA #$A6                 
81CB4B   LDY #$46                 
81CB4D   JSL $8089D7              
81CB51   LDA #$40                 
81CB53   STA $30                  
81CB55   RTS                      
----------------         
81CB56   JSL $8089DE              
81CB5A   DEC $30                  
81CB5C   BEQ $81CB61              
81CB5E   JMP $CBF3                
81CB61   LDA #$0C                 
81CB63   STA $04                  
81CB65   LDA #$01                 
81CB67   STA $4F                  
81CB69   JSR $D262                
81CB6C   LDA #$80                 
81CB6E   STA $30                  
81CB70   STZ $00FB                
81CB73   LDA #$F0                 
81CB75   STA $35                  
81CB77   LDA #$02                 
81CB79   STA $36                  
81CB7B   JSL $808859              
81CB7F   AND #$07                 
81CB81   TAX                      
81CB82   STX $37                  
81CB84   LDA $A7D7,X              
81CB87   STA $34                  
81CB89   BRA $81CB92              
81CB8B   LDX $37                  
81CB8D   LDA $A7DF,X              
81CB90   STA $34                  
81CB92   JSL $808F73              
81CB96   BCS $81CBD2              
81CB98   LDA #$06                 
81CB9A   STA $0003,X              
81CB9D   STZ $000C,X              
81CBA0   LDA #$0C                 
81CBA2   STA $000A,X              
81CBA5   LDA $34                  
81CBA7   STA $000B,X              
81CBAA   LDA #$68                 
81CBAC   STA $0014,X              
81CBAF   STZ $0015,X              
81CBB2   LDA #$03                 
81CBB4   STA $0000,X              
81CBB7   STA $000D,X              
81CBBA   LDA #$01                 
81CBBC   STA $0012,X              
81CBBF   LDA $35                  
81CBC1   STA $0011,X              
81CBC4   BPL $81CBD5              
81CBC6   LDA #$01                 
81CBC8   STA $000D,X              
81CBCB   LDA #$FF                 
81CBCD   STA $0012,X              
81CBD0   BRA $81CBD5              
--------unidentified--------
81CBD2  .db $EE $FB $00          
----------------         
81CBD5   SEP #$11                 
81CBD7   LDA #$10                 
81CBD9   STA $35                  
81CBDB   DEC $36                  
81CBDD   BNE $81CB8B              
81CBDF   LDA $00FB                
81CBE2   CMP #$02                 
81CBE4   BEQ $81CBF2              
81CBE6   LDA #$20                 
81CBE8   JSL $809A53              
81CBEC   LDA #$31                 
81CBEE   JSL $808660              
81CBF2   RTS                      
----------------         
81CBF3   LDA $30                  
81CBF5   CMP #$3E                 
81CBF7   BNE $81CBFF              
81CBF9   LDA #$01                 
81CBFB   JSL $809A53              
81CBFF   RTS                      
----------------         
81CC00   DEC $30                  
81CC02   BNE $81CC10              
81CC04   LDA #$0E                 
81CC06   STA $04                  
81CC08   LDA #$A6                 
81CC0A   LDY #$6B                 
81CC0C   JSL $8089D7              
81CC10   RTS                      
----------------         
81CC11   JSL $8089DE              
81CC15   LDA $08                  
81CC17   CMP #$40                 
81CC19   BNE $81CC25              
81CC1B   LDA #$10                 
81CC1D   STA $04                  
81CC1F   STZ $33                  
81CC21   LDA #$C8                 
81CC23   BRA $81CC35              
81CC25   RTS                      
----------------         
81CC26   JSL $808859              
81CC2A   AND #$0F                 
81CC2C   TAX                      
81CC2D   LDA $A837,X              
81CC30   BEQ $81CC50              
81CC32   DEC                      
81CC33   BEQ $81CC40              
81CC35   STA $0047                
81CC38   STZ $0048                
81CC3B   LDA #$1A                 
81CC3D   STA $04                  
81CC3F   RTS                      
----------------         
81CC40   LDA $00FB                
81CC43   CMP #$02                 
81CC45   BEQ $81CC57              
81CC47   LDA #$08                 
81CC49   STA $03                  
81CC4B   STA $46                  
81CC4D   JMP $CDAF                
81CC50   LDA $00FB                
81CC53   CMP #$02                 
81CC55   BNE $81CC5E              
81CC57   LDA #$08                 
81CC59   STA $03                  
81CC5B   STA $04                  
81CC5D   RTS                      
----------------         
81CC5E   LDA #$12                 
81CC60   STA $04                  
81CC62   LDA #$A6                 
81CC64   LDY #$BF                 
81CC66   JSL $80BF9F              
81CC6A   LDA #$18                 
81CC6C   STA $30                  
81CC6E   LDA #$A5                 
81CC70   LDY #$C9                 
81CC72   JSL $8089D7              
81CC76   RTS                      
----------------         
81CC77   DEC $30                  
81CC79   BNE $81CCA1              
81CC7B   LDA #$14                 
81CC7D   STA $04                  
81CC7F   INC $1F                  
81CC81   LDA #$14                 
81CC83   STA $1E                  
81CC85   LDA #$A5                 
81CC87   LDY #$D8                 
81CC89   JSL $8089D7              
81CC8D   LDA #$18                 
81CC8F   STA $31                  
81CC91   JSL $808859              
81CC95   AND #$1F                 
81CC97   STA $32                  
81CC99   LDA #$50                 
81CC9B   STA $30                  
81CC9D   LDA #$08                 
81CC9F   STA $2E                  
81CCA1   RTS                      
----------------         
81CCA2   DEC $30                  
81CCA4   BNE $81CCAF              
81CCA6   LDA #$16                 
81CCA8   STA $04                  
81CCAA   LDA #$24                 
81CCAC   STA $30                  
81CCAE   RTS                      
----------------         
81CCAF   JSL $8089DE              
81CCB3   JSR $D392                
81CCB6   JSR $D253                
81CCB9   DEC $31                  
81CCBB   BNE $81CCD9              
81CCBD   JSL $808859              
81CCC1   AND #$0F                 
81CCC3   TAX                      
81CCC4   LDA $A817,X              
81CCC7   STA $31                  
81CCC9   LDX $32                  
81CCCB   LDA $A7F7,X              
81CCCE   STA $43                  
81CCD0   TXA                      
81CCD1   INC                      
81CCD2   AND #$1F                 
81CCD4   STA $32                  
81CCD6   JSR $D410                
81CCD9   RTS                      
----------------         
81CCDA   JSL $8089DE              
81CCDE   JSR $D3B0                
81CCE1   DEC $30                  
81CCE3   BNE $81CCFD              
81CCE5   LDA #$18                 
81CCE7   STA $04                  
81CCE9   STZ $1F                  
81CCEB   LDA #$12                 
81CCED   STA $1E                  
81CCEF   STZ $00C8                
81CCF2   JSL $809A29              
81CCF6   JSR $D262                
81CCF9   LDA #$40                 
81CCFB   STA $30                  
81CCFD   RTS                      
----------------         
81CCFE   DEC $30                  
81CD00   BNE $81CD05              
81CD02   JMP $CC3B                
81CD05   RTS                      
----------------         
81CD06   LDA $00FB                
81CD09   CMP #$02                 
81CD0B   BNE $81CD10              
81CD0D   JMP $CC57                
81CD10   LDA #$1C                 
81CD12   STA $41                  
81CD14   LDA #$28                 
81CD16   STA $4D                  
81CD18   REP #$30                 
81CD1A   LDA #$0300               
81CD1D   STA $39                  
81CD1F   LDA #$0028               
81CD22   STA $4B                  
81CD24   LDA #$00C8               
81CD27   LDY #$0038               
81CD2A   CPY $47                  
81CD2C   BEQ $81CD31              
81CD2E   LDA #$0038               
81CD31   STA $47                  
81CD33   LDA #$0038               
81CD36   STA $49                  
81CD38   SEP #$30                 
81CD3A   LDA #$06                 
81CD3C   STA $03                  
81CD3E   STZ $04                  
81CD40   JMP $CA81                
81CD43   DEC $30                  
81CD45   BNE $81CD58              
81CD47   LDA #$10                 
81CD49   STA $04                  
81CD4B   LDA $33                  
81CD4D   CMP #$03                 
81CD4F   BNE $81CD56              
81CD51   STZ $33                  
81CD53   JMP $CC50                
81CD56   INC $33                  
81CD58   RTS                      
----------------         
--------sub start--------
81CD59   LDX $04                  
81CD5B   JMP ($CD5E,X)            
--------unidentified--------
81CD5E  .db $6A $CD $AF $CD      
----------------         
--------data--------     
81CD62  .db $BB $CD              
----------------         
--------unidentified--------
81CD64  .db $17 $CE              
----------------         
--------data--------     
81CD66  .db $25 $CE $82 $CE      
----------------         
--------unidentified--------
81CD6A  .db $A9 $02 $85 $31 $64 $46 $A9 $02
81CD72  .db $85 $4F $20 $4B $FE $AE $00 $00
81CD7A  .db $A0 $38 $BD $11 $01 $C9 $80 $B0
81CD82  .db $02 $A0 $C8 $84 $47 $64 $48 $A9
81CD8A  .db $49 $85 $4D $A5 $03 $85 $40 $A9
81CD92  .db $02 $85 $41 $C2 $30 $A9 $00 $05
81CD9A  .db $85 $39 $A9 $24 $00 $85 $4B $4C
81CDA2  .db $24 $CD $A5 $03 $85 $40 $A9 $02
81CDAA  .db $85 $41 $4C $14 $CD  
----------------         
81CDAF   LDA #$04                 
81CDB1   STA $04                  
81CDB3   LDA #$A6                 
81CDB5   LDY #$07                 
81CDB7   JSL $8089D7              
81CDBB   JSL $8089DE              
81CDBF   LDA $08                  
81CDC1   CMP #$50                 
81CDC3   BNE $81CE03              
81CDC5   LDA #$18                 
81CDC7   STA $08                  
81CDC9   JSL $8089DE              
81CDCD   JSL $808F8E              
81CDD1   BCS $81CE00              
81CDD3   LDA #$03                 
81CDD5   STA $0000,X              
81CDD8   LDA #$12                 
81CDDA   STA $000A,X              
81CDDD   STA $000B,X              
81CDE0   LDA $11                  
81CDE2   STA $0011,X              
81CDE5   STZ $0012,X              
81CDE8   LDA $14                  
81CDEA   CLC                      
81CDEB   ADC #$24                 
81CDED   STA $0014,X              
81CDF0   STZ $0015,X              
81CDF3   LDA #$10                 
81CDF5   STA $0017,X              
81CDF8   LDA $0C                  
81CDFA   STA $000C,X              
81CDFD   STZ $000D,X              
81CE00   SEP #$10                 
81CE02   RTS                      
----------------         
81CE03   CMP #$60                 
81CE05   BNE $81CE16              
81CE07   LDA $46                  
81CE09   BEQ $81CE12              
81CE0B   LDA #$06                 
81CE0D   STA $03                  
81CE0F   JMP $CD06                
--------unidentified--------
81CE12  .db $A9 $06 $85 $04      
----------------         
81CE16   RTS                      
----------------         
--------unidentified--------
81CE17  .db $C6 $31 $F0 $05 $64 $04 $4C $A4
81CE1F  .db $CD $A9 $08 $85 $04 $60
----------------         
81CE25   LDA #$02                 
81CE27   STA $4F                  
81CE29   LDA #$08                 
81CE2B   STA $40                  
81CE2D   LDA #$0A                 
81CE2F   STA $41                  
81CE31   LDA #$42                 
81CE33   STA $4D                  
81CE35   JSR $FE4B                
81CE38   LDX $0000                
81CE3B   REP #$30                 
81CE3D   LDA $0111,X              
81CE40   TAY                      
81CE41   SEC                      
81CE42   SBC #$0020               
81CE45   BCC $81CE51              
81CE47   SBC #$00C0               
81CE4A   BCC $81CE54              
81CE4C   LDY #$00DF               
81CE4F   BRA $81CE54              
--------unidentified--------
81CE51  .db $A0 $20 $00          
----------------         
81CE54   STY $47                  
81CE56   LDA $0114,X              
81CE59   TAY                      
81CE5A   SEC                      
81CE5B   SBC #$006C               
81CE5E   BCC $81CE6A              
81CE60   SBC #$005C               
81CE63   BCC $81CE6D              
81CE65   LDY #$00C7               
81CE68   BRA $81CE6D              
81CE6A   LDY #$006D               
81CE6D   STY $49                  
81CE6F   LDA #$0700               
81CE72   STA $39                  
81CE74   LDA #$0038               
81CE77   STA $4B                  
81CE79   SEP #$30                 
81CE7B   LDA #$06                 
81CE7D   STA $03                  
81CE7F   JMP $CA81                
81CE82   DEC $30                  
81CE84   BNE $81CE8C              
81CE86   LDA #$02                 
81CE88   STA $03                  
81CE8A   STZ $04                  
81CE8C   RTS                      
----------------         
--------sub start--------
81CE8D   LDX $04                  
81CE8F   JMP ($CE92,X)            
--------data--------     
81CE92  .db $9C $CE $D2 $CE $DE $CE $6B $CF
81CE9A  .db $6C $CF              
----------------         
81CE9C   STZ $33                  
81CE9E   LDA $14                  
81CEA0   CMP #$80                 
81CEA2   BCC $81CECE              
81CEA4   LDA $03                  
81CEA6   STA $40                  
81CEA8   LDA #$02                 
81CEAA   STA $41                  
81CEAC   REP #$20                 
81CEAE   LDA $11                  
81CEB0   STA $47                  
81CEB2   LDA #$0070               
81CEB5   STA $49                  
81CEB7   LDA #$0400               
81CEBA   STA $39                  
81CEBC   LDA #$0028               
81CEBF   STA $4B                  
81CEC1   SEP #$20                 
81CEC3   LDA #$35                 
81CEC5   STA $4D                  
81CEC7   LDA #$06                 
81CEC9   STA $03                  
81CECB   JMP $CA81                
81CECE   LDA #$02                 
81CED0   STA $04                  
81CED2   LDA #$04                 
81CED4   STA $04                  
81CED6   LDA #$A6                 
81CED8   LDY #$85                 
81CEDA   JSL $8089D7              
81CEDE   JSL $8089DE              
81CEE2   LDA $08                  
81CEE4   CMP #$60                 
81CEE6   BNE $81CF62              
81CEE8   LDA #$01                 
81CEEA   STA $08                  
81CEEC   JSL $8089DE              
81CEF0   JSR $FE4B                
81CEF3   LDA #$01                 
81CEF5   XBA                      
81CEF6   LDA $0000                
81CEF9   REP #$10                 
81CEFB   TAX                      
81CEFC   JSL $808B0E              
81CF00   STA $34                  
81CF02   JSL $808859              
81CF06   AND #$07                 
81CF08   TAX                      
81CF09   LDA $A93F,X              
81CF0C   CLC                      
81CF0D   ADC $34                  
81CF0F   CMP #$09                 
81CF11   BCS $81CF15              
81CF13   LDA #$09                 
81CF15   CMP #$18                 
81CF17   BCC $81CF1B              
81CF19   LDA #$17                 
81CF1B   STA $34                  
81CF1D   JSL $808F73              
81CF21   BCS $81CF5E              
81CF23   LDA #$03                 
81CF25   STA $0000,X              
81CF28   LDA #$3C                 
81CF2A   STA $000A,X              
81CF2D   LDA #$02                 
81CF2F   STA $000B,X              
81CF32   STZ $000C,X              
81CF35   LDA $11                  
81CF37   DEC                      
81CF38   DEC                      
81CF39   STA $0011,X              
81CF3C   STZ $0012,X              
81CF3F   LDA $14                  
81CF41   CLC                      
81CF42   ADC #$07                 
81CF44   STA $0014,X              
81CF47   STZ $0015,X              
81CF4A   LDA #$09                 
81CF4C   STA $0017,X              
81CF4F   LDA $34                  
81CF51   STA $000D,X              
81CF54   REP #$20                 
81CF56   TDC                      
81CF57   STA $0036,X              
81CF5A   SEP #$30                 
81CF5C   BRA $81CF62              
--------unidentified--------
81CF5E  .db $E2 $10 $80 $0A      
----------------         
81CF62   CMP #$50                 
81CF64   BNE $81CF6A              
81CF66   LDA #$06                 
81CF68   STA $04                  
81CF6A   RTS                      
----------------         
81CF6B   RTS                      
----------------         
81CF6C   INC $33                  
81CF6E   LDA $33                  
81CF70   CMP #$02                 
81CF72   BCS $81CF77              
81CF74   JMP $CECE                
81CF77   LDA #$02                 
81CF79   STA $03                  
81CF7B   STA $04                  
81CF7D   JMP $D262                
--------sub start--------
81CF80   LDX $04                  
81CF82   CPX #$08                 
81CF84   BNE $81CF8A              
81CF86   LDA $4E                  
81CF88   STA $11                  
81CF8A   JSR ($CFB1,X)            
81CF8D   LDX $04                  
81CF8F   CPX #$08                 
81CF91   BNE $81CFB0              
81CF93   LDA $11                  
81CF95   STA $4E                  
81CF97   LDA $009F                
81CF9A   AND #$03                 
81CF9C   BNE $81CFB0              
81CF9E   LDX #$FE                 
81CFA0   LDA $39                  
81CFA2   AND #$01                 
81CFA4   BEQ $81CFA8              
81CFA6   LDX #$02                 
81CFA8   TXA                      
81CFA9   CLC                      
81CFAA   ADC $11                  
81CFAC   STA $11                  
81CFAE   INC $39                  
81CFB0   RTS                      
----------------         
--------data--------     
81CFB1  .db $BF $CF $EC $CF $0A $D0 $2B $D0
81CFB9  .db $87 $D0 $EA $D0 $0E $D1
----------------         
--------sub start--------
81CFBF   STZ $45                  
81CFC1   LDA $03                  
81CFC3   STA $40                  
81CFC5   LDA #$02                 
81CFC7   STA $41                  
81CFC9   REP #$20                 
81CFCB   LDA #$0400               
81CFCE   STA $39                  
81CFD0   LDA #$0028               
81CFD3   STA $4B                  
81CFD5   LDA #$0080               
81CFD8   STA $47                  
81CFDA   LDA #$0068               
81CFDD   STA $49                  
81CFDF   SEP #$20                 
81CFE1   LDA #$35                 
81CFE3   STA $4D                  
81CFE5   LDA #$06                 
81CFE7   STA $03                  
81CFE9   JMP $CA81                
--------sub start--------
81CFEC   LDA #$04                 
81CFEE   STA $04                  
81CFF0   LDA #$80                 
81CFF2   STA $11                  
81CFF4   STA $4E                  
81CFF6   STZ $10                  
81CFF8   LDA #$68                 
81CFFA   STA $14                  
81CFFC   STZ $13                  
81CFFE   LDA #$A5                 
81D000   LDY #$C9                 
81D002   JSL $8089D7              
81D006   LDA #$10                 
81D008   STA $30                  
--------sub start--------
81D00A   DEC $30                  
81D00C   BNE $81D02A              
81D00E   LDA #$06                 
81D010   STA $04                  
81D012   INC $1F                  
81D014   LDA #$A5                 
81D016   LDY #$D8                 
81D018   JSL $8089D7              
81D01C   LDA #$14                 
81D01E   STA $1E                  
81D020   LDA #$20                 
81D022   STA $30                  
81D024   STZ $39                  
81D026   LDA #$08                 
81D028   STA $2E                  
81D02A   RTS                      
----------------         
--------sub start--------
81D02B   JSL $8089DE              
81D02F   JSR $D392                
81D032   DEC $30                  
81D034   BNE $81D086              
81D036   LDA #$08                 
81D038   STA $04                  
81D03A   JSL $808859              
81D03E   AND #$0F                 
81D040   ASL                      
81D041   TAX                      
81D042   REP #$10                 
81D044   LDY $A847,X              
81D047   STY $4B                  
81D049   REP #$10                 
81D04B   LDX $4B                  
81D04D   LDA $0000,X              
81D050   STA $0D                  
81D052   INC                      
81D053   BNE $81D060              
81D055   SEP #$10                 
81D057   LDA #$0A                 
81D059   STA $04                  
81D05B   LDA #$24                 
81D05D   STA $30                  
81D05F   RTS                      
----------------         
81D060   LDA $0001,X              
81D063   STA $30                  
81D065   LDA $0002,X              
81D068   STA $47                  
81D06A   LDA $0003,X              
81D06D   STA $48                  
81D06F   INX                      
81D070   INX                      
81D071   INX                      
81D072   INX                      
81D073   STX $4B                  
81D075   SEP #$10                 
81D077   LDA $0D                  
81D079   TAX                      
81D07A   LDA $48                  
81D07C   LDY $47                  
81D07E   JSL $809252              
81D082   LDA #$01                 
81D084   STA $31                  
81D086   RTS                      
----------------         
--------sub start--------
81D087   JSR $D253                
81D08A   LDA $31                  
81D08C   BNE $81D094              
81D08E   JSL $80C007              
81D092   BRA $81D096              
81D094   DEC $31                  
81D096   JSL $8089DE              
81D09A   JSR $D392                
81D09D   DEC $30                  
81D09F   BEQ $81D049              
81D0A1   LDA $45                  
81D0A3   BNE $81D0CA              
81D0A5   LDA $14                  
81D0A7   CMP #$80                 
81D0A9   BEQ $81D0B0              
81D0AB   INC                      
81D0AC   CMP #$80                 
81D0AE   BNE $81D0E9              
81D0B0   INC $45                  
81D0B2   JSL $808859              
81D0B6   AND #$0F                 
81D0B8   TAX                      
81D0B9   LDA $A92F,X              
81D0BC   STA $44                  
81D0BE   JSL $808859              
81D0C2   AND #$1F                 
81D0C4   STA $32                  
81D0C6   LDA #$01                 
81D0C8   STA $33                  
81D0CA   DEC $33                  
81D0CC   BNE $81D0E9              
81D0CE   DEC $44                  
81D0D0   BNE $81D0D5              
81D0D2   STZ $45                  
81D0D4   RTS                      
----------------         
81D0D5   LDA #$10                 
81D0D7   STA $33                  
81D0D9   LDX $32                  
81D0DB   LDA $A7F7,X              
81D0DE   STA $43                  
81D0E0   TXA                      
81D0E1   INC                      
81D0E2   AND #$1F                 
81D0E4   STA $32                  
81D0E6   JSR $D410                
81D0E9   RTS                      
----------------         
--------sub start--------
81D0EA   JSL $8089DE              
81D0EE   JSR $D3B0                
81D0F1   DEC $30                  
81D0F3   BNE $81D10D              
81D0F5   LDA #$0C                 
81D0F7   STA $04                  
81D0F9   STZ $00C8                
81D0FC   JSL $809A29              
81D100   STZ $1F                  
81D102   LDA #$50                 
81D104   STA $30                  
81D106   LDA #$12                 
81D108   STA $1E                  
81D10A   JMP $D262                
81D10D   RTS                      
----------------         
--------sub start--------
81D10E   DEC $30                  
81D110   BNE $81D118              
81D112   LDA #$02                 
81D114   STA $03                  
81D116   STZ $04                  
81D118   RTS                      
----------------         
81D119   LDX $03                  
81D11B   JSR ($D129,X)            
81D11E   JSL $808A25              
81D122   JSL $8088CE              
81D126   JMP $C682                
--------data--------     
81D129  .db $31 $D1              
----------------         
--------unidentified--------
81D12B  .db $64 $D1 $88 $FC $A9 $FC
----------------         
--------sub start--------
81D131   LDX $04                  
81D133   JMP ($D136,X)            
--------data--------     
81D136  .db $3A $D1 $4C $D1      
----------------         
81D13A   LDA #$02                 
81D13C   STA $04                  
81D13E   STA $2F                  
81D140   LDA #$A6                 
81D142   LDY #$AE                 
81D144   JSL $8089D7              
81D148   LDA #$18                 
81D14A   STA $30                  
81D14C   DEC $30                  
81D14E   BNE $81D163              
81D150   JSR $D262                
81D153   LDA #$02                 
81D155   STA $02                  
81D157   LDA $40                  
81D159   STA $03                  
81D15B   LDA $41                  
81D15D   STA $04                  
81D15F   STZ $1F                  
81D161   STZ $2F                  
81D163   RTS                      



$A6 $04 $7C
81D167  .db $69 $D1 $73 $D1 $8A $D1 $A3 $D1
81D16F  .db $2D $D2 $52 $D2 $A9 $02 $85 $04
81D177  .db $1A $85 $00 $EE $A8 $00 $A9 $A5
81D17F  .db $A0 $FA $22 $D7 $89 $80 $A9 $40
81D187  .db $85 $30 $60 $C6 $30 $D0 $14 $A2
81D18F  .db $60 $A5 $11 $C9 $80 $B0 $02 $A2
81D197  .db $A0 $86 $0D $A9 $04 $85 $04 $64
81D19F  .db $30 $80 $6F $60 $22 $07 $C0 $80
81D1A7  .db $A9 $02 $85 $34 $64 $35 $A5 $11
81D1AF  .db $C9 $E0 $90 $08 $A9 $DF $85 $11
81D1B7  .db $A5 $34 $04 $35 $06 $34 $A5 $14
81D1BF  .db $C9 $D0 $90 $08 $A9 $CF $85 $14
81D1C7  .db $A5 $34 $04 $35 $06 $34 $A5 $11
81D1CF  .db $C9 $20 $B0 $08 $A9 $21 $85 $11
81D1D7  .db $A5 $34 $04 $35 $A5 $35 $F0 $3C
81D1DF  .db $20 $BF $D2 $A5 $35 $C9 $06 $F0
81D1E7  .db $0C $C9 $0C $F0 $08 $E6 $30 $A5
81D1EF  .db $30 $C9 $02 $90 $1D $A9 $06 $85
81D1F7  .db $04 $A9 $03 $85 $3A $A9 $80 $85
81D1FF  .db $39 $A6 $0D $A9 $04 $A0 $00 $22
81D207  .db $52 $92 $80 $A9 $12 $22 $53 $9A
81D20F  .db $80 $60 $A6 $0D $A9 $0A $A0 $00
81D217  .db $22 $52 $92 $80 $A5 $17 $C9 $18
81D21F  .db $B0 $0B $C2 $21 $A5 $16 $69 $80
81D227  .db $00 $85 $16 $E2 $20 $60 $22 $07
81D22F  .db $C0 $80 $C2 $21 $A5 $16 $65 $39
81D237  .db $85 $16 $A5 $39 $38 $E9 $10 $00
81D23F  .db $85 $39 $E2 $20 $A5 $17 $10 $E5
81D247  .db $A9 $08 $85 $04 $64 $17 $64 $01
81D24F  .db $EE $A8 $00 $60 

81D253   DEC $2E                  
81D255   BNE $81D261              
81D257   LDA #$08                 
81D259   STA $2E                  
81D25B   LDA #$24                 
81D25D   JSL $809A50              
81D261   RTS                      
----------------         
--------sub start--------
81D262   LDA #$A5                 
81D264   LDY #$9B                 
81D266   JSL $8089D7              
81D26A   RTS                      
----------------         
--------sub start--------
81D26B   JSL $808F8E              
81D26F   BCS $81D288              
81D271   LDA #$03                 
81D273   STA $0000,X              
81D276   LDA #$0C                 
81D278   STA $000A,X              
81D27B   STZ $000B,X              
81D27E   LDA #$80                 
81D280   STA $0011,X              
81D283   LDA #$20                 
81D285   STA $0014,X              
81D288   SEP #$10                 
81D28A   RTS                      
----------------         
--------sub start--------
81D28B   LDA $0D                  
81D28D   STA $36                  
81D28F   LDA #$01                 
81D291   STA $34                  
81D293   STZ $35                  
81D295   STZ $0D                  
81D297   LDA #$A7                 
81D299   LDY #$A7                 
81D29B   LDX #$02                 
81D29D   JSR $9782                
81D2A0   BEQ $81D2AD              
81D2A2   LDA $34                  
81D2A4   ORA $35                  
81D2A6   STA $35                  
81D2A8   LDA $0D                  
81D2AA   JSR $D349                
81D2AD   ASL $34                  
81D2AF   INC $0D                  
81D2B1   LDA $0D                  
81D2B3   CMP #$04                 
81D2B5   BNE $81D297              
81D2B7   LDA $36                  
81D2B9   STA $0D                  
81D2BB   LDA $35                  
81D2BD   BEQ $81D2D9              
81D2BF   ASL                      
81D2C0   TAX                      
81D2C1   JSR ($D2DA,X)            
81D2C4   LDA $0D                  
81D2C6   CMP $36                  
81D2C8   BEQ $81D2D9              
81D2CA   LDA $31                  
81D2CC   TAX                      
81D2CD   LDA $A790,X              
81D2D0   LDY $A78F,X              
81D2D3   LDX $0D                  
81D2D5   JSL $809252              
81D2D9   RTS                      
----------------         
--------unidentified--------
81D2DA  .db $48 $D3              
----------------         
--------data--------     
81D2DC  .db $F8 $D2 $06 $D3      
----------------         
--------unidentified--------
81D2E0  .db $16 $D3              
----------------         
--------data--------     
81D2E2  .db $1B $D3              
----------------         
--------unidentified--------
81D2E4  .db $48 $D3 $29 $D3 $48 $D3
----------------         
--------data--------     
81D2EA  .db $2E $D3              
----------------         
--------unidentified--------
81D2EC  .db $3E $D3 $48 $D3 $48 $D3 $43 $D3
81D2F4  .db $48 $D3 $48 $D3      
----------------         
--------sub start--------
81D2F8   LDA $0D                  
81D2FA   BNE $81D301              
81D2FC   LDA #$80                 
81D2FE   STA $0D                  
81D300   RTS                      
----------------         
81D301   EOR #$40                 
81D303   STA $0D                  
81D305   RTS                      
----------------         
--------sub start--------
81D306   LDA $0D                  
81D308   CMP #$40                 
81D30A   BNE $81D311              
81D30C   LDA #$C0                 
81D30E   STA $0D                  
81D310   RTS                      
----------------         
--------unidentified--------
81D311  .db $49 $C0 $85 $0D $60 $A9 $A0 $85
81D319  .db $0D $60              
----------------         
--------sub start--------
81D31B   LDA $0D                  
81D31D   CMP #$80                 
81D31F   BNE $81D324              
81D321   STZ $0D                  
81D323   RTS                      
----------------         
--------unidentified--------
81D324  .db $49 $40 $85 $0D $60 $A9 $E0 $85
81D32C  .db $0D $60              
----------------         
--------sub start--------
81D32E   LDA $0D                  
81D330   CMP #$C0                 
81D332   BNE $81D339              
81D334   LDA #$40                 
81D336   STA $0D                  
81D338   RTS                      
----------------         
--------unidentified--------
81D339  .db $49 $C0 $85 $0D $60 $A9 $60 $85
81D341  .db $0D $60 $A9 $20 $85 $0D $60 $60
----------------         
--------sub start--------
81D349   ASL                      
81D34A   TAX                      
81D34B   JMP ($D34E,X)            
--------data--------     
81D34E  .db $56 $D3 $66 $D3 $74 $D3 $82 $D3
----------------         
81D356   LDA $14                  
81D358   SEC                      
81D359   SBC #$08                 
81D35B   AND #$07                 
81D35D   EOR #$07                 
81D35F   INC                      
81D360   CLC                      
81D361   ADC $14                  
81D363   STA $14                  
81D365   RTS                      
----------------         
81D366   LDA #$10                 
81D368   CLC                      
81D369   ADC $11                  
81D36B   AND #$F8                 
81D36D   DEC                      
81D36E   SEC                      
81D36F   SBC #$10                 
81D371   STA $11                  
81D373   RTS                      
----------------         
81D374   LDA #$08                 
81D376   CLC                      
81D377   ADC $14                  
81D379   AND #$F8                 
81D37B   DEC                      
81D37C   SEC                      
81D37D   SBC #$08                 
81D37F   STA $14                  
81D381   RTS                      
----------------         
81D382   LDA $11                  
81D384   SEC                      
81D385   SBC #$10                 
81D387   AND #$07                 
81D389   EOR #$07                 
81D38B   INC                      
81D38C   CLC                      
81D38D   ADC $11                  
81D38F   STA $11                  
81D391   RTS                      
----------------         
--------sub start--------
81D392   LDA $08                  
81D394   CMP $3B                  
81D396   BCS $81D3A0              
81D398   LDA #$01                 
81D39A   STA $08                  
81D39C   JSL $8089DE              
81D3A0   LDA $3B                  
81D3A2   CMP #$06                 
81D3A4   BEQ $81D3AF              
81D3A6   LDA $009F                
81D3A9   AND #$03                 
81D3AB   BNE $81D3AF              
81D3AD   INC $3B                  
81D3AF   RTS                      
----------------         
--------sub start--------
81D3B0   LDA $08                  
81D3B2   CMP $3B                  
81D3B4   BCS $81D3BE              
81D3B6   LDA #$01                 
81D3B8   STA $08                  
81D3BA   JSL $8089DE              
81D3BE   LDA $3B                  
81D3C0   DEC                      
81D3C1   BEQ $81D3CC              
81D3C3   LDA $009F                
81D3C6   AND #$03                 
81D3C8   BNE $81D3CC              
81D3CA   DEC $3B                  
81D3CC   RTS                      
----------------         
--------sub start--------
81D3CD   STZ $4204                
81D3D0   STA $4205                
81D3D3   LDA $4D                  
81D3D5   STA $4206                
81D3D8   NOP                      
81D3D9   NOP                      
81D3DA   NOP                      
81D3DB   NOP                      
81D3DC   NOP                      
81D3DD   NOP                      
81D3DE   NOP                      
81D3DF   NOP                      
81D3E0   LDY $4214                
81D3E3   LDA $4215                
81D3E6   RTS                      
----------------         
--------unidentified--------
81D3E7  .db $C2 $10 $A2 $00 $02 $A0 $00 $00
81D3EF  .db $BD $0A $00 $C9 $0C $D0 $05 $BD
81D3F7  .db $00 $00 $D0 $11 $C2 $21 $8A $69
81D3FF  .db $50 $00 $AA $E2 $20 $E0 $80 $09
81D407  .db $D0 $E6 $E2 $11 $60 $E2 $10 $18
81D40F  .db $60                  
----------------         
--------sub start--------
81D410   JSL $808F8E              
81D414   BCS $81D44A              
81D416   LDA #$03                 
81D418   STA $0000,X              
81D41B   LDA #$0A                 
81D41D   STA $0003,X              
81D420   STZ $000A,X              
81D423   LDA $11                  
81D425   STA $0011,X              
81D428   STZ $0012,X              
81D42B   LDA $14                  
81D42D   CLC                      
81D42E   ADC #$0C                 
81D430   STA $0014,X              
81D433   STZ $0015,X              
81D436   LDA #$2E                 
81D438   STA $0017,X              
81D43B   LDA $0C                  
81D43D   STA $000C,X              
81D440   LDA #$0A                 
81D442   STA $000B,X              
81D445   LDA $43                  
81D447   STA $000D,X              
81D44A   SEP #$10                 
81D44C   RTS                      
----------------         
81D44D   LDX $02                  
81D44F   JMP ($D452,X)            
--------data--------     
81D452  .db $5A $D4 $75 $D4      
----------------         
--------unidentified--------
81D456  .db $78 $D7              
----------------         
--------data--------     
81D458  .db $78 $D7              
----------------         
81D45A   LDA #$02                 
81D45C   STA $02                  
81D45E   STZ $04                  
81D460   STA $01                  
81D462   DEC                      
81D463   STA $00                  
81D465   LDA #$3F                 
81D467   STA $1B                  
81D469   LDA $0B                  
81D46B   STA $03                  
81D46D   LDA #$C0                 
81D46F   STA $1A                  
81D471   LDA #$0E                 
81D473   STA $1E                  
81D475   LDX $03                  
81D477   JSR ($D47F,X)            
81D47A   JSL $8088CE              
81D47E   RTS                      
----------------         
--------data--------     
81D47F  .db $8B $D4 $D8 $D4 $60 $D6 $C8 $D6
81D487  .db $ED $D6              
----------------         
--------unidentified--------
81D489  .db $65 $D7              
----------------         
--------sub start--------
81D48B   LDX $04                  
81D48D   JMP ($D490,X)            
--------data--------     
81D490  .db $94 $D4 $A6 $D4      
----------------         
81D494   LDA #$02                 
81D496   STA $04                  
81D498   STZ $0E                  
81D49A   STZ $12                  
81D49C   STZ $15                  
81D49E   LDA #$A9                 
81D4A0   LDY #$C3                 
81D4A2   JSL $8089A3              
81D4A6   REP #$11                 
81D4A8   LDX $36                  
81D4AA   LDA $0001,X              
81D4AD   BEQ $81D4D3              
81D4AF   LDY $0006,X              
81D4B2   CPY #$A59B               
81D4B5   BEQ $81D4BC              
81D4B7   CPY #$A6AE               
81D4BA   BNE $81D4D3              
81D4BC   LDA $0011,X              
81D4BF   ADC #$EE                 
81D4C1   STA $11                  
81D4C3   LDA $0014,X              
81D4C6   INC                      
81D4C7   STA $14                  
81D4C9   LDA #$07                 
81D4CB   STA $17                  
81D4CD   LDA #$02                 
81D4CF   STA $01                  
81D4D1   BRA $81D4D5              
81D4D3   STZ $01                  
81D4D5   SEP #$10                 
81D4D7   RTS                      
----------------         
--------sub start--------
81D4D8   LDX $04                  
81D4DA   JMP ($D4DD,X)            
--------data--------     
81D4DD  .db $E9 $D4 $77 $D5 $A6 $D5
----------------         
--------unidentified--------
81D4E3  .db $9A $D5              
----------------         
--------data--------     
81D4E5  .db $EF $D5 $06 $D6      
----------------         
81D4E9   LDA #$02                 
81D4EB   STA $04                  
81D4ED   STZ $1F                  
81D4EF   LDA #$A9                 
81D4F1   LDY #$B7                 
81D4F3   JSL $8089A3              
81D4F7   LDA #$08                 
81D4F9   STA $31                  
81D4FB   REP #$21                 
81D4FD   TDC                      
81D4FE   ADC #$0040               
81D501   STA $32                  
81D503   SEP #$20                 
81D505   JSL $808F73              
81D509   BCS $81D554              
81D50B   LDA #$3C                 
81D50D   STA $000A,X              
81D510   LDA #$03                 
81D512   STA $0000,X              
81D515   STZ $000C,X              
81D518   LDA #$04                 
81D51A   STA $000B,X              
81D51D   LDA $31                  
81D51F   DEC                      
81D520   BNE $81D52C              
81D522   LDA #$06                 
81D524   STA $000B,X              
81D527   LDA $0D                  
81D529   STA $000D,X              
81D52C   LDA $11                  
81D52E   STA $0011,X              
81D531   STA $3D                  
81D533   STZ $0012,X              
81D536   LDA $14                  
81D538   STA $0014,X              
81D53B   INC                      
81D53C   STA $3E                  
81D53E   STZ $0015,X              
81D541   LDA #$09                 
81D543   STA $0017,X              
81D546   REP #$20                 
81D548   LDY $32                  
81D54A   TXA                      
81D54B   STA $0000,Y              
81D54E   INY                      
81D54F   INY                      
81D550   STY $32                  
81D552   BRA $81D55C              
--------unidentified--------
81D554  .db $A4 $32 $9E $00 $00 $9E $01 $00
----------------         
81D55C   SEP #$30                 
81D55E   DEC $31                  
81D560   BNE $81D505              
81D562   LDA $0D                  
81D564   ASL                      
81D565   ASL                      
81D566   ASL                      
81D567   STA $0D                  
81D569   LDA #$00                 
81D56B   STA $30                  
81D56D   LDA #$90                 
81D56F   STA $2F                  
81D571   JSR $D7F4                
81D574   JMP $D7C5                
81D577   JSR $D77D                
81D57A   JSR $D790                
81D57D   JSR $D7F4                
81D580   JSL $80C007              
81D584   JSR $D7C5                
81D587   REP #$21                 
81D589   LDA $2F                  
81D58B   SBC #$0002               
81D58E   STA $2F                  
81D590   SEP #$20                 
81D592   LDA $30                  
81D594   BPL $81D5A5              
81D596   STZ $30                  
81D598   STZ $2F                  
81D59A   LDA #$04                 
81D59C   STA $04                  
--------sub start--------
81D59E   LDA $0D                  
81D5A0   CLC                      
81D5A1   ADC #$80                 
81D5A3   STA $0D                  
81D5A5   RTS                      
----------------         
81D5A6   JSR $D77D                
81D5A9   JSR $D790                
81D5AC   JSR $D7F4                
81D5AF   JSL $80C007              
81D5B3   JSR $D7C5                
81D5B6   REP #$21                 
81D5B8   LDA $2F                  
81D5BA   ADC #$0003               
81D5BD   STA $2F                  
81D5BF   CMP #$0090               
81D5C2   SEP #$20                 
81D5C4   BCC $81D5EE              
--------sub start--------
81D5C6   LDA #$06                 
81D5C8   STA $02                  
81D5CA   LDX #$00                 
81D5CC   REP #$10                 
81D5CE   LDY $40,X                
81D5D0   BEQ $81D5D9              
81D5D2   LDA #$04                 
81D5D4   STA $0004,Y              
81D5D7   INX                      
81D5D8   INX                      
81D5D9   CPX #$0010               
81D5DC   BNE $81D5CC              
81D5DE   LDX $36                  
81D5E0   LDA $0000,X              
81D5E3   CMP #$03                 
81D5E5   BEQ $81D5EC              
81D5E7   LDA #$08                 
81D5E9   STA $0004,X              
81D5EC   SEP #$10                 
81D5EE   RTS                      
----------------         
81D5EF   LDA #$0A                 
81D5F1   STA $04                  
81D5F3   LDA #$00                 
81D5F5   LDY #$20                 
81D5F7   LDX $0D                  
81D5F9   JSL $809252              
81D5FD   REP #$10                 
81D5FF   LDX $36                  
81D601   INC $0033,X              
81D604   SEP #$10                 
81D606   JSR $D77D                
81D609   JSR $D7B0                
81D60C   JSL $80C007              
81D610   JSR $D7C5                
81D613   LDA $14                  
81D615   CMP $3E                  
81D617   BCS $81D65F              
81D619   LDY $11                  
81D61B   LDA $0D                  
81D61D   BPL $81D625              
81D61F   DEY                      
81D620   CPY $3D                  
81D622   BCC $81D629              
81D624   RTS                      
----------------         
81D625   CPY $3D                  
81D627   BCC $81D65F              
81D629   JSR $D5C6                
81D62C   LDX $3C                  
81D62E   LDA $012C,X              
81D631   BEQ $81D65F              
81D633   LDA $0100,X              
81D636   DEC                      
81D637   BNE $81D65F              
81D639   LDA $011D,X              
81D63C   BEQ $81D646              
81D63E   STZ $011D,X              
81D641   STZ $013F,X              
81D644   BRA $81D64E              
--------unidentified--------
81D646  .db $9E $1C $01 $A9 $02 $9D $0D $01
----------------         
81D64E   INC $0100,X              
81D651   LDA #$04                 
81D653   STA $0102,X              
81D656   STZ $0103,X              
81D659   STZ $0104,X              
81D65C   STZ $0105,X              
81D65F   RTS                      
----------------         
--------sub start--------
81D660   LDX $04                  
81D662   JMP ($D665,X)            
--------data--------     
81D665  .db $6B $D6 $7E $D6 $C3 $D6
----------------         
81D66B   STZ $1F                  
81D66D   LDA #$A9                 
81D66F   LDY #$B7                 
81D671   JSL $8089A3              
81D675   LDA #$02                 
81D677   STA $04                  
81D679   STA $01                  
81D67B   DEC                      
81D67C   STA $00                  
81D67E   JSL $80C007              
81D682   LDA $012C                
81D685   BNE $81D68C              
81D687   LDA $01AC                
81D68A   BEQ $81D6C2              
81D68C   LDA $0B                  
81D68E   CMP #$10                 
81D690   BNE $81D6C2              
81D692   LDX $3C                  
81D694   REP #$30                 
81D696   LDA $11                  
81D698   TAY                      
81D699   SEC                      
81D69A   SBC #$0016               
81D69D   BCC $81D6A9              
81D69F   SBC #$00D5               
81D6A2   BCC $81D6AC              
81D6A4   LDY #$00EA               
81D6A7   BRA $81D6AC              
--------unidentified--------
81D6A9  .db $A0 $17 $00          
----------------         
81D6AC   TYA                      
81D6AD   STA $0111,X              
81D6B0   LDA $14                  
81D6B2   INC                      
81D6B3   TAY                      
81D6B4   CMP #$00CD               
81D6B7   BCC $81D6BC              
81D6B9   LDY #$00CC               
81D6BC   TYA                      
81D6BD   STA $0114,X              
81D6C0   SEP #$30                 
81D6C2   RTS                      
----------------         
81D6C3   LDA #$06                 
81D6C5   STA $02                  
81D6C7   RTS                      
----------------         
--------sub start--------
81D6C8   LDA #$04                 
81D6CA   STA $03                  
81D6CC   STA $1F                  
81D6CE   LDA #$10                 
81D6D0   STA $1E                  
81D6D2   LDA #$10                 
81D6D4   STA $0B                  
81D6D6   LDA $0D                  
81D6D8   TAX                      
81D6D9   LDA $A99F,X              
81D6DC   STA $0E                  
81D6DE   TXA                      
81D6DF   ASL                      
81D6E0   TAX                      
81D6E1   LDA $A96D,X              
81D6E4   LDY $A96C,X              
81D6E7   JSL $8089A3              
81D6EB   BRA $81D675              
--------sub start--------
81D6ED   LDX $04                  
81D6EF   JMP ($D6F2,X)            
--------data--------     
81D6F2  .db $F6 $D6 $02 $D7      
----------------         
81D6F6   LDA #$02                 
81D6F8   STA $04                  
81D6FA   STZ $0E                  
81D6FC   STZ $12                  
81D6FE   STZ $15                  
81D700   STZ $1A                  
81D702   REP #$11                 
81D704   LDX $36                  
81D706   LDA $0001,X              
81D709   BEQ $81D760              
81D70B   LDA $002F,X              
81D70E   BEQ $81D760              
81D710   REP #$20                 
81D712   LDY #$0000               
81D715   LDA $0006,X              
81D718   CMP $A9EF,Y              
81D71B   BNE $81D729              
81D71D   TYA                      
81D71E   LSR                      
81D71F   TAY                      
81D720   LDA $A9FD,Y              
81D723   AND #$00FF               
81D726   TAY                      
81D727   BRA $81D734              
--------unidentified--------
81D729  .db $C8 $C8 $C0 $0E $00 $D0 $E8 $E2
81D731  .db $20 $80 $2C          
----------------         
81D734   SEP #$21                 
81D736   LDA $0011,X              
81D739   CLC                      
81D73A   ADC $A9E5,Y              
81D73D   STA $11                  
81D73F   LDA $0014,X              
81D742   INC                      
81D743   STA $14                  
81D745   LDA $0017,X              
81D748   CLC                      
81D749   ADC $A9E6,Y              
81D74C   STA $17                  
81D74E   LDA #$02                 
81D750   STA $01                  
81D752   SEP #$10                 
81D754   LDA $A9C8,Y              
81D757   LDX $A9C7,Y              
81D75A   TXY                      
81D75B   JSL $8089A3              
81D75F   RTS                      
----------------         
81D760   STZ $01                  
81D762   SEP #$10                 
81D764   RTS                      
----------------         
--------unidentified--------
81D765  .db $C2 $10 $A2 $00 $01 $22 $0E $8B
81D76D  .db $80 $EA $A9 $A9 $A0 $B7 $22 $A3
81D775  .db $89 $80 $60          
----------------         
81D778   JSL $808F1E              
81D77C   RTS                      
----------------         
--------sub start--------
81D77D   REP #$10                 
81D77F   LDX $36                  
81D781   LDA $0000,X              
81D784   CMP #$03                 
81D786   SEP #$10                 
81D788   BNE $81D78F              
81D78A   PLA                      
81D78B   PLA                      
81D78C   JMP $D5C6                
81D78F   RTS                      
----------------         
--------sub start--------
81D790   LDX #$00                 
81D792   LDA $012C,X              
81D795   BNE $81D79E              
81D797   LDX #$80                 
81D799   LDA $012C,X              
81D79C   BEQ $81D7AF              
81D79E   STX $3C                  
81D7A0   LDA $04                  
81D7A2   CMP #$04                 
81D7A4   BEQ $81D7A9              
81D7A6   JSR $D59E                
81D7A9   LDA #$08                 
81D7AB   STA $04                  
81D7AD   PLA                      
81D7AE   PLA                      
81D7AF   RTS                      
----------------         
--------sub start--------
81D7B0   LDA $012C                
81D7B3   BNE $81D7C4              
81D7B5   LDA $01AC                
81D7B8   BNE $81D7C4              
81D7BA   LDA #$00                 
81D7BC   LDY #$B0                 
81D7BE   LDX $0D                  
81D7C0   JSL $809252              
81D7C4   RTS                      
----------------         
--------sub start--------
81D7C5   REP #$31                 
81D7C7   LDX #$0000               
81D7CA   LDA $28                  
81D7CC   STA $38                  
81D7CE   LDA $2A                  
81D7D0   STA $3A                  
81D7D2   LDY $40,X                
81D7D4   BEQ $81D7EC              
81D7D6   LDA $28                  
81D7D8   CLC                      
81D7D9   ADC $38                  
81D7DB   STA $38                  
81D7DD   STA $0028,Y              
81D7E0   LDA $2A                  
81D7E2   CLC                      
81D7E3   ADC $3A                  
81D7E5   STA $3A                  
81D7E7   STA $002A,Y              
81D7EA   INX                      
81D7EB   INX                      
81D7EC   CPX #$0010               
81D7EF   BNE $81D7D2              
81D7F1   SEP #$30                 
81D7F3   RTS                      
----------------         
--------sub start--------
81D7F4   LDA $30                  
81D7F6   LDY $2F                  
81D7F8   LDX $0D                  
81D7FA   JSL $809252              
81D7FE   RTS                      


;0x3E Sword Sprite (green pirate projectile) 
81D7FF   LDX $02  
81D801   JMP ($D804,X)
--------data--------     
81D804  .db $0C $D8 $56 $D8 $7E $D8 $A3 $D8
----------------   
81D80C   LDA #$02 
81D80E   STA $02  
81D810   DEC
81D811   STA $00  
81D813   STA $01  
81D815   LDA #$3F 
81D817   STA $1B  
81D819   LDA $00B6
81D81C   CMP #$02 
81D81E   BNE $81D82A  
81D820   LDA #$AA 
81D822   LDY #$67 
81D824   JSL $80896D  
81D828   BRA $81D836  
81D82A   CMP #$03 
81D82C   BNE $81D836  
81D82E   LDA #$AA 
81D830   LDY #$6D 
81D832   JSL $80896D  
81D836   CMP #$04 
81D838   BNE $81D83E  
81D83A   LDA #$3F 
81D83C   STA $1B  
81D83E   LDA #$40 
81D840   STA $1A  
81D842   LDA #$AA 
81D844   LDY #$04 
81D846   JSL FrameAnimationNoTimer ; $8089A3  
81D84A   LDA #$AA 
81D84C   LDY #$22 
81D84E   JSL Sprite_SetSpeeds ; 80BF9F  
81D852   LDA #$68 
81D854   STA $3F  
81D856   LDA $00AC
81D859   BNE $81D879  
81D85B   JSL FrameAnimationTimer; 8089A9  
81D85F   JSL MoveSprite ; 80C007  
81D863   DEC $3F  
81D865   BNE $81D86E  
81D867   LDA #$04 
81D869   STA $02  
81D86B   STZ $03  
81D86D   RTS
----------------   
81D86E   REP #$21 
81D870   LDA $16  
81D872   SBC #$001F   
81D875   STA $16  
81D877   SEP #$20 
81D879   JSL SpriteSaveDirectPage ; 8088CE  
81D87D   RTS
----------------   
81D87E   LDA $03  
81D880   BNE $81D890  
81D882   LDA #$03 
81D884   STA $00  
81D886   STA $03  
81D888   LDA #$AA 
81D88A   LDY #$16 
81D88C   JSL FrameAnimationNoTimer ; $8089A3  
81D890   JSL FrameAnimationTimer; 8089A9  
81D894   LDA $08  
81D896   CMP #$70 
81D898   BNE $81D89E  
81D89A   LDA #$06 
81D89C   STA $02  
81D89E   JSL SpriteSaveDirectPage ; 8088CE  
81D8A2   RTS
----------------   
81D8A3   JSL KillSprite ; 808F1E  
81D8A7   RTS


;Sprite 0x40 Boulders Bouncing
81D8A8   LDX $02                  
81D8AA   JMP ($D8AD,X)            
--------data--------     
81D8AD  .db $B5 $D8 $03 $D9 $47 $D9
----------------         
--------unidentified--------
81D8B3  .db $47 $D9              
----------------         
81D8B5   LDA #$02                 
81D8B7   STA $02                  
81D8B9   STA $01                  
81D8BB   DEC                      
81D8BC   STA $00                  
81D8BE   LDA #$3D                 
81D8C0   STA $1B                  
81D8C2   STZ $0E                  
81D8C4   LDA #$40                 
81D8C6   STA $1A                  
81D8C8   LDA #$AA                 
81D8CA   LDY #$8A                 
81D8CC   JSL $80BF9F              
81D8D0   LDA #$AA                 
81D8D2   LDY #$73                 
81D8D4   JSL $8089A3              
81D8D8   LDA #$C8                 
81D8DA   STA $4E                  
81D8DC   REP #$20                 
81D8DE   LDA #$0400               
81D8E1   STA $4C                  
81D8E3   SEP #$20                 
81D8E5   JSL $808F73 ;Get next empty sprite?
81D8E9   BCS $81D900              
81D8EB   LDA #$03                 
81D8ED   STA $0000,X              
81D8F0   LDA #$4E                 
81D8F2   STA $000A,X              
81D8F5   LDA #$06                 
81D8F7   STA $000B,X              
81D8FA   REP #$20                 
81D8FC   TDC                      
81D8FD   STA $0030,X              
81D900   SEP #$30                 
81D902   RTS                      
----------------         
81D903   LDX $03                  
81D905   JSR ($D911,X)            
81D908   JSL $8089A9              
81D90C   JSL $8088CE              
81D910   RTS                      
----------------         
--------data--------     
81D911  .db $13 $D9              
----------------         
--------sub start--------
81D913   DEC $4E                  
81D915   BNE $81D91C              
81D917   LDA #$04                 
81D919   STA $02                  
81D91B   RTS                      
----------------         
81D91C   REP #$21                 
81D91E   LDA $16                  
81D920   ADC $4C                  
81D922   BPL $81D936              
81D924   SEP #$20                 
81D926   LDA #$19                 
81D928   JSL $809A53              
81D92C   REP #$20                 
81D92E   LDA #$0400               
81D931   STA $4C                  
81D933   LDA #$0000               
81D936   STA $16                  
81D938   LDA $4C                  
81D93A   SEC                      
81D93B   SBC #$0020               
81D93E   STA $4C                  
81D940   SEP #$20                 
81D942   JSL $80C007              
81D946   RTS                      
----------------         
81D947   JSL $808F1E              
81D94B   RTS                      

;0x42 Order Switches Sprite      
81D94C   LDX $02                  
81D94E   JMP ($D951,X)            
  
81D951 
dw $D957 ;Init
dw $D988
dw $D9CB 
       
81D957   LDA $0D ;Check subtype
81D959   CMP #$04                 
81D95B   BNE $81D964
81D95D   LDA #$04                 
81D95F   STA $02                  
81D961   JMP $D9CB 
;Subtype04:               
81D964   LDA #$02                 
81D966   STA $02                  
81D968   LDA $11                  
81D96A   LSR                      
81D96B   LSR                      
81D96C   LSR                      
81D96D   STA $3E                  
81D96F   STZ $3F                  
81D971   REP #$20                 
81D973   LDA $14                  
81D975   AND #$00F8               
81D978   ASL                      
81D979   ASL                      
81D97A   ADC $3E                  
81D97C   ADC #$4FDF               
81D97F   STA $3E                  
81D981   STA $0010                
81D984   SEP #$20                 
81D986   BRA $81D998  

81D988   LDX $0D                  
81D98A   LDA $00FC                
81D98D   BIT $80B8,X              
81D990   BNE $81D9A5              
81D992   LDA $03                  
81D994   BEQ $81D9CA              
81D996   STZ $03                  
81D998   LDA #$04                 
81D99A   LDX $0B                  
81D99C   BEQ $81D9A3              
81D99E   LDA #$06                 
81D9A0   CLC                      
81D9A1   ADC $0D                  
81D9A3   BRA $81D9BC              
81D9A5   LDA $03                  
81D9A7   BNE $81D9CA              
81D9A9   LDA #$07                 
81D9AB   JSL $809A53              
81D9AF   INC $03                  
81D9B1   LDA #$05                 
81D9B3   LDX $0B                  
81D9B5   BEQ $81D9BC              
81D9B7   LDA #$0A                 
81D9B9   CLC                      
81D9BA   ADC $0D                  
81D9BC   LDX $3E                  
81D9BE   STX $0010                
81D9C1   LDX $3F                  
81D9C3   STX $0011                
81D9C6   JSL $808D7B              
81D9CA   RTS                      

       
81D9CB   LDX $03                  
81D9CD   JMP ($D9D0,X)            

81D9D0  
dw $D9D8
dw $DA04
dw $DA50
dw $DAA3

81D9D8   LDA #$02                 
81D9DA   STA $03                  
81D9DC   STZ $3D                  
81D9DE   STZ $00FC                
81D9E1   LDA $0B                  
81D9E3   ASL                      
81D9E4   ASL                      
81D9E5   TAY                      
81D9E6   LDX #$00                 
81D9E8   STZ $40,X                
81D9EA   LDA $AA92,Y              
81D9ED   CLC                      
81D9EE   ADC #$05                 
81D9F0   STA $41,X                
81D9F2   LDA $AA93,Y              
81D9F5   CLC                      
81D9F6   ADC #$05                 
81D9F8   STA $42,X                
81D9FA   INX                      
81D9FB   INX                      
81D9FC   INX                      
81D9FD   INY                      
81D9FE   INY                      
81D9FF   CPX #$0C                 
81DA01   BCC $81D9E8              
81DA03   RTS                      


81DA04   LDX #$00                 
81DA06   STZ $3E                  
81DA08   LDA $40,X                
81DA0A   BNE $81DA1D              
81DA0C   LDY #$00                 
81DA0E   JSR $DA84                
81DA11   BCS $81DA1A              
81DA13   LDY #$80                 
81DA15   JSR $DA84                
81DA18   BCC $81DA1D              
81DA1A   JSR $DA27                
81DA1D   INC $3E                  
81DA1F   INX                      
81DA20   INX                      
81DA21   INX                      
81DA22   CPX #$0C                 
81DA24   BCC $81DA08              
81DA26   RTS                      
----------------         
--------sub start--------
81DA27   LDA #$01                 
81DA29   STA $40,X                
81DA2B   PHX                      
81DA2C   LDX $3E                  
81DA2E   LDA $80B8,X              
81DA31   TSB $00FC                
81DA34   PLX                      
81DA35   LDA $3E                  
81DA37   CMP $3D                  
81DA39   BNE $81DA4B              
81DA3B   INC                      
81DA3C   STA $3D                  
81DA3E   CMP #$04                 
81DA40   BCC $81DA4A              
81DA42   LDA #$06                 
81DA44   STA $03                  
81DA46   LDA #$10                 
81DA48   STA $0F                  
81DA4A   RTS                      
----------------         
--------unidentified--------
81DA4B  .db $A9 $04 $85 $03 $60 $A2 $00 $64
81DA53  .db $3E $64 $3F $A0 $00 $20 $84 $DA
81DA5B  .db $B0 $07 $A0 $80 $20 $84 $DA $90
81DA63  .db $10 $A9 $01 $95 $40 $DA $A6 $3E
81DA6B  .db $BD $B8 $80 $0C $FC $00 $85 $3F
81DA73  .db $FA $E6 $3E $E8 $E8 $E8 $E0 $0C
81DA7B  .db $90 $D9 $A5 $3F $D0 $02 $64 $03
81DA83  .db $60                  
----------------         
--------sub start--------
81DA84   LDA $0100,Y              
81DA87   AND #$03                 
81DA89   BEQ $81DAA1              
81DA8B   LDA $41,X                
81DA8D   SEC                      
81DA8E   SBC $0111,Y              
81DA91   CMP #$0C                 
81DA93   BCS $81DAA1              
81DA95   LDA $42,X                
81DA97   SEC                      
81DA98   SBC $0114,Y              
81DA9B   CMP #$0C                 
81DA9D   BCS $81DAA1              
81DA9F   SEC                      
81DAA0   RTS                      
----------------         
81DAA1   CLC                      
81DAA2   RTS                      
----------------         
81DAA3   DEC $0F                  
81DAA5   BNE $81DACD              
81DAA7   LDA #$21                 
81DAA9   JSL $809A53              
81DAAD   REP #$20                 
81DAAF   LDA #$011E               
81DAB2   LDY #$02                 
81DAB4   LDX $0B                  
81DAB6   BEQ $81DABD              
81DAB8   LDA #$000E               
81DABB   LDY #$00                 
81DABD   STA $0013                
81DAC0   STY $000A                
81DAC3   SEP #$20                 
81DAC5   JSL $82C3B4              
81DAC9   JSL $808F1E              
81DACD   RTS                      
----------------         
81DACE   LDX $02                  
81DAD0   JMP ($DAD3,X)            
--------data--------     
81DAD3  .db $DB $DA $1A $DB      
----------------         
--------unidentified--------
81DAD7  .db $1B $DB              
----------------         
--------data--------     
81DAD9  .db $4C $DB              
----------------         
81DADB   LDA $0D                  
81DADD   BEQ $81DAE6              
81DADF   LDA #$06                 
81DAE1   STA $02                  
81DAE3   JMP $DB4C                
81DAE6   LDA #$02                 
81DAE8   STA $02                  
81DAEA   STZ $03                  
81DAEC   DEC                      
81DAED   STA $00                  
81DAEF   LDA $11                  
81DAF1   LSR                      
81DAF2   LSR                      
81DAF3   LSR                      
81DAF4   STA $4E                  
81DAF6   STZ $4F                  
81DAF8   REP #$20                 
81DAFA   LDA $14                  
81DAFC   AND #$00F8               
81DAFF   ASL                      
81DB00   ASL                      
81DB01   ADC $4E                  
81DB03   ADC #$57DF               
81DB06   STA $4E                  
81DB08   STA $0010                
81DB0B   SEP #$20                 
81DB0D   LDA $1144                
81DB10   AND #$04                 
81DB12   BNE $81DB3B              
81DB14   LDA #$0F                 
81DB16   JSL $808D7B              
81DB1A   RTS                      
----------------         
--------unidentified--------
81DB1B  .db $A6 $03 $7C $20 $DB $24 $DB $46
81DB23  .db $DB $A9 $02 $85 $03 $EE $F8 $00
81DB2B  .db $A9 $07 $22 $53 $9A $80 $A5 $4E
81DB33  .db $8D $10 $00 $A5 $4F $8D $11 $00
----------------         
81DB3B   LDA #$10                 
81DB3D   JSL $808D7B              
81DB41   LDA #$03                 
81DB43   STA $00                  
81DB45   RTS                      
----------------         
--------unidentified--------
81DB46  .db $AD $FC $00 $F0 $9B $60
----------------         
81DB4C   LDX $03                  
81DB4E   JMP ($DB51,X)            
--------data--------     
81DB51  .db $5B $DB              
----------------         
--------unidentified--------
81DB53  .db $74 $DB $8C $DB $E1 $DB
----------------         
--------data--------     
81DB59  .db $06 $DC              
----------------         
81DB5B   STZ $4B                  
81DB5D   STZ $4E                  
81DB5F   LDA #$08                 
81DB61   STA $4F                  
81DB63   LDA $1144                
81DB66   AND #$04                 
81DB68   BNE $81DBD0              
81DB6A   LDA #$02                 
81DB6C   STA $03                  
81DB6E   STZ $00F8                
81DB71   STZ $00FC                
81DB74   LDA $00F8                
81DB77   BNE $81DB7A              
81DB79   RTS                      
----------------         
--------unidentified--------
81DB7A  .db $A9 $04 $85 $03 $8D $FC $00 $C2
81DB82  .db $20 $A9 $1C $02 $85 $4C $E2 $20
81DB8A  .db $80 $17 $C2 $20 $C6 $4C $E2 $20
81DB92  .db $D0 $0F $64 $4A $64 $4B $20 $26
81DB9A  .db $DC $A5 $4B $C9 $06 $90 $F7 $80
81DBA2  .db $B8 $AD $F8 $00 $C5 $4B $F0 $5C
81DBAA  .db $A5 $4E $1A $85 $4A $AD $F8 $00
81DBB2  .db $C5 $4B $F0 $0B $20 $26 $DC $A5
81DBBA  .db $4B $C9 $06 $F0 $03 $80 $EE $60
81DBC2  .db $A9 $04 $0C $44 $11 $A9 $06 $85
81DBCA  .db $03 $A9 $10 $85 $0F $60
----------------         
81DBD0   LDA #$01                 
81DBD2   STA $4A                  
81DBD4   STZ $4B                  
81DBD6   JSR $DC26                
81DBD9   LDA $4B                  
81DBDB   CMP #$06                 
81DBDD   BCC $81DBD6              
81DBDF   BRA $81DBEB              
--------unidentified--------
81DBE1  .db $C6 $0F $D0 $20 $A9 $21 $22 $53
81DBE9  .db $9A $80              
----------------         
81DBEB   LDA #$0E                 
81DBED   STA $0013                
81DBF0   LDA #$00                 
81DBF2   STA $0014                
81DBF5   STZ $000A                
81DBF8   JSL $82C3B4              
81DBFC   LDA #$08                 
81DBFE   STA $03                  
81DC00   LDA #$06                 
81DC02   STA $00F8                
81DC05   RTS                      
----------------         
81DC06   DEC $4F                  
81DC08   BNE $81DC25              
81DC0A   LDA #$08                 
81DC0C   STA $4F                  
81DC0E   LDA $4E                  
81DC10   EOR #$01                 
81DC12   STA $4E                  
81DC14   INC                      
81DC15   STA $4A                  
81DC17   STZ $4B                  
81DC19   LDA $00F8                
81DC1C   CMP $4B                  
81DC1E   BEQ $81DC25              
81DC20   JSR $DC26                
81DC23   BRA $81DC19              
81DC25   RTS                      
----------------         
--------sub start--------
81DC26   LDA $4B                  
81DC28   ASL                      
81DC29   TAX                      
81DC2A   REP #$21                 
81DC2C   LDA $AAA2,X              
81DC2F   STA $0010                
81DC32   SEP #$20                 
81DC34   LDA $4A                  
81DC36   JSL $808E4E              
81DC3A   INC $4B                  
81DC3C   RTS                      
----------------         
81DC3D   LDX $02                  
81DC3F   JMP ($DC42,X)            
--------data--------     
81DC42  .db $46 $DC $6D $DC      
----------------         
81DC46   LDA #$02                 
81DC48   STA $02                  
81DC4A   DEC                      
81DC4B   STA $00                  
81DC4D   STA $01                  
81DC4F   LDA #$80                 
81DC51   STA $1A                  
81DC53   LDA #$37                 
81DC55   STA $1B                  
81DC57   LDY #$AE                 
81DC59   LDA #$AA                 
81DC5B   JSL $8089A3              
81DC5F   LDA $14                  
81DC61   STA $4D                  
81DC63   LDA $0B                  
81DC65   BEQ $81DC6B              
81DC67   ASL                      
81DC68   STA $03                  
81DC6A   RTS                      
----------------         
81DC6B   BRA $81DCA0              
81DC6D   LDA $00AC                
81DC70   BNE $81DC77              
81DC72   LDX $03                  
81DC74   JSR ($DC7C,X)            
81DC77   JSL $8088DF              
81DC7B   RTS                      
----------------         
--------data--------     
81DC7C  .db $82 $DC $8F $DC $C6 $DC
----------------         
--------sub start--------
81DC82   JSR $DCD5                
81DC85   DEC $0F                  
81DC87   BNE $81DCC5              
81DC89   LDA #$02                 
81DC8B   STA $03                  
81DC8D   BRA $81DCA5              
--------sub start--------
81DC8F   JSL $8089A9              
81DC93   JSL $80C048              
81DC97   JSR $DCD5                
81DC9A   DEC $0F                  
81DC9C   BNE $81DCC5              
81DC9E   STZ $03                  
81DCA0   LDA #$78                 
81DCA2   STA $0F                  
81DCA4   RTS                      
----------------         
81DCA5   LDA $0D                  
81DCA7   INC                      
81DCA8   AND #$01                 
81DCAA   STA $0D                  
81DCAC   LDA $0B                  
81DCAE   LSR                      
81DCAF   TAX                      
81DCB0   LDA $AACE,X              
81DCB3   STA $0F                  
81DCB5   REP #$20                 
81DCB7   LDA #$FEC0               
81DCBA   LDX $0D                  
81DCBC   BEQ $81DCC1              
81DCBE   LDA #$0140               
81DCC1   STA $2A                  
81DCC3   SEP #$20                 
81DCC5   RTS                      
----------------         
--------sub start--------
81DCC6   JSR $DCD5                
81DCC9   LDA $00FE                
81DCCC   BEQ $81DC77              
81DCCE   STZ $03                  
81DCD0   LDA #$3C                 
81DCD2   STA $0F                  
81DCD4   RTS                      
----------------         
--------sub start--------
81DCD5   LDY #$00                 
81DCD7   LDX #$00                 
81DCD9   JSR $DCE8                
81DCDC   LDY #$80                 
81DCDE   LDX #$01                 
81DCE0   JSR $DCE8                
81DCE3   LDA $14                  
81DCE5   STA $4D                  
81DCE7   RTS                      
----------------         
--------sub start--------
81DCE8   LDA $0100,Y              
81DCEB   AND #$03                 
81DCED   BEQ $81DD56              
81DCEF   LDA $4E,X                
81DCF1   BNE $81DD13              
81DCF3   LDA $11                  
81DCF5   CLC                      
81DCF6   ADC #$15                 
81DCF8   SEC                      
81DCF9   SBC $0111,Y              
81DCFC   CMP #$2B                 
81DCFE   BCS $81DD56              
81DD00   LDA $14                  
81DD02   CLC                      
81DD03   ADC #$0F                 
81DD05   SEC                      
81DD06   SBC $0114,Y              
81DD09   CMP #$1F                 
81DD0B   BCS $81DD56              
81DD0D   LDA #$01                 
81DD0F   STA $4E,X                
81DD11   BRA $81DD2D              
81DD13   LDA $11                  
81DD15   CLC                      
81DD16   ADC #$18                 
81DD18   SEC                      
81DD19   SBC $0111,Y              
81DD1C   CMP #$31                 
81DD1E   BCS $81DD56              
81DD20   LDA $14                  
81DD22   CLC                      
81DD23   ADC #$10                 
81DD25   SEC                      
81DD26   SBC $0114,Y              
81DD29   CMP #$21                 
81DD2B   BCS $81DD56              
81DD2D   LDA $03                  
81DD2F   BEQ $81DD4F              
81DD31   LDA $14                  
81DD33   SEC                      
81DD34   SBC $4D                  
81DD36   CLC                      
81DD37   ADC $0114,Y              
81DD3A   STA $0114,Y              
81DD3D   LDA $0D                  
81DD3F   PHD                      
81DD40   ASL                      
81DD41   ASL                      
81DD42   TAX                      
81DD43   LDA #$01                 
81DD45   XBA                      
81DD46   TYA                      
81DD47   TCD                      
81DD48   JSL $8291C6              
--------unidentified--------
81DD4C  .db $7B $A8 $2B $A9 $01 $99 $44 $01
81DD54  .db $60 $60              
----------------         
81DD56   STZ $4E,X                
81DD58   RTS                      

;0x48 Moving platform with 9 arrows
81DD59   LDX $02                  
81DD5B   JMP ($DD5E,X)            
--------data--------     
81DD5E
dw $DD62 
dw $DDB8     
----------------         
81DD62   LDA #$02                 
81DD64   STA $02                  
81DD66   DEC                      
81DD67   STA $00                  
81DD69   LDY $0B                  
81DD6B   BEQ $81DD82              
81DD6D   STA $01                  
81DD6F   LDA #$40                 
81DD71   STA $1A                  
81DD73   LDA #$3B                 
81DD75   STA $1B                  
81DD77   STZ $43                  
81DD79   STZ $44                  
81DD7B   STZ $45                  
81DD7D   STZ $46                  
81DD7F   JMP $DE95                
81DD82   STZ $43                  
81DD84   STZ $44                  
81DD86   STZ $30                  
81DD88   JSL GetEmptySprite ; 808F73              
81DD8C   BCS $81DDAA              
81DD8E   LDA #$02                 
81DD90   STA $0003,X              
81DD93   DEC                      
81DD94   STA $0000,X              
81DD97   LDA #$48                 
81DD99   STA $000A,X              
81DD9C   STA $000B,X              
81DD9F   LDA $30                  
81DDA1   STA $0042,X              
81DDA4   REP #$20                 
81DDA6   TDC                      
81DDA7   STA $0040,X              
81DDAA   SEP #$30                 
81DDAC   INY                      
81DDAD   INY                      
81DDAE   INC $30                  
81DDB0   LDA $30                  
81DDB2   CMP #$09                 
81DDB4   BNE $81DD88              
81DDB6   BRA $81DDBD              
81DDB8   LDA $00AC                
81DDBB   BNE $81DDC2              
81DDBD   LDX $03                  
81DDBF   JSR ($DDC7,X)            
81DDC2   JSL $8088DF              
81DDC6   RTS                      
----------------         
--------data--------     
81DDC7  .db $CB $DD $95 $DE      
----------------         
--------sub start--------
81DDCB   LDX $04                  
81DDCD   JMP ($DDD0,X)            
--------data--------     
81DDD0  .db $D6 $DD $FD $DD      
----------------         
--------unidentified--------
81DDD4  .db $81 $DE              
----------------         
81DDD6   LDA #$02                 
81DDD8   STA $04                  
81DDDA   STZ $30                  
81DDDC   LDY $30                  
81DDDE   CPY #$03                 
81DDE0   BNE $81DDE8              
81DDE2   TXA                      
81DDE3   INC                      
81DDE4   AND #$0F                 
81DDE6   BRA $81DDF0              
81DDE8   INC $30                  
81DDEA   JSL $808859              
81DDEE   AND #$0F                 
81DDF0   TAX                      
81DDF1   LDA $AB08,X              
81DDF4   CMP $40                  
81DDF6   BEQ $81DDDC              
81DDF8   STA $40                  
81DDFA   STZ $00FE                
81DDFD   LDA $00FE                
81DE00   BEQ $81DE14              
81DE02   LDA #$04                 
81DE04   STA $04                  
81DE06   LDA #$10                 
81DE08   STA $32                  
81DE0A   LDA #$AA                 
81DE0C   LDY #$D0                 
81DE0E   JSL $80BF9F              
--------unidentified--------
81DE12  .db $80 $6D              
----------------         
81DE14   LDY #$00                 
81DE16   LDX #$00                 
81DE18   JSR $DE1F                
81DE1B   LDY #$80                 
81DE1D   LDX #$01                 
--------sub start--------
81DE1F   LDA $0100,Y              
81DE22   AND #$03                 
81DE24   BEQ $81DE80              
81DE26   LDA $43,X                
81DE28   BNE $81DE45              
81DE2A   LDA $0111,Y              
81DE2D   CLC                      
81DE2E   ADC #$17                 
81DE30   SEC                      
81DE31   SBC $11                  
81DE33   CMP #$2D                 
81DE35   BCS $81DE7E              
81DE37   LDA $0114,Y              
81DE3A   ADC #$17                 
81DE3C   SEC                      
81DE3D   SBC $14                  
81DE3F   CMP #$2D                 
81DE41   BCS $81DE7E              
81DE43   INC $43,X                
81DE45   LDA $0111,Y              
81DE48   CLC                      
81DE49   ADC #$18                 
81DE4B   SEC                      
81DE4C   SBC $11                  
81DE4E   CMP #$2F                 
81DE50   BCS $81DE7E              
81DE52   LDA $0114,Y              
81DE55   ADC #$18                 
81DE57   SEC                      
81DE58   SBC $14                  
81DE5A   CMP #$2F                 
81DE5C   BCS $81DE7E              
81DE5E   LDA #$01                 
81DE60   STA $0144,Y              
81DE63   LDA $04                  
81DE65   CMP #$04                 
81DE67   BNE $81DE80              
81DE69   TXA                      
81DE6A   ASL                      
81DE6B   TAX                      
81DE6C   LDA $0111,Y              
81DE6F   SEC                      
81DE70   SBC $11                  
81DE72   STA $45,X                
81DE74   LDA $0114,Y              
81DE77   SEC                      
81DE78   SBC $14                  
81DE7A   STA $46,X                
81DE7C   BRA $81DE80              
81DE7E   STZ $43,X                
81DE80   RTS                      


81DE81  .db $20 $14 $DE $22 $07 $C0 $80
81DE88  .db $20 $A7 $DF $20 $65 $DF $C6 $32
81DE90  .db $D0 $02 $64 $04 $60 $A6 $04 $7C
81DE98  .db $9A $DE $9C $DE $A5 $42 $0A $A8
81DEA0  .db $C2 $11 $A6 $40 $BD $11 $00 $79
81DEA8  .db $60 $AB $85 $11 $BD $14 $00 $18
81DEB0  .db $79 $61 $AB $85 $14 $E2 $10 $A0
81DEB8  .db $00 $A2 $00 $86 $30 $20 $EB $DE
81DEC0  .db $A0 $80 $A2 $01 $86 $30 $20 $EB
81DEC8  .db $DE $20 $95 $DF $0A $AA $4A $4A
81DED0  .db $85 $0E $A5 $43 $05 $44 $D0 $08
81DED8  .db $BD $E1 $AA $BC $E0 $AA $80 $06
81DEE0  .db $BD $F5 $AA $BC $F4 $AA $22 $A3
81DEE8  .db $89 $80 $60 $B9 $00 $01 $29 $03
81DEF0  .db $F0 $62 $A5 $11 $18 $69 $07 $38
81DEF8  .db $F9 $11 $01 $C9 $10 $B0 $55 $A5
81DF00  .db $14 $69 $07 $38 $F9 $14 $01 $C9
81DF08  .db $10 $B0 $49 $C2 $31 $A5 $30 $29
81DF10  .db $FF $00 $65 $40 $AA $BD $43 $00
81DF18  .db $29 $FF $00 $E2 $30 $F0 $35 $A6
81DF20  .db $30 $A9 $01 $95 $43 $20 $95 $DF
81DF28  .db $0A $AA $C2 $20 $A5 $06 $DD $F4
81DF30  .db $AA $E2 $20 $F0 $1D $A6 $30 $B5
81DF38  .db $45 $D0 $17 $B5 $43 $F0 $13 $AD
81DF40  .db $FE $00 $D0 $0E $EE $FE $00 $C2
81DF48  .db $10 $A4 $40 $A5 $0D $99 $0D $00
81DF50  .db $E2 $10 $80 $0A $74 $43 $8A $49
81DF58  .db $01 $AA $B5 $43 $D0 $00 $A6 $30
81DF60  .db $B5 $43 $95 $45 $60 $A0 $00 $BB
81DF68  .db $20 $6F $DF $A0 $80 $A2 $02 $B9
81DF70  .db $44 $01 $F0 $20 $A5 $11 $18 $75
81DF78  .db $45 $99 $11 $01 $A5 $14 $18 $75
81DF80  .db $46 $99 $14 $01 $A5 $0D $0B $0A
81DF88  .db $AA $A9 $01 $EB $98 $5B $22 $C6
81DF90  .db $91 $82 $7B $2B $60 $C2 $11 $A6
81DF98  .db $40 $BD $40 $00 $65 $42 $E2 $10
81DFA0  .db $A8 $B9 $08 $AB $85 $0D $60 $A6
81DFA8  .db $0D $BC $72 $AB $84 $31 $A9 $03
81DFB0  .db $85 $30 $9C $0B $00 $9C $0D $00
81DFB8  .db $A4 $31 $B9 $72 $AB $18 $65 $11
81DFC0  .db $8D $0A $00 $B9 $73 $AB $18 $65
81DFC8  .db $14 $8D $0C $00 $22 $86 $8A $80
81DFD0  .db $F0 $04 $C9 $30 $F0 $0B $64 $28
81DFD8  .db $64 $29 $64 $2A $64 $2B $4C $EA
81DFE0  .db $DF $E6 $31 $E6 $31 $C6 $30 $D0
81DFE8  .db $CF $60 $A5 $0D $0A $AA $7C $F1
81DFF0  .db $DF $F9 $DF $09 $E0 $17 $E0 $25
81DFF8  .db $E0 $A5 $14 $38 $E9 $18 $29 $07
81E000  .db $49 $07 $1A $18 $65 $14 $85 $14
81E008  .db $60 $A9 $17 $18 $65 $11 $29 $F8
81E010  .db $3A $38 $E9 $17 $85 $11 $60 $A9
81E018  .db $17 $18 $65 $14 $29 $F8 $3A $38
81E020  .db $E9 $17 $85 $14 $60 $A5 $11 $38
81E028  .db $E9 $18 $29 $07 $49 $07 $1A $18
81E030  .db $65 $11 $85 $11 $60

;0x4A Destroyable tile
81E035   LDX $02                  
81E037   JMP ($E03A,X)            
--------data--------     
81E03A  .db $40 $E0 $93 $E0 $CA $E0
----------------         
81E040   LDA #$02                 
81E042   STA $02                  
81E044   DEC                      
81E045   STA $00                  
81E047   STA $01                  
81E049   STA $1C                  
81E04B   LDA #$3D                 
81E04D   STA $1B                  
81E04F   LDA #$80                 
81E051   STA $1A                  
81E053   LDY #$B8                 
81E055   LDA #$A2                 
81E057   JSL $8089A3              
81E05B   LDA $11                  
81E05D   LSR                      
81E05E   LSR                      
81E05F   LSR                      
81E060   STA $3E                  
81E062   STZ $3F                  
81E064   REP #$20                 
81E066   LDA $14                  
81E068   AND #$00F8               
81E06B   ASL                      
81E06C   ASL                      
81E06D   ADC $3E                  
81E06F   ADC #$FF9E               
81E072   STA $3E                  
81E074   SEP #$20                 
81E076   LDA $0B                  
81E078   LSR                      
81E079   TAX                      
81E07A   LDA $AB8E,X              
81E07D   TAY                      
81E07E   LSR                      
81E07F   LSR                      
81E080   LSR                      
81E081   TAX                      
81E082   TYA                      
81E083   AND #$07                 
81E085   TAY                      
81E086   LDA $1144,X              
81E089   AND $80B8,Y              
81E08C   BEQ $81E0C9              
81E08E   JSR $E0B8                
--------unidentified--------
81E091  .db $80 $4B              
----------------         
81E093   LDA $1C                  
81E095   BNE $81E0C9              
81E097   LDA #$03                 
81E099   STA $00                  
81E09B   LDA #$04                 
81E09D   STA $02                  
81E09F   LDA $0B                  
81E0A1   LSR                      
81E0A2   TAX                      
81E0A3   LDA $AB8E,X              
81E0A6   TAY                      
81E0A7   LSR                      
81E0A8   LSR                      
81E0A9   LSR                      
81E0AA   TAX                      
81E0AB   TYA                      
81E0AC   AND #$07                 
81E0AE   TAY                      
81E0AF   LDA $1144,X              
81E0B2   ORA $80B8,Y              
81E0B5   STA $1144,X              
81E0B8   LDA $3E                  
81E0BA   STA $0013                
81E0BD   LDA $3F                  
81E0BF   STA $0014                
81E0C2   STZ $000A                
81E0C5   JSL $82C3B4              
81E0C9   RTS                      
----------------         
81E0CA   LDA $00AC                
81E0CD   BNE $81E0DD              
81E0CF   JSL $8089A9              
81E0D3   LDA $08                  
81E0D5   CMP #$70                 
81E0D7   BEQ $81E0DE              
81E0D9   JSL $8088CE              
81E0DD   RTS                      
----------------         
81E0DE   JSL $808F1E              
81E0E2   RTS                      
   

;Small Pirate Sprite
81E0E3   LDX $02  
81E0E5   JMP ($E0E8,X)
--------data--------     
81E0E8  .db $F0 $E0 $F2 $E1 $8D $E5 $90 $E7
----------------   
81E0F0   LDX $03  
81E0F2   JSR ($E0FE,X)
81E0F5   JSL $808A25  
81E0F9   JSL SpriteSaveDirectPage ; 8088CE  
81E0FD   RTS
----------------   
--------data--------     
81E0FE  .db $06 $E1 $54 $E1
----------------   
--------unidentified--------
81E102  .db $70 $E1 $E1 $E1
----------------   
--------sub start--------
81E106   JSL $808EE9  
81E10A   BCS $81E14F  
81E10C   LDA #$04 
81E10E   STA $1C  
81E110   STA $1D  
81E112   LDA #$39 
81E114   STA $1B  
81E116   LDA #$02 
81E118   STA $03  
81E11A   DEC
81E11B   STA $00  
81E11D   STA $01  
81E11F   STA $34  
81E121   STZ $33  
81E123   STZ $31  
81E125   STZ $30  
81E127   STZ $2F  
81E129   STZ $1F  
81E12B   LDA #$06 
81E12D   STA $1E  
81E12F   LDA #$06 
81E131   STA $22  
81E133   JSL $808A53  
81E137   JSR $E24F
81E13A   JSL $808A21  
81E13E   LDA $0D  
81E140   STA $3A  
81E142   JSL GetRandomInt;$808859  
81E146   AND #$07 
81E148   TAX
81E149   LDA $AD11,X  
81E14C   STA $37  
81E14E   RTS
----------------   
--------unidentified--------
81E14F  .db $22 $0F $8F $80 $60  
----------------   
--------sub start--------
81E154   LDA $1D  
81E156   CMP $1C  
81E158   BEQ $81E163  
81E15A   LDA #$04 
81E15C   STA $02  
81E15E   STZ $03  
81E160   JMP $E599
81E163   DEC $37  
81E165   BNE $81E16F  
81E167   LDA #$02 
81E169   STA $02  
81E16B   STZ $03  
81E16D   STZ $04  
81E16F   RTS
----------------   
--------unidentified--------
81E170  .db $A6 $04 $7C $75 $E1 $7B $E1 $8E
81E178  .db $E1 $CD $E1 $A9 $02 $85 $04 $20
81E180  .db $0B $E5 $A9 $AD $A0 $81 $22 $9F
81E188  .db $BF $80 $A9 $50 $85 $3C $22 $DE
81E190  .db $89 $80 $A5 $08 $C9 $0B $D0 $08
81E198  .db $A9 $01 $85 $08 $22 $DE $89 $80
81E1A0  .db $22 $07 $C0 $80 $C6 $3C $D0 $24
81E1A8  .db $A9 $04 $85 $04 $AD $FD $00 $D0
81E1B0  .db $0B $A9 $21 $22 $53 $9A $80 $EE
81E1B8  .db $FD $00 $80 $03 $9C $FD $00 $A9
81E1C0  .db $30 $22 $60 $86 $80 $20 $4F $E2
81E1C8  .db $A9 $50 $85 $3C $60 $C6 $3C $D0
81E1D0  .db $0F $A9 $02 $85 $02 $85 $03 $64
81E1D8  .db $04 $3A $85 $00 $85 $01 $68 $68
81E1E0  .db $60 $20 $06 $E1 $A9 $04 $85 $03
81E1E8  .db $3A $85 $00 $A9 $39 $85 $1B $68
81E1F0  .db $68 $60  
----------------   
81E1F2   LDA $1D  
81E1F4   CMP $1C  
81E1F6   BEQ $81E201  
81E1F8   LDA #$04 
81E1FA   STA $02  
81E1FC   STZ $03  
81E1FE   JMP $E599
81E201   LDA $00AC
81E204   BNE $81E215  
81E206   LDX $03  
81E208   JSR ($E21A,X)
81E20B   JSR $FD2D
81E20E   JSL $808A25  
81E212   JSR $FCCC
81E215   JSL SpriteSaveDirectPage ; 8088CE  
81E219   RTS
----------------   
--------data--------     
81E21A  .db $1E $E2 $1B $E3
----------------   
--------sub start--------
81E21E   LDX $04  
81E220   JSR ($E241,X)
81E223   LDA #$00 
81E225   JSR $FE6D
81E228   BCS $81E230  
81E22A   LDA #$02 
81E22C   STA $03  
81E22E   STZ $04  
81E230   JSR $FD03    
81E233   BCC $81E240 ;IF Carry is clear pirates are not aggroing
81E235   LDA #$02
81E237   STA $03 ;$0253 ;??
81E239   STZ $04 ;$0254 ;??
81E23B   LDA #$20 
81E23D   JMP $E34A
81E240   RTS
----------------   
--------data--------     
81E241  .db $47 $E2 $AD $E2 $EF $E2
----------------   
--------sub start--------
81E247   JSL GetRandomInt;$808859  
81E24B   BIT #$03 
81E24D   BEQ $81E264  
--------sub start--------
81E24F   LDA $0D  
81E251   STA $3A  
--------sub start--------
81E253   ASL
81E254   TAX
81E255   LSR
81E256   LSR
81E257   STA $0E  
81E259   LDA $B326,X  
81E25C   LDY $B325,X  
81E25F   JSL $8089D7  
81E263   RTS
----------------   
81E264   LDX $0D  
81E266   INX
81E267   AND #$80 
81E269   BNE $81E26D  
81E26B   DEX
81E26C   DEX
81E26D   TXA
81E26E   AND #$03 
81E270   STA $0D  
81E272   STZ $3E  
81E274   JSL GetRandomInt;$808859  
81E278   AND #$07 
81E27A   STA $37  
81E27C   LDA $0B  
81E27E   ASL
81E27F   ASL
81E280   ADC $37  
81E282   TAX
81E283   LDA $AD19,X  
81E286   STA $3C  
81E288   LDA #$02 
81E28A   STA $04  
81E28C   LDA $0D  
81E28E   STA $3A  
81E290   ASL
81E291   TAX
81E292   LSR
81E293   LSR
81E294   STA $0E  
81E296   LDA $B368,X  
81E299   LDY $B367,X  
81E29C   JSL $8089D7  
81E2A0   LDA $0B  
81E2A2   TAX
81E2A3   LDA $AD7A,X  
81E2A6   LDY $AD79,X  
81E2A9   JSL Sprite_SetSpeeds ; 80BF9F  
--------sub start--------
81E2AD   JSL MoveSprite ; 80C007  
81E2B1   JSL $8089DE  
81E2B5   LDA $08  
81E2B7   CMP #$0B 
81E2B9   BNE $81E2C3  
81E2BB   LDA #$01 
81E2BD   STA $08  
81E2BF   JSL $8089DE  
81E2C3   DEC $3C  
81E2C5   BNE $81E2C9  
81E2C7   STZ $04  
81E2C9   LDX $0D  
81E2CB   LDA #$AE ;affect small pirates movements :?
81E2CD   LDY #$E9 
81E2CF   JSR $FD53  ;Set $001F
81E2D2   BEQ $81E2EE  
81E2D4   JSR $FE00
81E2D7   LDX #$01 
81E2D9   JSL GetRandomInt;$808859  
81E2DD   BMI $81E2E1  
81E2DF   DEX
81E2E0   DEX
81E2E1   STX $3D  
81E2E3   LDA #$04 
81E2E5   STA $04  
81E2E7   LDA #$18 
81E2E9   STA $3C  
81E2EB   JSR $E24F
81E2EE   RTS
----------------   
--------sub start--------
81E2EF   DEC $3C  
81E2F1   BNE $81E2F8  
81E2F3   INC $3E  
81E2F5   JMP $E274
81E2F8   LDA $3C  
81E2FA   CMP #$10 
81E2FC   BNE $81E300  
81E2FE   BRA $81E30E  
81E300   CMP #$08 
81E302   BNE $81E31A  
81E304   LDA $3E  
81E306   CMP #$02 
81E308   BNE $81E30E  
81E30A   STZ $3E  
81E30C   BRA $81E31A  
81E30E   LDA $0D  
81E310   CLC
81E311   ADC $3D  
81E313   AND #$03 
81E315   STA $0D  
81E317   JMP $E24F
81E31A   RTS
----------------   
--------sub start--------
81E31B   LDX $04  
81E31D   JSR ($E330,X)
81E320   JSR $FD03
81E323   BCC $81E32F  
81E325   LDA #$02 
81E327   STA $03  
81E329   STZ $04  
81E32B   LDA #$20 
81E32D   BRA $81E34A  
81E32F   RTS
----------------   
--------data--------     
81E330  .db $38 $E3 $7A $E3 $F6 $E3 $54 $E4
----------------   
--------sub start--------
81E338   JSL GetRandomInt;$808859  
81E33C   AND #$07 
81E33E   STA $37  
81E340   LDA $0B  
81E342   ASL
81E343   ASL
81E344   ADC $37  
81E346   TAX
81E347   LDA $AD39,X

81E34A   XBA
81E34B   LDA #$00  ;turn A into 2000
81E34D   REP #$20 
81E34F   LSR
81E350   LSR
81E351   LSR
81E352   LSR   ;turn A into 0200   
81E353   STA $3E ;$028E and $028F ?
81E355   SEP #$20 
81E357   LDA #$02 
81E359   STA $04 ;$0254 to 02
81E35B   STZ $3C ;$028C to 00  
81E35D   STZ $36 ;$0286 to 00 
81E35F   STZ $35 ;$0285 to 00
81E361   LDA #$18
81E363   STA $32 ;$0282 to 18     
81E365   LDA #$FF 
81E367   STA $3A ;$028A to FF
81E369   JSR $E4E5
81E36C   LDA $0B  
81E36E   TAX
81E36F   LDA $ADC2,X  
81E372   LDY $ADC1,X  
81E375   JSL Sprite_SetSpeeds ; 80BF9F  
81E379   RTS
----------------   
--------sub start--------
81E37A   LDX #$03 
81E37C   JSL $8091F6  
81E380   BCC $81E38B  
81E382   LDA #$01 
81E384   STA $3C  
81E386   LDA $3A  
81E388   JMP $E253
81E38B   LDA $3C  
81E38D   BEQ $81E394  
81E38F   STZ $3C  
81E391   JSR $E50B
81E394   JSL $8089DE  
81E398   LDA $08  
81E39A   CMP #$0E 
81E39C   BCS $81E3A6  
81E39E   LDA #$01 
81E3A0   STA $08  
81E3A2   JSL $8089DE  
81E3A6   JSR $E469
81E3A9   LDA $009F
81E3AC   CLC
81E3AD   ADC $25  
81E3AF   AND #$03 
81E3B1   BNE $81E3D4  
81E3B3   LDA $31  
81E3B5   BNE $81E3BF  
81E3B7   JSR $FE4B
81E3BA   LDA $0000
81E3BD   STA $3B  
81E3BF   DEC $32  
81E3C1   BNE $81E3C9  
81E3C3   LDA #$18 
81E3C5   STA $32  
81E3C7   STZ $35  
81E3C9   LDA $35  
81E3CB   BNE $81E3D4  
81E3CD   JSR $E4E5
81E3D0   JSL Sprite_SetSpeedsAlt ; 80BFA3  
81E3D4   JSL MoveSprite ; 80C007  
81E3D8   JSR $E51E
81E3DB   REP #$20 
81E3DD   DEC $3E  
81E3DF   SEP #$20 
81E3E1   BNE $81E3F5  
81E3E3   LDA $31  
81E3E5   BEQ $81E3E9  
81E3E7   STZ $31  
81E3E9   LDA #$04 
81E3EB   STA $04  
81E3ED   LDA #$20 
81E3EF   STA $3E  
81E3F1   LDA #$0F 
81E3F3   STA $3C  
81E3F5   RTS
----------------   
--------sub start--------
81E3F6   LDA $3E  
81E3F8   BNE $81E417  
81E3FA   LDA #$06 
81E3FC   STA $04  
81E3FE   JSL GetRandomInt;$808859  
81E402   AND #$07 
81E404   STA $37  
81E406   LDA $0B  
81E408   ASL
81E409   ASL
81E40A   ADC $37  
81E40C   TAX
81E40D   LDA $AD59,X  
81E410   STA $3C  
81E412   LDA $3A  
81E414   JMP $E253
81E417   AND #$03 
81E419   BNE $81E438  
81E41B   JSR $E4E5
81E41E   LDA $3F  
81E420   ASL
81E421   TAX
81E422   LDA $0D  
81E424   ASL
81E425   ASL
81E426   ASL
81E427   ASL
81E428   PHA
81E429   LDA $AEDA,X  
81E42C   LDY $AED9,X  
81E42F   PLX
81E430   JSL $809252  
81E434   INC $3F  
81E436   DEC $3C  
81E438   DEC $3E  
81E43A   JSL MoveSprite ; 80C007  
81E43E   JSR $E51E
81E441   JSL $8089DE  
81E445   LDA $08  
81E447   CMP $3C  
81E449   BCS $81E453  
81E44B   LDA #$01 
81E44D   STA $08  
81E44F   JSL $8089DE  
81E453   RTS
----------------   
--------sub start--------
81E454   DEC $3C  
81E456   BNE $81E468  
81E458   STZ $03  
81E45A   STZ $04  
81E45C   JSR $E580
81E45F   LDA $0D  
81E461   LSR
81E462   LSR
81E463   STA $0D  
81E465   JMP $E50B
81E468   RTS
----------------   
--------sub start--------
81E469   LDA $33  
81E46B   BNE $81E49A  
81E46D   STZ $37  
81E46F   LDA $3A  
81E471   ASL
81E472   TAX
81E473   PHX
81E474   LDA $AF15,X  
81E477   LDY $AF16,X  
81E47A   JSR $FDCA
81E47D   BEQ $81E481  
81E47F   INC $37  
81E481   PLX
81E482   LDA $AF1D,X  
81E485   LDY $AF1E,X  
81E488   JSR $FDCA
81E48B   BEQ $81E493  
81E48D   LDA $37  
81E48F   ORA #$02 
81E491   STA $37  
81E493   LDA $37  
81E495   ASL
81E496   TAX
81E497   JMP ($E49D,X)
81E49A   DEC $33  
81E49C   RTS
----------------   
--------data--------     
81E49D  .db $A5 $E4 $B7 $E4 $CB $E4 $D6 $E4
----------------   
81E4A5   LDA $35  
81E4A7   BEQ $81E4B6  
81E4A9   LDA #$30 
81E4AB   STA $33  
81E4AD   JSR $E4E5
81E4B0   JSL Sprite_SetSpeedsAlt ; 80BFA3  
81E4B4   STZ $35  
81E4B6   RTS
----------------   
81E4B7   LSR
81E4B8   STA $34  
81E4BA   LDA $3A  
81E4BC   ASL
81E4BD   ASL
81E4BE   ADC #$02 
81E4C0   AND #$0F 
81E4C2   STA $0D  
81E4C4   JSL Sprite_SetSpeedsAlt ; 80BFA3  
81E4C8   INC $35  
81E4CA   RTS
----------------   
81E4CB   LSR
81E4CC   STA $34  
81E4CE   LDA $3A  
81E4D0   ASL
81E4D1   ASL
81E4D2   SBC #$01 
81E4D4   BRA $81E4C0  
81E4D6   LDA $34  
81E4D8   CMP #$01 
81E4DA   BNE $81E4DE  
81E4DC   BRA $81E495  
81E4DE   CMP #$02 
81E4E0   BNE $81E4E4  
81E4E2   BRA $81E495  
--------unidentified--------
81E4E4  .db $60  
----------------   
--------sub start--------

81E4E5   LDA #$01 
81E4E7   XBA 
81E4E8   LDA $3B ;$028B ? A = 01XX
81E4EC   TAX ;X = 01XX
81E4ED   JSL $808B0E  
81E4F1   PHA
81E4F2   INC
81E4F3   LSR
81E4F4   AND #$0F 
81E4F6   STA $0D  
81E4F8   PLA
81E4F9   CLC
81E4FA   ADC #$04 
81E4FC   LSR
81E4FD   LSR
81E4FE   LSR
81E4FF   AND #$03 
81E501   CMP $3A  
81E503   BEQ $81E50A  
81E505   STA $3A  
81E507   JSR $E50D
81E50A   RTS
----------------   
--------sub start--------
81E50B   LDA $3A  
--------sub start--------
81E50D   ASL
81E50E   TAX
81E50F   LSR
81E510   LSR
81E511   STA $0E  
81E513   LDA $B368,X  
81E516   LDY $B367,X  
81E519   JSL $8089D7 ;Used alots not sure for what
81E51D   RTS
----------------   
--------sub start-------- ;When small pirate see you?
81E51E   LDA $0D 
81E520   BIT #$03 
81E522   BNE $81E535  
81E524   LDX $3A  
81E526   LDA #$AE 
81E528   LDY #$E9 
81E52A   JSR $FD53  ;Set $001F   
81E52D   BEQ $81E534  
81E52F   LDA $3A  
81E531   JMP $FE02
81E534   RTS
---------------- ;When small pirate see you?   
81E535   LSR
81E536   LSR
81E537   STA $3D  
81E539   TAX
81E53A   LDA #$AE 
81E53C   LDY #$FF 
81E53E   JSR $FD53   ;Set $001F  
81E541   BEQ $81E548  
81E543   LDA $3D  
81E545   JSR $FE02
81E548   LDA $3D  
81E54A   INC
81E54B   AND #$03 
81E54D   STA $3D  
81E54F   TAX
81E550   LDA #$AE 
81E552   LDY #$FF 
81E554   JSR $FD53  ;Set $001F   
81E557   BEQ $81E55E  
81E559   LDA $3D  
81E55B   JSR $FE02
81E55E   LDA $35  
81E560   BEQ $81E58C  
81E562   LDA $3D  
81E564   ASL
81E565   TAX
81E566   STX $37  
81E568   LDA $AF25,X  
81E56B   LDY $AF26,X  
81E56E   JSR $FDCA
81E571   BEQ $81E58C  
81E573   LDX $37  
81E575   LDA $AF2D,X  
81E578   LDY $AF2E,X  
81E57B   JSR $FDCA
81E57E   BEQ $81E58C  
--------sub start--------
81E580   LDA $34  
81E582   TAX
81E583   ASL
81E584   CMP #$02 
81E586   BEQ $81E58A  
81E588   LSR
81E589   LSR
81E58A   STA $34  
81E58C   RTS
----------------   
81E58D   LDA $1D  
81E58F   CMP $1C  
81E591   BEQ $81E599  
81E593   LDA #$04 
81E595   STA $02  
81E597   STZ $03  
81E599   LDX $03  
81E59B   JSR ($E5A7,X)
81E59E   JSL $808A25  
81E5A2   JSL SpriteSaveDirectPage ; 8088CE  
81E5A6   RTS
----------------   
--------data--------     
81E5A7  .db $B3 $E5 $FD $E5 $7C $E6
----------------   
--------unidentified--------
81E5AD  .db $DC $E6  
----------------   
--------data--------     
81E5AF  .db $88 $FC $A9 $FC
----------------   
--------sub start--------
81E5B3   STZ $31  
81E5B5   LDA $30  
81E5B7   BEQ $81E5C9  
81E5B9   LDA $2F  
81E5BB   BEQ $81E5C9  
81E5BD   LDA $3D  
81E5BF   STA $11  
81E5C1   LDA $3E  
81E5C3   STA $14  
81E5C5   STZ $30  
81E5C7   STZ $2F  
81E5C9   LDA #$01 
81E5CB   STA $01  
81E5CD   LDA $1D  
81E5CF   INC
81E5D0   BNE $81E5D4  
81E5D2   INC $30  
81E5D4   LDA $1C  
81E5D6   STA $1D  
81E5D8   BNE $81E5EB  
81E5DA   LDA #$B5 
81E5DC   LDY #$58 
81E5DE   JSL $8089D7  
81E5E2   LDA #$08 
81E5E4   STA $03  
81E5E6   LDA #$03 
81E5E8   STA $00  
81E5EA   RTS
----------------   
81E5EB   LDA #$02 
81E5ED   STA $03  
81E5EF   LDA #$AE 
81E5F1   LDY #$C9 
81E5F3   JSL Sprite_SetSpeeds ; 80BF9F  
81E5F7   LDA #$05 
81E5F9   STA $3C  
81E5FB   STZ $3F  
--------sub start--------
81E5FD   LDA $00AC
81E600   BNE $81E679  
81E602   JSL MoveSprite ; 80C007  
81E606   DEC $3C  
81E608   BNE $81E60C  
81E60A   INC $3F  
81E60C   LDY $0D  
81E60E   LDX $AF35,Y  
81E611   STX $3E  
81E613   LDY #$02 
81E615   LDA $0D  
81E617   LSR
81E618   BCS $81E61C  
81E61A   LDY #$03 
81E61C   STY $3D  
81E61E   LDA $AF35,X  
81E621   LDY $AF36,X  
81E624   JSR $FDCA
81E627   BEQ $81E65F  
81E629   LDX $3F  
81E62B   BEQ $81E634  
81E62D   LDA $0D  
81E62F   JSR $FE02
--------unidentified--------
81E632  .db $80 $0F $29 $F0 $C9 $F0 $F0 $25
81E63A  .db $C9 $30 $F0 $21 $A5 $0D $20 $02
81E642  .db $FE  
----------------   
81E643   LDA #$04 
81E645   STA $03  
81E647   LDA $3A  
81E649   JSR $E253
81E64C   LDA #$30 
81E64E   STA $3C  
81E650   LDA $11  
81E652   STA $3D  
81E654   LDA $14  
81E656   STA $3E  
81E658   LDA #$02 
81E65A   STA $00  
81E65C   INC $2F  
81E65E   RTS
----------------   
81E65F   LDX $3E  
81E661   INX
81E662   INX
81E663   STX $3E  
81E665   DEC $3D  
81E667   BNE $81E61E  
81E669   LDA $3F  
81E66B   BNE $81E643  
81E66D   JSR $E711
81E670   LDA $30  
81E672   BNE $81E679  
81E674   LDA $009F
81E677   TSB $01  
81E679   JMP $FCCC
--------sub start--------
81E67C   LDA $00AC
81E67F   BNE $81E6A6  
81E681   DEC $3C  
81E683   BNE $81E6A7  
81E685   LDA #$02 
81E687   STA $02  
81E689   DEC
81E68A   STA $00  
81E68C   STZ $03  
81E68E   STZ $04  
81E690   STA $01  
81E692   LDA $3A  
81E694   STA $0D  
81E696   LDA $30  
81E698   BEQ $81E6A6  
81E69A   LDA $3D  
81E69C   STA $11  
81E69E   LDA $3E  
81E6A0   STA $14  
81E6A2   STZ $30  
81E6A4   STZ $2F  
81E6A6   RTS
----------------   
81E6A7   LDA $30  
81E6A9   BNE $81E6B3  
81E6AB   LDA $009F
81E6AE   AND #$03 
81E6B0   STA $01  
81E6B2   RTS
----------------   
81E6B3   LDA $0D  
81E6B5   LSR
81E6B6   BCC $81E6CA  
81E6B8   LDX $11  
81E6BA   INX
81E6BB   INX
81E6BC   LDA $009F
81E6BF   AND #$01 
81E6C1   BEQ $81E6C7  
81E6C3   DEX
81E6C4   DEX
81E6C5   DEX
81E6C6   DEX
81E6C7   STX $11  
81E6C9   RTS
----------------   
--------unidentified--------
81E6CA  .db $A6 $14 $E8 $E8 $AD $9F $00 $29
81E6D2  .db $01 $F0 $04 $CA $CA $CA $CA $86
81E6DA  .db $14 $60 $22 $DE $89 $80 $A5 $08
81E6E2  .db $C9 $50 $F0 $1C $C9 $70 $D0 $1C
81E6EA  .db $A9 $01 $85 $08 $22 $DE $89 $80
81E6F2  .db $A9 $31 $85 $1B $A5 $3C $22 $53
81E6FA  .db $9A $80 $A9 $04 $85 $22 $80 $04
81E702  .db $A9 $06 $85 $02 $22 $25 $8A $80
81E70A  .db $22 $DF $88 $80 $68 $68 $60
----------------   
--------sub start--------
81E711   STZ $39  
81E713   LDA $0D  
81E715   ASL
81E716   ASL
81E717   TAX
81E718   STX $38  
81E71A   LDA $AF4D,X  
81E71D   LDY $AF4E,X  
81E720   JSR $FDCA
81E723   BEQ $81E729  
81E725   STA $3F  
81E727   INC $39  
81E729   LDX $38  
81E72B   LDA $AF4F,X  
81E72E   LDY $AF50,X  
81E731   JSR $FDCA
81E734   BEQ $81E73E  
81E736   STA $3F  
81E738   LDA $39  
81E73A   ORA #$02 
81E73C   STA $39  
81E73E   LDA $39  
81E740   BEQ $81E78F  
81E742   ASL
81E743   ASL
81E744   ASL
81E745   STA $38  
81E747   LDA $0D  
81E749   ASL
81E74A   ADC $38  
81E74C   TAX
81E74D   LDA $11  
81E74F   CLC
81E750   ADC $AF55,X  
81E753   STA $11  
81E755   LDA $14  
81E757   CLC
81E758   ADC $AF56,X  
81E75B   STA $14  
81E75D   LDA $3F  
81E75F   CMP #$F0 
81E761   BEQ $81E767  
81E763   CMP #$30 
81E765   BNE $81E78F  
81E767   LDA #$B5 
81E769   LDY #$75 
81E76B   JSL $8089D7  
--------unidentified--------
81E76F  .db $A2 $0F $A5 $3F $C9 $F0 $F0 $0A
81E777  .db $A9 $B5 $A0 $C4 $22 $D7 $89 $80
81E77F  .db $A2 $0E $86 $3C $A9 $03 $85 $00
81E787  .db $A9 $06 $85 $03 $85 $01 $68 $68
----------------   
81E78F   RTS
----------------   
81E790   JSL $808F0F ;Kill sprite increasing 00FB 
81E794   RTS

;Small green Pirate (throwing sword)
81E795   LDX $02  
81E797   JMP ($E79A,X)
--------data--------     
81E79A  .db 
dw $AE72 
dw $E800
dw $E58D 
dw $E790 ;kill sprite and increase 00FB
----------------   
81E7A2   LDX $03  
81E7A4   JSR ($E7B0,X)
81E7A7   JSL $808A25  
81E7AB   JSL SpriteSaveDirectPage ; 8088CE  
81E7AF   RTS
----------------   
--------data--------     
81E7B0  .db $B8 $E7 $54 $E1
----------------   
--------unidentified--------
81E7B4  .db $70 $E1 $F5 $E7
----------------   
--------sub start--------
81E7B8   JSL $808EE9  
81E7BC   BCS $81E7F4  
81E7BE   LDA #$05 
81E7C0   STA $1C  
81E7C2   STA $1D  
81E7C4   LDA #$3F 
81E7C6   STA $1B  
81E7C8   LDA $00B6
81E7CB   CMP #$02 
81E7CD   BNE $81E7D9  
81E7CF   LDA #$AF 
81E7D1   LDY #$75 
81E7D3   JSL $80896D  
81E7D7   BRA $81E7E5  
81E7D9   CMP #$03 
81E7DB   BNE $81E7E5  
81E7DD   LDA #$AF 
81E7DF   LDY #$7B 
81E7E1   JSL $80896D  
81E7E5   CMP #$04 
81E7E7   BNE $81E7ED  
81E7E9   LDA #$3F 
81E7EB   STA $1B  
81E7ED   STZ $2D  
81E7EF   STZ $2C  
81E7F1   JMP $E116
--------unidentified--------
81E7F4  .db $60 $20 $B8 $E7 $A9 $04 $85 $03
81E7FC  .db $3A $85 $00 $60
----------------   
81E800   LDA $1D  
81E802   CMP $1C  
81E804   BEQ $81E80F  
81E806   LDA #$04 
81E808   STA $02  
81E80A   STZ $03  
81E80C   JMP $E599
81E80F   LDA $00AC
81E812   BNE $81E829  
81E814   LDX $03  
81E816   JSR ($E82E,X)
81E819   JSR $FD2D
81E81C   JSL $808A25  
81E820   JSR $FCCC
81E823   LDA $2C  
81E825   BEQ $81E829  
81E827   DEC $2C  
81E829   JSL SpriteSaveDirectPage ; 8088CE  
81E82D   RTS
----------------   
--------data--------     
81E82E  .db $34 $E8 $79 $E8 $B3 $E8
----------------   
--------sub start--------
81E834   LDX $04  
81E836   JSR ($E86E,X)
81E839   LDA #$01 
81E83B   JSR $FE7F
81E83E   BCS $81E848  
81E840   LDA #$02 
81E842   STA $03  
81E844   STZ $04  
81E846   BRA $81E859  
81E848   LDA $2C  
81E84A   BNE $81E859  
81E84C   LDA #$02 
81E84E   JSR $FE6D
81E851   BCS $81E859  
81E853   LDA #$04 
81E855   STA $03  
81E857   STZ $04  
81E859   JSR $FD03
81E85C   BCC $81E86D  
81E85E   LDA #$02 
81E860   STA $03  
81E862   STZ $04  
81E864   LDA #$FF 
81E866   STA $2C  
81E868   LDA #$0F 
81E86A   JMP $E34A
81E86D   RTS
----------------   
--------data--------     
81E86E  .db $74 $E8 $AD $E2 $EF $E2
----------------   
--------sub start--------
81E874   STZ $2D  
81E876   JMP $E247
--------sub start--------
81E879   LDX $04  
81E87B   JSR ($E8A6,X)
81E87E   LDA $2C  
81E880   BNE $81E891  
81E882   LDA #$01 
81E884   JSR $FE7F
81E887   BCC $81E891  
81E889   LDA #$04 
81E88B   STA $03  
81E88D   STZ $04  
81E88F   STZ $31  
81E891   JSR $FD03
81E894   BCC $81E8A5  
81E896   LDA #$02 
81E898   STA $03  
81E89A   STZ $04  
81E89C   LDA #$FF 
81E89E   STA $2C  
81E8A0   LDA #$0F 
81E8A2   JMP $E34A
81E8A5   RTS
----------------   
--------data--------     
81E8A6  .db $AE $E8 $7A $E3 $F6 $E3 $54 $E4
----------------   
--------sub start--------
81E8AE   STZ $2D  
81E8B0   JMP $E338
--------sub start--------
81E8B3   LDX $04  
81E8B5   JSR ($E8BB,X)
81E8B8   JMP $E859
--------data--------     
81E8BB  .db $C3 $E8 $E1 $E8 $FC $E8 $91 $E9
----------------   
--------sub start--------
81E8C3   LDA #$02 
81E8C5   STA $04  
81E8C7   JSR $E4E5
81E8CA   LDA $3A  
81E8CC   JSR $E253
81E8CF   INC $2D  
81E8D1   LDA $2D  
81E8D3   CMP #$03 
81E8D5   BNE $81E8DD  
81E8D7   LDA #$FF 
81E8D9   STA $2C  
81E8DB   STZ $2D  
81E8DD   LDA #$20 
81E8DF   STA $3C  
--------sub start--------
81E8E1   DEC $3C  
81E8E3   BNE $81E8FB  
81E8E5   LDA #$04 
81E8E7   STA $04  
81E8E9   LDA $3A  
81E8EB   ASL
81E8EC   TAX
81E8ED   LSR
81E8EE   LSR
81E8EF   STA $0E  
81E8F1   LDA $B626,X  
81E8F4   LDY $B625,X  
81E8F7   JSL $8089D7  
81E8FB   RTS
----------------   
--------sub start--------
81E8FC   JSL $8089DE  
81E900   LDA $08  
81E902   CMP #$70 
81E904   BNE $81E914  
81E906   LDA #$06 
81E908   STA $04  
81E90A   LDA $3A  
81E90C   JSR $E253
81E90F   LDA #$20 
81E911   STA $3C  
81E913   RTS
----------------   
81E914   CMP #$50 
81E916   BNE $81E990  
81E918   LDA #$01 
81E91A   STA $08  
81E91C   JSL $8089DE  
81E920   LDA $3A  
81E922   ASL
81E923   ASL
81E924   STA $2E  
81E926   REP #$10 
81E928   LDA #$01 
81E92A   XBA
81E92B   LDA $3B  
81E92D   REP #$10 
81E92F   TAX
81E930   JSL $808B0E  
81E934   INC
81E935   LSR
81E936   AND #$0F 
81E938   SEC
81E939   SBC $2E  
81E93B   AND #$0F 
81E93D   BEQ $81E94D  
81E93F   CMP #$08 
81E941   LDX $2E  
81E943   INX
81E944   BCC $81E948  
81E946   DEX
81E947   DEX
81E948   TXA
81E949   AND #$0F 
81E94B   STA $2E  
81E94D   JSL GetNextEmptySprite;$808F73  
81E951   BCS $81E98E  
81E953   LDA #$3E 
81E955   STA $000A,X  
81E958   LDA #$03 
81E95A   STA $0000,X  
81E95D   LDA $0C  
81E95F   STA $000C,X  
81E962   LDA $11  
81E964   STA $0011,X  
81E967   STZ $0012,X  
81E96A   LDY $14  
81E96C   INY
81E96D   LDA $3A  
81E96F   BNE $81E973  
81E971   DEY
81E972   DEY
81E973   TYA
81E974   STA $0014,X  
81E977   STZ $0015,X  
81E97A   LDA $17  
81E97C   CLC
81E97D   ADC #$14 
81E97F   STA $0017,X  
81E982   LDA $2E  
81E984   STA $000D,X  
81E987   LDA $0E  
81E989   EOR #$FF 
81E98B   STA $000E,X  
81E98E   SEP #$10 
81E990   RTS
----------------   
--------sub start--------
81E991   DEC $3C  
81E993   BNE $81E9A4  
81E995   STZ $03  
81E997   STZ $04  
81E999   STZ $31  
81E99B   LDA $0D  
81E99D   LSR
81E99E   LSR
81E99F   STA $0D  
81E9A1   JMP $E839
81E9A4   RTS

;Red pirate throwing barrel back
81E9A5   LDX $02  
81E9A7   JMP ($E9AA,X)
--------data--------     
81E9AA  .db $B2 $E9 $05 $EA
----------------   
--------unidentified--------
81E9AE   
dw $EC49 
dw $E790
----------------   
81E9B2   LDX $03  
81E9B4   JSR ($E9BC,X)
81E9B7   JSL SpriteSaveDirectPage ; 8088CE  
81E9BB   RTS
----------------   
--------data--------     
81E9BC  .db $C0 $E9 $54 $E1
----------------   
--------sub start--------
81E9C0   JSL $808EE9  
81E9C4   BCS $81E9FD  
81E9C6   LDA #$05 
81E9C8   STA $1C  
81E9CA   STA $1D  
81E9CC   LDA #$3F 
81E9CE   STA $1B  
81E9D0   LDA $00B6
81E9D3   CMP #$03 
81E9D5   BNE $81E9DF  
81E9D7   LDA #$AF 
81E9D9   LDY #$B1 
81E9DB   JSL $80896D  
81E9DF   CMP #$04 
81E9E1   BNE $81E9EB  
81E9E3   LDA #$AF 
81E9E5   LDY #$B7 
81E9E7   JSL $80896D  
81E9EB   LDA #$04 
81E9ED   STA $09  
81E9EF   STZ $44  
81E9F1   STZ $45  
81E9F3   STZ $2D  
81E9F5   STZ $46  
81E9F7   STZ $47  
81E9F9   LDA #$B0 
81E9FB   STA $4F  
81E9FD   JMP $E116
--------unidentified--------
81EA00  .db $22 $0F $8F $80 $60  
----------------   
81EA05   LDA $1D  
81EA07   CMP $1C  
81EA09   BEQ $81EA14  
81EA0B   LDA #$04 
81EA0D   STA $02  
81EA0F   STZ $03  
81EA11   JMP $EC55
81EA14   LDA $00AC
81EA17   BNE $81EA48  
81EA19   LDA $03  
81EA1B   CMP #$04 
81EA1D   BEQ $81EA39  
81EA1F   CMP #$06 
81EA21   BEQ $81EA39  
81EA23   LDA $2D  
81EA25   BNE $81EA2C  
81EA27   JSR $F4AC
81EA2A   BRA $81EA2E  
81EA2C   DEC $2D  
81EA2E   LDA $45  
81EA30   BNE $81EA37  
81EA32   JSR $ECB1
81EA35   BRA $81EA39  
81EA37   DEC $45  
81EA39   LDX $03  
81EA3B   JSR ($EA4D,X)
81EA3E   JSR $FD2D
81EA41   JSL $808A25  
81EA45   JSR $FCCC
81EA48   JSL SpriteSaveDirectPage ; 8088CE  
81EA4C   RTS
----------------   
--------data--------     
81EA4D  .db $1E $E2  
----------------   
--------unidentified--------
81EA4F  .db $1B $E3  
----------------   
--------data--------     
81EA51  .db $55 $EA $7E $EB
----------------   
--------sub start--------
81EA55   LDX $04  
81EA57   JMP ($EA5A,X)
--------data--------     
81EA5A  .db $60 $EA $7D $EA $3F $EB
----------------   
81EA60   LDA #$02 
81EA62   STA $04  
81EA64   LDA $2E  
81EA66   JSR $E50D
81EA69   LDA #$AF 
81EA6B   LDY #$91 
81EA6D   JSL Sprite_SetSpeeds ; 80BF9F  
81EA71   LDA $2E  
81EA73   ASL
81EA74   ASL
81EA75   STA $3C  
81EA77   LDA #$80 
81EA79   STA $2D  
81EA7B   STA $45  
81EA7D   STZ $3D  
81EA7F   LDX $3C  
81EA81   LDA $B181,X  
81EA84   LDY $B182,X  
81EA87   JSR $FDCA
81EA8A   AND #$F0 
81EA8C   CMP $4F  
81EA8E   BNE $81EA92  
81EA90   INC $3D  
81EA92   LDX $3C  
81EA94   LDA $B183,X  
81EA97   LDY $B184,X  
81EA9A   JSR $FDCA
81EA9D   AND #$F0 
81EA9F   CMP $4F  
81EAA1   BNE $81EAA5  
81EAA3   INC $3D  
81EAA5   LDA $3D  
81EAA7   BNE $81EAB0  
81EAA9   STZ $03  
81EAAB   STZ $04  
81EAAD   STZ $31  
81EAAF   RTS
----------------   
81EAB0   CMP #$02 
81EAB2   BNE $81EB28  
81EAB4   LDA #$04 
81EAB6   STA $04  
81EAB8   LDA $2E  
81EABA   JSR $ECA0
81EABD   JSR $F449
81EAC0   REP #$30 
81EAC2   LDA $37  
81EAC4   ASL
81EAC5   TAX
81EAC6   LDA $7FE000,X ; ??????
81EACA   SEC
81EACB   SBC #$0380   
81EACE   STA $37  
81EAD0   SEP #$30 
81EAD2   LDA $2E  
81EAD4   ASL
81EAD5   TAX
81EAD6   LDA $AFA1,X  
81EAD9   STA $38  
81EADB   LDA $AFA2,X  
81EADE   STA $39  
81EAE0   JSL $808F8E  
81EAE4   BCS $81EB21  
81EAE6   LDA #$03 
81EAE8   STA $0000,X  
81EAEB   STZ $000A,X  
81EAEE   STZ $0002,X  
81EAF1   LDA #$08 
81EAF3   STA $0003,X  
81EAF6   LDA #$02 
81EAF8   STA $0004,X  
81EAFB   STZ $0005,X  
81EAFE   LDA $38  
81EB00   ADC $11  
81EB02   STA $0011,X  
81EB05   LDA $39  
81EB07   ADC $14  
81EB09   STA $0014,X  
81EB0C   LDA #$03 
81EB0E   STA $0017,X  
81EB11   LDA $37  
81EB13   LSR
81EB14   STA $000B,X  
81EB17   STX $40  
81EB19   LDA #$12 
81EB1B   STA $09  
81EB1D   STA $46  
81EB1F   STZ $44  
81EB21   SEP #$30 
81EB23   LDA #$10 
81EB25   STA $3E  
81EB27   RTS
----------------   
81EB28   JSL $8089DE  
81EB2C   LDA $08  
81EB2E   CMP #$0B 
81EB30   BNE $81EB3A  
81EB32   LDA #$01 
81EB34   STA $08  
81EB36   JSL $8089DE  
81EB3A   JSL MoveSprite ; 80C007  
81EB3E   RTS
----------------   
81EB3F   DEC $3E  
81EB41   BNE $81EB70  
81EB43   JSR $FE4B
81EB46   LDA $0000
81EB49   STA $3B  
81EB4B   LDA #$01 
81EB4D   XBA
81EB4E   LDA $3B  
81EB50   REP #$10 
81EB52   TAX
81EB53   JSL $808B0E  
81EB57   LSR
81EB58   LSR
81EB59   INC
81EB5A   LSR
81EB5B   AND #$03 
81EB5D   STA $0D  
81EB5F   STA $3A  
81EB61   JSR $EBB0
81EB64   LDA #$06 
81EB66   STA $03  
81EB68   LDA #$04 
81EB6A   STA $04  
81EB6C   LDA #$10 
81EB6E   STA $3C  
81EB70   LDA $3E  
81EB72   CMP #$0C 
81EB74   BNE $81EB7D  
81EB76   LDA $2E  
81EB78   JSR $EBB0
81EB7B   STZ $46  
81EB7D   RTS
----------------   
--------sub start--------
81EB7E   LDX $04  
81EB80   JMP ($EB83,X)
--------data--------     
81EB83  .db $8B $EB  
----------------   
--------unidentified--------
81EB85  .db $A2 $EB  
----------------   
--------data--------     
81EB87  .db $C1 $EB $39 $EC
----------------   
81EB8B   DEC $3C  
81EB8D   BNE $81EBA1  
81EB8F   STZ $03  
81EB91   STZ $47  
81EB93   JSL GetRandomInt;$808859  
81EB97   AND #$07 
81EB99   TAX
81EB9A   LDA $AF81,X  
81EB9D   STA $45  
81EB9F   STZ $44  
81EBA1   RTS
----------------   
--------unidentified--------
81EBA2  .db $A9 $04 $85 $04 $A9 $20 $85 $3C
81EBAA  .db $A9 $12 $85 $09 $A5 $0D
----------------   
--------sub start--------
81EBB0   ASL
81EBB1   TAX
81EBB2   LSR
81EBB3   LSR
81EBB4   STA $0E  
81EBB6   LDA $B5E8,X  
81EBB9   LDY $B5E7,X  
81EBBC   JSL $8089D7  
81EBC0   RTS
----------------   
81EBC1   DEC $3C  
81EBC3   BNE $81EC38  
81EBC5   LDA #$06 
81EBC7   STA $04  
81EBC9   LDA $0D  
81EBCB   JSR $ECA0
81EBCE   LDA $3A  
81EBD0   ASL
81EBD1   ASL
81EBD2   STA $3A  
81EBD4   REP #$10 
81EBD6   LDA #$01 
81EBD8   XBA
81EBD9   LDA $3B  
81EBDB   REP #$10 
81EBDD   TAX
81EBDE   JSL $808B0E  
81EBE2   INC
81EBE3   LSR
81EBE4   AND #$0F 
81EBE6   SEC
81EBE7   SBC $3A  
81EBE9   AND #$0F 
81EBEB   BEQ $81EBFB  
81EBED   CMP #$08 
81EBEF   LDX $3A  
81EBF1   INX
81EBF2   BCC $81EBF6  
81EBF4   DEX
81EBF5   DEX
81EBF6   TXA
81EBF7   AND #$0F 
81EBF9   STA $3A  
81EBFB   LDA $0D  
81EBFD   ASL
81EBFE   TAX
81EBFF   LDA $AFA9,X  
81EC02   STA $38  
81EC04   LDA $AFAA,X  
81EC07   STA $39  
81EC09   REP #$10 
81EC0B   LDX $40  
81EC0D   LDA #$02 
81EC0F   STA $0002,X  
81EC12   LDA #$0C 
81EC14   STA $0003,X  
81EC17   LDA $3A  
81EC19   STA $000D,X  
81EC1C   LDA $38  
81EC1E   ADC $11  
81EC20   STA $0011,X  
81EC23   LDA $39  
81EC25   ADC $14  
81EC27   STA $0014,X  
81EC2A   SEP #$10 
81EC2C   LDA $0D  
81EC2E   STA $3A  
81EC30   LDA #$08 
81EC32   STA $3C  
81EC34   LDA #$04 
81EC36   STA $09  
81EC38   RTS
----------------   
81EC39   DEC $3C  
81EC3B   BNE $81EC48  
81EC3D   STZ $03  
81EC3F   STZ $04  
81EC41   STZ $45  
81EC43   STZ $31  
81EC45   JMP $ECF4
81EC48   RTS
----------------   
--------unidentified--------
81EC49  .db $A5 $1D $C5 $1C $F0 $06 $A9 $04
81EC51  .db $85 $02 $64 $03 $A6 $03 $FC $63
81EC59  .db $EC $22 $25 $8A $80 $22 $CE $88
81EC61  .db $80 $60 $6F $EC $FD $E5 $7C $E6
81EC69  .db $DC $E6 $88 $FC $A9 $FC $A5 $09
81EC71  .db $C9 $04 $F0 $26 $C2 $10 $A6 $40
81EC79  .db $BD $00 $00 $3A $D0 $12 $A9 $02
81EC81  .db $9D $02 $00 $A9 $0E $9D $03 $00
81EC89  .db $9E $0D $00 $A9 $30 $9D $17 $00
81EC91  .db $E2 $10 $A9 $04 $85 $09 $64 $45
81EC99  .db $64 $46 $64 $44 $4C $B3 $E5
----------------   
--------sub start--------
81ECA0   ASL
81ECA1   TAX
81ECA2   LSR
81ECA3   LSR
81ECA4   STA $0E  
81ECA6   LDA $B607,X  
81ECA9   LDY $B606,X  
81ECAC   JSL $8089D7  
81ECB0   RTS
----------------   
--------sub start--------
81ECB1   LDX #$04 
81ECB3   JSL $8091F6  
81ECB7   BCC $81ED0F  
81ECB9   LDX $0004
81ECBC   CPX #$FF 
81ECBE   BNE $81ECD0  
81ECC0   JSL $80919A  
--------unidentified--------
81ECC4  .db $AE $00 $00 $BD $53 $01 $D0 $09
81ECCC  .db $8A $49 $80 $AA
----------------   
81ECD0   LDA $0153,X  
81ECD3   BEQ $81ED0F  
81ECD5   STX $3B  
81ECD7   LDA #$01 
81ECD9   XBA
81ECDA   TXA
81ECDB   REP #$10 
81ECDD   TAX
81ECDE   JSL $808B0E  
81ECE2   TAX
81ECE3   INC
81ECE4   LSR
81ECE5   AND #$03 
81ECE7   BNE $81ED0F  
81ECE9   TXA
81ECEA   CLC
81ECEB   ADC #$04 
81ECED   LSR
81ECEE   LSR
81ECEF   LSR
81ECF0   AND #$03 
81ECF2   STA $0D  
81ECF4   JSR $E24F
81ECF7   LDA #$06 
81ECF9   STA $03  
81ECFB   STZ $04  
81ECFD   LDA #$FF 
81ECFF   STA $45  
81ED01   STA $44  
81ED03   JSL GetRandomInt;$808859  
81ED07   AND #$07 
81ED09   TAX
81ED0A   LDA $AF89,X  
81ED0D   STA $3C  
81ED0F   RTS


;Big Pirate
81ED10   LDX $02  
81ED12   JMP ($ED15,X)
--------data--------     
81ED15  
dw $ED1D
dw $EE0F
dw $F14E
dw $E790
----------------   
81ED1D   LDX $03  
81ED1F   JSR ($ED2B,X)
81ED22   JSL $808A25  
81ED26   JSL SpriteSaveDirectPage ; 8088CE  
81ED2A   RTS
----------------   
--------data--------     
81ED2B  .db $33 $ED $8A $ED
----------------   
--------unidentified--------
81ED2F  .db $8D $ED $FE $ED
----------------   
--------sub start--------
81ED33   JSL $808EE9  
81ED37   BCS $81ED85  
81ED39   LDA #$05 
81ED3B   STA $1C  
81ED3D   STA $1D  
81ED3F   LDA $00B6
81ED42   ASL
81ED43   TAX
81ED44   LDA $AFBE,X  
81ED47   LDY $AFBD,X  
81ED4A   JSL $80896D  
81ED4E   LDA #$02 
81ED50   STA $03  
81ED52   DEC
81ED53   STA $00  
81ED55   STA $01  
81ED57   STA $34  
81ED59   STZ $33  
81ED5B   STZ $31  
81ED5D   STZ $30  
81ED5F   STZ $2F  
81ED61   STZ $1F  
81ED63   STZ $1E  
81ED65   LDA #$08 
81ED67   STA $22  
81ED69   JSL $808A53  
81ED6D   JSR $EE6C
81ED70   JSL $808A21  
81ED74   LDA $0D  
81ED76   STA $3A  
81ED78   JSL GetRandomInt;$808859  
81ED7C   AND #$07 
81ED7E   TAX
81ED7F   LDA $AFE1,X  
81ED82   STA $37  
81ED84   RTS
----------------   
--------unidentified--------
81ED85  .db $22 $0F $8F $80 $60  
----------------   
--------sub start--------
81ED8A   JMP $E154
--------unidentified--------
81ED8D  .db $A6 $04 $7C $92 $ED $98 $ED $AB
81ED95  .db $ED $EA $ED $A9 $02 $85 $04 $20
81ED9D  .db $BB $F0 $A9 $B1 $A0 $4D $22 $9F
81EDA5  .db $BF $80 $A9 $50 $85 $3C $22 $DE
81EDAD  .db $89 $80 $A5 $08 $C9 $0B $D0 $08
81EDB5  .db $A9 $01 $85 $08 $22 $DE $89 $80
81EDBD  .db $22 $07 $C0 $80 $C6 $3C $D0 $24
81EDC5  .db $A9 $04 $85 $04 $AD $FD $00 $D0
81EDCD  .db $0B $A9 $21 $22 $53 $9A $80 $EE
81EDD5  .db $FD $00 $80 $03 $9C $FD $00 $A9
81EDDD  .db $30 $22 $60 $86 $80 $20 $6C $EE
81EDE5  .db $A9 $50 $85 $3C $60 $C6 $3C $D0
81EDED  .db $0F $A9 $02 $85 $02 $85 $03 $64
81EDF5  .db $04 $3A $85 $00 $85 $01 $68 $68
81EDFD  .db $60 $20 $33 $ED $A9 $04 $85 $03
81EE05  .db $3A $85 $00 $A9 $3B $85 $1B $68
81EE0D  .db $68 $60  
----------------   
81EE0F   LDA $1D  
81EE11   CMP $1C  
81EE13   BEQ $81EE1E  
81EE15   LDA #$04 
81EE17   STA $02  
81EE19   STZ $03  
81EE1B   JMP $F15A
81EE1E   LDA $00AC
81EE21   BNE $81EE32  
81EE23   LDX $03  
81EE25   JSR ($EE37,X)
81EE28   JSR $FD2D
81EE2B   JSL $808A25  
81EE2F   JSR $FCCC
81EE32   JSL SpriteSaveDirectPage ; 8088CE  
81EE36   RTS
----------------   
--------data--------     
81EE37  .db $3B $EE $45 $EF
----------------   
--------sub start--------
81EE3B   LDX $04  
81EE3D   JSR ($EE5E,X)
81EE40   LDA #$00 
81EE42   JSR $FE6D
81EE45   BCS $81EE4D  
81EE47   LDA #$02 
81EE49   STA $03  
81EE4B   STZ $04  
81EE4D   JSR $FD03
81EE50   BCC $81EE5D  
81EE52   LDA #$02 
81EE54   STA $03  
81EE56   STZ $04  
81EE58   LDA #$20 
81EE5A   JMP $EF74
81EE5D   RTS
----------------   
--------data--------     
81EE5E  .db $64 $EE $D7 $EE $19 $EF
----------------   
--------sub start--------
81EE64   JSL GetRandomInt;$808859  
81EE68   BIT #$03 
81EE6A   BEQ $81EE81  
--------sub start--------
81EE6C   LDA $0D  
81EE6E   STA $3A  
81EE70   ASL
81EE71   TAX
81EE72   LSR
81EE73   LSR
81EE74   STA $0E  
81EE76   LDA $B32E,X  
81EE79   LDY $B32D,X  
81EE7C   JSL $8089D7  
81EE80   RTS
----------------   
81EE81   STZ $3E  
81EE83   AND #$0F 
81EE85   BEQ $81EF01  
81EE87   DEC
81EE88   BEQ $81EE9C  
81EE8A   JSL GetRandomInt;$808859  
81EE8E   LDX $0D  
81EE90   INX
81EE91   AND #$80 
81EE93   BNE $81EE97  
81EE95   DEX
81EE96   DEX
81EE97   TXA
81EE98   AND #$03 
81EE9A   STA $0D  
81EE9C   JSL GetRandomInt;$808859  
81EEA0   AND #$07 
81EEA2   STA $37  
81EEA4   LDA $0B  
81EEA6   ASL
81EEA7   ASL
81EEA8   ADC $37  
81EEAA   TAX
81EEAB   LDA $AFC9,X  
81EEAE   STA $3C  
81EEB0   LDA #$02 
81EEB2   STA $04  
81EEB4   LDA $0D  
81EEB6   STA $3A  
81EEB8   ASL
81EEB9   TAX
81EEBA   LSR
81EEBB   LSR
81EEBC   STA $0E  
81EEBE   LDA $B370,X  
81EEC1   LDY $B36F,X  
81EEC4   JSL $8089D7  
81EEC8   LDA $0B  
81EECA   AND #$07 
81EECC   TAX
81EECD   LDA $B032,X  
81EED0   LDY $B031,X  
81EED3   JSL Sprite_SetSpeeds ; 80BF9F  
--------sub start--------
81EED7   JSL MoveSprite ; 80C007  
81EEDB   JSL $8089DE  
81EEDF   LDA $08  
81EEE1   CMP #$0A 
81EEE3   BNE $81EEED  
81EEE5   LDA #$01 
81EEE7   STA $08  
81EEE9   JSL $8089DE  
81EEED   DEC $3C  
81EEEF   BNE $81EEF3  
81EEF1   STZ $04  
81EEF3   LDX $0D  
81EEF5   LDA #$AE 
81EEF7   LDY #$E9 
81EEF9   JSR $FD53  ;Set $001F   
81EEFC   BEQ $81EF18  
81EEFE   JSR $FE00
81EF01   LDX #$01 
81EF03   JSL GetRandomInt;$808859  
81EF07   BMI $81EF0B  
81EF09   DEX
81EF0A   DEX
81EF0B   STX $3D  
81EF0D   LDA #$04 
81EF0F   STA $04  
81EF11   LDA #$18 
81EF13   STA $3C  
81EF15   JSR $EE6C
81EF18   RTS
----------------   
--------sub start--------
81EF19   DEC $3C  
81EF1B   BNE $81EF22  
81EF1D   INC $3E  
81EF1F   JMP $EE9C
81EF22   LDA $3C  
81EF24   CMP #$10 
81EF26   BNE $81EF2A  
81EF28   BRA $81EF38  
81EF2A   CMP #$08 
81EF2C   BNE $81EF44  
81EF2E   LDA $3E  
81EF30   CMP #$02 
81EF32   BNE $81EF38  
81EF34   STZ $3E  
81EF36   BRA $81EF44  
81EF38   LDA $0D  
81EF3A   CLC
81EF3B   ADC $3D  
81EF3D   AND #$03 
81EF3F   STA $0D  
81EF41   JMP $EE6C
81EF44   RTS
----------------   
--------sub start--------
81EF45   LDX $04  
81EF47   JSR ($EF5A,X)
81EF4A   JSR $FD03
81EF4D   BCC $81EF59  
81EF4F   LDA #$02 
81EF51   STA $03  
81EF53   STZ $04  
81EF55   LDA #$20 
81EF57   BRA $81EF74  
81EF59   RTS
----------------   
--------data--------     
81EF5A  .db $62 $EF $A6 $EF $22 $F0 $80 $F0
----------------   
--------sub start--------
81EF62   JSL GetRandomInt;$808859  
81EF66   AND #$07 
81EF68   STA $37  
81EF6A   LDA $0B  
81EF6C   ASL
81EF6D   ASL
81EF6E   ADC $37  
81EF70   TAX
81EF71   LDA $AFE1,X  
81EF74   XBA
81EF75   LDA #$00 
81EF77   REP #$20 
81EF79   LSR
81EF7A   LSR
81EF7B   LSR
81EF7C   LSR
81EF7D   STA $3E  
81EF7F   SEP #$20 
81EF81   LDA #$02 
81EF83   STA $04  
81EF85   STZ $3C  
81EF87   STZ $36  
81EF89   STZ $35  
81EF8B   LDA #$18 
81EF8D   STA $32  
81EF8F   LDA #$FF 
81EF91   STA $3A  
81EF93   JSR $F095
81EF96   LDA $0B  
81EF98   AND #$07 
81EF9A   TAX
81EF9B   LDA $B068,X  
81EF9E   LDY $B067,X  
81EFA1   JSL Sprite_SetSpeeds ; 80BF9F  
81EFA5   RTS
----------------   
--------sub start--------
81EFA6   LDX #$03 
81EFA8   JSL $8091F6  
81EFAC   BCC $81EFB7  
81EFAE   LDA #$01 
81EFB0   STA $3C  
81EFB2   LDA $3A  
81EFB4   JMP $EE70
81EFB7   LDA $3C  
81EFB9   BEQ $81EFC0  
81EFBB   STZ $3C  
81EFBD   JSR $F0BB
81EFC0   JSL $8089DE  
81EFC4   LDA $08  
81EFC6   CMP #$0E 
81EFC8   BCS $81EFD2  
81EFCA   LDA #$01 
81EFCC   STA $08  
81EFCE   JSL $8089DE  
81EFD2   JSR $F0CE
81EFD5   LDA $009F
81EFD8   CLC
81EFD9   ADC $25  
81EFDB   AND #$03 
81EFDD   BNE $81F000  
81EFDF   LDA $31  
81EFE1   BNE $81EFEB  
81EFE3   JSR $FE4B
81EFE6   LDA $0000
81EFE9   STA $3B  
81EFEB   DEC $32  
81EFED   BNE $81EFF5  
81EFEF   LDA #$18 
81EFF1   STA $32  
81EFF3   STZ $35  
81EFF5   LDA $35  
81EFF7   BNE $81F000  
81EFF9   JSR $F095
81EFFC   JSL Sprite_SetSpeedsAlt ; 80BFA3  
81F000   JSL MoveSprite ; 80C007  
81F004   JSR $E51E
81F007   REP #$20 
81F009   DEC $3E  
81F00B   SEP #$20 
81F00D   BNE $81F021  
81F00F   LDA $31  
81F011   BEQ $81F015  
81F013   STZ $31  
81F015   LDA #$04 
81F017   STA $04  
81F019   LDA #$20 
81F01B   STA $3E  
81F01D   LDA #$0F 
81F01F   STA $3C  
81F021   RTS
----------------   
--------sub start--------
81F022   LDA $3E  
81F024   BNE $81F043  
81F026   LDA #$06 
81F028   STA $04  
81F02A   JSL GetRandomInt;$808859  
81F02E   AND #$07 
81F030   STA $37  
81F032   LDA $0B  
81F034   ASL
81F035   ASL
81F036   ADC $37  
81F038   TAX
81F039   LDA $AFF9,X  
81F03C   STA $3C  
81F03E   LDA $3A  
81F040   JMP $EE70
81F043   AND #$03 
81F045   BNE $81F064  
81F047   JSR $F095
81F04A   LDA $3F  
81F04C   ASL
81F04D   TAX
81F04E   LDA $0D  
81F050   ASL
81F051   ASL
81F052   ASL
81F053   ASL
81F054   PHA
81F055   LDA $B13E,X  
81F058   LDY $B13D,X  
81F05B   PLX
81F05C   JSL $809252  
81F060   INC $3F  
81F062   DEC $3C  
81F064   DEC $3E  
81F066   JSL MoveSprite ; 80C007  
81F06A   JSR $E51E
81F06D   JSL $8089DE  
81F071   LDA $08  
81F073   CMP $3C  
81F075   BCS $81F07F  
81F077   LDA #$01 
81F079   STA $08  
81F07B   JSL $8089DE  
81F07F   RTS
----------------   
--------sub start--------
81F080   DEC $3C  
81F082   BNE $81F094  
81F084   STZ $03  
81F086   STZ $04  
81F088   JSR $E580
81F08B   LDA $0D  
81F08D   LSR
81F08E   LSR
81F08F   STA $0D  
81F091   JMP $F0BB
81F094   RTS
----------------   
--------sub start--------
81F095   LDA #$01 
81F097   XBA
81F098   LDA $3B  
81F09A   REP #$10 
81F09C   TAX
81F09D   JSL $808B0E  
81F0A1   PHA
81F0A2   INC
81F0A3   LSR
81F0A4   AND #$0F 
81F0A6   STA $0D  
81F0A8   PLA
81F0A9   CLC
81F0AA   ADC #$04 
81F0AC   LSR
81F0AD   LSR
81F0AE   LSR
81F0AF   AND #$03 
81F0B1   CMP $3A  
81F0B3   BEQ $81F0BA  
81F0B5   STA $3A  
81F0B7   JSR $F0BD
81F0BA   RTS
----------------   
--------sub start--------
81F0BB   LDA $3A  
--------sub start--------
81F0BD   ASL
81F0BE   TAX
81F0BF   LSR
81F0C0   LSR
81F0C1   STA $0E  
81F0C3   LDA $B370,X  
81F0C6   LDY $B36F,X  
81F0C9   JSL $8089D7  
81F0CD   RTS
----------------   
--------sub start--------
81F0CE   LDA $33  
81F0D0   BNE $81F0FF  
81F0D2   STZ $37  
81F0D4   LDA $3A  
81F0D6   ASL
81F0D7   TAX
81F0D8   PHX
81F0D9   LDA $AF15,X  
81F0DC   LDY $AF16,X  
81F0DF   JSR $FDCA
81F0E2   BEQ $81F0E6  
81F0E4   INC $37  
81F0E6   PLX
81F0E7   LDA $AF1D,X  
81F0EA   LDY $AF1E,X  
81F0ED   JSR $FDCA
81F0F0   BEQ $81F0F8  
81F0F2   LDA $37  
81F0F4   ORA #$02 
81F0F6   STA $37  
81F0F8   LDA $37  
81F0FA   ASL
81F0FB   TAX
81F0FC   JMP ($F102,X)
81F0FF   DEC $33  
81F101   RTS
----------------   
--------data--------     
81F102  .db $0A $F1 $1C $F1 $30 $F1 $3B $F1
----------------   
81F10A   LDA $35  
81F10C   BEQ $81F11B  
81F10E   LDA #$30 
81F110   STA $33  
81F112   JSR $F095
81F115   JSL Sprite_SetSpeedsAlt ; 80BFA3  
81F119   STZ $35  
81F11B   RTS
----------------   
81F11C   LSR
81F11D   STA $34  
81F11F   LDA $3A  
81F121   ASL
81F122   ASL
81F123   ADC #$02 
81F125   AND #$0F 
81F127   STA $0D  
81F129   JSL Sprite_SetSpeedsAlt ; 80BFA3  
81F12D   INC $35  
81F12F   RTS
----------------   
81F130   LSR
81F131   STA $34  
81F133   LDA $3A  
81F135   ASL
81F136   ASL
81F137   SBC #$01 
81F139   BRA $81F125  
81F13B   LDA $0B  
81F13D   BMI $81F14D  
81F13F   LDA $34  
81F141   CMP #$01 
81F143   BNE $81F147  
81F145   BRA $81F0FA  
81F147   CMP #$02 
81F149   BNE $81F14D  
81F14B   BRA $81F0FA  
--------unidentified--------
81F14D  .db $60  
----------------   
81F14E   LDA $1D  
81F150   CMP $1C  
81F152   BEQ $81F15A  
81F154   LDA #$04 
81F156   STA $02  
81F158   STZ $03  
81F15A   LDX $03  
81F15C   JSR ($F168,X)
81F15F   JSL $808A25  
81F163   JSL SpriteSaveDirectPage ; 8088CE  
81F167   RTS
----------------   
--------data--------     
81F168  .db $74 $F1  
----------------   
--------unidentified--------
81F16A  .db $BE $F1 $3F $F2 $42 $F2
----------------   
--------data--------     
81F170  .db $88 $FC $A9 $FC
----------------   
--------sub start--------
81F174   STZ $31  
81F176   LDA $30  
81F178   BEQ $81F18A  
81F17A   LDA $2F  
81F17C   BEQ $81F18A  
81F17E   LDA $3D  
81F180   STA $11  
81F182   LDA $3E  
81F184   STA $14  
81F186   STZ $30  
81F188   STZ $2F  
81F18A   LDA #$01 
81F18C   STA $01  
81F18E   LDA $1D  
81F190   INC
81F191   BNE $81F195  
81F193   INC $30  
81F195   LDA $1C  
81F197   STA $1D  
81F199   BNE $81F1AC  
81F19B   LDA #$B5 
81F19D   LDY #$4F 
81F19F   JSL $8089D7  
81F1A3   LDA #$08 
81F1A5   STA $03  
81F1A7   LDA #$03 
81F1A9   STA $00  
81F1AB   RTS
----------------   
--------unidentified--------
81F1AC  .db $A9 $02 $85 $03 $A9 $B1 $A0 $2D
81F1B4  .db $22 $9F $BF $80 $A9 $04 $85 $3C
81F1BC  .db $64 $3F $AD $AC $00 $D0 $79 $22
81F1C4  .db $07 $C0 $80 $C6 $3C $D0 $02 $E6
81F1CC  .db $3F $A4 $0D $BE $35 $AF $86 $3E
81F1D4  .db $A0 $02 $A5 $0D $4A $B0 $02 $A0
81F1DC  .db $03 $84 $3D $BD $35 $AF $BC $36
81F1E4  .db $AF $20 $CA $FD $F0 $36 $A6 $3F
81F1EC  .db $F0 $07 $A5 $0D $20 $02 $FE $80
81F1F4  .db $0F $29 $F0 $C9 $F0 $F0 $25 $C9
81F1FC  .db $30 $F0 $21 $A5 $0D $20 $02 $FE
81F204  .db $A9 $04 $85 $03 $A5 $3A $20 $70
81F20C  .db $EE $A9 $30 $85 $3C $A5 $11 $85
81F214  .db $3D $A5 $14 $85 $3E $E6 $2F $A9
81F21C  .db $02 $85 $00 $60 $A6 $3E $E8 $E8
81F224  .db $86 $3E $C6 $3D $D0 $B5 $A5 $3F
81F22C  .db $D0 $D6 $20 $45 $F2 $A5 $30 $D0
81F234  .db $07 $AD $9F $00 $29 $03 $85 $01
81F23C  .db $4C $CC $FC $4C $7C $E6 $4C $DC
81F244  .db $E6 $64 $39 $A5 $0D $0A $0A $AA
81F24C  .db $86 $38 $BD $4D $AF $BC $4E $AF
81F254  .db $20 $CA $FD $F0 $04 $85 $3F $E6
81F25C  .db $39 $A6 $38 $BD $4F $AF $BC $50
81F264  .db $AF $20 $CA $FD $F0 $08 $85 $3F
81F26C  .db $A5 $39 $09 $02 $85 $39 $A5 $39
81F274  .db $F0 $4D $0A $0A $0A $85 $38 $A5
81F27C  .db $0D $0A $65 $38 $AA $A5 $11 $18
81F284  .db $7D $55 $AF $85 $11 $A5 $14 $18
81F28C  .db $7D $56 $AF $85 $14 $A5 $3F $C9
81F294  .db $F0 $F0 $04 $C9 $30 $D0 $28 $A9
81F29C  .db $B5 $A0 $61 $22 $D7 $89 $80 $A2
81F2A4  .db $0F $A5 $3F $C9 $F0 $F0 $0A $A9
81F2AC  .db $B5 $A0 $AD $22 $D7 $89 $80 $A2
81F2B4  .db $0E $86 $3C $A9 $03 $85 $00 $A9
81F2BC  .db $06 $85 $03 $85 $01 $68 $68 $60

;Purplehat big pirate
81F2C4   LDX $02                  
81F2C6   JMP ($F2C9,X)            
--------data--------     
81F2C9  .db $D1 $F2 $0B $F3      
----------------         
--------unidentified--------
81F2CD
dw $F446
dw $E790      
----------------         
81F2D1   LDX $03                  
81F2D3   JSR ($F2DF,X)            
81F2D6   JSL $808A25              
81F2DA   JSL $8088CE              
81F2DE   RTS                      
----------------         
--------data--------     
81F2DF  .db $E3 $F2 $8A $ED      
----------------         
--------sub start--------
81F2E3   JSL $808EE9              
81F2E7   BCS $81F307              
81F2E9   LDA #$05                 
81F2EB   STA $1C                  
81F2ED   STA $1D                  
81F2EF   STZ $2D                  
81F2F1   LDA #$A0                 
81F2F3   STA $4F                  
81F2F5   LDA $00B6                
81F2F8   ASL                      
81F2F9   TAX                      
81F2FA   LDA $B15E,X              
81F2FD   LDY $B15D,X              
81F300   JSL $80896D              
81F304   JMP $ED4E                
--------unidentified--------
81F307  .db $22 $0F $8F $80      
----------------         
81F30B   LDA $1D                  
81F30D   CMP $1C                  
81F30F   BEQ $81F31A              
81F311   LDA #$04                 
81F313   STA $02                  
81F315   STZ $03                  
81F317   JMP $F15A                
81F31A   LDA $00AC                
81F31D   BNE $81F339              
81F31F   LDA $2D                  
81F321   BNE $81F328              
81F323   JSR $F4AC                
81F326   BRA $81F32A              
--------unidentified--------
81F328  .db $C6 $2D              
----------------         
81F32A   LDX $03                  
81F32C   JSR ($F33E,X)            
81F32F   JSR $FD2D                
81F332   JSL $808A25              
81F336   JSR $FCCC                
81F339   JSL $8088CE              
81F33D   RTS                      


81F33E  .db $3B $EE $45 $EF $44 $F3
81F344  .db $A6 $04 $7C $49 $F3 $4F $F3 $6A
81F34C  .db $F3 $C8 $F3 $A9 $02 $85 $04 $A5
81F354  .db $2E $20 $BD $F0 $A9 $B1 $A0 $A1
81F35C  .db $22 $9F $BF $80 $A5 $2E $0A $0A
81F364  .db $85 $3C $A9 $80 $85 $2D $64 $3D
81F36C  .db $A6 $3C $BD $81 $B1 $BC $82 $B1
81F374  .db $20 $CA $FD $29 $F0 $C5 $4F $D0
81F37C  .db $02 $E6 $3D $A6 $3C $BD $83 $B1
81F384  .db $BC $84 $B1 $20 $CA $FD $29 $F0
81F38C  .db $C5 $4F $D0 $02 $E6 $3D $A5 $3D
81F394  .db $F0 $3C $C9 $02 $D0 $17 $A9 $04
81F39C  .db $85 $04 $A5 $2E $0A $AA $4A $4A
81F3A4  .db $85 $0E $BD $45 $B4 $BC $44 $B4
81F3AC  .db $22 $D7 $89 $80 $60 $22 $DE $89
81F3B4  .db $80 $A5 $08 $C9 $0B $D0 $08 $A9
81F3BC  .db $01 $85 $08 $22 $DE $89 $80 $22
81F3C4  .db $07 $C0 $80 $60 $22 $DE $89 $80
81F3CC  .db $A5 $08 $C9 $70 $D0 $06 $64 $03
81F3D4  .db $64 $04 $64 $31 $C9 $78 $D0 $60
81F3DC  .db $20 $49 $F4 $C2 $30 $A5 $40 $0A
81F3E4  .db $AA $BF $00 $E0 $7F $F0 $52 $38
81F3EC  .db $E9 $B4 $03 $85 $37 $E2 $30 $22
81F3F4  .db $8E $8F $80 $B0 $41 $A5 $37 $4A
81F3FC  .db $9D $0B $00 $BD $00 $00 $D0 $05
81F404  .db $A9 $02 $9D $00 $00 $9E $02 $00
81F40C  .db $9E $03 $00 $9E $04 $00 $A9 $02
81F414  .db $9D $0A $00 $9E $05 $00 $A5 $40
81F41C  .db $0A $0A $0A $18 $69 $08 $9D $11
81F424  .db $00 $C2 $20 $A5 $40 $4A $4A $E2
81F42C  .db $21 $29 $F8 $69 $07 $9D $14 $00
81F434  .db $A5 $2E $0A $9D $0D $00 $E2 $10
81F43C  .db $60 $BF $02 $E0 $7F $AA $E2 $20
81F444  .db $80 $B9  
----------------   
81F446   JMP $F14E
--------sub start--------
81F449   LDX $3C  
81F44B   LDA $B183,X  
81F44E   LDY $B184,X  
81F451   JSR $FDCA
81F454   AND #$F0 
81F456   CMP $4F  
81F458   BEQ $81F463  
81F45A   STZ $03  
81F45C   STZ $04  
81F45E   STZ $31  
81F460   PLA
81F461   PLA
81F462   RTS
----------------   
81F463   REP #$10 
81F465   JSR $FDE0
81F468   LDA #$00 
81F46A   XBA
81F46B   LDA $2E  
81F46D   TAY
81F46E   LDA $B1B1,Y  
81F471   STA $37  
81F473   LDA #$FF 
81F475   STA $38  
81F477   REP #$21 
81F479   TXA
81F47A   ADC $37  
81F47C   TAX
81F47D   SEP #$20 
81F47F   LDA $1400,X  
81F482   CMP $4F  
81F484   BEQ $81F49F  
81F486   INX
81F487   LDA $1400,X  
81F48A   CMP $4F  
81F48C   BEQ $81F49F  
81F48E   REP #$21 
81F490   TXA
81F491   ADC #$001F   
81F494   TAX
81F495   SEP #$20 
81F497   LDA $1400,X  
81F49A   CMP $4F  
81F49C   BEQ $81F49F  
81F49E   INX
81F49F   REP #$20 
81F4A1   STX $37  
81F4A3   STX $40  
81F4A5   JSL $8088F0  
81F4A9   SEP #$30 
81F4AB   RTS
----------------   
--------sub start--------
81F4AC   LDA $3A  
81F4AE   DEC
81F4AF   AND #$03 
81F4B1   STA $2E  
81F4B3   ASL
81F4B4   ASL
81F4B5   TAX
81F4B6   LDA #$03 
81F4B8   STA $37  
81F4BA   STX $38  
81F4BC   LDA $B181,X  
81F4BF   LDY $B182,X  
81F4C2   JSR $FDCA
81F4C5   AND #$F0 
81F4C7   CMP $4F  
81F4C9   BNE $81F4EE  
81F4CB   LDA $4F  
81F4CD   CMP #$A0 
81F4CF   BNE $81F4DE  
81F4D1   LDX $38  
81F4D3   LDA $B191,X  
81F4D6   LDY $B192,X  
81F4D9   JSR $FDCA
--------unidentified--------
81F4DC  .db $D0 $10  
----------------   
81F4DE   LDA $2E  
81F4E0   DEC
81F4E1   AND #$03 
81F4E3   STA $0D  
81F4E5   LDA #$04 
81F4E7   STA $03  
81F4E9   STA $45  
81F4EB   STZ $04  
81F4ED   RTS
----------------   
81F4EE   LDX $38  
81F4F0   LDA $B183,X  
81F4F3   LDY $B184,X  
81F4F6   JSR $FDCA
81F4F9   AND #$F0 
81F4FB   CMP $4F  
81F4FD   BNE $81F51B  
81F4FF   LDA $4F  
81F501   CMP #$A0 
81F503   BNE $81F512  
81F505   LDX $38  
81F507   LDA $B193,X  
81F50A   LDY $B194,X  
81F50D   JSR $FDCA
--------unidentified--------
81F510  .db $D0 $09 $A5 $2E $1A $29 $03 $85
81F518  .db $0D $80 $CA    
----------------   
81F51B   LDA $2E  
81F51D   INC
81F51E   AND #$03 
81F520   STA $2E  
81F522   ASL
81F523   ASL
81F524   TAX
81F525   DEC $37  
81F527   BNE $81F4BA  
81F529   RTS
----------------   

;Big Pirate Rolling
81F52A   LDX $02  
81F52C   JMP ($F52F,X)
--------data--------     
81F52F  .db 
dw $F537
dw $F582
dw $F446
dw $E790

81F537   LDX $03  
81F539   JSR ($F545,X)
81F53C   JSL $808A25  
81F540   JSL SpriteSaveDirectPage ; 8088CE  
81F544   RTS
----------------   
--------data--------     
81F545  .db $4D $F5 $8A $ED
----------------   
--------unidentified--------
81F549  .db $8D $ED $75 $F5
----------------   
--------sub start--------
81F54D   JSL $808EE9  
81F551   BCS $81F571  
81F553   LDA #$05 
81F555   STA $1C  
81F557   STA $1D  
81F559   STZ $46  
81F55B   LDA #$A0 
81F55D   STA $4F  
81F55F   LDA $00B6
81F562   ASL
81F563   TAX
81F564   LDA $B1B6,X  
81F567   LDY $B1B5,X  
81F56A   JSL $80896D  
81F56E   JMP $ED4E
--------unidentified--------
81F571  .db $22 $0F $8F $80 $20 $4D $F5 $A9
81F579  .db $04 $85 $03 $3A $85 $00 $68 $68
81F581  .db $60  
----------------   
81F582   LDA $1D  
81F584   CMP $1C  
81F586   BEQ $81F591  
81F588   LDA #$04 
81F58A   STA $02  
81F58C   STZ $03  
81F58E   JMP $F15A
81F591   LDA $00AC
81F594   BNE $81F5EE  
81F596   LDA $03  
81F598   CMP #$04 
81F59A   BEQ $81F5DF  
81F59C   CMP #$06 
81F59E   BEQ $81F5DF  
81F5A0   LDA $46  
81F5A2   BNE $81F5A6  
81F5A4   BRA $81F5AA  
--------unidentified--------
81F5A6  .db $C6 $46 $80 $2A
----------------   
81F5AA   JSR $F75F
81F5AD   LDA $37  
81F5AF   CMP #$FF 
81F5B1   BEQ $81F5D4  
81F5B3   LDA #$01 
81F5B5   XBA
81F5B6   LDA $37  
81F5B8   REP #$10 
81F5BA   TAX
81F5BB   JSL $808B0E  
81F5BF   LSR
81F5C0   LSR
81F5C1   INC
81F5C2   LSR
81F5C3   AND #$03 
81F5C5   STA $0D  
81F5C7   JSR $EE6C
81F5CA   LDA #$06 
81F5CC   STA $03  
81F5CE   STZ $04  
81F5D0   LDA #$04 
81F5D2   STA $3C  
81F5D4   LDA $2D  
81F5D6   BNE $81F5DD  
81F5D8   JSR $F4AC
81F5DB   BRA $81F5DF  
--------unidentified--------
81F5DD  .db $C6 $2D  
----------------   
81F5DF   LDX $03  
81F5E1   JSR ($F5F3,X)
81F5E4   JSR $FD2D
81F5E7   JSL $808A25  
81F5EB   JSR $FCCC
81F5EE   JSL SpriteSaveDirectPage ; 8088CE  
81F5F2   RTS
----------------   
--------data--------     
81F5F3  .db $3B $EE  
----------------   
--------unidentified--------
81F5F5  .db $45 $EF $44 $F3
----------------   
--------data--------     
81F5F9  .db $FB $F5  
----------------   
--------sub start--------
81F5FB   LDX $04  
81F5FD   JMP ($F600,X)
--------data--------     
81F600  .db $0A $F6 $25 $F6 $5D $F6 $7C $F6
81F608  .db $13 $F7  
----------------   
81F60A   DEC $3C  
81F60C   BNE $81F624  
81F60E   LDA #$02 
81F610   STA $04  
81F612   LDA $0D  
81F614   ASL
81F615   TAX
81F616   LSR
81F617   LSR
81F618   STA $0E  
81F61A   LDA $B49B,X  
81F61D   LDY $B49A,X  
81F620   JSL $8089D7  
81F624   RTS
----------------   
81F625   JSL $8089DE  
81F629   LDA $08  
81F62B   CMP #$70 
81F62D   BNE $81F65C  
81F62F   LDA #$04 
81F631   STA $04  
81F633   LDA $0D  
81F635   ASL
81F636   TAX
81F637   LSR
81F638   LSR
81F639   STA $0E  
81F63B   LDA $B4F1,X  
81F63E   LDY $B4F0,X  
81F641   JSL $8089D7  
81F645   STZ $47  
81F647   STZ $48  
81F649   INC $1F  
81F64B   LDA #$0C 
81F64D   STA $17  
81F64F   REP #$20 
81F651   LDA $11  
81F653   STA $49  
81F655   LDA $14  
81F657   STA $4B  
81F659   JSR $F6FF
81F65C   RTS
----------------   
81F65D   JSL $8089DE  
81F661   LDA $08  
81F663   CMP #$03 
81F665   BNE $81F66F  
81F667   LDA #$01 
81F669   STA $08  
81F66B   JSL $8089DE  
81F66F   DEC $17  
81F671   DEC $17  
81F673   BNE $81F67B  
81F675   LDA #$06 
81F677   STA $04  
81F679   STZ $17  
81F67B   RTS
----------------   
81F67C   JSL MoveSprite ; 80C007  
81F680   JSL $8089DE  
81F684   LDA $08  
81F686   CMP $48  
81F688   BCS $81F692  
81F68A   LDA #$01 
81F68C   STA $08  
81F68E   JSL $8089DE  
81F692   LDX $0D  
81F694   LDA #$B1 
81F696   LDY #$D9 
81F698   JSR $FD53  ;Set $001F   
81F69B   BEQ $81F6E9  
81F69D   LDA #$08 
81F69F   STA $04  
81F6A1   LDA #$27 
81F6A3   JSL PlaySFX ;$809A53
81F6A7   JSR $FE00
81F6AA   LDA $48  
81F6AC   ASL
81F6AD   TAX
81F6AE   REP #$20 
81F6B0   LDA $B1EF,X  
81F6B3   STA $4D  
81F6B5   LDA $11  
81F6B7   SEC
81F6B8   SBC $49  
81F6BA   CLC
81F6BB   ADC $14  
81F6BD   SEC
81F6BE   SBC $4B  
81F6C0   BPL $81F6C6  
81F6C2   EOR #$FFFF   
81F6C5   INC
81F6C6   SEP #$20 
81F6C8   LDY #$20 
81F6CA   LSR
81F6CB   LSR
81F6CC   LSR
81F6CD   LSR
81F6CE   BNE $81F6D5  
81F6D0   TAY
81F6D1   LDA #$80 
81F6D3   STA $46  
81F6D5   LDA $0D  
81F6D7   INC
81F6D8   INC
81F6D9   AND #$03 
81F6DB   ASL
81F6DC   ASL
81F6DD   ASL
81F6DE   ASL
81F6DF   ASL
81F6E0   ASL
81F6E1   TAX
81F6E2   LDA #$00 
81F6E4   JSL $809252  
81F6E8   RTS
----------------   
81F6E9   LDA $48  
81F6EB   CMP #$04 
81F6ED   BEQ $81F712  
81F6EF   LDA $009F
81F6F2   AND #$03 
81F6F4   BNE $81F712  
81F6F6   REP #$21 
81F6F8   LDA $47  
81F6FA   ADC #$0080   
81F6FD   STA $47  
--------sub start--------
81F6FF   LDA $0D  
81F701   AND #$00FF   
81F704   XBA
81F705   LSR
81F706   LSR
81F707   SEP #$20 
81F709   TAX
81F70A   LDA $48  
81F70C   LDY $47  
81F70E   JSL $809252  
81F712   RTS
----------------   
81F713   JSL $8089DE  
81F717   LDA $08  
81F719   CMP #$03 
81F71B   BNE $81F725  
81F71D   LDA #$01 
81F71F   STA $08  
81F721   JSL $8089DE  
81F725   JSL MoveSprite ; 80C007  
81F729   REP #$21 
81F72B   LDA $4D  
81F72D   ADC $16  
81F72F   STA $16  
81F731   LDA $4D  
81F733   SEC
81F734   SBC #$0030   
81F737   STA $4D  
81F739   SEP #$20 
81F73B   LDA $17  
81F73D   BPL $81F75E  
81F73F   LDA #$03 
81F741   STA $37  
81F743   LDX $37  
81F745   LDA #$B1 
81F747   LDY #$D9 
81F749   JSR $FD53 ;Set $001F
81F74C   BEQ $81F750  
81F74E   STZ $1C  
81F750   DEC $37  
81F752   BPL $81F743  
81F754   STZ $03  
81F756   STZ $04  
81F758   STZ $17  
81F75A   STZ $1F  
81F75C   STZ $31  
81F75E   RTS
----------------   
--------sub start--------
81F75F   LDA #$FF 
81F761   STA $37  
81F763   LDX #$00 
81F765   JSR $F781
81F768   BCS $81F76C  
81F76A   STX $37  
81F76C   LDX #$80 
81F76E   JSR $F781
81F771   BCS $81F780  
81F773   LDA $37  
81F775   BNE $81F77E  
81F777   JSL $80919A  
--------unidentified--------
81F77B  .db $AE $00 $00 $86 $37  
----------------   
81F780   RTS
----------------   
--------sub start--------
81F781   LDA $0100,X  
81F784   BNE $81F788  
81F786   SEC
81F787   RTS
----------------   
81F788   LDA $11  
81F78A   CLC
81F78B   ADC #$08 
81F78D   SEC
81F78E   SBC $0111,X  
81F791   CMP #$10 
81F793   BCS $81F796  
81F795   RTS
----------------   
81F796   LDA $14  
81F798   CLC
81F799   ADC #$08 
81F79B   SEC
81F79C   SBC $0114,X  
81F79F   CMP #$10 
81F7A1   RTS

;Red Big Pirate!
81F7A2   LDX $02                  
81F7A4   JMP ($F7A7,X)            
--------data--------     
81F7A7
dw $F7AF
dw $F7EB
dw $FAA6
dw $E790
----------------         
81F7AF   LDX $03                  
81F7B1   JSR ($F7C0,X)            
81F7B4   JSR $FD2D                
81F7B7   JSL $808A25              
81F7BB   JSL $8088CE              
81F7BF   RTS                      
----------------         
--------data--------     
81F7C0  .db $C4 $F7 $8A $ED      
----------------         
--------sub start--------
81F7C4   JSL $808EE9              
81F7C8   BCS $81F7E6              
81F7CA   LDA #$05                 
81F7CC   STA $1C                  
81F7CE   STA $1D                  
81F7D0   STZ $40                  
81F7D2   STZ $42                  
81F7D4   LDA $00B6                
81F7D7   ASL                      
81F7D8   TAX                      
81F7D9   LDA $B1FA,X              
81F7DC   LDY $B1F9,X              
81F7DF   JSL $80896D              
81F7E3   JMP $ED4E                
--------unidentified--------
81F7E6  .db $22 $0F $8F $80 $60  
----------------         
81F7EB   LDA $1D                  
81F7ED   CMP $1C                  
81F7EF   BEQ $81F837              
81F7F1   INC                      
81F7F2   BNE $81F822              
81F7F4   LDA $1C                  
81F7F6   STA $1D                  
81F7F8   LDA $03                  
81F7FA   CMP #$06                 
81F7FC   BNE $81F837              
81F7FE   LDA $04                  
81F800   CMP #$06                 
81F802   BNE $81F837              
81F804   LDA $0D                  
81F806   INC                      
81F807   INC                      
81F808   AND #$03                 
81F80A   CMP $3A                  
81F80C   BEQ $81F837              
81F80E   LDA #$08                 
81F810   STA $03                  
81F812   STZ $04                  
81F814   LDA #$01                 
81F816   STA $46                  
81F818   STZ $45                  
81F81A   JSR $F986                
--------unidentified--------
81F81D  .db $20 $5D $FA $80 $15  
----------------         
81F822   LDA $1C                  
81F824   BEQ $81F82E              
81F826   STA $1D                  
81F828   LDA #$30                 
81F82A   STA $42                  
81F82C   BRA $81F837              
81F82E   LDA #$04                 
81F830   STA $02                  
81F832   STZ $03                  
81F834   JMP $FAA6                
81F837   LDA $00AC                
81F83A   BNE $81F883              
81F83C   LDA $42                  
81F83E   BEQ $81F84E              
81F840   DEC                      
81F841   STA $42                  
81F843   BNE $81F84A              
81F845   INC                      
81F846   STA $01                  
81F848   BRA $81F84E              
--------unidentified--------
81F84A  .db $29 $03 $85 $01      
----------------         
81F84E   LDA $41                  
81F850   BEQ $81F856              
81F852   DEC $41                  
81F854   BRA $81F87A              
81F856   LDA $03                  
81F858   CMP #$06                 
81F85A   BEQ $81F87A              
81F85C   JSR $FC00                
81F85F   LDA $37                  
81F861   INC                      
81F862   BEQ $81F878              
81F864   INC $40                  
81F866   LDA $40                  
81F868   CMP #$1A                 
81F86A   BCC $81F87A              
81F86C   LDA $03                  
81F86E   CMP #$04                 
81F870   BEQ $81F87A              
81F872   LDA #$06                 
81F874   STA $03                  
81F876   STZ $04                  
81F878   STZ $40                  
81F87A   LDX $03                  
81F87C   JSR ($F888,X)            
81F87F   JSL $808A25              
81F883   JSL $8088CE              
81F887   RTS                      
----------------         
--------data--------     
81F888  .db $92 $F8 $A3 $F8 $C8 $F8 $61 $F9
----------------         
--------unidentified--------
81F890  .db $6C $FA              
----------------         
--------sub start--------
81F892   JSL $808859              
81F896   LDX #$04                 
81F898   AND #$03                 
81F89A   BNE $81F89E              
81F89C   LDX #$02                 
81F89E   STX $03                  
81F8A0   STZ $04                  
81F8A2   RTS                      
----------------         
--------sub start--------
81F8A3   LDX $04                  
81F8A5   JMP ($F8A8,X)            
--------data--------     
81F8A8  .db $AC $F8 $C1 $F8      
----------------         
81F8AC   LDA #$02                 
81F8AE   STA $04                  
81F8B0   JSR $FE4B                
81F8B3   LDA #$01                 
81F8B5   XBA                      
81F8B6   LDA $0000                
81F8B9   JSR $FACC                
81F8BC   LDA #$20                 
81F8BE   STA $3C                  
81F8C0   RTS                      
----------------         
81F8C1   DEC $3C                  
81F8C3   BNE $81F8C7              
81F8C5   STZ $03                  
81F8C7   RTS                      
----------------         
--------sub start--------
81F8C8   LDX $04                  
81F8CA   JMP ($F8CD,X)            
--------data--------     
81F8CD  .db $D1 $F8 $1E $F9      
----------------         
81F8D1   LDA #$02                 
81F8D3   STA $04                  
81F8D5   LDA $0D                  
81F8D7   STA $37                  
81F8D9   STZ $0D                  
81F8DB   LDA #$01                 
81F8DD   STA $38                  
81F8DF   STZ $39                  
81F8E1   LDA #$B2                 
81F8E3   LDY #$2D                 
81F8E5   LDX #$02                 
81F8E7   JSR $9782                
81F8EA   BNE $81F8F7              
81F8EC   LDA #$B2                 
81F8EE   LDY #$31                 
81F8F0   LDX #$02                 
81F8F2   JSR $9782                
81F8F5   BEQ $81F8FD              
81F8F7   LDA $38                  
81F8F9   ORA $39                  
81F8FB   STA $39                  
81F8FD   ASL $38                  
81F8FF   INC $0D                  
81F901   LDA $0D                  
81F903   CMP #$04                 
81F905   BNE $81F8E1              
81F907   LDA $37                  
81F909   STA $0D                  
81F90B   JSR $FAE1                
81F90E   JSR $F0BD                
81F911   LDA #$B2                 
81F913   LDY #$1D                 
81F915   JSL $80BF9F              
81F919   LDA #$20                 
81F91B   STA $3C                  
81F91D   RTS                      
----------------         
81F91E   JSL $8089DE              
81F922   LDA $08                  
81F924   CMP #$0C                 
81F926   BNE $81F930              
81F928   LDA #$01                 
81F92A   STA $08                  
81F92C   JSL $8089DE              
81F930   JSL $80C007              
81F934   DEC $3C                  
81F936   BNE $81F93B              
81F938   STZ $03                  
81F93A   RTS                      
----------------         
81F93B   LDX $0D                  
81F93D   LDA #$AE                 
81F93F   LDY #$E9                 
81F941   JSR $FD53                
81F944   BEQ $81F960              
81F946   LDA $0D                  
81F948   INC                      
81F949   INC                      
81F94A   AND #$03                 
81F94C   STA $0D                  
81F94E   JSR $F0BD                
--------unidentified--------
81F951  .db $A9 $B2 $A0 $1D $22 $9F $BF $80
81F959  .db $A9 $20 $38 $E5 $3C $85 $3C
----------------         
81F960   RTS                      
----------------         
--------sub start--------
81F961   LDX $04                  
81F963   JMP ($F966,X)            
--------data--------     
81F966  .db $6E $F9 $7E $F9 $99 $F9 $FE $F9
----------------         
81F96E   LDA #$02                 
81F970   STA $04                  
81F972   LDA #$01                 
81F974   XBA                      
81F975   LDA $37                  
81F977   JSR $FACC                
81F97A   LDA #$10                 
81F97C   STA $3C                  
81F97E   DEC $3C                  
81F980   BNE $81F998              
81F982   LDA #$04                 
81F984   STA $04                  
81F986   LDA $3A                  
81F988   ASL                      
81F989   TAX                      
81F98A   LSR                      
81F98B   LSR                      
81F98C   STA $0E                  
81F98E   LDA $B66D,X              
81F991   LDY $B66C,X              
81F994   JSL $8089D7              
81F998   RTS                      
----------------         
81F999   JSL $8089DE              
81F99D   LDA $08                  
81F99F   CMP #$70                 
81F9A1   BEQ $81F9A4              
81F9A3   RTS                      
----------------         
81F9A4   LDA #$06                 
81F9A6   STA $04                  
81F9A8   LDA #$FF                 
81F9AA   STA $3C                  
81F9AC   LDA #$01                 
81F9AE   STA $3E                  
81F9B0   JSL $808F73              
81F9B4   BCS $81F9FC              
81F9B6   STZ $0002,X              
81F9B9   STZ $0003,X              
81F9BC   STZ $0004,X              
81F9BF   LDA #$03                 
81F9C1   STA $0000,X              
81F9C4   LDA #$30                 
81F9C6   STA $000A,X              
81F9C9   LDA #$0A                 
81F9CB   STA $000B,X              
81F9CE   LDA $0C                  
81F9D0   STA $000C,X              
81F9D3   LDA #$00                 
81F9D5   XBA                      
81F9D6   LDA $3A                  
81F9D8   ASL                      
81F9D9   TAY                      
81F9DA   LDA $11                  
81F9DC   ADC $B31D,Y              
81F9DF   STA $0011,X              
81F9E2   STZ $0012,X              
81F9E5   LDA $14                  
81F9E7   CLC                      
81F9E8   ADC $B31E,Y              
81F9EB   STA $0014,X              
81F9EE   STZ $0015,X              
81F9F1   LDA #$0A                 
81F9F3   STA $0017,X              
81F9F6   REP #$20                 
81F9F8   TDC                      
81F9F9   STA $0043,X              
81F9FC   SEP #$30                 
81F9FE   DEC $3E                  
81FA00   BNE $81FA57              
81FA02   LDA #$08                 
81FA04   STA $3E                  
81FA06   JSL $808F73              
81FA0A   BCS $81FA55              
81FA0C   STZ $0002,X              
81FA0F   STZ $0003,X              
81FA12   STZ $0004,X              
81FA15   LDA #$03                 
81FA17   STA $0000,X              
81FA1A   LDA #$30                 
81FA1C   STA $000A,X              
81FA1F   LDA #$08                 
81FA21   STA $000B,X              
81FA24   LDA $0C                  
81FA26   STA $000C,X              
81FA29   LDA #$00                 
81FA2B   XBA                      
81FA2C   LDA $3A                  
81FA2E   STA $000D,X              
81FA31   ASL                      
81FA32   TAY                      
81FA33   LDA $11                  
81FA35   ADC $B31D,Y              
81FA38   STA $0011,X              
81FA3B   STZ $0012,X              
81FA3E   LDA $14                  
81FA40   CLC                      
81FA41   ADC $B31E,Y              
81FA44   STA $0014,X              
81FA47   STZ $0015,X              
81FA4A   LDA #$0A                 
81FA4C   STA $0017,X              
81FA4F   REP #$20                 
81FA51   TDC                      
81FA52   STA $0043,X              
81FA55   SEP #$30                 
81FA57   DEC $3C                  
81FA59   BNE $81FA6B              
81FA5B   STZ $03                  
81FA5D   LDA #$3C                 
81FA5F   STA $41                  
81FA61   LDA #$08                 
81FA63   JSR $BDB3                
81FA66   LDA #$0A                 
81FA68   JMP $BDB3                
81FA6B   RTS                      
----------------         
--------unidentified--------
81FA6C  .db $A6 $04 $7C $71 $FA $75 $FA $9B
81FA74  .db $FA $C2 $21 $A5 $16 $65 $45 $85
81FA7C  .db $16 $A5 $45 $38 $E9 $30 $00 $85
81FA84  .db $45 $E2 $20 $A5 $17 $10 $0F $64
81FA8C  .db $17 $A9 $10 $85 $3C $A9 $02 $85
81FA94  .db $04 $A5 $3A $20 $70 $EE $60 $C6
81FA9C  .db $3C $D0 $06 $A9 $02 $85 $03 $64
81FAA4  .db $04 $60              
----------------         
81FAA6   LDX $03                  
81FAA8   JSR ($FAB4,X)            
81FAAB   JSL $808A25              
81FAAF   JSL $8088CE              
81FAB3   RTS                      
----------------         
--------data--------     
81FAB4  .db $BA $FA $88 $FC $A9 $FC
----------------         
--------sub start--------
81FABA   LDA #$02                 
81FABC   STA $03                  
81FABE   INC                      
81FABF   STA $00                  
81FAC1   LDA #$B5                 
81FAC3   LDY #$4F                 
81FAC5   JSL $8089D7              
81FAC9   JMP $FA61                
--------sub start--------
81FACC   REP #$10                 
81FACE   TAX                      
81FACF   JSL $808B0E              
81FAD3   LSR                      
81FAD4   LSR                      
81FAD5   INC                      
81FAD6   LSR                      
81FAD7   AND #$03                 
81FAD9   STA $0D                  
81FADB   STA $3A                  
81FADD   JSR $EE70                
81FAE0   RTS                      
----------------         
--------sub start--------
81FAE1   JSL $808859              
81FAE5   AND #$07                 
81FAE7   STA $37                  
81FAE9   STZ $38                  
81FAEB   LDA $39                  
81FAED   ASL                      
81FAEE   TAX                      
81FAEF   JSR ($FAF7,X)            
81FAF2   STA $0D                  
81FAF4   STA $3A                  
81FAF6   RTS                      
----------------         
--------data--------     
81FAF7  .db $17 $FB              
----------------         
--------unidentified--------
81FAF9  .db $29 $FB $3F $FB $54 $FB $6A $FB
----------------         
--------data--------     
81FB01  .db $7C $FB              
----------------         
--------unidentified--------
81FB03  .db $8E $FB $A3 $FB $A6 $FB $BB $FB
----------------         
--------data--------     
81FB0B  .db $D0 $FB              
----------------         
--------unidentified--------
81FB0D  .db $E5 $FB $E8 $FB $FA $FB $FD $FB
81FB15  .db $FD $FB              
----------------         
--------sub start--------
81FB17   LDA $0D                  
81FB19   ASL                      
81FB1A   TAX                      
81FB1B   REP #$31                 
81FB1D   LDA $B24D,X              
81FB20   ADC $37                  
81FB22   TAY                      
81FB23   LDA $0000,Y              
81FB26   SEP #$30                 
81FB28   RTS                      
----------------         
--------unidentified--------
81FB29  .db $A5 $0D $0A $AA $C2 $31 $BD $75
81FB31  .db $B2 $65 $37 $A8 $B9 $00 $00 $E2
81FB39  .db $30 $1A $1A $29 $03 $60 $A5 $0D
81FB41  .db $0A $AA $C2 $31 $BD $7D $B2 $65
81FB49  .db $37 $A8 $B9 $00 $00 $E2 $30 $3A
81FB51  .db $29 $03 $60 $A5 $0D $0A $AA $C2
81FB59  .db $31 $BD $B5 $B2 $65 $37 $A8 $B9
81FB61  .db $00 $00 $E2 $30 $1A $1A $29 $03
81FB69  .db $60 $A5 $0D $0A $AA $C2 $31 $BD
81FB71  .db $85 $B2 $65 $37 $A8 $B9 $00 $00
81FB79  .db $E2 $30 $60          
----------------         
--------sub start--------
81FB7C   LDA $0D                  
81FB7E   ASL                      
81FB7F   TAX                      
81FB80   REP #$31                 
81FB82   LDA $B2F5,X              
81FB85   ADC $37                  
81FB87   TAY                      
81FB88   LDA $0000,Y              
81FB8B   SEP #$30                 
81FB8D   RTS                      
----------------         
--------unidentified--------
81FB8E  .db $A5 $0D $0A $AA $C2 $31 $BD $BD
81FB96  .db $B2 $65 $37 $A8 $B9 $00 $00 $E2
81FB9E  .db $30 $3A $29 $03 $60 $A9 $03 $60
81FBA6  .db $A5 $0D $0A $AA $C2 $31 $BD $8D
81FBAE  .db $B2 $65 $37 $A8 $B9 $00 $00 $E2
81FBB6  .db $30 $1A $29 $03 $60 $A5 $0D $0A
81FBBE  .db $AA $C2 $31 $BD $CD $B2 $65 $37
81FBC6  .db $A8 $B9 $00 $00 $E2 $30 $1A $29
81FBCE  .db $03 $60              
----------------         
--------sub start--------
81FBD0   LDA $0D                  
81FBD2   ASL                      
81FBD3   TAX                      
81FBD4   REP #$31                 
81FBD6   LDA $B2FD,X              
81FBD9   ADC $37                  
81FBDB   TAY                      
81FBDC   LDA $0000,Y              
81FBDF   SEP #$30                 
81FBE1   INC                      
81FBE2   AND #$03                 
81FBE4   RTS                      
----------------         
--------unidentified--------
81FBE5  .db $A9 $02 $60 $A5 $0D $0A $AA $C2
81FBED  .db $31 $BD $C5 $B2 $65 $37 $A8 $B9
81FBF5  .db $00 $00 $E2 $30 $60 $A9 $01 $60
81FBFD  .db $A9 $00 $60          
----------------         
--------sub start--------
81FC00   LDA #$FF                 
81FC02   STA $37                  
81FC04   LDX #$00                 
81FC06   LDA $0100,X              
81FC09   BEQ $81FC19              
81FC0B   JSR $FC3A                
81FC0E   BCS $81FC12              
81FC10   BRA $81FC17              
81FC12   JSR $FC52                
81FC15   BCS $81FC19              
81FC17   STX $37                  
81FC19   LDX #$80                 
81FC1B   LDA $0100,X              
81FC1E   BEQ $81FC39              
81FC20   JSR $FC3A                
--------unidentified--------
81FC23  .db $B0 $02 $80 $05 $20 $52 $FC $B0
81FC2B  .db $0D $A5 $37 $D0 $07 $22 $9A $91
81FC33  .db $80 $AE $00 $00 $86 $37
----------------         
81FC39   RTS                      
----------------         
--------sub start--------
81FC3A   REP #$20                 
81FC3C   LDA #$0050               
81FC3F   STA $0000                
81FC42   ASL                      
81FC43   STA $0002                
81FC46   LDA #$0010               
81FC49   STA $0004                
81FC4C   ASL                      
81FC4D   STA $0006                
81FC50   BRA $81FC68              
--------sub start--------
81FC52   REP #$20                 
81FC54   LDA #$0010               
81FC57   STA $0000                
81FC5A   ASL                      
81FC5B   STA $0002                
81FC5E   LDA #$0050               
81FC61   STA $0004                
81FC64   ASL                      
81FC65   STA $0006                
81FC68   LDA $11                  
81FC6A   ADC $0000                
81FC6D   SEC                      
81FC6E   SBC $0111,X              
81FC71   CMP $0002                
81FC74   BCC $81FC78              
81FC76   BRA $81FC85              
81FC78   LDA $14                  
81FC7A   CLC                      
81FC7B   ADC $0004                
81FC7E   SEC                      
81FC7F   SBC $0114,X              
81FC82   CMP $0006                
81FC85   SEP #$20                 
81FC87   RTS                      

----------------   
;Boss1 State 02
81FC88   LDA #$01 
81FC8A   STA $01 ;Set MainState to 01
81FC8C   LDA $03 
81FC8E   CLC
81FC8F   ADC #$02 ;Increase Secondary State by 02
81FC91   STA $03  
81FC93   LDA #$A0
81FC95   STA $3E ;ZSpeed/Gravity
81FC97   LDA #$03 
81FC99   STA $3F ;ZSpeed/Gravity
81FC9B   LDA #$12 ;sprite thrown out of screen
81FC9D   JSL PlaySFX ;$809A53
81FCA1   LDA #$B6 
81FCA3   LDY #$AB 
81FCA5   JSL Sprite_SetSpeeds ; 80BF9F ;Move Routine?
;Boss1 State 03:
81FCA9   JSL MoveSprite ; 80C007 ;Move Sprite with speeds
;Gravity Code i think ?
81FCAD   REP #$21 
81FCAF   LDA $16 ;Height
81FCB1   ADC $3E ;ZSpeed
81FCB3   STA $16 ;Height  
81FCB5   LDA $3E ;ZSpeed
81FCB7   SEC
81FCB8   SBC #$001E   
81FCBB   STA $3E ;ZSpeed
81FCBD   SEP #$20 
81FCBF   LDA $17 ;Height Lowbyte 
81FCC1   BPL $81FCCB  
81FCC3   LDA #$06 
81FCC5   STA $02  
81FCC7   STZ $17  
81FCC9   STZ $01  
81FCCB   RTS
----------------   
--------sub start--------
81FCCC   REP #$20 
81FCCE   LDA $11  
81FCD0   SEC
81FCD1   SBC #$0007   
81FCD4   BMI $81FCDE  
81FCD6   CMP #$00F3   
81FCD9   BCC $81FCE7  
81FCDB   SBC #$00F2   
81FCDE   EOR #$FFFF   
81FCE1   INC
81FCE2   CLC
81FCE3   ADC $11  
81FCE5   STA $11  
81FCE7   LDA $14  
81FCE9   SEC
81FCEA   SBC #$0003   
81FCED   BMI $81FCF7  
81FCEF   CMP #$00DB   
81FCF2   BCC $81FD00  
81FCF4   SBC #$00DA   
81FCF7   EOR #$FFFF   
81FCFA   INC
81FCFB   CLC
81FCFC   ADC $14  
81FCFE   STA $14  
81FD00   SEP #$20 
81FD02   RTS
----------------   
--------sub start--------
81FD03   LDA $1A4F
81FD06   BNE $81FD0A ;IF Pirate aggro is not zero
81FD08   CLC
81FD09   RTS
;Pirate aggroing? ;We are in DP 0250 here
81FD0A   CMP $31 ;$0281
81FD0C   BEQ $81FD08  
81FD0E   STA $31 
81FD10   CMP #$01 
81FD12   BNE $81FD18 
81FD14   STZ $3B  
81FD16   SEC
81FD17   RTS
----------------   
81FD18   CMP #$02 
81FD1A   BNE $81FD22  
81FD1C   LDA #$80 
81FD1E   STA $3B  
81FD20   SEC
81FD21   RTS
----------------   
--------unidentified--------
81FD22  .db $22 $9A $91 $80 $AD $00 $00 $85
81FD2A  .db $3B $38 $60    
----------------   
--------sub start--------
81FD2D   LDA $23  
81FD2F   CMP $24  
81FD31   BEQ $81FD52  
81FD33   LDA $0B  
81FD35   LSR
81FD36   LSR
81FD37   LSR
81FD38   TAX
81FD39   LDA $23  
81FD3B   LSR
81FD3C   LSR
81FD3D   PHP
81FD3E   CLC
81FD3F   ADC $B6BB,X  
81FD42   TAX
81FD43   PLP
81FD44   LDA $B6BB,X  
81FD47   BCS $81FD4D  
81FD49   LSR
81FD4A   LSR
81FD4B   LSR
81FD4C   LSR
81FD4D   AND #$0F 
81FD4F   ASL
81FD50   STA $1E  
81FD52   RTS
----------------   
;TODO, Arguments :
;X get stored in $0021
;A = high byte addr
;Y = low byte addr
;A+Y get stored in $001F
;Y = $0021*2 + $001F
;then we get address at $0000, Y then store that in $001F
81FD53   STX $0021
81FD56   XBA
81FD57   TYA
81FD58   REP #$30 
81FD5A   STA $001F
81FD5D   LDA $0021
81FD60   AND #$00FF   
81FD63   ASL
81FD64   ADC $001F
81FD67   TAY
81FD68   LDX $0000,Y  
81FD6B   STX $001F
81FD6E   SEP #$20 
81FD70   LDA $0021
81FD73   LSR
81FD74   BCS $81FDA0  
81FD76   LDA #$03 
81FD78   STA $36  
81FD7A   LDA $14  
81FD7C   ADC $0000,X  
81FD7F   STA $000C
81FD82   LDA $11  
81FD84   CLC
81FD85   ADC $0001,X  
81FD88   STA $000A
81FD8B   JSR $FDE0
81FD8E   BEQ $81FD92  
81FD90   BRA $81FD9D  
81FD92   LDX $001F
81FD95   INX
81FD96   STX $001F
81FD99   DEC $36  
81FD9B   BNE $81FD82  
81FD9D   SEP #$10 
81FD9F   RTS
----------------   
81FDA0   LDA #$02 
81FDA2   STA $36  
81FDA4   LDA $11  
81FDA6   CLC
81FDA7   ADC $0000,X  
81FDAA   STA $000A
81FDAD   LDA $14  
81FDAF   CLC
81FDB0   ADC $0001,X  
81FDB3   STA $000C
81FDB6   JSR $FDE0
81FDB9   BEQ $81FDBD  
81FDBB   BRA $81FD9D  
81FDBD   LDX $001F
81FDC0   INX
81FDC1   STX $001F
81FDC4   DEC $36  
81FDC6   BNE $81FDAD  
81FDC8   BRA $81FD9D  
--------sub start--------
81FDCA   CLC
81FDCB   ADC $11  
81FDCD   STA $000A
81FDD0   TYA
81FDD1   CLC
81FDD2   ADC $14  
81FDD4   STA $000C
81FDD7   JSL $808A86  
81FDDB   BNE $81FDDD  
81FDDD   SEP #$10 
81FDDF   RTS
----------------   
--------sub start--------
81FDE0   LDA $000A
81FDE3   LSR
81FDE4   LSR
81FDE5   LSR
81FDE6   STA $0002
81FDE9   STZ $0003
81FDEC   REP #$20 
81FDEE   LDA $000C
81FDF1   AND #$00F8   
81FDF4   ASL
81FDF5   ASL
81FDF6   ADC $0002
81FDF9   TAX
81FDFA   SEP #$20 
81FDFC   LDA $1400,X  
81FDFF   RTS
----------------   
--------sub start--------
81FE00   LDA $0D  
--------sub start--------
81FE02   ASL
81FE03   TAX
81FE04   JMP ($FE07,X)
--------data--------     
81FE07  .db $0F $FE $1F $FE $2D $FE $3B $FE
----------------   
81FE0F   LDA $14  
81FE11   SEC
81FE12   SBC #$03 
81FE14   AND #$07 
81FE16   EOR #$07 
81FE18   INC
81FE19   CLC
81FE1A   ADC $14  
81FE1C   STA $14  
81FE1E   RTS
----------------   
81FE1F   LDA #$07 
81FE21   CLC
81FE22   ADC $11  
81FE24   AND #$F8 
81FE26   DEC
81FE27   SEC
81FE28   SBC #$07 
81FE2A   STA $11  
81FE2C   RTS
----------------   
81FE2D   LDA #$03 
81FE2F   CLC
81FE30   ADC $14  
81FE32   AND #$F8 
81FE34   DEC
81FE35   SEC
81FE36   SBC #$03 
81FE38   STA $14  
81FE3A   RTS
----------------   
81FE3B   LDA $11  
81FE3D   SEC
81FE3E   SBC #$07 
81FE40   AND #$07 
81FE42   EOR #$07 
81FE44   INC
81FE45   CLC
81FE46   ADC $11  
81FE48   STA $11  
81FE4A   RTS
----------------   
--------sub start--------
81FE4B   LDA #$FF 
81FE4D   STA $0000
81FE50   LDA $0100
81FE53   BEQ $81FE58  
81FE55   STZ $0000
81FE58   LDA $0180
81FE5B   BEQ $81FE6C  
81FE5D   LDA $0000
81FE60   BNE $81FE67  
81FE62   JSL $80919A  
81FE66   RTS
----------------   
--------unidentified--------
81FE67  .db $A9 $80 $8D $00 $00  
----------------   
81FE6C   RTS
----------------   
--------sub start--------
81FE6D   ASL
81FE6E   PHA
81FE6F   JSR $FE4B
81FE72   LDA $0000
81FE75   STA $3B  
81FE77   PLX
81FE78   LDA $0D  
81FE7A   JSR $FEB0
81FE7D   BRA $81FE8F  
--------sub start--------
81FE7F   ASL
81FE80   PHA
81FE81   JSR $FE4B
81FE84   LDA $0000
81FE87   STA $3B  
81FE89   PLX
81FE8A   LDA $3A  
81FE8C   JSR $FEB0
81FE8F   LDX $3B  
81FE91   REP #$21 
81FE93   LDA $11  
81FE95   ADC $0000
81FE98   SEC
81FE99   SBC $0111,X  
81FE9C   CMP $0002
81FE9F   BCS $81FEAD  
81FEA1   LDA $14  
81FEA3   ADC $0004
81FEA6   SEC
81FEA7   SBC $0114,X  
81FEAA   CMP $0006
81FEAD   SEP #$20 
81FEAF   RTS
----------------   
--------sub start--------
81FEB0   ASL
81FEB1   PHA
81FEB2   STZ $0001
81FEB5   STZ $0003
81FEB8   STZ $0005
81FEBB   STZ $0007
81FEBE   LDA $B6DE,X  
81FEC1   LDY $B6DF,X  
81FEC4   PLX
81FEC5   JMP ($FEC8,X)
--------data--------     
81FEC8  .db $D0 $FE $E5 $FE $FA $FE $0F $FF
----------------   
81FED0   STA $0000
81FED3   ASL
81FED4   STA $0002
81FED7   STY $0004
81FEDA   STY $0006
81FEDD   LSR
81FEDE   ADC $0006
81FEE1   STA $0006
81FEE4   RTS
----------------   
81FEE5   STA $0000
81FEE8   STA $0004
81FEEB   ASL
81FEEC   STA $0006
81FEEF   STY $0002
81FEF2   LSR
81FEF3   ADC $0002
81FEF6   STA $0002
81FEF9   RTS
----------------   
81FEFA   STA $0000
81FEFD   STA $0004
81FF00   STA $0006
81FF03   ASL
81FF04   STA $0002
81FF07   TYA
81FF08   ADC $0006
81FF0B   STA $0006
81FF0E   RTS
----------------   
81FF0F   STA $0002
81FF12   STA $0004
81FF15   ASL
81FF16   STA $0006
81FF19   STY $0000
81FF1C   TYA
81FF1D   ADC $0002
81FF20   STA $0002
81FF23   RTS
----------------   
--------unidentified--------
81FF24  .db $5B $A5 $03 $48 $A5 $02 $48 $60
81FF2C  .db $68 $85 $02 $68 $85 $03 $60 

81FF33 - 81FFFF
NULL DATA
