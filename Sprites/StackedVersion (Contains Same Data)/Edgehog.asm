;DATA BANK IS SETTED on 0x83
;DIRECT PAGE IS SETTED on 0x0200

818411 
;Sprite 0x00 - Edgehog
Sprite_Edgehog:
{
LDX $02 ;$0200
JMP Sprite_Edgehog_MainTable, X  ; ($8416,X)            
    
Sprite_Edgehog_MainTable: ; 818416
dw Sprite_Edgehog_Init ;$1E84 ;0x00 Init
dw $8455 ;0x02
dw $85F9 ;0x04
dw $8624 ;0x06

}

81841E
Sprite_Edgehog_Init:
{
LDA #$02 : STA $02 ;Set Sprite MainState to 02
LDA #$01 : STA $00 : STA $01 ;Set Sprite to Alive
STA $1C : STA $1D ;Set HP to 1 and LastHP to 1
LDA #$97 : LDY #$6F ;XSpeed & YSpeed
JSL Sprite_SetSpeeds
LDA #$40 : STA $1A
LDA #$3D : STA $1B ;Set Palettes/Properties (VHOOPPPT)
LDA $0D : INC : LSR : AND #$03 : TAY ;$0D is Often used as Direction
LDX $9606,Y : STX $0E ;9606 = [00 00 00 01] ?
ASL : TAX  ;Use direction*2 to set the addresses for FrameAnimation
LDY $95F6,X 
LDA $95F7,X 
JSL FrameAnimationNoTimer ; $8089A3              
RTS                      
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
