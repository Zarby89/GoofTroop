
828000  .db $00 $00 $00 $00
828004  .db $80 $6B $0E $80 $2A $80 $48 $80
82800C  .db $5A $80 $A5 $0B $85 $02 $A9 $03
828014  .db $85 $00 $3A $85 $01 $64 $17 $A9
82801C  .db $36 $85 $1B $64 $1A $A9 $AC $A0
828024  .db $B8 $22 $A3 $89 $80 $60 $C2 $10
82802C  .db $A6 $30 $BD $17 $00 $F0 $12 $C2
828034  .db $20 $BD $11 $00 $85 $11 $BD $14
82803C  .db $00 $85 $14 $E2 $30 $22 $DF $88
828044  .db $80 $E2 $10 $60 $C2 $10 $A6 $30
82804C  .db $BD $17 $00 $F0 $F4 $BD $01 $00
828054  .db $C9 $02 $D0 $ED $80 $D9 $C2 $10
82805C  .db $A6 $30 $BD $00 $00 $F0 $02 $80
828064  .db $CE $E2 $10 $80 $00 $22 $1E $8F
82806C  .db $80 $60              
----------------         
--------sub start--------
82806E   LDX $02                  
828070   JMP ($8073,X)            
--------data--------     
828073  .db $7B $80 $D4 $80 $09 $81
----------------         
--------unidentified--------
828079  .db $09 $81              
----------------         
82807B   LDX $03                  
82807D   JMP ($8080,X)            
--------data--------     
828080  .db $84 $80 $B8 $80      
----------------         
828084   LDA #$02                 
828086   STA $03                  
828088   INC                      
828089   STA $00                  
82808B   STZ $0E                  
82808D   STZ $12                  
82808F   STZ $15                  
828091   LDA #$31                 
828093   STA $1B                  
828095   LDA #$C0                 
828097   STA $1A                  
828099   LDY #$BD                 
82809B   LDA #$AC                 
82809D   JSL $8089A3              
8280A1   LDA #$07                 
8280A3   STA $17                  
8280A5   STZ $0C                  
8280A7   LDA #$06                 
8280A9   STA $4F                  
8280AB   REP #$20                 
8280AD   LDA #$0400               
8280B0   STA $4D                  
8280B2   SEP #$20                 
8280B4   JSR $810E                
8280B7   RTL                      
----------------         
8280B8   LDA $00AC                
8280BB   BNE $8280D3              
8280BD   DEC $4F                  
8280BF   BNE $8280D3              
8280C1   LDA #$02                 
8280C3   STA $01                  
8280C5   STA $02                  
8280C7   STZ $03                  
8280C9   LDA #$0F                 
8280CB   JSL PlaySFX ;$809A53
8280CF   LDA #$21                 
8280D1   STA $4F                  
8280D3   RTL                      
----------------         
8280D4   LDA $00AC                
8280D7   BNE $8280E2              
8280D9   LDX $03                  
8280DB   JSR ($80E7,X)            
8280DE   JSL $8089A9              
8280E2   JSL $8088CE              
8280E6   RTL                      
----------------         
--------data--------     
8280E7  .db $E9 $80              
----------------         
--------sub start--------
8280E9   DEC $4F                  
8280EB   BNE $8280F6              
8280ED   JSR $810E                
8280F0   LDA #$04                 
8280F2   STA $02                  
8280F4   STZ $03                  
8280F6   REP #$21                 
8280F8   LDA $16                  
8280FA   ADC $4D                  
8280FC   STA $16                  
8280FE   LDA $4D                  
828100   SEC                      
828101   SBC #$0040               
828104   STA $4D                  
828106   SEP #$20                 
828108   RTS                      
----------------         
828109   JSL $808F1E              
82810D   RTL                      
----------------         
--------sub start--------
82810E   JSL $808F8E              
828112   BCS $82812D              
828114   LDA #$03                 
828116   STA $0000,X              
828119   LDA #$10                 
82811B   STA $000A,X              
82811E   LDA $02                  
828120   STA $000B,X              
828123   LDA $11                  
828125   STA $0011,X              
828128   LDA $14                  
82812A   STA $0014,X              
82812D   SEP #$10                 
82812F   RTS                      
----------------         
--------sub start--------
828130   LDA #$01 ;A:0001
828132   XBA                      
828133   LDA #$00 ;A:0100            
828135   JSR $8141 ;Set Direct Page to 0100
828138   LDA #$01                 
82813A   XBA                      
82813B   LDA #$80                 
82813D   JSR $8141                
828140   RTL                      
----------------         
--------sub start--------
828141   TCD ;Set Direct Page
828142   LDA $00 ; 0x0100 ?
828144   BEQ $828151              
828146   JSR $9475                
828149   LDX $02                  
82814B   JSR ($8152,X)            
82814E   JSR $9958                
828151   RTS                      
----------------         
    
;828152
dw $815C ;Unknown?? a sort of init routine i guess
dw $8221 
dw $88CE
dw $0B08
dw $8B91          
   
SpriteRelatedRoutine:; ??
;DP = 0100 here
;DB = 83
82815C   LDA #$02
82815E   STA.b $0102
828160   LDA.b $0100
828162   CMP #$04
828164   BEQ $82816A              
828166   CMP #$02                 
828168   BNE $82816C              
82816A   DEC.b $0100                  
82816C   LDA #$01                 
82816E   STA.b $0101                  
828170   STA.b $011C                  
828172   STZ.b $010E                  
828174   LDA $1A4A                
828177   STA.b $0147                  
828179   STA.b $010D                  
82817B   CMP #$06                 
82817D   BNE $828181              
82817F   INC $0E                  
828181   LDA $1A4B                
828184   STA.b $010C                  
828186   LDA.b $014C                  
828188   STZ.b $0110                  
82818A   STA.b $0111                  
82818C   STZ.b $0112                  
82818E   LDA.b $014D                  
828190   STZ.b $0113                  
828192   STA.b $0114                  
828194   STZ.b $0115                  
828196   STZ.b $0116                  
828198   STZ.b $0117                  
82819A   STZ.b $0117 ;clearing $0117 twice ? :shrug:                
82819C   LDA.b $0156                  
82819E   LSR                      
82819F   TAX                      
8281A0   LDA $B6E6,X              
8281A3   STA $1A      ;011A            
8281A5   LDA $B6E8,X              
8281A8   STA $22      ;0122            
8281AA   LDA $B6EA,X              
8281AD   STA $1B      ;011B            
8281AF   LDA $B6EC,X              
8281B2   STA $58      ;0158 <- that is used for OAM Data byte3
8281B4   LDA #$32                 
8281B6   STA $59      ;0159 <- that is used for OAM Data byte4
8281B8   LDY $B7C2,X              
8281BB   JSL $80BFC1              
8281BF   JSR $945C ;set a bunch of values
8281C2   JSL $808A53 ;set a bunch of values (especially $20)
8281C6   STZ $1A                  
8281C8   LDA $56                  
8281CA   ASL                      
8281CB   ASL                      
8281CC   STA $0B                  
8281CE   ADC $47                  
8281D0   TAX                      
8281D1   LDA $B980,X              
8281D4   LDY $B97F,X              
8281D7   JSL $8089D7              
8281DB   JSL $808A21 ;set a bunch of values?
8281DF   LDA #$01                 
8281E1   STA $48                  
8281E3   STZ $54                  
8281E5   STZ $52                  
8281E7   STZ $53                  
8281E9   STZ $4B                  
8281EB   STZ $55                  
8281ED   STZ $46                  
8281EF   STZ $4A                  
8281F1   STZ $45                  
8281F3   STZ $3C                  
8281F5   STZ $34                  
8281F7   STZ $35                  
8281F9   STZ $36                  
8281FB   STZ $37                  
8281FD   STZ $2C                  
8281FF   LDA #$14                 
828201   STA $2F                  
828203   JSR $98D6                
828206   STZ $3F                  
828208   LDA $0A                  
82820A   LSR                      
82820B   INC                      
82820C   ORA $00BE                
82820F   STA $00BE                
828212   RTS                      
----------------         
828213   LDA $03                  
828215   CMP #$02                 
828217   BNE $82824C              
828219   LDA $04                  
82821B   CMP #$06                 
82821D   BCC $82824C              
82821F   BRA $828226              
--------sub start--------
828221   LDA $00AC ;Related to pause?
828224   BNE $828213
828226   JSR $9571                
828229   JSR $991A                
82822C   LDX $03 ;$0103 Here checking for the item currently used
82822E   JSR ($8254,X) ;Items Use ?? 
828231   JSR $98F6 ;item use again??
828234   JSL $808A25              
828238   JSR $966A                
82823B   JSR $958C                
82823E   JSL $82962B              
828242   JSR $96A1 ;Check for collision with transition rectangles
828245   JSL $808AA8              
828249   JSR $9C53                
82824C   JSL $8088CE              
828250   JSR $A1E4                
828253   RTS                      
----------------
;828254         
ItemCurrentlyUsedTable:
{     
dw $826A ;00 ;Normal Routine
dw $835E ;02 ;Lifting
dw $853E ;04 ;Holding
dw $858E ;06 ;Throwing
dw $8651 ;08 ;Kicking
dw $8758 ;0A ;Hookshot
dw $87D2 ;0C ;Nothing - would be smallkey defined elsewhere
dw $87D2 ;0E ;Nothing - would be bosskey defined elsewhere
dw $87D2 ;10 ;Nothing - would be plank defined elsewhere
dw $87D3 ;12 ;Digging
dw $8876 ;14 Bell?
} 
      
JumpTable03_00_TODO:
82826A   JSR $900A
82826D   JSL $8089DE
828271   LDA $00CA                
828274   BNE $828292              
828276   LDA $46                  
828278   STA $33                  
82827A   BEQ $828280              
82827C   JSL $80BFCC              
828280   JSR $95D6                
828283   LDA $44                  
828285   BNE $82828C              
828287   LDX $33                  
828289   JSR ($8297,X)            
82828C   JSR $9AF8                
82828F   JMP $8F7B                
--------unidentified-------- <- Looks like code
828292  .db $20 $E4 $8C $80 $E9  
----------------         
--------data--------     
828297  .db $F7 $82 $A9 $82 $B7 $82 $BF $82
82829F  .db $CD $82 $D5 $82 $F8 $82 $1A $83
8282A7  .db $3C $83              
----------------         
--------sub start--------
8282A9   LDX #$00                 
8282AB   JSR $91F9                
8282AE   JSR $9239                
8282B1   JSR $925C                
8282B4   JMP $9292                
--------sub start--------
8282B7   LDX #$00                 
8282B9   JSR $92FF                
8282BC   JMP $933C                
--------sub start--------
8282BF   LDX #$03                 
8282C1   JSR $91F9                
8282C4   JSR $924B                
8282C7   JSR $925C                
8282CA   JMP $929F                
--------sub start--------
8282CD   LDX #$03                 
8282CF   JSR $92FF                
8282D2   JMP $9341                
--------sub start--------
8282D5   LDA #$00                 
8282D7   JSR $93B7                
8282DA   JSR $9239                
8282DD   JSR $93FF                
8282E0   JSR $9374                
8282E3   LDA $5F                  
8282E5   BNE $8282F7              
8282E7   JSR $9440                
8282EA   LDA $5E                  
8282EC   BEQ $8282F7              
8282EE   DEC                      
8282EF   BEQ $8282F4              
8282F1   JMP $923D                
--------unidentified--------
8282F4  .db $4C $78 $93          
----------------         
--------sub start--------
8282F7   RTS                      
----------------         
--------sub start--------
8282F8   LDA #$07                 
8282FA   JSR $93B7                
8282FD   JSR $9239                
828300   JSR $93FF                
828303   JSR $93A4                
828306   LDA $5F                  
828308   BNE $8282F7              
82830A   JSR $9440                
82830D   LDA $5E                  
82830F   BEQ $8282F7              
828311   DEC                      
828312   BEQ $828317              
828314   JMP $923D                
828317   JMP $93A8                
--------sub start--------
82831A   LDA #$0E                 
82831C   JSR $93B7                
82831F   JSR $924B                
828322   JSR $93FF                
828325   JSR $9374                
828328   LDA $5F                  
82832A   BNE $8282F7              
82832C   JSR $9440                
82832F   LDA $5E                  
828331   BEQ $8282F7              
828333   DEC                      
828334   BEQ $828339              
828336   JMP $924F                
--------unidentified--------
828339  .db $4C $78 $93          
----------------         
--------sub start--------
82833C   LDA #$15                 
82833E   JSR $93B7                
828341   JSR $924B                
828344   JSR $93FF                
828347   JSR $93A4                
82834A   LDA $5F                  
82834C   BNE $8282F7              
82834E   JSR $9440                
828351   LDA $5E                  
828353   BEQ $8282F7              
828355   DEC                      
828356   BEQ $82835B              
828358   JMP $924F                
--------unidentified--------
82835B  .db $4C $A8 $93          
----------------         
--------sub start--------
82835E   LDA $00CA                
828361   BEQ $82836B              
828363   JSR $8CE0                
--------unidentified--------
828366  .db $A6 $33 $FC $97 $82  
----------------         
82836B   LDX $04                  
82836D   JMP ($8370,X)            
--------data--------     
828370  .db $7C $83              
----------------         
--------unidentified--------
828372  .db $95 $84              
----------------         
--------data--------     
828374  .db $AA $84 $ED $84 $24 $85 $1A $86
----------------         
82837C   LDA #$04                 
82837E   STA $04                  
828380   STA $48                  
828382   LDA #$10                 
828384   STA $54                  
828386   JSR $A18C                
828389   BCC $8283B2              
82838B   STZ $002D,X              
82838E   STX $52                  
828390   STZ $0002,X              
828393   LDA #$02                 
828395   STA $0003,X              
828398   TDC                      
828399   STA $0030,X              
82839C   XBA                      
82839D   STA $0031,X              
8283A0   LDA $000A,X              
8283A3   BEQ $8283AD              
8283A5   LDA #$08                 
8283A7   STA $000A,X              
8283AA   STZ $0003,X              
8283AD   SEP #$10                 
8283AF   JMP $8482                
8283B2   JSR $9514                
8283B5   BCC $8283DF              
8283B7   LDA #$06                 
8283B9   STA $04                  
8283BB   STA $00AC                
8283BE   LDA $47                  
8283C0   CLC                      
8283C1   ADC $0B                  
8283C3   TAX                      
8283C4   LDA $B9C0,X              
8283C7   LDY $B9BF,X              
8283CA   JSL $8089D7              
8283CE   LDA #$10                 
8283D0   STA $53                  
8283D2   LDA $0A                  
8283D4   ASL                      
8283D5   ASL                      
8283D6   ASL                      
8283D7   ASL                      
8283D8   ADC #$C0                 
8283DA   STA $52                  
8283DC   JMP $8F19                
8283DF   JSL $808F8E              
8283E3   BCS $828439              
8283E5   STX $0022                
8283E8   SEP #$10                 
8283EA   LDA $47                  
8283EC   LSR                      
8283ED   TAX                      
8283EE   LDY $B756,X              
8283F1   LDA $B756,Y              
8283F4   STA $000E                
8283F7   INY                      
8283F8   CLC                      
8283F9   LDA $11                  
8283FB   ADC $B756,Y              
8283FE   STA $0006                
828401   LSR                      
828402   LSR                      
828403   LSR                      
828404   STA $0002                
828407   STZ $0003                
82840A   REP #$31                 
82840C   LDA $14                  
82840E   ADC $B757,Y              
828411   INY                      
828412   INY                      
828413   AND #$00F8               
828416   ASL                      
828417   ASL                      
828418   ADC $0002                
82841B   TAX                      
82841C   SEP #$20                 
82841E   LDA $1400,X              
828421   AND #$FE                 
828423   CMP #$B0                 
828425   BEQ $828443              
828427   SEP #$10                 
828429   DEC $000E                
82842C   BNE $8283F8              
82842E   JSR $8E22                
828431   SEP #$10                 
828433   BCS $82843E              
828435   LDA $49                  
828437   BNE $82843E              
828439   SEP #$10                 
82843B   JMP $84B7                
82843E   STZ $54                  
828440   JMP $866F                
828443   REP #$20                 
828445   STX $5E                  
828447   JSL $8088F0              
82844B   LDA $5E                  
82844D   ASL                      
82844E   TAX                      
82844F   LDA $7FE000,X            
828453   SEC                      
828454   SBC #$0380               
828457   STA $68                  
828459   SEP #$20                 
82845B   LDX $0022                
82845E   LDA #$02                 
828460   STA $0000,X              
828463   STZ $000A,X              
828466   LDA $68                  
828468   LSR                      
828469   STA $000B,X              
82846C   LDA #$02                 
82846E   STA $0004,X              
828471   STX $52                  
828473   TDC                      
828474   STA $0030,X              
828477   XBA                      
828478   STA $0031,X              
82847B   SEP #$10                 
82847D   STZ $6E                  
82847F   JSR $9BDA                
828482   LDA $47                  
828484   CLC                      
828485   ADC $0B                  
828487   TAX                      
828488   LDA $B9C0,X              
82848B   LDY $B9BF,X              
82848E   JSL $8089D7              
828492   JMP $8F19                
--------unidentified--------
828495  .db $A9 $04 $85 $04 $85 $48 $C2 $10
82849D  .db $A6 $52 $A9 $02 $9D $03 $00 $85
8284A5  .db $45 $E2 $10 $80 $D8  
----------------         
8284AA   JSL $8089DE              
8284AE   LDA $08                  
8284B0   CMP #$70                 
8284B2   BEQ $8284B7              
8284B4   JMP $8F19                
8284B7   LDA #$04                 
8284B9   STA $03                  
8284BB   STZ $04                  
8284BD   LDA #$10                 
8284BF   STA $54                  
8284C1   STZ $48                  
8284C3   LDA $47                  
8284C5   CLC                      
8284C6   ADC $0B                  
8284C8   TAX                      
8284C9   LDA $60                  
8284CB   BNE $8284DE              
8284CD   LDA $B990,X              
8284D0   LDY $B98F,X              
8284D3   JSL $8089D7              
8284D7   STZ $46                  
8284D9   INC $48                  
8284DB   JMP $8F19                
8284DE   LDY $B9AF,X              
8284E1   LDA $B9B0,X              
8284E4   JSL $8089D7              
8284E8   LDA #$01                 
8284EA   STA $55                  
8284EC   RTS                      
----------------         
8284ED   JSL $8089DE              
8284F1   LDA $08                  
8284F3   CMP #$70                 
8284F5   BNE $828521              
8284F7   LDA #$08                 
8284F9   STA $04                  
8284FB   LDA #$1F                 
8284FD   JSL PlaySFX ;$809A53
828501   LDA $23                  
828503   PHA                      
828504   LDA $47                  
828506   CLC                      
828507   ADC $0B                  
828509   TAX                      
82850A   LDY $B9CF,X              
82850D   LDA $B9D0,X              
828510   JSL $8089D7              
828514   JSL $808A21              
828518   PLA                      
828519   STA $23                  
82851B   STA $24                  
82851D   LDA #$3C                 
82851F   STA $08                  
828521   JMP $8F19                
828524   DEC $08                  
828526   BNE $82853D              
828528   LDA #$0A                 
82852A   STA $04                  
82852C   REP #$30                 
82852E   LDX $52                  
828530   STZ $52                  
828532   STZ $0000,X              
828535   STZ $0002,X              
828538   SEP #$30                 
82853A   STZ $00AC                
82853D   RTS                      
----------------         
--------sub start--------
82853E   JSR $900A                
828541   JSL $8089DE              
828545   LDA $56                  
828547   LSR                      
828548   LDX $53                  
82854A   BEQ $82854E              
82854C   INC                      
82854D   INC                      
82854E   TAX                      
82854F   LDY $B7C2,X              
828552   JSL $80BFC1              
828556   LDA $00CA
828559   BNE $828577              
82855B   LDA $46                  
82855D   STA $33                  
82855F   BEQ $828565              
828561   JSL $80BFCC              
828565   JSR $95D6                
828568   LDA $44                  
82856A   BNE $828571              
82856C   LDX $33                  
82856E   JSR ($857C,X)            
828571   JSR $9AF8                
828574   JMP $8F2A                
--------unidentified--------
828577  .db $20 $E4 $8C $80 $E9  
----------------         
--------data--------     
82857C  .db $F7 $82 $A9 $82 $B7 $82 $BF $82
828584  .db $CD $82 $D5 $82 $F8 $82 $1A $83
82858C  .db $3C $83              
----------------         
--------sub start--------
82858E   LDA $00CA                
828591   BEQ $82859B              
828593   JSR $8CE0                
--------unidentified--------
828596  .db $A6 $33 $FC $97 $82  
----------------         
82859B   LDX $04                  
82859D   JMP ($85A0,X)            
--------data--------     
8285A0  .db $A4 $85 $10 $86      
----------------         
8285A4   LDA #$02                 
8285A6   STA $04                  
8285A8   STA $48                  
8285AA   STZ $45                  
8285AC   STZ $54                  
8285AE   LDA $53                  
8285B0   BEQ $8285F9              
8285B2   LDA $47                  
8285B4   CLC                      
8285B5   ADC $0B                  
8285B7   ASL                      
8285B8   TAY                      
8285B9   LDA $47                  
8285BB   LSR                      
8285BC   REP #$10                 
8285BE   LDX $52                  
8285C0   STA $000D,X              
8285C3   REP #$21                 
8285C5   LDA $11                  
8285C7   ADC $B6FC,Y              
8285CA   STA $0011,X              
8285CD   LDA $14                  
8285CF   CLC                      
8285D0   ADC $B6FE,Y              
8285D3   STA $0014,X              
8285D6   LDA #$0C00               
8285D9   STA $0016,X              
8285DC   STZ $0030,X              
8285DF   SEP #$20                 
8285E1   LDA #$02                 
8285E3   STA $0002,X              
8285E6   STZ $0003,X              
8285E9   STA $0005,X              
8285EC   LDA $56                  
8285EE   LSR                      
8285EF   ADC #$04                 
8285F1   STA $001C,X              
8285F4   STZ $001E,X              
8285F7   SEP #$10                 
8285F9   STZ $52                  
8285FB   STZ $53                  
8285FD   STZ $54                  
8285FF   LDA $47                  
828601   CLC                      
828602   ADC $0B                  
828604   TAX                      
828605   LDA $BA10,X              
828608   LDY $BA0F,X              
82860B   JSL $8089D7              
82860F   RTS                      
----------------         
828610   JSL $8089DE              
828614   LDA $08                  
828616   CMP #$70                 
828618   BNE $828650              
--------sub start--------
82861A   STZ $03                  
82861C   STZ $04                  
82861E   STZ $54                  
828620   STZ $48                  
828622   LDA $56                  
828624   LSR                      
828625   TAX                      
828626   LDY $B7C2,X              
828629   JSL $80BFC1              
82862D   LDA $47                  
82862F   CLC                      
828630   ADC $0B                  
828632   TAX                      
828633   LDA $60                  
828635   BNE $828646              
828637   LDA $B980,X              
82863A   LDY $B97F,X              
82863D   JSL $8089D7              
828641   STZ $46                  
828643   INC $48                  
828645   RTS                      
----------------         
828646   LDA $B9A0,X              
828649   LDY $B99F,X              
82864C   JSL $8089D7              
828650   RTS                      
----------------         
--------sub start--------
828651   LDA $00CA                
828654   BEQ $82865E              
828656   JSR $8CE0                
--------unidentified--------
828659  .db $A6 $33 $FC $97 $82  
----------------         
82865E   LDX $04                  
828660   JMP ($8663,X)            
--------unidentified--------
828663  .db $6F $86              
----------------         
--------data--------     
828665  .db $8A $86 $9D $86 $15 $87 $47 $87
82866D  .db $1A $86              
----------------         
82866F   LDA #$08                 
828671   STA $03                  
828673   LDA #$02                 
828675   STA $04                  
828677   STA $48                  
828679   LDA $47                  
82867B   CLC                      
82867C   ADC $0B                  
82867E   TAX                      
82867F   LDA $B9E0,X              
828682   LDY $B9DF,X              
828685   JSL $8089D7              
828689   RTS                      
----------------         
82868A   JSL $8089DE              
82868E   LDA $08                  
828690   CMP #$70                 
828692   BNE $82869C              
828694   LDA #$01                 
828696   STA $08                  
828698   LDA #$04                 
82869A   STA $04                  
82869C   RTS                      
----------------         
82869D   JSR $8E22                
8286A0   BCC $828707              
8286A2   REP #$31                 
8286A4   LDX $5E                  
8286A6   JSL $8088F0              
8286AA   LDA $5E                  
8286AC   ASL                      
8286AD   TAX                      
8286AE   LDA $7FE000,X            
8286B2   BEQ $82870C              
8286B4   SEC                      
8286B5   SBC #$03B4               
8286B8   STA $68                  
8286BA   SEP #$30                 
8286BC   JSL $808F8E              
8286C0   BCS $828705              
8286C2   LDA $68                  
8286C4   LSR                      
8286C5   STA $000B,X              
8286C8   LDA $0000,X              
8286CB   BNE $8286D2              
8286CD   LDA #$02                 
8286CF   STA $0000,X              
8286D2   STZ $0002,X              
8286D5   STZ $0003,X              
8286D8   STZ $0004,X              
8286DB   LDA #$02                 
8286DD   STA $0005,X              
8286E0   STA $000A,X              
8286E3   LDA $0010                
8286E6   ASL                      
8286E7   ASL                      
8286E8   ASL                      
8286E9   CLC                      
8286EA   ADC #$08                 
8286EC   STA $0011,X              
8286EF   REP #$20                 
8286F1   LDA $0010                
8286F4   LSR                      
8286F5   LSR                      
8286F6   SEP #$20                 
8286F8   AND #$F8                 
8286FA   CLC                      
8286FB   ADC #$08                 
8286FD   STA $0014,X              
828700   LDA $47                  
828702   STA $000D,X              
828705   SEP #$10                 
828707   LDA #$06                 
828709   STA $04                  
82870B   RTS                      
----------------         
--------unidentified--------
82870C  .db $BF $02 $E0 $7F $AA $E2 $20 $80
828714  .db $B3                  
----------------         
828715   JSL $8089DE              
828719   LDA $08                  
82871B   CMP #$70                 
82871D   BNE $828746              
82871F   LDA #$0A                 
828721   STA $04                  
828723   LDA $49                  
828725   BEQ $828746              
828727   LDA #$02                 
828729   STA $00                  
82872B   DEC                      
82872C   STA $01                  
82872E   LDA #$08                 
828730   STA $04                  
828732   LDA #$30                 
828734   STA $0F                  
828736   LDA $47                  
828738   CLC                      
828739   ADC $0B                  
82873B   TAX                      
82873C   LDA $B9F0,X              
82873F   LDY $B9EF,X              
828742   JSL $8089D7              
828746   RTS                      
----------------         
828747   JSL $8089DE              
82874B   DEC $0F                  
82874D   BNE $828746              
82874F   LDA #$01                 
828751   STA $00                  
828753   LDA #$0A                 
828755   STA $04                  
828757   RTS                      
----------------         
--------sub start--------
828758   LDA $00CA                
82875B   BEQ $828765              
82875D   JSR $8CE0                
--------unidentified--------
828760  .db $A6 $33 $FC $97 $82  
----------------         
828765   LDX $04                  
828767   JSR ($8780,X)            
82876A   LDA $0A                  
82876C   LSR                      
82876D   TAY                      
82876E   LDX $B7D6,Y              
828771   REP #$20                 
828773   LDA $11                  
828775   STA $0DBC,X              
828778   LDA $14                  
82877A   STA $0DBE,X              
82877D   SEP #$20                 
82877F   RTS                      
----------------         
--------data--------     
828780  .db $86 $87 $C5 $87 $1A $86
----------------         
--------sub start--------
828786   LDA #$02                 
828788   STA $04                  
82878A   LDA $47                  
82878C   CLC                      
82878D   ADC $0B                  
82878F   TAX                      
828790   LDY $BA1F,X              
828793   LDA $BA20,X              
828796   JSL $8089D7              
82879A   LDA $0A                  
82879C   LSR                      
82879D   TAY                      
82879E   LDX $B7D6,Y              
8287A1   LDA $0D80,X              
8287A4   BNE $8287C4              
8287A6   LDA #$02                 
8287A8   STA $0D80,X              
8287AB   LDA $0C                  
8287AD   STA $0D8C,X              
8287B0   LDA $56                  
8287B2   STA $0D8B,X              
8287B5   ASL                      
8287B6   ASL                      
8287B7   ORA $47                  
8287B9   ASL                      
8287BA   STA $0DAE,X              
8287BD   LDA $47                  
8287BF   STA $0D8D,X              
8287C2   INC $4A                  
8287C4   RTS                      
----------------         
--------sub start--------
8287C5   JSL $8089DE              
8287C9   LDA $4A                  
8287CB   BNE $8287D1              
8287CD   LDA #$04                 
8287CF   STA $04                  
8287D1   RTS                      
----------------         
--------unidentified--------
8287D2  .db $60 $AD $CA $00 $F0 $08 $20 $E0
8287DA  .db $8C $A6 $33 $FC $97 $82 $A6 $04
8287E2  .db $7C $E5 $87 $ED $87 $0A $88 $0A
8287EA  .db $88 $6B $88 $A9 $02 $85 $04 $A5
8287F2  .db $47 $4A $4A $85 $0E $A6 $56 $BC
8287FA  .db $67 $BA $BD $68 $BA $22 $D7 $89
828802  .db $80 $A9 $1B $22 $53 $9A $80 $60
82880A  .db $22 $DE $89 $80 $A5 $08 $C9 $71
828812  .db $D0 $56 $A9 $01 $85 $08 $A5 $04
82881A  .db $18 $69 $02 $85 $04 $C9 $04 $D0
828822  .db $47 $20 $94 $94 $90 $42 $64 $6A
82882A  .db $C2 $31 $A5 $5E $AA $69 $00 $50
828832  .db $8D $10 $00 $E2 $20 $BD $00 $14
82883A  .db $C9 $40 $D0 $09 $A9 $48 $9D $00
828842  .db $14 $E2 $30 $80 $13 $C2 $20 $9E
82884A  .db $00 $14 $9E $20 $14 $E6 $6A $E2
828852  .db $30 $A9 $FF $85 $6E $20 $DA $9B
82885A  .db $AD $B6 $00 $3A $F0 $04 $E6 $6A
828862  .db $E6 $6A $A5 $6A $22 $7B $8D $80
82886A  .db $60 $A5 $47 $4A $1A $4A $4A $85
828872  .db $0E $4C $1A $86      
----------------         
--------sub start--------
828876   LDA $00CA ;Dont Know yet :TODORAM
828879   BEQ $828883              
82887B   JSR $8CE0                
--------unidentified--------
82887E  .db $A6 $33 $FC $97 $82  
----------------         
828883   LDX $04 ;0104 ??
828885   JMP ($8888,X)            
--------data--------     
828888
dw $888E
dw $88B3
dw $861A
----------------         
82888E   LDA #$02 
828890   STA $04
828892   LDA $47 ;0147 P1 facing direction
828894   CLC
828895   ADC $0B 
828897   TAX
828898   LDY $BA2F,X              
82889B   LDA $BA30,X              
82889E   JSL $8089D7 ;Routine used everywhere to set $0123 ?
8288A2   LDA $0A ;010A?
8288A4   LSR                      
8288A5   INC                      
8288A6   ORA $1A4F                
8288A9   STA $1A4F ;Set all pirates on chase mode
8288AC   LDA #$0A                 
8288AE   JSL PlaySFX ;$809A53
8288B2   RTS                      
----------------         
8288B3   JSL $8089DE              
8288B7   LDA $08                  
8288B9   CMP #$70                 
8288BB   BNE $8288CD              
8288BD   LDA #$04                 
8288BF   STA $04                  
--------sub start--------
8288C1   LDA $0A                  
8288C3   LSR                      
8288C4   INC                      
8288C5   EOR #$FF 
8288C7   AND $1A4F                
8288CA   STA $1A4F                
8288CD   RTS                      
----------------         
--------sub start--------
8288CE   LDX $03                  
8288D0   JSR ($88DC,X)            
8288D3   JSL $808A25              
8288D7   JSL $8088CE              
8288DB   RTS                      
----------------         
--------data--------     
8288DC  .db $E6 $88              
----------------         
--------unidentified--------
8288DE  .db $BE $89              
----------------         
--------data--------     
8288E0  .db $F4 $89 $43 $8A $87 $8A
----------------         
--------sub start--------
8288E6   LDX $04                  
8288E8   JMP ($88EB,X)            
--------data--------     
8288EB  .db $F1 $88 $63 $89 $B3 $89
----------------         
8288F1   LDA #$0B                 
8288F3   JSL PlaySFX ;$809A53
8288F7   LDA #$01                 
8288F9   STA $01                  
8288FB   STZ $2C                  
8288FD   JSR $8DDE                
828900   JSR $88C1                
828903   LDA $47                  
828905   CLC                      
828906   ADC $0B                  
828908   TAX                      
828909   LDY $BA3F,X              
82890C   LDA $BA40,X              
82890F   JSL $8089D7              
828913   LDA $1C                  
828915   BEQ $82893A              
828917   LDA #$02                 
828919   STA $04                  
82891B   LDA $4B                  
82891D   BNE $828939              
82891F   REP #$10                 
828921   LDX $52                  
828923   LDA $53                  
828925   BEQ $828937              
828927   STZ $53                  
828929   STA $4B                  
82892B   LDA #$01                 
82892D   STA $55                  
82892F   LDA $002E,X              
828932   STZ $002E,X              
828935   STA $4F                  
828937   SEP #$10                 
828939   RTS                      
----------------         
82893A   LDA #$04                 
82893C   STA $00                  
82893E   LDA #$04                 
828940   STA $04                  
828942   LDA $53                  
828944   BEQ $828958              
828946   REP #$10                 
828948   LDX $52                  
82894A   LDA #$06                 
82894C   STA $0002,X              
82894F   STZ $0003,X              
828952   SEP #$10                 
828954   STZ $52                  
828956   STZ $53                  
828958   LDA $0A                  
82895A   LSR                      
82895B   INC                      
82895C   EOR $00BE                
82895F   STA $00BE                
828962   RTS                      
----------------         
828963   DEC $08                  
828965   BNE $828962              
828967   LDA #$03                 
828969   STA $00                  
82896B   LDA #$02                 
82896D   STA $02                  
82896F   LDA $54                  
828971   BNE $828976              
828973   JMP $861A                
828976   LDA $4B                  
828978   STZ $4B                  
82897A   STA $53                  
82897C   BEQ $828993              
82897E   REP #$10                 
828980   LDX $52                  
828982   LDA $0009,X              
828985   CMP #$08                 
828987   BEQ $8289A2              
828989   LDA $4F                  
82898B   STA $002E,X              
82898E   SEP #$10                 
828990   JMP $84B7                
828993   LDA $78                  
828995   BEQ $828990              
828997   LDA $61                  
828999   BIT $75                  
82899B   BNE $828990              
82899D   STZ $54                  
82899F   JMP $861A                
--------unidentified--------
8289A2  .db $A9 $06 $9D $02 $00 $9E $03 $00
8289AA  .db $E2 $10 $64 $52 $64 $53 $4C $1A
8289B2  .db $86                  
----------------         
8289B3   DEC $08                  
8289B5   BNE $8289BD              
8289B7   LDA #$08                 
8289B9   STA $03                  
8289BB   STZ $04                  
8289BD   RTS                      
----------------         
--------unidentified--------
8289BE  .db $A6 $04 $7C $C3 $89 $C7 $89 $E8
8289C6  .db $89 $A9 $02 $85 $04 $20 $DE $8D
8289CE  .db $20 $C1 $88 $A9 $78 $85 $0F $A5
8289D6  .db $47 $18 $65 $0B $AA $BC $FF $B9
8289DE  .db $BD $00 $BA $22 $D7 $89 $80 $4C
8289E6  .db $1B $89 $22 $DE $89 $80 $C6 $0F
8289EE  .db $F0 $01 $60 $4C $67 $89
----------------         
--------sub start--------
8289F4   LDX $04                  
8289F6   JMP ($89F9,X)            
--------data--------     
8289F9  .db $FD $89 $35 $8A      
----------------         
8289FD   LDA #$02                 
8289FF   STA $04                  
828A01   JSR $8DDE                
828A04   JSR $88C1                
828A07   LDX $56                  
828A09   LDY $BA63,X              
828A0C   LDA $BA64,X              
828A0F   JSL $8089D7              
828A13   JSL $808F8E              
828A17   BCS $828A30              
828A19   LDA #$04                 
828A1B   STA $000A,X              
828A1E   LDA #$02                 
828A20   STA $0000,X              
828A23   REP #$20                 
828A25   LDA $11                  
828A27   STA $0011,X              
828A2A   LDA $14                  
828A2C   INC                      
828A2D   STA $0014,X              
828A30   SEP #$30                 
828A32   JMP $891B                
828A35   JSL $8089DE              
828A39   LDA $08                  
828A3B   CMP #$60                 
828A3D   BEQ $828A40              
828A3F   RTS                      
----------------         
828A40   JMP $8967                
--------sub start--------
828A43   LDX $04                  
828A45   JMP ($8A48,X)            
--------data--------     
828A48  .db $4C $8A $72 $8A      
----------------         
828A4C   LDA #$02                 
828A4E   STA $04                  
828A50   DEC                      
828A51   STA $01                  
828A53   LDA #$04                 
828A55   STA $00                  
828A57   JSR $8DDE                
828A5A   JSR $88C1                
828A5D   LDA #$0D                 
828A5F   JSL PlaySFX ;$809A53
828A63   LDX $56                  
828A65   LDY $BA5F,X              
828A68   LDA $BA60,X              
828A6B   JSL $8089D7              
828A6F   JMP $8942                
828A72   JSL $8089DE              
828A76   LDA $08                  
828A78   CMP #$70                 
828A7A   BNE $828A86              
828A7C   LDA #$06                 
828A7E   STA $02                  
828A80   STZ $03                  
828A82   STZ $1C                  
828A84   STZ $1D                  
828A86   RTS                      
----------------         
--------sub start--------
828A87   LDX $04                  
828A89   JMP ($8A8C,X)            
--------data--------     
828A8C  .db $90 $8A $C6 $8A      
----------------         
828A90   LDA #$02                 
828A92   STA $04                  
828A94   LDA #$0D                 
828A96   JSL PlaySFX ;$809A53
828A9A   LDY #$06                 
828A9C   JSL $80BFC1              
828AA0   LDA #$1E                 
828AA2   STA $0F                  
828AA4   LDA $0D                  
828AA6   INC                      
828AA7   AND #$03                 
828AA9   LSR                      
828AAA   STA $0E                  
828AAC   LDA $0D                  
828AAE   ASL                      
828AAF   ADC $0B                  
828AB1   TAX                      
828AB2   LDY $BA4F,X              
828AB5   LDA $BA50,X              
828AB8   JSL $8089D7              
828ABC   REP #$20                 
828ABE   LDA #$0400               
828AC1   STA $2A                  
828AC3   SEP #$20                 
828AC5   RTS                      
----------------         
828AC6   JSL $80BFCC              
828ACA   REP #$21                 
828ACC   LDA $2A                  
828ACE   CLC                      
828ACF   ADC $16                  
828AD1   STA $16                  
828AD3   LDA $2A                  
828AD5   SEC                      
828AD6   SBC #$0020               
828AD9   STA $2A                  
828ADB   SEP #$20                 
828ADD   LDA $17                  
828ADF   BPL $828AE9              
828AE1   LDA #$06                 
828AE3   STA $02                  
828AE5   STZ $17                  
828AE7   STZ $2F                  
828AE9   RTS                      
----------------         
--------sub start--------
828AEA   LDA #$01                 
828AEC   XBA                      
828AED   LDA #$00                 
828AEF   JSR $8B01                
828AF2   LDA #$01                 
828AF4   XBA                      
828AF5   LDA #$80                 
828AF7   JSR $8B01                
828AFA   LDA #$00                 
828AFC   XBA                      
828AFD   LDA #$00                 
828AFF   TCD                      
828B00   RTL                      
----------------         
--------sub start--------
828B01   TCD                      
828B02   LDA $00                  
828B04   CMP #$04                 
828B06   BNE $828B1E              
--------sub start--------
828B08   STZ $00                  
828B0A   STZ $01                  
828B0C   STZ $02                  
828B0E   STZ $03                  
828B10   STZ $04                  
828B12   STZ $05                  
828B14   STZ $2F                  
828B16   DEC $57                  
828B18   BEQ $828B1F              
828B1A   LDA #$04                 
828B1C   STA $00                  
828B1E   RTS                      
----------------         
828B1F   LDA #$06                 
828B21   STA $70                  
828B23   STZ $71                  
828B25   JSL $808589              
828B29   LDA $0A                  
828B2B   LSR                      
828B2C   INC                      
828B2D   EOR $00BD                
828B30   STA $00BD                
828B33   BNE $828B52              
828B35   LDA $40                  
828B37   STZ $40                  
828B39   STA $00BF                
828B3C   LDA $42                  
828B3E   STZ $42                  
828B40   STA $00C0                
828B43   LDA $43                  
828B45   STZ $43                  
828B47   STA $00C1                
828B4A   LDA $41                  
828B4C   STZ $41                  
828B4E   STA $00C2                
828B51   RTS                      
----------------         
--------unidentified--------
828B52  .db $A5 $42 $F0 $1D $A5 $0A $4A $A8
828B5A  .db $BE $E4 $B6 $BD $42 $01 $D0 $12
828B62  .db $A5 $42 $64 $42 $9D $42 $01 $A5
828B6A  .db $5A $9D $5A $01 $A5 $5B $9D $5B
828B72  .db $01 $60 $A5 $42 $64 $42 $9D $43
828B7A  .db $01 $A5 $5A $9D $5C $01 $A5 $5B
828B82  .db $9D $5D $01 $A9 $02 $9D $40 $01
828B8A  .db $9E $41 $01 $9E $3F $01 $60
----------------         
--------sub start--------
828B91   JSL $8088CE              
828B95   LDX $30                  
828B97   JMP ($8B9A,X)            
--------data--------     
828B9A  .db $A4 $8B $FF $8B $2E $8C $64 $8C
828BA2  .db $73 $8C              
----------------         
828BA4   LDA $31                  
828BA6   ORA #$20                 
828BA8   JSL $808667              
828BAC   INC $31                  
828BAE   LDA $31                  
828BB0   CMP #$08                 
828BB2   BCC $828BFE              
828BB4   LDA #$02                 
828BB6   STA $30                  
828BB8   STZ $31                  
828BBA   LDA #$22                 
828BBC   STA $2123                
828BBF   STZ $2124                
828BC2   LDA #$20                 
828BC4   STA $2125                
828BC7   LDA #$12                 
828BC9   STA $0084                
828BCC   LDA #$83                 
828BCE   STA $0085                
828BD1   LDX $00B6                
828BD4   LDA $B7E5,X              
828BD7   STA $0086                
828BDA   STA $0087                
828BDD   STA $0088                
828BE0   LDA #$01                 
828BE2   STA $4370                
828BE5   LDA #$26                 
828BE7   STA $4371                
828BEA   LDA #$D8                 
828BEC   STA $4372                
828BEF   LDA #$B7
828BF1   STA $4373                
828BF4   LDA #$83                 
828BF6   STA $4374                
828BF9   LDA #$80                 
828BFB   STA $0089                
828BFE   RTS                      
----------------         
828BFF   LDA #$04                 
828C01   STA $30                  
828C03   LDA $32                  
828C05   AND #$0E                 
828C07   LSR                      
828C08   TAX                      
828C09   LDA $80B8,X              
828C0C   AND $00CE                
828C0F   BEQ $828C12              
828C11   SEC                      
828C12   LDA $00CE                
828C15   ORA $80B8,X              
828C18   STA $00CE                
828C1B   LDA $32                  
828C1D   AND #$0E                 
828C1F   LDX $00B6                
828C22   ADC $8BE800,X            
828C26   TAX                      
828C27   LDA $8BE800,X            
828C2B   JMP $8C9B                
828C2E   JSR $8CAC                
828C31   BEQ $828C49              
828C33   BPL $828C48              
828C35   DEC                      
828C36   BMI $828C4E              
828C38   REP #$21                 
828C3A   LDA $38                  
828C3C   AND #$FFE0               
828C3F   ADC #$0044               
828C42   STA $38                  
828C44   INC $3A                  
828C46   SEP #$20                 
828C48   RTS                      
----------------         
828C49   LDA #$08                 
828C4B   STA $30                  
828C4D   RTS                      
----------------         
828C4E   LDA #$06                 
828C50   STA $30                  
828C52   LDA #$06                 
828C54   JSL $8085CC              
828C58   REP #$20                 
828C5A   LDA #$4E44               
828C5D   STA $38                  
828C5F   INC $3A                  
828C61   SEP #$20                 
828C63   RTS                      
----------------         
828C64   LDA $65                  
828C66   BIT #$CC                 
828C68   BEQ $828C72              
828C6A   LDA #$04                 
828C6C   STA $30                  
828C6E   JSL $808574              
828C72   RTS                      
----------------         
828C73   LDA $65                  
828C75   BIT #$CC                 
828C77   BEQ $828C9A              
828C79   LDA #$02                 
828C7B   STA $02                  
828C7D   STZ $30                  
828C7F   STZ $32                  
828C81   STZ $00AC                
828C84   JSL $80856E              
828C88   STZ $2123                
828C8B   STZ $2124                
828C8E   STZ $2125                
828C91   STZ $0084                
828C94   STZ $0085                
828C97   STZ $0089                
828C9A   RTS                      
----------------         
828C9B   ASL                      
828C9C   TAX                      
828C9D   REP #$20                 
828C9F   LDA $8BE81D,X            
828CA3   STA $3A                  
828CA5   LDA #$4E44               
828CA8   STA $38                  
828CAA   SEP #$20                 
--------sub start--------
828CAC   PEA #$838B               
828CAF   PLB                      
828CB0   LDX $0041                
828CB3   LDA #$80                 
828CB5   STA $1900,X              
828CB8   LDA #$02                 
828CBA   STA $1903,X              
828CBD   REP #$20                 
828CBF   LDA $38                  
828CC1   STA $1901,X              
828CC4   INC $38                  
828CC6   LDA ($3A)                
828CC8   INC $3A                  
828CCA   SEP #$21                 
828CCC   STA $1904,X              
828CCF   LDA #$20                 
828CD1   STA $1905,X              
828CD4   TXA                      
828CD5   ADC #$05                 
828CD7   STA $0041                
828CDA   LDA ($3A)                
828CDC   PLB                      
828CDD   CMP #$00                 
828CDF   RTS                      
----------------         
--------unidentified--------
828CE0  .db $A2 $00 $80 $06 $22 $A3 $BF $80
828CE8  .db $A6 $46 $C2 $21 $FC $22 $8D $A5
828CF0  .db $34 $85 $28 $A5 $36 $85 $2A $E2
828CF8  .db $20 $22 $07 $C0 $80 $C2 $10 $A9
828D00  .db $00 $A6 $34 $F0 $08 $30 $04 $09
828D08  .db $01 $80 $02 $09 $02 $A6 $36 $F0
828D10  .db $08 $30 $04 $09 $04 $80 $02 $09
828D18  .db $08 $E2 $10 $AA $BD $C6 $B7 $85
828D20  .db $33 $60 $34 $8D $3A $8D $40 $8D
828D28  .db $46 $8D $4C $8D $52 $8D $58 $8D
828D30  .db $5E $8D $64 $8D $20 $B0 $8D $4C
828D38  .db $C7 $8D $20 $9E $8D $4C $B0 $8D
828D40  .db $20 $6B $8D $4C $C7 $8D $20 $8E
828D48  .db $8D $4C $B0 $8D $20 $7C $8D $4C
828D50  .db $C7 $8D $20 $9E $8D $4C $6A $8D
828D58  .db $20 $9E $8D $4C $7B $8D $20 $8E
828D60  .db $8D $4C $6A $8D $20 $8E $8D $4C
828D68  .db $7B $8D $18 $A5 $34 $69 $10 $00
828D70  .db $30 $06 $C5 $28 $90 $02 $A5 $28
828D78  .db $85 $34 $60 $18 $A5 $34 $69 $F0
828D80  .db $FF $10 $08 $85 $34 $A5 $28 $C5
828D88  .db $34 $90 $02 $85 $34 $60 $A5 $36
828D90  .db $69 $10 $00 $30 $06 $C5 $2A $90
828D98  .db $02 $A5 $2A $85 $36 $60 $A5 $36
828DA0  .db $69 $F0 $FF $10 $08 $85 $36 $A5
828DA8  .db $2A $C5 $36 $90 $02 $85 $36 $60
828DB0  .db $18 $A5 $34 $30 $0B $69 $F8 $FF
828DB8  .db $10 $03 $A9 $00 $00 $85 $34 $60
828DC0  .db $69 $08 $00 $30 $F8 $80 $F3 $18
828DC8  .db $A5 $36 $30 $0B $69 $F8 $FF $10
828DD0  .db $03 $A9 $00 $00 $85 $36 $60 $69
828DD8  .db $08 $00 $30 $F8 $80 $F3
----------------         
--------sub start--------
828DDE   LDX #$00                 
828DE0   LDA $0A                  
828DE2   BEQ $828DE6              
828DE4   LDX #$40                 
828DE6   LDA $0D80,X              
828DE9   BEQ $828E21              
828DEB   DEC                      
828DEC   BNE $828E0F              
828DEE   LDA $0DBB,X              
828DF1   BEQ $828E0F              
828DF3   REP #$10                 
828DF5   LDY $0DBA,X              
828DF8   LDA #$02                 
828DFA   STA $0000,Y              
828DFD   LDA #$06                 
828DFF   STA $0002,Y              
828E02   LDA #$00                 
828E04   STA $0003,Y              
828E07   STA $0004,Y              
828E0A   STA $0005,Y              
828E0D   SEP #$10                 
828E0F   STZ $0D80,X              
828E12   STZ $0D81,X              
828E15   STZ $0D82,X              
828E18   STZ $0D83,X              
828E1B   STZ $0D84,X              
828E1E   STZ $0D85,X              
828E21   RTS                      
----------------         
--------sub start--------
828E22   STZ $49                  
828E24   STZ $5E                  
828E26   LDA $47                  
828E28   ASL                      
828E29   TAY                      
828E2A   JSR $8ED7                
828E2D   STX $0010                
828E30   LDA $0004                
828E33   STA $0008                
828E36   LDA $0006                
828E39   STA $000A                
828E3C   SEP #$10                 
828E3E   JSR $8ED7                
828E41   STX $0013                
828E44   SEP #$10                 
828E46   LDX $5E                  
828E48   JMP ($8E4B,X)            
--------data--------     
828E4B  .db $53 $8E $55 $8E $6E $8E $75 $8E
----------------         
828E53   CLC                      
828E54   RTS                      
----------------         
828E55   REP #$10                 
828E57   LDX $0013                
828E5A   STX $0010                
828E5D   LDA $1400,X              
828E60   CMP #$A0                 
828E62   BEQ $828EA3              
828E64   CMP #$B1                 
828E66   BNE $828E6A              
828E68   INC $49                  
828E6A   SEP #$10                 
828E6C   CLC                      
828E6D   RTS                      
----------------         
828E6E   REP #$10                 
828E70   LDX $0010                
828E73   BRA $828E5D              
828E75   LDX $47                  
828E77   JMP ($8E7A,X)            
--------data--------     
828E7A  .db $82 $8E $8D $8E $98 $8E $8D $8E
----------------         
828E82   LDA $0008                
828E85   AND #$07                 
828E87   CMP #$06                 
828E89   BCC $828E6E              
828E8B   BRA $828E55              
828E8D   LDA $000A                
828E90   AND #$07                 
828E92   CMP #$04                 
828E94   BCC $828E6E              
828E96   BRA $828E55              
828E98   LDA $0008                
828E9B   AND #$07                 
828E9D   CMP #$05                 
828E9F   BCC $828E6E              
828EA1   BRA $828E55              
828EA3   STX $5E                  
828EA5   LDA #$00                 
828EA7   XBA                      
828EA8   LDA $47                  
828EAA   ASL                      
828EAB   TAY                      
828EAC   REP #$21                 
828EAE   TXA                      
828EAF   ADC $B78A,Y              
828EB2   TAX                      
828EB3   CLC                      
828EB4   ADC $B78C,Y              
828EB7   TAY                      
828EB8   SEP #$20                 
828EBA   LDA $1400,X              
828EBD   LDX $1400,Y              
828EC0   SEP #$10                 
828EC2   CMP #$00                 
828EC4   BPL $828ECA              
828EC6   CMP #$F0                 
828EC8   BNE $828ED1              
828ECA   TXA                      
828ECB   BPL $828ED5              
828ECD   CMP #$F0                 
828ECF   BEQ $828ED5              
828ED1   INC $49                  
828ED3   CLC                      
828ED4   RTS                      
----------------         
828ED5   SEC                      
828ED6   RTS                      
----------------         
--------sub start--------
828ED7   CLC                      
828ED8   LDA $11                  
828EDA   ADC $B77A,Y              
828EDD   STA $0004                
828EE0   LSR                      
828EE1   LSR                      
828EE2   LSR                      
828EE3   STA $0002                
828EE6   STZ $0003                
828EE9   LDA $14                  
828EEB   REP #$31                 
828EED   ADC $B77B,Y              
828EF0   STA $0006                
828EF3   AND #$00F8               
828EF6   ASL                      
828EF7   ASL                      
828EF8   ADC $0002                
828EFB   TAX                      
828EFC   INY                      
828EFD   INY                      
828EFE   SEP #$20                 
828F00   LDA $1400,X              
828F03   BPL $828F16              
828F05   REP #$21                 
828F07   PHY                      
828F08   AND #$000E               
828F0B   TAY                      
828F0C   TXA                      
828F0D   ADC $B79A,Y              
828F10   TAX                      
828F11   PLY                      
828F12   SEP #$20                 
828F14   INC $5E                  
828F16   ASL $5E                  
828F18   RTS                      
----------------         
828F19   LDA $56                  
828F1B   LSR                      
828F1C   TAX                      
828F1D   LDA $23                  
828F1F   LSR                      
828F20   ADC $B7BA,X              
828F23   TAY                      
828F24   LDA $B7BA,Y              
828F27   STA $55                  
828F29   RTS                      
----------------         
828F2A   LDA $65                  
828F2C   BIT $77                  
828F2E   BEQ $828F48              
828F30   LDA $41                  
828F32   STA $4E                  
828F34   STZ $41                  
828F36   LDX $42                  
828F38   JSR ($8FC2,X)            
828F3B   LDA #$02                 
828F3D   STA $41                  
828F3F   LDX $43                  
828F41   JSR ($8FC2,X)            
828F44   LDA $4E                  
828F46   STA $41                  
828F48   LDA $78                  
828F4A   BNE $828F5D              
828F4C   LDA $65                  
828F4E   BIT $75                  
828F50   BNE $828F6D              
828F52   LDA $45                  
828F54   BEQ $828F5C              
828F56   LDA $65                  
828F58   BIT $77                  
828F5A   BNE $828F6D              
828F5C   RTS                      
----------------         
--------unidentified--------
828F5D  .db $A5 $61 $24 $75 $D0 $12 $A5 $45
828F65  .db $F0 $06 $A5 $61 $24 $77 $D0 $08
----------------         
828F6D   LDA $53                  
828F6F   BEQ $828F76              
828F71   LDA #$06                 
828F73   STA $03                  
828F75   RTS                      
----------------         
828F76   STZ $54                  
828F78   JMP $861A                
828F7B   LDA $65                  
828F7D   BIT $75                  
828F7F   BNE $828F8C              
828F81   LDA $42                  
828F83   BEQ $828F8B              
828F85   LDA $65                  
828F87   BIT $77                  
828F89   BNE $828F91 ;Goto item use routine if we're pressing Y button
828F8B   RTS 
----------------         
828F8C   LDA #$02                 
828F8E   STA $03                  
828F90   RTS                      
;ItemUse Routine!     
828F91   LDA $41 ; Load item slot
828F93   STA $4E ; Store the slot 4E ?
828F95   STZ $41 ; Item slot to 0
828F97   LDX $42 ; Load P1 Item1
828F99   JSR ($8FC2,X)            
828F9C   LDA #$02                 
828F9E   STA $41                  
828FA0   LDX $43                  
828FA2   JSR ($8FC2,X)            
828FA5   LDA $4E                  
828FA7   STA $41                  
828FA9   LDX $42                  
828FAB   LDA $41                  
828FAD   BEQ $828FB1              
828FAF   LDX $43                  
828FB1   JMP ($8FB2,X)            
;Using Item Table 2   
828FB4
dw $8FD2 ;0x02 Hookshot
dw $8FE5 ;0x04 Candle
dw $8FE6 ;0x06 Small Key
dw $8FEB ;0x08 Boss Key
dw $8FD9 ;0x0A Shovel 
dw $8FDF ;0x0C Bell   
dw $8FF0 ;0x0E Plank  
    
;Using Item Table    
828FC2
dw $8FF3 ;0x00 Nothing?
dw $8FF3 ;0x02 Hookshot
dw $8FF3 ;0x04 Candle
dw $8FF4 ;0x06 Small Key
dw $8FFE ;0x08 Boss Key
dw $8FF3 ;0x0A Shovel   
dw $8FF3 ;0x0C Bell
dw $9005 ;0x0E Plank
 
----------------         
828FD2   LDA $00                  
828FD4   CMP #$05                 
828FD6   BNE $828FDF              
828FD8   RTS                      
----------------         
ItemUseShovel2:
828FD9  .db $A5 $47 $29 $02 $F0 $06

ItemUseBell2:
828FDF   TXA ;? 
828FE0   CLC ;?                     
828FE1   ADC #$08 
828FE3   STA $03 ;that function return $0103 ($0103 here = 0x0C+0x08 = 0x14)
828FE5   RTS ;jumpback to 828231
----------------         
ItemUseSmallKey2:
828FE6  .db $A9 $00 $4C $3A $9B 
828FEB  .db $A9 $80 $4C
828FEE  .db $3A $9B 
828FF0  .db $4C $A5 $9C  
----------------
;828FF3         
ItemUseReturn:
RTS                      
----------------         
;small key use
;828FF4  .db $A9 $00 $20 $3A $9B
ItemUseSmallKey:
828FF4 LDA #$00 ;Get Stored in $016E (compared with bit7 of door array)
828FF6 JSR $9B3A ;Check if we are unlocking a door <- complicated routine
;-------------------   
828FF9   BCC $828FFD ;branch if we're not unlocking the door
828FFB   PLA                      
828FFC   PLA                      
828FFD   RTS                      
;------------------      
ItemUseBossKey:
828FFE   LDA #$80 ;Get Stored in $016E (compared with bit7 of door array)
829000   JSR $9B3A ;Check if we are unlocking a door <- complicated routine
829003   BRA $828FF9
ItemUsePlank:
829005   JSR $9CA5
829008   BRA $828FF9

;82900A
DoJumpUknown_TODO:
{
82900A   LDA $60                  
82900C   ASL                      
82900D   TAX                      
82900E   JMP ($9011,X)   
}         

JumpTableUnknown_TODO:
{   
dw $9031 ;00
dw $9079 ;02
dw $90D3 ;04
dw $9031 ;06
dw $90A6 ;08
dw $9164 ;0A
dw $9195 ;0C
dw $9031 ;0E
dw $904E ;10
dw $9102 ;12
dw $9133 ;14
dw $9031 ;16
dw $9031 ;18
dw $9031 ;1A
dw $9031 ;1C
dw $9031 ;1E        
}


;JumpTableUnknown00,06,0E,16,18,1A,1C,1E
829031   LDA $48                  
829033   BNE $82904D              
829035   STZ $46                  
829037   LDA #$02                 
829039   STA $48                  
82903B   LDA $47                  
82903D   CLC                      
82903E   ADC $0B                  
829040   ADC $54                  
829042   TAX                      
829043   LDA $B980,X              
829046   LDY $B97F,X              
829049   JSL $8089D7              
82904D   RTS                      
;JumpTableUnknown02        
82904E   LDA #$02                 
829050   CMP $46                  
829052   BEQ $829078              
829054   STA $46                  
829056   STZ $0D                  
829058   LDX #$00                 
82905A   LDA $48                  
82905C   BNE $829062              
82905E   CPX $47                  
829060   BEQ $829078              
829062   STX $47                  
829064   STZ $48                  
829066   LDA $0B                  
829068   CLC                      
829069   ADC $54                  
82906B   TAX                      
82906C   LDA $B9A0,X              
82906F   LDY $B99F,X              
829072   JSL $8089D7              
829076   STZ $0E                  
829078   RTS                      
;JumpTableUnknown04         
829079   LDA #$04                 
82907B   CMP $46                  
82907D   BEQ $8290A5              
82907F   STA $46                  
829081   LDA #$02                 
829083   STA $0D                  
829085   LDX #$02                 
829087   LDA $48                  
829089   BNE $82908F              
82908B   CPX $47                  
82908D   BEQ $8290A5              
82908F   STX $47                  
829091   STZ $48                  
829093   LDA $0B                  
829095   CLC                      
829096   ADC $54                  
829098   TAX                      
829099   LDA $B9A2,X              
82909C   LDY $B9A1,X              
82909F   JSL $8089D7              
8290A3   STZ $0E                  
8290A5   RTS                     
;JumpTableUnknown08         
8290A6   LDA #$06                 
8290A8   CMP $46                  
8290AA   BEQ $8290D2              
8290AC   STA $46                  
8290AE   LDA #$04                 
8290B0   STA $0D                  
8290B2   LDX #$04                 
8290B4   LDA $48                  
8290B6   BNE $8290BC              
8290B8   CPX $47                  
8290BA   BEQ $8290D2              
8290BC   STX $47                  
8290BE   STZ $48                  
8290C0   LDA $0B                  
8290C2   CLC                      
8290C3   ADC $54                  
8290C5   TAX                      
8290C6   LDA $B9A4,X              
8290C9   LDY $B9A3,X              
8290CC   JSL $8089D7              
8290D0   STZ $0E                  
8290D2   RTS                      
;JumpTableUnknown04       
8290D3   LDA #$08                 
8290D5   CMP $46                  
8290D7   BEQ $829101              
8290D9   STA $46                  
8290DB   LDA #$06                 
8290DD   STA $0D                  
8290DF   LDX #$06                 
8290E1   LDA $48                  
8290E3   BNE $8290E9              
8290E5   CPX $47                  
8290E7   BEQ $829101              
8290E9   STX $47                  
8290EB   STZ $48                  
8290ED   LDA $0B                  
8290EF   CLC                      
8290F0   ADC $54                  
8290F2   TAX                      
8290F3   LDA $B9A2,X              
8290F6   LDY $B9A1,X              
8290F9   JSL $8089D7              
8290FD   LDA #$01                 
8290FF   STA $0E                  
829101   RTS                      
;JumpTableUnknown12       
829102   LDA #$0A                 
829104   CMP $46                  
829106   BEQ $829132              
829108   STA $46                  
82910A   LDA #$01                 
82910C   STA $0D                  
82910E   LDA $48                  
829110   BNE $82911C              
829112   LDA $47                  
829114   CMP #$00                 
829116   BEQ $829132              
829118   CMP #$02                 
82911A   BEQ $829132              
82911C   LDA $0B                  
82911E   CLC                      
82911F   ADC $54                  
829121   TAX                      
829122   LDA $B9A0,X              
829125   LDY $B99F,X              
829128   JSL $8089D7              
82912C   LDA #$00                 
82912E   STA $47                  
829130   STZ $48                  
829132   RTS                      
;JumpTableUnknown14   
829133   LDA #$0C                 
829135   CMP $46                  
829137   BEQ $829163              
829139   STA $46                  
82913B   LDA #$07                 
82913D   STA $0D                  
82913F   LDA $48                  
829141   BNE $82914D              
829143   LDA $47                  
829145   CMP #$00                 
829147   BEQ $829163              
829149   CMP #$06                 
82914B   BEQ $829163              
82914D   LDA $0B                  
82914F   CLC                      
829150   ADC $54                  
829152   TAX                      
829153   LDA $B9A0,X              
829156   LDY $B99F,X              
829159   JSL $8089D7              
82915D   LDA #$00                 
82915F   STA $47                  
829161   STZ $48                  
829163   RTS                      
;JumpTableUnknown0A       
829164   LDA #$0E                 
829166   CMP $46                  
829168   BEQ $829194              
82916A   STA $46                  
82916C   LDA #$03                 
82916E   STA $0D                  
829170   LDA $48                  
829172   BNE $82917E              
829174   LDA $47                  
829176   CMP #$04                 
829178   BEQ $829194              
82917A   CMP #$02                 
82917C   BEQ $829194              
82917E   LDA $0B                  
829180   CLC                      
829181   ADC $54                  
829183   TAX                      
829184   LDA $B9A4,X              
829187   LDY $B9A3,X              
82918A   JSL $8089D7              
82918E   LDA #$04                 
829190   STA $47                  
829192   STZ $48                  
829194   RTS                      
;JumpTableUnknown0C       
829195   LDA #$10                 
829197   CMP $46                  
829199   BEQ $8291C5              
82919B   STA $46                  
82919D   LDA #$05                 
82919F   STA $0D                  
8291A1   LDA $48                  
8291A3   BNE $8291AF              
8291A5   LDA $47                  
8291A7   CMP #$04                 
8291A9   BEQ $8291C5              
8291AB   CMP #$06                 
8291AD   BEQ $8291C5              
8291AF   LDA $0B                  
8291B1   CLC                      
8291B2   ADC $54                  
8291B4   TAX                      
8291B5   LDA $B9A4,X              
8291B8   LDY $B9A3,X              
8291BB   JSL $8089D7              
8291BF   LDA #$04                 
8291C1   STA $47                  
8291C3   STZ $48                  
8291C5   RTS                      
----------------         
--------unidentified--------
8291C6  .db $7C $C9 $91 $D1 $91 $DA $91 $E3
8291CE  .db $91 $EC $91 $A2 $00 $20 $F9 $91
8291D6  .db $20 $39 $92 $6B $A2 $00 $20 $FF
8291DE  .db $92 $20 $3C $93 $6B $A2 $03 $20
8291E6  .db $F9 $91 $20 $4B $92 $6B $A2 $03
8291EE  .db $20 $FF $92 $20 $41 $93 $6B $A9
8291F6  .db $03 $80 $02          
----------------         
--------sub start--------
8291F9   LDA #$02                 
8291FB   STA $000C                
8291FE   STZ $5E                  
829200   LDA $14                  
829202   CLC                      
829203   ADC $B71C,X              
829206   STA $0008                
829209   REP #$20                 
82920B   AND #$00F8               
82920E   ASL                      
82920F   ASL                      
829210   STA $0000                
829213   REP #$31                 
829215   LDA $11                  
829217   ADC $B71D,X              
82921A   INX                      
82921B   AND #$00FF               
82921E   LSR                      
82921F   LSR                      
829220   LSR                      
829221   CLC                      
829222   ADC $0000                
829225   TAY                      
829226   SEP #$20                 
829228   LDA $1400,Y              
82922B   BPL $82922F              
82922D   INC $5E                  
82922F   ASL $5E                  
829231   DEC $000C                
829234   BNE $829213              
829236   SEP #$10                 
829238   RTS                      
----------------         
--------sub start--------
829239   LDA $5E                  
82923B   BEQ $82924A              
82923D   LDA $0008                
829240   EOR #$FF                 
829242   AND #$07                 
829244   INC                      
829245   CLC                      
829246   ADC $14                  
829248   STA $14                  
82924A   RTS                      
----------------         
--------sub start--------
82924B   LDA $5E                  
82924D   BEQ $82925B              
82924F   LDA $0008                
829252   AND #$07                 
829254   EOR #$FF                 
829256   CLC                      
829257   ADC $14                  
829259   STA $14                  
82925B   RTS                      
----------------         
--------sub start--------
82925C   LDA $5E                  
82925E   STZ $5E                  
829260   CMP #$06                 
829262   BNE $829265              
829264   RTS                      
----------------         
829265   LDA #$02                 
829267   STA $000C                
82926A   LDX #$00                 
82926C   REP #$31                 
82926E   LDA $11                  
829270   ADC $B732,X              
829273   AND #$00FF               
829276   INX                      
829277   LSR                      
829278   LSR                      
829279   LSR                      
82927A   CLC                      
82927B   ADC $0000                
82927E   TAY                      
82927F   SEP #$20                 
829281   LDA $1400,Y              
829284   BPL $829288              
829286   INC $5E                  
829288   ASL $5E                  
82928A   DEC $000C                
82928D   BNE $82926C              
82928F   SEP #$10                 
829291   RTS                      
----------------         
829292   LDX $5E                  
829294   JMP ($9297,X)            
--------data--------     
829297  .db $F1 $92 $C8 $92 $AC $92
----------------         
--------unidentified--------
82929D  .db $E4 $92              
----------------         
82929F   LDX $5E                  
8292A1   JMP ($92A4,X)            
--------data--------     
8292A4  .db $F1 $92 $C8 $92 $AC $92
----------------         
--------unidentified--------
8292AA  .db $F2 $92              
----------------         
8292AC   REP #$21                 
8292AE   LDA $10                  
8292B0   ADC #$00C0               
8292B3   STA $10                  
8292B5   SEP #$20                 
8292B7   LDX #$00                 
8292B9   JSR $92FF                
8292BC   JSR $9374                
8292BF   LDA $14                  
8292C1   AND #$F8                 
8292C3   ORA #$04                 
8292C5   STA $14                  
8292C7   RTS                      
----------------         
8292C8   REP #$21                 
8292CA   LDA $10                  
8292CC   ADC #$FF40               
8292CF   STA $10                  
8292D1   SEP #$20                 
8292D3   LDX #$03                 
8292D5   JSR $92FF                
8292D8   JSR $93A4                
8292DB   LDA $14                  
8292DD   AND #$F8                 
8292DF   ORA #$04                 
8292E1   STA $14                  
8292E3   RTS                      
----------------         
--------unidentified--------
8292E4  .db $AD $08 $00 $49 $FF $29 $07 $1A
8292EC  .db $18 $65 $14 $85 $14  
----------------         
8292F1   RTS                      
----------------         
--------unidentified--------
8292F2  .db $AD $08 $00 $29 $07 $49 $FF $18
8292FA  .db $65 $14 $85 $14 $60  
----------------         
--------sub start--------
8292FF   STZ $5E                  
829301   LDA #$02                 
829303   STA $000C                
829306   CLC                      
829307   LDA $11                  
829309   ADC $B734,X              
82930C   STA $0006                
82930F   LSR                      
829310   LSR                      
829311   LSR                      
829312   STA $0002                
829315   STZ $0003                
829318   REP #$31                 
82931A   LDA $14                  
82931C   ADC $B735,X              
82931F   INX                      
829320   AND #$00F8               
829323   ASL                      
829324   ASL                      
829325   ADC $0002                
829328   TAY                      
829329   SEP #$20                 
82932B   LDA $1400,Y              
82932E   BPL $829332              
829330   INC $5E                  
829332   ASL $5E                  
829334   DEC $000C                
829337   BNE $829318              
829339   SEP #$10                 
82933B   RTS                      
----------------         
82933C   LDX $5E                  
82933E   JMP ($9346,X)            
829341   LDX $5E                  
829343   JMP ($934E,X)            
--------data--------     
829346  .db $85 $93 $56 $93 $65 $93 $78 $93
82934E  .db $B6 $93 $86 $93 $95 $93 $A8 $93
----------------         
829356   JSR $9378                
829359   REP #$21                 
82935B   LDA $13                  
82935D   ADC #$FF40               
829360   STA $13                  
829362   SEP #$20                 
829364   RTS                      
----------------         
829365   JSR $9378                
829368   REP #$21                 
82936A   LDA $13                  
82936C   ADC #$00C0               
82936F   STA $13                  
829371   SEP #$20                 
829373   RTS                      
----------------         
--------sub start--------
829374   LDA $5E                  
829376   BEQ $829385              
--------sub start--------
829378   LDA $0006                
82937B   AND #$07                 
82937D   EOR #$FF                 
82937F   CLC                      
829380   ADC $11                  
829382   STA $11                  
829384   SEC                      
829385   RTS                      
----------------         
829386   JSR $93A8                
829389   REP #$21                 
82938B   LDA $13                  
82938D   ADC #$FF40               
829390   STA $13                  
829392   SEP #$20                 
829394   RTS                      
----------------         
829395   JSR $93A8                
829398   REP #$21                 
82939A   LDA $13                  
82939C   ADC #$00C0               
82939F   STA $13                  
8293A1   SEP #$20                 
8293A3   RTS                      
----------------         
--------sub start--------
8293A4   LDA $5E                  
8293A6   BEQ $8293B6              
--------sub start--------
8293A8   LDA $0006                
8293AB   EOR #$FF                 
8293AD   AND #$07                 
8293AF   INC                      
8293B0   CLC                      
8293B1   ADC $11                  
8293B3   STA $11                  
8293B5   SEC                      
8293B6   RTS                      
----------------         
--------sub start--------
8293B7   TAX                      
8293B8   STA $0004                
8293BB   STZ $0005                
8293BE   STZ $5E                  
8293C0   STZ $5F                  
8293C2   LDA #$03                 
8293C4   STA $000C                
8293C7   LDA $14                  
8293C9   CLC                      
8293CA   ADC $B73A,X              
8293CD   STA $0008                
8293D0   REP #$20                 
8293D2   AND #$00F8               
8293D5   ASL                      
8293D6   ASL                      
8293D7   STA $0000                
8293DA   REP #$31                 
8293DC   LDA $11                  
8293DE   ADC $B73B,X              
8293E1   INX                      
8293E2   AND #$00FF               
8293E5   LSR                      
8293E6   LSR                      
8293E7   LSR                      
8293E8   CLC                      
8293E9   ADC $0000                
8293EC   TAY                      
8293ED   SEP #$20                 
8293EF   LDA $1400,Y              
8293F2   BPL $8293F9              
8293F4   INC $5E                  
8293F6   INC $5F                  
8293F8   RTS                      
----------------         
8293F9   DEC $000C                
8293FC   BNE $8293DA              
8293FE   RTS                      
----------------         
--------sub start--------
8293FF   LDX $0004                
829402   STZ $5E                  
829404   LDA #$02                 
829406   STA $000C                
829409   CLC                      
82940A   LDA $11                  
82940C   ADC $B73E,X              
82940F   STA $0006                
829412   LSR                      
829413   LSR                      
829414   LSR                      
829415   STA $0002                
829418   STZ $0003                
82941B   REP #$31                 
82941D   LDA $14                  
82941F   ADC $B73F,X              
829422   INX                      
829423   AND #$00F8               
829426   ASL                      
829427   ASL                      
829428   ADC $0002                
82942B   TAY                      
82942C   SEP #$20                 
82942E   LDA $1400,Y              
829431   SEP #$10                 
829433   BPL $82943A              
829435   INC $5E                  
829437   INC $5F                  
829439   RTS                      
----------------         
82943A   DEC $000C                
82943D   BNE $82941B              
82943F   RTS                      
----------------         
--------sub start--------
829440   STZ $5E                  
829442   REP #$31                 
829444   LDA $0000                
829447   ADC $0002                
82944A   TAY                      
82944B   SEP #$20                 
82944D   LDA $1400,Y              
829450   BPL $829459              
829452   LDA $47                  
829454   AND #$02                 
829456   INC                      
829457   STA $5E                  
829459   SEP #$10                 
82945B   RTS                      
----------------         
--------sub start--------
82945C   LDX $42 ;???
82945E   LDA $B6EC,X              
829461   STA $5A2 ;???                  
829463   LDA $B6ED,X              
829466   STA $5B2 ;???
829468   LDX $432 ;???
82946A   LDA $B6EC,X              
82946D   STA $5C2 ;???
82946F   LDA $B6ED,X              
829472   STA $5D2 ;???
829474   RTS                      
----------------         
--------sub start--------
829475   LDA $00                  
829477   CMP #$03                 
829479   BNE $829493              
82947B   LDA $009F                
82947E   AND #$02                 
829480   STA $01                  
829482   LDA $3C                  
829484   INC                      
829485   CMP #$64                 
829487   BCC $829491              
829489   LDA #$01                 
82948B   STA $00                  
82948D   STA $01                  
82948F   LDA #$00                 
829491   STA $3C                  
829493   RTS                      
----------------         
--------unidentified--------
829494  .db $A5 $47 $29 $04 $AA $C2 $31 $BD
82949C  .db $FB $B8 $65 $11 $C9 $00 $01 $B0
8294A4  .db $6B $4A $4A $4A $85 $68 $A5 $14
8294AC  .db $C9 $E0 $00 $B0 $5F $29 $F8 $00
8294B4  .db $0A $0A $65 $68 $85 $5E $A8 $E2
8294BC  .db $20 $B9 $00 $14 $85 $6C $29 $F0
8294C4  .db $C9 $40 $D0 $48 $A5 $6C $29 $07
8294CC  .db $C2 $21 $29 $FF $00 $A8 $A5 $5E
8294D4  .db $79 $03 $B9 $85 $5E $BD $FD $B8
8294DC  .db $18 $65 $11 $4A $4A $4A $85 $6A
8294E4  .db $A5 $14 $29 $F8 $00 $0A $0A $65
8294EC  .db $6A $A8 $E2 $20 $B9 $00 $14 $85
8294F4  .db $6C $29 $F0 $C9 $40 $D0 $15 $A5
8294FC  .db $6C $29 $07 $C2 $21 $29 $FF $00
829504  .db $AA $98 $7D $03 $B9 $C5 $5E $D0
82950C  .db $03 $E2 $31 $60 $E2 $30 $18 $60
----------------         
--------sub start--------
829514   LDA $47                  
829516   ASL                      
829517   TAX                      
829518   REP #$21                 
82951A   LDA $11                  
82951C   ADC $B7EA,X              
82951F   STA $68                  
829521   LDA $14                  
829523   CLC                      
829524   ADC $B7EC,X              
829527   STA $6A                  
829529   SEP #$20                 
82952B   LDX #$00                 
82952D   LDA $1040,X              
829530   DEC                      
829531   BNE $829552              
829533   REP #$21                 
829535   LDA $1051,X              
829538   ADC #$000B               
82953B   SEC                      
82953C   SBC $68                  
82953E   CMP #$0019               
829541   BCS $829552              
829543   LDA $1054,X              
829546   CLC                      
829547   ADC #$0007               
82954A   SEC                      
82954B   SBC $6A                  
82954D   CMP #$000D               
829550   BCC $82955F              
829552   SEP #$20                 
829554   TXA                      
829555   CLC                      
829556   ADC #$20                 
829558   TAX                      
829559   CMP #$80                 
82955B   BCC $82952D              
82955D   CLC                      
82955E   RTS                      
----------------         
82955F   SEP #$20                 
829561   LDA #$02                 
829563   STA $1040,X              
829566   LDA #$04                 
829568   STA $1042,X              
82956B   TDC                      
82956C   STA $1045,X              
82956F   SEC                      
829570   RTS                      
----------------         
;Routine checking for what item we're currently using
829571   LDA $03 ;(Item ID+08)
829573   CMP #$0A ;0A would be hookshot?
829575   BCS $82958B ;return if >= 0A ??
829577   LDA $40
829579   BEQ $82958B ;if item count == 0 then return
82957B   LDA $65 ;???
82957D   BIT #$03                 
82957F   BEQ $82958B 
829581   LDA $41 
829583   INC                      
829584   INC                      
829585   AND #$02               
829587   STA $41  ;change item slot used?  
829589   STZ $3F ;013F ?
82958B   RTS                      
----------------         
--------sub start--------
82958C   LDA $00B6                
82958F   CMP #$02                 
829591   BCC $8295D5              
829593   BNE $82959C              
829595   LDA $00B7                
829598   CMP #$0D                 
82959A   BEQ $8295D5              
82959C   LDA $11                  
82959E   SEC                      
82959F   SBC #$78                 
8295A1   CMP #$10                 
8295A3   BCS $8295AB              
8295A5   LDA $14                  
8295A7   CMP #$24                 
8295A9   BCC $8295B3              
8295AB   LDA $1B                  
8295AD   ORA #$30                 
8295AF   STA $1B                  
8295B1   BRA $8295BB              
8295B3   LDA $1B                  
8295B5   AND #$CF                 
8295B7   ORA #$20                 
8295B9   STA $1B                  
8295BB   LDA $53                  
8295BD   BEQ $8295D5              
8295BF   LDA $1B                  
8295C1   AND #$30                 
8295C3   STA $68                  
8295C5   REP #$10                 
8295C7   LDX $52                  
8295C9   LDA $001B,X              
8295CC   AND #$CF                 
8295CE   ORA $68                  
8295D0   STA $001B,X              
8295D3   SEP #$10                 
8295D5   RTS                      
----------------         
--------sub start--------
8295D6   STZ $44                  
8295D8   LDA $1000                
8295DB   BEQ $8295E2              
8295DD   LDX #$00                 
8295DF   JSR $95ED                
8295E2   LDA $1000                
8295E5   BEQ $8295EC              
8295E7   LDX #$20                 
8295E9   JSR $95ED                
8295EC   RTS                      
----------------         
--------sub start--------
8295ED   LDA $100D,X              
8295F0   AND #$01                 
8295F2   ASL                      
8295F3   ASL                      
8295F4   ORA $100B,X              
8295F7   ASL                      
8295F8   TAY                      
8295F9   LDA $1011,X              
8295FC   ADC $B85F,Y              
8295FF   SEC                      
829600   SBC $11                  
829602   CMP $B860,Y              
829605   BCS $82962A              
829607   LDA $1014,X              
82960A   CLC                      
82960B   ADC $B861,Y              
82960E   SEC                      
82960F   SBC $14                  
829611   CMP $B862,Y              
829614   BCS $82962A              
829616   INC $44                  
829618   LDA $100D,X              
82961B   AND #$01                 
82961D   BNE $829625              
82961F   LDA $1011,X              
829622   STA $11                  
829624   RTS                      
----------------         
--------unidentified--------
829625  .db $BD $14 $10 $85 $14  
----------------         
82962A   RTS                      
----------------         
--------sub start--------
82962B   LDA $53                  
82962D   BEQ $829669              
82962F   LDA $56                  
829631   LSR                      
829632   TAX                      
829633   LDA $23                  
829635   CLC                      
829636   ADC $B887,X              
829639   TAY                      
82963A   LDA #$00                 
82963C   LDX $B887,Y              
82963F   BPL $829642              
829641   DEC                      
829642   XBA                      
829643   TXA                      
829644   REP #$20                 
829646   LDX $0E                  
829648   BEQ $82964E              
82964A   EOR #$FFFF               
82964D   INC                      
82964E   CLC                      
82964F   ADC $11                  
829651   STA $68                  
829653   LDA $B888,Y              
829656   ORA #$FF00               
829659   REP #$11                 
82965B   ADC $14                  
82965D   LDX $52                  
82965F   STA $0014,X              
829662   LDA $68                  
829664   STA $0011,X              
829667   SEP #$30                 
829669   RTL                      
----------------         
--------sub start--------
82966A   REP #$20                 
82966C   LDA $11                  
82966E   SEC                      
82966F   SBC #$0006               
829672   BMI $82967C              
829674   CMP #$00F5               
829677   BCC $829685              
829679   SBC #$00F4               
82967C   EOR #$FFFF               
82967F   INC                      
829680   CLC                      
829681   ADC $11                  
829683   STA $11                  
829685   LDA $14                  
829687   SEC                      
829688   SBC #$0004               
82968B   BMI $829695              
82968D   CMP #$00D9               
829690   BCC $82969E              
829692   SBC #$00D8               
829695   EOR #$FFFF               
829698   INC                      
829699   CLC                      
82969A   ADC $14                  
82969C   STA $14                  
82969E   SEP #$20                 
8296A0   RTS                      
----------------         
;Check for collision with transition rectangles!
8296A1   LDX #$00                 
8296A3   CLC                      
8296A4   LDA $11 ;TODO find what $11 is
8296A6   ADC $B86F,X ;Always 00 ? wtf - No there's a branch after the LDX lower
8296A9   LSR
8296AA   LSR
8296AB   LSR ; >> 3
8296AC   STA $0002                
8296AF   STZ $0003                
8296B2   REP #$31                 
8296B4   LDA $14 ;TODO Find what is $14
8296B6   ADC $B870,X              
8296B9   AND #$00F8               
8296BC   ASL                      
8296BD   ASL                      
8296BE   ADC $0002                
8296C1   TAY ;No idea what this is doing... 
8296C2   SEP #$20                 
8296C4   LDA $1400,Y ;Get value from RAM based on no clue $11 and $14
8296C7   TAY                      
8296C8   AND #$F0                 
8296CA   CMP #$60                 
8296CC   SEP #$10                 
8296CE   BNE $8296DE              
8296D0   INX                      
8296D1   INX                      
8296D2   CPX #$08                 
8296D4   BCC $8296A3 ;Repeat this code 8 time or until it has value expected above
8296D6   STY $00B8 ;<- set the transition index to use to transition
8296D9   LDA #$01
8296DB   STA $00AC                
8296DE   RTS                      
----------------         
--------sub start--------
8296DF   TCD                      
8296E0   LDA $44                  
8296E2   ORA $00AC                
8296E5   BNE $82971B              
8296E7   LDA $02                  
8296E9   CMP #$02                 
8296EB   BNE $82971B              
8296ED   LDY #$06                 
8296EF   LDA $11                  
8296F1   CLC                      
8296F2   ADC $B877,Y              
8296F5   STA $000A                
8296F8   LDA $14                  
8296FA   CLC                      
8296FB   ADC $B878,Y              
8296FE   STA $000C                
829701   JSL $808A86              
829705   CMP #$30                 
829707   BNE $82971B              
829709   DEY                      
82970A   DEY                      
82970B   BPL $8296EF              
82970D   LDA #$02                 
82970F   STA $00                  
829711   LDA #$04                 
829713   STA $02                  
829715   LDA #$06                 
829717   STA $03                  
829719   STZ $04                  
82971B   RTS                      
----------------         
--------sub start--------
82971C   LDA #$01                 
82971E   XBA                      
82971F   LDA #$00                 
829721   JSR $96DF                
829724   JSR $9733                
829727   LDA #$01                 
829729   XBA                      
82972A   LDA #$80                 
82972C   JSR $96DF                
82972F   JSR $9733                
829732   RTL                      
----------------         
--------sub start--------
829733   LDA $00                  
829735   BEQ $82973B              
829737   LDA $3F                  
829739   BEQ $82973C              
82973B   RTS                      
----------------         
82973C   INC $3F                  
82973E   JSL $808589              
829742   LDA $0A                  
829744   ASL                      
829745   ORA $40                  
829747   TAY                      
829748   LDX $0041                
82974B   LDA #$80                 
82974D   STA $1900,X              
829750   STA $1916,X              
829753   STA $192C,X              
829756   STA $1938,X              
829759   REP #$21                 
82975B   LDA $B87F,Y              
82975E   STA $1901,X              
829761   ADC #$0020               
829764   STA $1917,X              
829767   LDA #$4C05               
82976A   LDY $0A                  
82976C   BEQ $829771              
82976E   LDA #$4C18               
829771   STA $192D,X              
829774   CLC                      
829775   ADC #$0060               
829778   STA $1939,X              
82977B   SEP #$20                 
82977D   LDA #$12                 
82977F   STA $1903,X              
829782   STA $1919,X              
829785   LDA #$08                 
829787   STA $192F,X              
82978A   STA $193B,X              
82978D   LDA #$60                 
82978F   STA $1904,X              
829792   CLC                      
829793   ADC $57                  
829795   STA $1906,X              
829798   ADC #$10                 
82979A   STA $191C,X              
82979D   LDA #$70                 
82979F   STA $191A,X              
8297A2   LDA #$20                 
8297A4   STA $1905,X              
8297A7   STA $1907,X              
8297AA   STA $191B,X              
8297AD   STA $191D,X              
8297B0   REP #$20                 
8297B2   LDA #$2400               
8297B5   STA $190C,X              
8297B8   STA $190E,X              
8297BB   STA $1910,X              
8297BE   STA $1912,X              
8297C1   STA $1914,X              
8297C4   STA $1922,X              
8297C7   STA $1924,X              
8297CA   STA $1926,X              
8297CD   STA $1928,X              
8297D0   STA $192A,X              
8297D3   SEP #$20                 
8297D5   LDA #$6E                 
8297D7   STA $1908,X              
8297DA   LDA #$6F                 
8297DC   STA $190A,X              
8297DF   LDA #$7E                 
8297E1   STA $191E,X              
8297E4   LDA #$7F                 
8297E6   STA $1920,X              
8297E9   LDA #$28                 
8297EB   STA $1909,X              
8297EE   STA $190B,X              
8297F1   STA $191F,X              
8297F4   STA $1921,X              
8297F7   LDA $40                  
8297F9   ASL                      
8297FA   BEQ $829834              
8297FC   LDA #$6E                 
8297FE   STA $190C,X              
829801   LDA #$6F                 
829803   STA $190E,X              
829806   LDA #$7E                 
829808   STA $1922,X              
82980B   LDA #$7F                 
82980D   STA $1924,X              
829810   LDY $41                  
829812   LDA $B858,Y              
829815   STA $6E                  
829817   STA $1909,X              
82981A   STA $190B,X              
82981D   STA $191F,X              
829820   STA $1921,X              
829823   LDA $B859,Y              
829826   STA $6F                  
829828   STA $190D,X              
82982B   STA $190F,X              
82982E   STA $1923,X              
829831   STA $1925,X              
829834   LDA $40                  
829836   BEQ $82983C              
829838   INX                      
829839   INX                      
82983A   INX                      
82983B   INX                      
82983C   LDY $1D                  
82983E   BEQ $829863              
829840   LDA #$7C                 
829842   STA $190C,X              
829845   DEY                      
829846   BEQ $829863              
829848   STA $190E,X              
82984B   DEY                      
82984C   BEQ $829863              
82984E   STA $1910,X              
829851   DEY                      
829852   BEQ $829863              
829854   STA $1922,X              
829857   DEY                      
829858   BEQ $829863              
82985A   STA $1924,X              
82985D   DEY                      
82985E   BEQ $829863              
829860   STA $1926,X              
829863   LDA $0041                
829866   TAX                      
829867   CLC                      
829868   ADC #$44                 
82986A   STA $0041                
82986D   LDA #$A9                 
82986F   STA $1930,X              
829872   STA $1934,X              
829875   INC                      
829876   STA $1932,X              
829879   STA $1936,X              
82987C   LDA #$B9                 
82987E   STA $193C,X              
829881   STA $1940,X              
829884   INC                      
829885   STA $193E,X              
829888   STA $1942,X              
82988B   LDA $40                  
82988D   BNE $82989D              
82988F   LDA $0A                  
829891   LSR                      
829892   TAY                      
829893   LDA $B85C,Y              
829896   STA $6E                  
829898   LDA $B85D,Y              
82989B   STA $6F                  
82989D   LDA $6E                  
82989F   STA $1931,X              
8298A2   STA $1933,X              
8298A5   STA $193D,X              
8298A8   STA $193F,X              
8298AB   BNE $8298B9              
8298AD   STA $1930,X              
8298B0   STA $1932,X              
8298B3   STA $193C,X              
8298B6   STA $193E,X              
8298B9   LDA $6F                  
8298BB   STA $1935,X              
8298BE   STA $1937,X              
8298C1   STA $1941,X              
8298C4   STA $1943,X              
8298C7   BNE $8298D5              
8298C9   STA $1934,X              
8298CC   STA $1936,X              
8298CF   STA $1940,X              
8298D2   STA $1942,X              
8298D5   RTS                      
----------------         
--------sub start--------
8298D6   LDX #$00                 
8298D8   TXY                      
8298D9   LDA $00B1                
8298DC   BEQ $8298E9              
8298DE   LDX $0A                  
8298E0   LDA $1A50,X ;Load OAM Data
8298E3   ASL                      
8298E4   TAY                      
8298E5   LDA $1A51,X ;Load OAM Data
8298E8   TAX                      
8298E9   LDA $B90B,Y              
8298EC   STA $75                  
8298EE   LDA $B90C,Y              
8298F1   STA $77                  
8298F3   STX $78                  
8298F5   RTS                      
----------------         
--------sub start--------
8298F6   LDA $23                  
8298F8   CMP $24
8298FA   BEQ $829919              
8298FC   LDA $56                  
8298FE   LSR                      
8298FF   TAX                      
829900   LDA $23                  
829902   LSR                      
829903   LSR                      
829904   PHP                      
829905   CLC                      
829906   ADC $B7FA,X              
829909   TAX                      
82990A   PLP                      
82990B   LDA $B7FA,X              
82990E   BCC $829914              
829910   LSR                      
829911   LSR                      
829912   LSR                      
829913   LSR                      
829914   AND #$0F                 
829916   ASL                      
829917   STA $1E                  
829919   RTS                      
----------------         
--------sub start--------
82991A   LDX $2C                  
82991C   BNE $82991F              
82991E   RTS                      
----------------         
--------unidentified-------- ;<- THAT SECTION IS CODE!!!
82991F  .db $7C $20 $99 $28 $99 $2D $99 $3C
829927  .db $99 $A9 $04 $85 $2C $60 $A5 $64
82992F  .db $F0 $0A $A9 $06 $85 $2C $A9 $08
829937  .db $85 $2D $64 $2E $60 $A5 $64 $D0
82993F  .db $09 $C6 $2D $D0 $04 $A9 $04 $85
829947  .db $2C $60 $A9 $08 $85 $2D $E6 $2E
82994F  .db $A5 $2E $C9 $07 $90 $02 $64 $2C
829957  .db $60                  
----------------         
--------sub start--------
829958   LDA $00C9                
82995B   BNE $82995E              
82995D   RTS                      
----------------         
--------unidentified-------- ;<- THAT SECTION IS CODE!!!
82995E  .db $F4 $7F $83 $AB $A2 $00 $C2 $20
829966  .db $9E $00 $F5 $E8 $E8 $E0 $64 $90
82996E  .db $F7 $E2 $20 $AB $A5 $2F $D0 $03
829976  .db $4C $1D $9A $9C $00 $00 $9C $01
82997E  .db $00 $8D $02 $00 $9C $03 $00 $A9
829986  .db $32 $38 $E5 $2F $8D $10 $00 $A9
82998E  .db $32 $8D $13 $00 $8D $16 $00 $18
829996  .db $65 $2F $8D $19 $00 $A5 $2F $C2
82999E  .db $20 $29 $FF $00 $0A $69 $FD $FF
8299A6  .db $49 $FF $FF $1A $8D $04 $00 $E2
8299AE  .db $20 $AD $02 $00 $CD $00 $00 $90
8299B6  .db $66 $AD $00 $00 $AE $10 $00 $9F
8299BE  .db $00 $F5 $7F $AE $19 $00 $9F $00
8299C6  .db $F5 $7F $AD $02 $00 $AE $13 $00
8299CE  .db $9F $00 $F5 $7F $AE $16 $00 $9F
8299D6  .db $00 $F5 $7F $C2 $20 $AD $04 $00
8299DE  .db $10 $0E $AD $00 $00 $0A $0A $18
8299E6  .db $6D $04 $00 $69 $06 $00 $80 $1C
8299EE  .db $AD $00 $00 $38 $ED $02 $00 $0A
8299F6  .db $0A $18 $6D $04 $00 $69 $0A $00
8299FE  .db $8D $04 $00 $CE $02 $00 $EE $10
829A06  .db $00 $CE $19 $00 $8D $04 $00 $E2
829A0E  .db $20 $EE $00 $00 $CE $13 $00 $EE
829A16  .db $16 $00 $80 $95 $E2 $20 $60 $A5
829A1E  .db $17 $85 $68 $64 $69 $C2 $21 $64
829A26  .db $6A $A9 $64 $00 $85 $6C $A5 $14
829A2E  .db $69 $BE $FF $38 $E5 $68 $10 $15
829A36  .db $64 $68 $18 $65 $6C $30 $DD $F0
829A3E  .db $DB $85 $6C $A9 $64 $00 $38 $E5
829A46  .db $6C $85 $6A $80 $18 $85 $68 $18
829A4E  .db $65 $6C $38 $E9 $E0 $00 $90 $0D
829A56  .db $49 $FF $FF $1A $18 $65 $6C $85
829A5E  .db $6C $30 $B9 $F0 $B7 $C2 $10 $A5
829A66  .db $0A $29 $FF $00 $85 $6E $A5 $68
829A6E  .db $0A $0A $65 $68 $65 $6E $AA $E2
829A76  .db $20 $F4 $7F $83 $AB $A4 $6A $64
829A7E  .db $6F $A9 $01 $64 $69 $85 $68 $B9
829A86  .db $00 $F5 $F0 $35 $85 $6E $C2 $21
829A8E  .db $A5 $6E $65 $11 $30 $2B $C9 $00
829A96  .db $01 $90 $03 $A9 $FF $00 $85 $69
829A9E  .db $A5 $11 $38 $E5 $6E $30 $09 $C9
829AA6  .db $00 $01 $90 $07 $E2 $20 $80 $0B
829AAE  .db $A9 $00 $00 $E2 $20 $85 $68 $C5
829AB6  .db $69 $D0 $06 $A9 $01 $85 $68 $64
829ABE  .db $69 $C2 $20 $A5 $68 $9D $01 $F0
829AC6  .db $E2 $20 $C8 $E8 $E8 $E8 $E8 $E8
829ACE  .db $C6 $6C $D0 $AD $AB $E2 $30 $A0
829AD6  .db $00 $A6 $2F $F0 $16 $A9 $04 $C5
829ADE  .db $42 $F0 $0B $C5 $43 $F0 $07 $E0
829AE6  .db $14 $F0 $08 $88 $80 $05 $E0 $28
829AEE  .db $F0 $01 $C8 $98 $18 $65 $2F $85
829AF6  .db $2F $60              
----------------         
--------sub start--------
829AF8   LDA $65                  
829AFA   BIT #$CC                 
829AFC   BEQ $829B39              
829AFE   LDX $47                  
829B00   LDA $11                  
829B02   CLC                      
829B03   ADC $B977,X              
829B06   LSR                      
829B07   LSR                      
829B08   LSR                      
829B09   STA $68                  
829B0B   STZ $69                  
829B0D   LDA $14                  
829B0F   CLC                      
829B10   ADC $B978,X              
829B13   REP #$30                 
829B15   AND #$00F8               
829B18   ASL                      
829B19   ASL                      
829B1A   ADC $68                  
829B1C   TAX                      
829B1D   SEP #$20                 
829B1F   LDA $1400,X              
829B22   STA $6A                  
829B24   AND #$F0                 
829B26   SEP #$10                 
829B28   CMP #$90                 
829B2A   BNE $829B39              
829B2C   LDA $6A                  
829B2E   STA $32                  
829B30   INC $00AC                
829B33   LDA #$08                 
829B35   STA $02                  
829B37   PLA                      
829B38   PLA                      
829B39   RTS                      
----------------         
;Check if we need to unlock a door
CollisionWithLockedDoor:
{
829B3A   STA $6E ;$016E <- #$80 (offseted YLowpos?)
829B3C   LDA $47 ;p1 direction facing without moving same as above
829B3E   ASL 
829B3F   TAX 
829B40   REP #$31 
829B42   LDA $11 ;$0111 (P1 XPos)
829B44   ADC $B967,X ;Add Direction Offset
829B47   CMP #$0100 ;Check if X difference is smaller than 0x100
829B4A   BCS $829B71 ;If it's bigger then CLC and RTS
829B4C   LSR                      
829B4D   LSR                      
829B4E   LSR                      
829B4F   STA $68 ;???
829B51   LDA $14 ;$0114 (P1 YPos)
829B53   CLC                      
829B54   ADC $B969,X ;Add Direction Offset              
829B57   CMP #$00E0  ;Check if X difference is smaller than 0xE0              
829B5A   BCS $829B71 ;If it's bigger then CLC and RTS             
829B5C   AND #$00F8               
829B5F   ASL                      
829B60   ASL                      
829B61   ADC $68 ; ??? Tilemap data??
829B63   TAY                      
829B64   LDA $1400,Y ;Load Tile Type at that position?
829B67   SEP #$30
829B69   STA $6A ;Store it in $016A ?
829B6B   AND #$F0
829B6D   CMP #$D0 ;Check if Tile is D0 (door lock)                 
829B6F   BEQ KeyUsedOnLockedDoor ;$829B75
829B71   SEP #$30                 
829B73   CLC                      
829B74   RTS   
}    

KeyUsedOnLockedDoor:
{        
829B75   PEA #$8382               
829B78   PLB ;Set Databank to $82
829B79   LDX $00B6 ;Load LEVEL Index
829B7C   LDA $C461,X 
829B7F   CLC 
829B80   ADC $00B7 ;Load Map Index
829B83   TAX 
829B84   LDA $6A ;Restore Tiletype we encountered (0xD0?) ;Note this routine might be used for something else!!
829B86   AND #$0F
829B88   ASL                      
829B89   ASL                      
829B8A   LDY $C461,X ;Locked Door Array (one value per map 00 = no key door, non-zero = door id)
829B8D   ADC $C4D7,Y ;Add value for that door??? [00 10 15 1A 1F 24 29 2E 33 38 3D 42 47 4C 51 56 5B] <- all doors values
829B90   REP #$31 ;reset Carry
829B92   AND #$00FF
829B95   ADC #$C4D9 ;Add that means C4D9
829B98   TAY          ;?? ?? ?? ID  ?? ?? ?? ID  ?? ?? ?? ID           
829B99   LDA $0000,Y ;[0E 00 00 00][4E 03 04 00][0E 00 00 82]
829B9C   STA $0013 ;Store in $13 the 1st 2bytes ;$000E/$034E ??
829B9F   SEP #$20                 
829BA1   LDA $0002,Y ;3rd byte in $0A ;No idea either $00/$04
829BA4   STA $000A                
829BA7   LDA $0003,Y ;4th byte in ;$0168? Door ID ($0168 = bitmask) not sure about bit 7
829BAA   STA $68                  
829BAC   AND #$7F                 
829BAE   LSR                      
829BAF   LSR                      
829BB0   LSR                      
829BB1   TAX ;Used to get upper bits?
829BB2   LDA $68 ;Reload unmodified byte4
829BB4   AND #$07 ;And lower bits
829BB6   SEP #$10 
829BB8   PLB ;Set DataBank back to $83
829BB9   TAY
829BBA   LDA $68 ;? 4th byte modified
829BBC   AND #$80                 
829BBE   CMP $6E ;?? ;$016E ?? if bit7 is set we compare with that 
829BC0   BNE $829B73 ; CLC : Return             
829BC2   LDA $80B8,Y ;Bitmask table ;Only the 4 lowest values are possible (00, 02, 04, 08)
829BC5   ORA $1144,X ;Keep currently unlocked doors
829BC8   STA $1144,X ;Save new unlocked door with the previously unlocked doors             
829BCB   JSL $82C3B4 ;Unknown Yet
829BCF   JSR $9C82 ;Place Plank Routine?? :thinking:
829BD2   LDA #$0C
829BD4   JSL PlaySFX ;$809A53
829BD8   SEC                      
829BD9   RTS
}
----------------         
--------sub start--------
829BDA   LDA $57                  
829BDC   CMP #$09                 
829BDE   BCS $829C11              
829BE0   TAX                      
829BE1   LDY $B948,X              
829BE4   JSL GetRandomInt;$808859              
829BE8   AND #$1E                 
829BEA   TAX                      
829BEB   REP #$20                 
829BED   LDA $B951,Y              
829BF0   BIT $80C0,X              
829BF3   SEP #$20                 
829BF5   BEQ $829C11              
829BF7   REP #$10                 
829BF9   LDX #$0E00               
829BFC   LDA $0000,X              
829BFF   BEQ $829C12              
829C01   REP #$21                 
829C03   TXA                      
829C04   ADC #$0020               
829C07   TAX                      
829C08   CMP #$1000               
829C0B   SEP #$20                 
829C0D   BCC $829BFC              
829C0F   SEP #$10                 
829C11   RTS                      
----------------         
829C12   LDA #$02                 
829C14   STA $0000,X              
829C17   STA $000A,X              
829C1A   LDA $0C                  
829C1C   STA $000C,X              
829C1F   JSL GetRandomInt;$808859              
829C23   AND #$0F                 
829C25   XBA                      
829C26   LDA #$00                 
829C28   XBA                      
829C29   TAY                      
829C2A   LDA $B957,Y              
829C2D   STA $000B,X              
829C30   LDA $6E                  
829C32   STA $000D,X              
829C35   LDA $5E                  
829C37   ASL                      
829C38   ASL                      
829C39   ASL                      
829C3A   CLC                      
829C3B   ADC #$08                 
829C3D   STA $0011,X              
829C40   REP #$20                 
829C42   LDA $5E                  
829C44   LSR                      
829C45   LSR                      
829C46   SEP #$20                 
829C48   AND #$F8                 
829C4A   CLC                      
829C4B   ADC #$0C                 
829C4D   STA $0014,X              
829C50   SEP #$10                 
829C52   RTS                      
----------------         
--------sub start--------
829C53   LDA $00                  
829C55   DEC                      
829C56   BNE $829C81              
829C58   JSL $808A66              
829C5C   CMP #$10                 
829C5E   BNE $829C81              
829C60   LDA $1D                  
829C62   BEQ $829C6A              
829C64   STZ $1D                  
829C66   STZ $3F                  
829C68   BRA $829C75              
--------unidentified--------
829C6A  .db $64 $1C $A5 $47 $4A $69 $02 $29
829C72  .db $03 $85 $0D $E6 $00 $A9 $04 $85
829C7A  .db $02 $64 $03 $64 $04 $64 $05
----------------         
829C81   RTS                      
----------------         
;Place Plank Routine!
829C82   LDA $40 ; P1 Item Count
829C84   BEQ $829CA2 ; if == 0 then just clear item 01 ($0142)
829C86   STZ $3F ; 013F? ; Player1 related
829C88   STZ $40 ; P1 Item Count        
829C8A   LDA $41 ; P1 Item 1
829C8C   STZ $41 ; P1 Item 1 == 0
829C8E   BEQ $829C93 ; if P1 Item 1 == 0, plank was on item 2 so c
829C90   STZ $43 ; P1 Item 2 == 0
829C92   RTS                      
;829C93  .db $A5 $43 $64 $43 $85 $42 $A5 $5C
;829C9B  .db $85 $5A $A5 $5D $85 $5B $60
829C93 LDA $43
STZ $43
STA $42
LDA $5C
STA $5A
LDA $5D
STA $5B
RTS
----------------         
829CA2   STZ $42 ;Clear item 01
829CA4   RTS                      
----------------         
;Using Plank Routine
829CA5   LDX $1A46 ;Are we placing a plank?
829CA8   BEQ $829CE7 ;No - Return
829CAA   LDY $47 ;P1 Direction (looking)
829CAC   LDA $11 ;P1 X Pos Low Byte
829CAE   CLC                      
829CAF   ADC $B913,Y ;Depending on the position we're looking at ADD offset to our value
829CB2   STA $6C ; 016C = offseted XLowpos
829CB4   LDA $14 ; P1 Y Pos Low Byte
829CB6   CLC                      
829CB7   ADC $B914,Y ;Depending on the position we're looking at ADD offset to our value
829CBA   STA $6E ; 016C = offseted YLowpos
829CBC   LDA $B92B,X ;Plank ID we're trying to place ?
829CBF   STA $68                  
829CC1   INX                      
829CC2   LDY $B930,X ; ?? ;01
829CC5   LDA $1178,Y ; ?? Unknown ram < P1 Related probably
829CC8   BNE $829CDE ;Return?
829CCA   LDA $6C ;Load X Position
829CCC   SEC
829CCD   SBC $B92B,X ;Remove Offset from X     
829CD0   CMP #$0C                 
829CD2   BCS $829CDE ; branch if remains is bigger than #$0C for the X Position
829CD4   LDA $6E ;Load Y Position
829CD6   SEC                      
829CD7   SBC $B92C,X ;Remove Offset from Y 
829CDA   CMP #$0C                 
829CDC   BCC $829CE9 ;branch if remains is smaller than #$0C for the Y Position
829CDE   TXA                      
829CDF   CLC                      
829CE0   ADC #$06                 
829CE2   TAX                      
829CE3   DEC $68                  
829CE5   BNE $829CC2              
829CE7   CLC                      
829CE8   RTS                      
;Plank Getting Placed Routine       
829CE9   JSR $9C82                
829CEC   LDY $B930,X              
829CEF   LDA #$FF                 
829CF1   STA $1178,Y              
--------sub start--------
829CF4   TXY                      
829CF5   REP #$30                 
829CF7   LDX $B92D,Y              
829CFA   LDA #$0000               
829CFD   STA $1400,X              
829D00   STA $1420,X              
829D03   SEP #$30                 
829D05   LDA $B92F,Y              
829D08   JSL $808667              
829D0C   SEC                      
829D0D   RTS                      
----------------         
;Plank Holes Check?
829D0E   LDY $B6 ;Load Level Index
829D10   LDX $B91B,Y ; Load offset to skip in X for that level ["05" 08 0B 0E 0F]
829D13   LDA $B91B,X ; Load with the offset we have "05" [01 07 00]
829D16   BEQ $829D27 ;if 0 return
829D18   STA $0E ;Store first value in $0E (length?)
829D1A   LDA $B7 ;Load Map Index
829D1C   CMP $B91C,X ;Check if map match this value [07 00]
829D1F   BEQ $829D2B
829D21   INX
829D22   INX
829D23   DEC $0E
829D25   BNE $829D1C ;if we are not done loop back until we done all of them
829D27   STZ $1A46 ;This seems the only value setted by this routine and bottom routine
829D2A   RTL                      
----------------
;IF Byte Above == 0 then go here
829D2B   LDY $B91D,X              
829D2E   LDX $B92B,Y              
829D31   STX $1A46 ;
829D34   LDA $B92B,X              
829D37   STA $0E                  
829D39   INX                      
829D3A   LDY $B930,X              
829D3D   LDA $1178,Y ; No clue what is that RAM ? player1 related probably
829D40   BEQ $829D49              
829D42   STX $22                  
829D44   JSR $9CF4 ; TODO 
829D47   LDX $22                  
829D49   TXA                      
829D4A   CLC                      
829D4B   ADC #$06                 
829D4D   TAX                      
829D4E   DEC $0E                  
829D50   BNE $829D3A              
829D52   RTL                      
----------------         
--------sub start--------
829D53   LDA $00AC                
829D56   BNE $829D72              
829D58   LDA $0D80                
829D5B   BEQ $829D65              
829D5D   LDA #$0D                 
829D5F   XBA                      
829D60   LDA #$80                 
829D62   JSR $9D73                
829D65   LDA $0DC0                
829D68   BEQ $829D72              
829D6A   LDA #$0D                 
829D6C   XBA                      
829D6D   LDA #$C0                 
829D6F   JSR $9D73                
829D72   RTL                      
----------------         
--------sub start--------
829D73   TCD                      
829D74   LDX $2E                  
829D76   REP #$21                 
829D78   LDA $3C                  
829D7A   ADC $C1FB,X              
829D7D   STA $20                  
829D7F   LDA $3E                  
829D81   CLC                      
829D82   ADC $C1FD,X              
829D85   STA $22                  
829D87   SEP #$20                 
829D89   LDX $02                  
829D8B   JMP ($9D8E,X)            
--------data--------     
829D8E  .db $96 $9D $FD $9D $B5 $9E $D1 $9E
----------------         
829D96   LDA #$02                 
829D98   STA $02                  
829D9A   LDA $0D                  
829D9C   STA $03                  
829D9E   LDA #$01                 
829DA0   STA $00                  
829DA2   STA $01                  
829DA4   STZ $35                  
829DA6   STZ $39                  
829DA8   STZ $38                  
829DAA   LDX $2E                  
829DAC   REP #$21                 
829DAE   STZ $18                  
829DB0   STZ $2C                  
829DB2   STZ $3A                  
829DB4   SEP #$20                 
829DB6   LDA #$22                 
829DB8   STA $1B                  
829DBA   STZ $0E                  
829DBC   LDX $0D                  
829DBE   CPX #$06                 
829DC0   BNE $829DC4              
829DC2   INC $0E                  
829DC4   REP #$20                 
829DC6   LDA $C21B,X              
829DC9   STA $28                  
829DCB   STA $2A                  
829DCD   SEP #$20                 
829DCF   LDY $C233,X              
829DD2   LDA $C234,X              
829DD5   JSL $8089A3              
829DD9   LDA #$20                 
829DDB   STA $0F                  
829DDD   JSR $9F15                
829DE0   JSR $A120                
829DE3   BCS $829DF6              
829DE5   JSR $9FDF                
829DE8   BCS $829DF3              
829DEA   JSL $80DA6E              
829DEE   BCS $829DF1              
829DF0   RTS                      
----------------         
--------unidentified--------
829DF1  .db $64 $38 $20 $27 $9F $A9 $06 $85
829DF9  .db $02 $4C $74 $9F      
----------------         
829DFD   LDX $03                  
829DFF   JSR ($9E7F,X)            
829E02   JSR $9F15                
829E05   INC $35                  
829E07   JSR $A026                
829E0A   BCS $829E4A              
829E0C   LDA $00B6                
829E0F   DEC                      
829E10   BNE $829E2B              
829E12   LDA $00B7                
829E15   CMP #$0D                 
829E17   BNE $829E2B              
829E19   JSL $80DA6E              
--------unidentified--------
829E1D  .db $B0 $36 $20 $20 $A1 $B0 $36 $20
829E25  .db $DF $9F $B0 $2E $80 $10
----------------         
829E2B   JSR $9FDF                
829E2E   BCS $829E57              
829E30   JSL $80DA6E              
829E34   BCS $829E55              
829E36   JSR $A120                
829E39   BCS $829E5A              
829E3B   DEC $0F                  
829E3D   BEQ $829E5A              
829E3F   LDX $0A                  
829E41   LDA $0161,X              
829E44   BIT $0177,X              
829E47   BEQ $829E5A              
829E49   RTS                      
----------------         
829E4A   LDA #$06                 
829E4C   STA $02                  
829E4E   LDA #$07                 
829E50   JSL PlaySFX ;$809A53
829E54   RTS                      
----------------         
829E55   STZ $38                  
829E57   JSR $9F27                
829E5A   LDA #$04                 
829E5C   STA $02                  
829E5E   JSR $9F74                
829E61   LDA $03                  
829E63   AND #$02                 
829E65   REP #$20                 
829E67   BNE $829E74              
829E69   LDA $2A                  
829E6B   EOR #$FFFF               
829E6E   INC                      
829E6F   STA $2A                  
829E71   SEP #$20                 
829E73   RTS                      
----------------         
829E74   LDA $28                  
829E76   EOR #$FFFF               
829E79   INC                      
829E7A   STA $28                  
829E7C   SEP #$20                 
829E7E   RTS                      
----------------         
--------data--------     
829E7F  .db $87 $9E $9F $9E $87 $9E $9F $9E
----------------         
--------sub start--------
829E87   REP #$21                 
829E89   LDA $2C                  
829E8B   ADC $2A                  
829E8D   STA $2C                  
829E8F   BPL $829E95              
829E91   EOR #$00FF               
829E94   INC                      
829E95   SEP #$21                 
829E97   ADC #$06                 
829E99   LSR                      
829E9A   LSR                      
829E9B   LSR                      
829E9C   STA $39                  
829E9E   RTS                      
----------------         
--------sub start--------
829E9F   REP #$21                 
829EA1   LDA $18                  
829EA3   ADC $28                  
829EA5   STA $18                  
829EA7   BPL $829EAD              
829EA9   EOR #$00FF               
829EAC   INC                      
829EAD   SEP #$21                 
829EAF   LSR                      
829EB0   LSR                      
829EB1   LSR                      
829EB2   STA $39                  
829EB4   RTS                      
----------------         
829EB5   LDX $03                  
829EB7   JSR ($9EC9,X)            
829EBA   JSR $9F15                
829EBD   JSR $9FBF                
829EC0   DEC $35                  
829EC2   BNE $829EC8              
829EC4   LDA #$06                 
829EC6   STA $02                  
829EC8   RTS                      
----------------         
--------data--------     
829EC9  .db $87 $9E $9F $9E $87 $9E $9F $9E
----------------         
829ED1   LDX $0A                  
829ED3   STZ $014A,X              
829ED6   REP #$10                 
829ED8   LDY $3A                  
829EDA   BEQ $829F06              
829EDC   LDA $0009,Y              
829EDF   CMP #$10                 
829EE1   BEQ $829F01              
829EE3   LDA $3A                  
829EE5   STA $0152,X              
829EE8   LDA $3B                  
829EEA   STA $0153,X              
829EED   LDA $0D                  
829EEF   STA $0155,X              
829EF2   LDA #$02                 
829EF4   STA $0103,X              
829EF7   STA $0104,X              
829EFA   LDA #$10                 
829EFC   STA $0154,X              
829EFF   BRA $829F06              
--------unidentified--------
829F01  .db $A9 $00 $99 $03 $00  
----------------         
829F06   SEP #$10                 
829F08   STZ $00                  
829F0A   STZ $01                  
829F0C   STZ $02                  
829F0E   STZ $03                  
829F10   STZ $04                  
829F12   STZ $05                  
829F14   RTS                      
----------------         
--------sub start--------
829F15   REP #$21                 
829F17   LDA $20                  
829F19   ADC $18                  
829F1B   STA $11                  
829F1D   LDA $22                  
829F1F   CLC                      
829F20   ADC $2C                  
829F22   STA $14                  
829F24   SEP #$20                 
829F26   RTS                      
----------------         
--------sub start--------
829F27   LDX #$1D                 
829F29   LDA $38                  
829F2B   BEQ $829F46              
829F2D   AND #$F0                 
829F2F   CMP #$B0                 
829F31   BEQ $829F73              
829F33   CMP #$C0                 
829F35   BEQ $829F73              
829F37   CMP #$90                 
829F39   BNE $829F42              
829F3B   LDY $00B6                
829F3E   CPY #$02                 
829F40   BNE $829F4D              
829F42   LDA #$17                 
829F44   BRA $829F4E              
829F46   LDA $1C                  
829F48   BEQ $829F52              
829F4A   DEC                      
829F4B   BNE $829F42              
829F4D   TXA                      
829F4E   JSL PlaySFX ;$809A53
829F52   LDX $0A                  
829F54   BEQ $829F58              
829F56   LDX #$20                 
829F58   LDA #$02                 
829F5A   STA $0AC0,X              
829F5D   STZ $0AC2,X              
829F60   LDA $0C                  
829F62   STA $0ACC,X              
829F65   REP #$20                 
829F67   LDA $11                  
829F69   STA $0AD1,X              
829F6C   LDA $14                  
829F6E   STA $0AD4,X              
829F71   SEP #$20                 
829F73   RTS                      
----------------         
--------sub start--------
829F74   LDA $38                  
829F76   AND #$F0                 
829F78   CMP #$B0                 
829F7A   BNE $829FDE              
829F7C   LDA $38                  
829F7E   AND #$0E                 
829F80   TAX                      
829F81   REP #$31                 
829F83   LDA $36                  
829F85   ADC $B79A,X              
829F88   STA $36                  
829F8A   TAX                      
829F8B   JSL $8088F0              
--------unidentified--------
829F8F  .db $A5 $36 $0A $AA $BF $00 $E0 $7F
829F97  .db $38 $E9 $80 $03 $4A $E2 $30 $85
829F9F  .db $38 $22 $8E $8F $80 $86 $3A $A9
829FA7  .db $02 $9D $00 $00 $9E $0A $00 $A5
829FAF  .db $38 $9D $0B $00 $A9 $04 $9D $04
829FB7  .db $00 $A5 $0C $9D $0C $00 $E2 $10
----------------         
--------sub start--------
829FBF   LDA $3B                  
829FC1   BEQ $829FDE              
829FC3   LDA $0D                  
829FC5   ASL                      
829FC6   TAY                      
829FC7   REP #$31                 
829FC9   LDX $3A                  
829FCB   LDA $11                  
829FCD   ADC $C223,Y              
829FD0   STA $0011,X              
829FD3   LDA $14                  
829FD5   CLC                      
829FD6   ADC $C225,Y              
829FD9   STA $0014,X              
829FDC   SEP #$30                 
829FDE   RTS                      
----------------         
--------sub start--------
829FDF   REP #$30                 
829FE1   LDA $11                  
829FE3   CMP #$0100               
829FE6   BCS $82A016              
829FE8   LSR                      
829FE9   LSR                      
829FEA   LSR                      
829FEB   STA $36                  
829FED   LDA $14                  
829FEF   CMP #$00E0               
829FF2   BCS $82A016              
829FF4   AND #$00F8               
829FF7   ASL                      
829FF8   ASL                      
829FF9   ADC $36                  
829FFB   TAX                      
829FFC   STX $36                  
829FFE   SEP #$20                 
82A000   LDA $1400,X              
82A003   STA $38                  
82A005   SEP #$10                 
82A007   BPL $82A01A              
82A009   CMP #$F0                 
82A00B   BEQ $82A024              
82A00D   CLC                      
82A00E   ADC $0C                  
82A010   CMP #$E0                 
82A012   BEQ $82A024              
82A014   SEC                      
82A015   RTS                      
----------------         
82A016   SEP #$30                 
82A018   CLC                      
82A019   RTS                      
----------------         
82A01A   AND #$F0                 
82A01C   CMP #$70                 
82A01E   BNE $82A024              
82A020   LDA $0C                  
82A022   BNE $82A014              
82A024   CLC                      
82A025   RTS                      
----------------         
--------sub start--------
82A026   LDX $1A48                
82A029   BEQ $82A053              
82A02B   LDY $1A47                
82A02E   LDA $8977,X              
82A031   DEC                      
82A032   BEQ $82A055              
82A034   LDA $1180,Y              
82A037   AND #$F0                 
82A039   BNE $82A055              
82A03B   INX                      
82A03C   INX                      
82A03D   INX                      
82A03E   INX                      
82A03F   JSR $A0A4                
--------unidentified--------
82A042  .db $B0 $11 $AC $47 $1A $0A $0A $0A
82A04A  .db $0A $19 $80 $11 $99 $80 $11 $80
82A052  .db $1A                  
----------------         
82A053   CLC                      
82A054   RTS                      
----------------         
82A055   LDA $1180,Y              
82A058   AND #$0F                 
82A05A   BNE $82A053              
82A05C   LDX $1A48                
82A05F   JSR $A0A4                
82A062   BCS $82A053              
82A064   LDY $1A47                
82A067   ORA $1180,Y              
82A06A   STA $1180,Y              
82A06D   JSL $80AC32              
82A071   LDX $0A                  
82A073   LDA $0140,X              
82A076   BEQ $82A09F              
82A078   STZ $013F,X              
82A07B   STZ $0140,X              
82A07E   LDA $0141,X              
82A081   STZ $0141,X              
82A084   BEQ $82A08B              
82A086   STZ $0143,X              
82A089   SEC                      
82A08A   RTS                      
----------------         
--------unidentified--------
82A08B  .db $BD $43 $01 $9D $42 $01 $BD $5C
82A093  .db $01 $9D $5A $01 $BD $5D $01 $9D
82A09B  .db $5B $01 $38 $60      
----------------         
82A09F   STZ $0142,X              
82A0A2   SEC                      
82A0A3   RTS                      
----------------         
--------sub start--------
82A0A4   LDA $3C                  
82A0A6   SEC                      
82A0A7   SBC $8978,X              
82A0AA   CMP #$0C                 
82A0AC   BCS $82A0CC              
82A0AE   LDA $3E                  
82A0B0   SEC                      
82A0B1   SBC $8979,X              
82A0B4   CMP #$0C                 
82A0B6   BCS $82A0CC              
82A0B8   LDA $11                  
82A0BA   SEC                      
82A0BB   SBC $897A,X              
82A0BE   CMP #$0C                 
82A0C0   BCS $82A0CC              
82A0C2   LDA $14                  
82A0C4   SEC                      
82A0C5   SBC $897B,X              
82A0C8   CMP #$0C                 
82A0CA   BCC $82A0F5              
82A0CC   LDA $11                  
82A0CE   SEC                      
82A0CF   SBC $8978,X              
82A0D2   CMP #$0C                 
82A0D4   BCS $82A0F4              
82A0D6   LDA $14                  
82A0D8   SEC                      
82A0D9   SBC $8979,X              
82A0DC   CMP #$0C                 
82A0DE   BCS $82A0F4              
82A0E0   LDA $3C                  
82A0E2   SEC                      
82A0E3   SBC $897A,X              
82A0E6   CMP #$0C                 
82A0E8   BCS $82A0F4              
82A0EA   LDA $3E                  
82A0EC   SEC                      
82A0ED   SBC $897B,X              
82A0F0   CMP #$0C                 
82A0F2   BCC $82A0F5              
82A0F4   RTS                      
----------------         
82A0F5   LDA $0D                  
82A0F7   LSR                      
82A0F8   STA $34                  
82A0FA   AND #$01                 
82A0FC   BEQ $82A107              
82A0FE   LDA $897A,X              
82A101   SEC                      
82A102   SBC $8978,X              
82A105   BRA $82A10E              
82A107   LDA $897B,X              
82A10A   SEC                      
82A10B   SBC $8979,X              
82A10E   LDY #$04                 
82A110   CMP #$60                 
82A112   BEQ $82A116              
82A114   LDY #$0C                 
82A116   TYA                      
82A117   ORA $34                  
82A119   STA $34                  
82A11B   STA $0000                
82A11E   CLC                      
82A11F   RTS                      
----------------         
--------sub start--------
82A120   LDA #$08                 
82A122   STA $2F                  
82A124   REP #$10                 
82A126   LDX #$0E00               
82A129   LDA $009F                
82A12C   AND #$01                 
82A12E   BEQ $82A133              
82A130   LDX #$0E20               
82A133   LDA $0000,X              
82A136   DEC                      
82A137   BNE $82A15F              
82A139   REP #$21                 
82A13B   LDA $0011,X              
82A13E   ADC #$0007               
82A141   SEC                      
82A142   SBC $11                  
82A144   CMP #$000E               
82A147   BCS $82A15F              
82A149   LDA $0014,X              
82A14C   ADC #$0007               
82A14F   SEC                      
82A150   SBC $14                  
82A152   CMP #$000E               
82A155   BCS $82A15F              
82A157   SEP #$20                 
82A159   LDA $17                  
82A15B   CMP #$06                 
82A15D   BCC $82A170              
82A15F   REP #$21                 
82A161   TXA                      
82A162   ADC #$0040               
82A165   TAX                      
82A166   SEP #$20                 
82A168   DEC $2F                  
82A16A   BNE $82A133              
82A16C   SEP #$10                 
82A16E   CLC                      
82A16F   RTS                      
----------------         
--------unidentified--------
82A170  .db $A9 $02 $9D $00 $00 $A9 $04 $9D
82A178  .db $02 $00 $A9 $02 $9D $03 $00 $A5
82A180  .db $0A $9D $05 $00 $9E $17 $00 $86
82A188  .db $3A $E2 $11 $60      
----------------         
--------sub start--------
82A18C   LDA $47                  
82A18E   ASL                      
82A18F   ASL                      
82A190   TAX                      
82A191   REP #$21                 
82A193   LDA $11                  
82A195   ADC $C255,X              
82A198   STA $68                  
82A19A   LDA $14                  
82A19C   CLC                      
82A19D   ADC $C257,X              
82A1A0   STA $6A                  
82A1A2   LDA $C259,X              
82A1A5   STA $6C                  
82A1A7   LDA $C25B,X              
82A1AA   STA $6E                  
82A1AC   SEP #$20                 
82A1AE   REP #$10                 
82A1B0   LDX #$0B00               
82A1B3   LDA $002D,X              
82A1B6   BEQ $82A1CE              
82A1B8   REP #$20                 
82A1BA   LDA $0011,X              
82A1BD   SEC                      
82A1BE   SBC $68                  
82A1C0   CMP $6C                  
82A1C2   BCS $82A1CE              
82A1C4   LDA $0014,X              
82A1C7   SEC                      
82A1C8   SBC $6A                  
82A1CA   CMP $6E                  
82A1CC   BCC $82A1E0              
82A1CE   REP #$21                 
82A1D0   TXA                      
82A1D1   ADC #$0040               
82A1D4   TAX                      
82A1D5   CMP #$0D80               
82A1D8   SEP #$20                 
82A1DA   BCC $82A1B3              
82A1DC   SEP #$10                 
82A1DE   CLC                      
82A1DF   RTS                      
----------------         
--------unidentified--------
82A1E0  .db $E2 $20 $38 $60      
----------------         
--------sub start--------
82A1E4   LDA #$04                 
82A1E6   STA $68                  
82A1E8   LDA $009F                
82A1EB   AND #$03                 
82A1ED   ASL                      
82A1EE   TAY                      
82A1EF   REP #$11                 
82A1F1   LDX $C24D,Y              
82A1F4   LDA $0000,X              
82A1F7   DEC                      
82A1F8   BNE $82A228              
82A1FA   LDA $0011,X              
82A1FD   ADC #$08                 
82A1FF   SEC                      
82A200   SBC $11                  
82A202   CMP #$10                 
82A204   BCS $82A228              
82A206   LDA $0014,X              
82A209   ADC #$06                 
82A20B   SEC                      
82A20C   SBC $14                  
82A20E   CMP #$0C                 
82A210   BCS $82A228              
82A212   LDA #$02                 
82A214   STA $0000,X              
82A217   LDA #$04                 
82A219   STA $0002,X              
82A21C   STZ $0003,X              
82A21F   LDA $0A                  
82A221   BEQ $82A228              
82A223   LDA #$80                 
82A225   STA $0005,X              
82A228   REP #$21                 
82A22A   TXA                      
82A22B   ADC #$0080               
82A22E   TAX                      
82A22F   SEP #$20                 
82A231   DEC $68                  
82A233   BNE $82A1F4              
82A235   SEP #$10                 
82A237   RTS                      
----------------         
--------sub start--------
82A238   LDA $0A00                
82A23B   BEQ $82A245              
82A23D   LDA #$0A                 
82A23F   XBA                      
82A240   LDA #$00                 
82A242   JSR $A287                
82A245   LDA $0A20                
82A248   BEQ $82A252              
82A24A   LDA #$0A                 
82A24C   XBA                      
82A24D   LDA #$20                 
82A24F   JSR $A287                
82A252   LDA $0A40                
82A255   BEQ $82A25F              
82A257   LDA #$0A                 
82A259   XBA                      
82A25A   LDA #$40                 
82A25C   JSR $A287                
82A25F   LDA $0A60                
82A262   BEQ $82A26C              
82A264   LDA #$0A                 
82A266   XBA                      
82A267   LDA #$60                 
82A269   JSR $A287                
82A26C   LDA $0A80                
82A26F   BEQ $82A279              
82A271   LDA #$0A                 
82A273   XBA                      
82A274   LDA #$80                 
82A276   JSR $A287                
82A279   LDA $0AA0                
82A27C   BEQ $82A286              
82A27E   LDA #$0A                 
82A280   XBA                      
82A281   LDA #$A0                 
82A283   JSR $A287                
82A286   RTL                      
----------------         
--------sub start--------
82A287   TCD                      
82A288   LDX $0A                  
82A28A   JMP ($A28D,X)            
--------data--------     
82A28D  .db $AB $A2              
----------------         
--------unidentified--------
82A28F  .db $0A $A3              
----------------         
--------data--------     
82A291  .db $B5 $A3 $59 $A5 $AB $A5 $D4 $A6
----------------         
--------unidentified--------
82A299  .db $10 $A7 $47 $A7 $E9 $A7 $0C $A8
82A2A1  .db $88 $A8              
----------------         
--------data--------     
82A2A3  .db $96 $A9              
----------------         
--------unidentified--------
82A2A5  .db $DA $AA $7A $AB      
----------------         
--------data--------     
82A2A9  .db $FF $AB              
----------------         
82A2AB   LDX $02                  
82A2AD   JMP ($A2B0,X)            
--------data--------     
82A2B0  .db $B6 $A2 $DA $A2 $05 $A3
----------------         
82A2B6   LDA #$02                 
82A2B8   STA $02                  
82A2BA   LDA $0B                  
82A2BC   ASL                      
82A2BD   TAX                      
82A2BE   LDA $C275,X              
82A2C1   STA $1E                  
82A2C3   LDA $C276,X              
82A2C6   STA $1F                  
82A2C8   LDA $C277,X              
82A2CB   STA $1D                  
82A2CD   LDA $C278,X              
82A2D0   CMP $1A4A                
82A2D3   BEQ $82A2ED              
82A2D5   LDA $14                  
82A2D7   STA $12                  
82A2D9   RTS                      
----------------         
82A2DA   REP #$10                 
82A2DC   LDX $11                  
82A2DE   LDA $1400,X              
82A2E1   SEP #$10                 
82A2E3   CMP #$A0                 
82A2E5   BNE $82A304              
82A2E7   LDA #$0C                 
82A2E9   JSL PlaySFX ;$809A53
82A2ED   LDA #$04                 
82A2EF   STA $02                  
82A2F1   LDA $1E                  
82A2F3   STA $0013                
82A2F6   LDA $1F                  
82A2F8   STA $0014                
82A2FB   LDA $1D                  
82A2FD   STA $000A                
82A300   JSL $82C3B4              
82A304   RTS                      
----------------         
82A305   JSL $808F3B              
82A309   RTS                      
----------------         
--------unidentified--------
82A30A  .db $A6 $02 $7C $0F $A3 $15 $A3 $3E
82A312  .db $A3 $88 $A3 $A9 $02 $85 $02 $A5
82A31A  .db $0B $4A $65 $0B $85 $1C $64 $1D
82A322  .db $A6 $0B $BD $81 $C2 $85 $1F $BD
82A32A  .db $82 $C2 $A8 $4A $4A $4A $AA $98
82A332  .db $29 $07 $A8 $BD $44 $11 $39 $B8
82A33A  .db $80 $D0 $2C $60 $AD $FB $00 $C5
82A342  .db $1F $D0 $42 $A6 $0B $BD $82 $C2
82A34A  .db $A8 $4A $4A $4A $AA $98 $29 $07
82A352  .db $A8 $BD $44 $11 $19 $B8 $80 $9D
82A35A  .db $44 $11 $A6 $1C $BD $8F $C2 $30
82A362  .db $2A $A9 $21 $22 $53 $9A $80 $A6
82A36A  .db $1C $BD $8D $C2 $8D $13 $00 $BD
82A372  .db $8E $C2 $8D $14 $00 $BD $8F $C2
82A37A  .db $29 $7F $8D $0A $00 $22 $B4 $C3
82A382  .db $82 $22 $3B $8F $80 $60 $C6 $0F
82A38A  .db $F0 $DD $60 $A9 $04 $85 $02 $A9
82A392  .db $78 $85 $0F $22 $8E $8F $80 $B0
82A39A  .db $17 $A9 $0E $9D $0A $00 $A9 $03
82A3A2  .db $9D $00 $00 $9E $0B $00 $A4 $1C
82A3AA  .db $C2 $20 $B9 $8D $C2 $9D $28 $00
82A3B2  .db $E2 $30 $60          
----------------         
82A3B5   LDX $02                  
82A3B7   JMP ($A3BA,X)            
--------data--------     
82A3BA  .db $BE $A3 $DC $A3      
----------------         
82A3BE   LDA #$02                 
82A3C0   STA $02                  
82A3C2   STZ $1D                  
82A3C4   LDA $0D                  
82A3C6   BNE $82A3DB              
82A3C8   LDA $0B                  
82A3CA   CMP #$10                 
82A3CC   BNE $82A3D8              
82A3CE   LDA $1144                
82A3D1   BIT #$01                 
82A3D3   BEQ $82A3D8              
82A3D5   JSR $A4E3                
82A3D8   JSR $A48F                
82A3DB   RTS                      
----------------         
82A3DC   LDA $0D                  
82A3DE   BNE $82A410              
82A3E0   JSR $A4B2                
82A3E3   BCS $82A3F2              
82A3E5   LDA $0B                  
82A3E7   LSR                      
82A3E8   EOR #$0F                 
82A3EA   AND $00FC                
82A3ED   STA $00FC                
82A3F0   BRA $82A410              
--------unidentified--------
82A3F2  .db $A9 $00 $85 $03 $C2 $10 $A6 $16
82A3FA  .db $F0 $0F $BD $03 $00 $D0 $0A $A9
82A402  .db $06 $9D $02 $00 $A2 $00 $00 $86
82A40A  .db $16 $E2 $10 $4C $C4 $A4
----------------         
82A410   LDX $03                  
82A412   JMP ($A415,X)            
--------data--------     
82A415  .db $1B $A4 $32 $A4 $4A $A4
----------------         
82A41B   LDA #$02                 
82A41D   STA $03                  
82A41F   JSL GetRandomInt;$808859              
82A423   AND #$0F                 
82A425   ASL                      
82A426   TAX                      
82A427   LDA $C29F,X              
82A42A   STA $1E                  
82A42C   LDA $C2A0,X              
82A42F   STA $1F                  
82A431   RTS                      
----------------         
82A432   REP #$20                 
82A434   DEC $1E                  
82A436   SEP #$20                 
82A438   BNE $82A449              
82A43A   LDA #$04                 
82A43C   STA $03                  
82A43E   LDA #$03                 
82A440   STA $1D                  
82A442   LDA #$20                 
82A444   STA $1E                  
82A446   JSR $A4F5                
82A449   RTS                      
----------------         
82A44A   LDA $1D                  
82A44C   BNE $82A453              
82A44E   LDA #$00                 
82A450   STA $03                  
82A452   RTS                      
----------------         
82A453   DEC $1E                  
82A455   BNE $82A48E              
82A457   DEC $1D                  
82A459   LDA #$20                 
82A45B   STA $1E                  
82A45D   JSL $808F73              
82A461   BCS $82A48C              
82A463   STX $16                  
82A465   LDA #$02                 
82A467   STA $0000,X              
82A46A   LDA #$1C                 
82A46C   STA $000A,X              
82A46F   LDA $11                  
82A471   STA $0011,X              
82A474   STZ $0012,X              
82A477   LDA $14                  
82A479   STA $0014,X              
82A47C   STZ $0015,X              
82A47F   LDA #$00                 
82A481   XBA                      
82A482   LDA $1D                  
82A484   TAX                      
82A485   LDA $18,X                
82A487   LDX $16                  
82A489   STA $000D,X              
82A48C   SEP #$10                 
82A48E   RTS                      
----------------         
--------sub start--------
82A48F   REP #$20                 
82A491   LDA $11                  
82A493   LSR                      
82A494   LSR                      
82A495   LSR                      
82A496   STA $1B                  
82A498   LDA $14                  
82A49A   ASL                      
82A49B   ASL                      
82A49C   CLC                      
82A49D   ADC $1B                  
82A49F   CLC                      
82A4A0   STA $1B                  
82A4A2   CLC                      
82A4A3   ADC #$581F               
82A4A6   STA $0010                
82A4A9   SEP #$20                 
82A4AB   LDA #$04                 
82A4AD   JSL $808D7B              
82A4B1   RTS                      
----------------         
--------sub start--------
82A4B2   REP #$10                 
82A4B4   LDX $1B                  
82A4B6   LDA $1420,X              
82A4B9   CMP #$A2                 
82A4BB   BEQ $82A4C1              
82A4BD   SEP #$10                 
82A4BF   CLC                      
82A4C0   RTS                      
----------------         
--------unidentified--------
82A4C1  .db $E2 $11 $60 $A5 $0B $4A $0D $FC
82A4C9  .db $00 $8D $FC $00 $C9 $0F $D0 $23
82A4D1  .db $AD $44 $11 $29 $01 $D0 $0B $A9
82A4D9  .db $01 $0C $44 $11 $A9 $20 $22 $53
82A4E1  .db $9A $80 $C2 $20 $A9 $0E $00 $8D
82A4E9  .db $13 $00 $E2 $20 $9C $0A $00 $22
82A4F1  .db $B4 $C3 $82 $60      
----------------         
--------sub start--------
82A4F5   JSR $A531                
82A4F8   JSL $808B0E              
82A4FC   STA $18                  
82A4FE   INC                      
82A4FF   LSR                      
82A500   AND #$0F                 
82A502   STA $1A                  
82A504   ASL                      
82A505   SEC                      
82A506   SBC $18                  
82A508   BEQ $82A51A              
82A50A   AND #$1F                 
82A50C   BMI $82A51A              
82A50E   LDA $1A                  
82A510   STA $19                  
82A512   DEC $19                  
82A514   STA $18                  
82A516   INC $18                  
82A518   BRA $82A524              
82A51A   LDA $1A                  
82A51C   STA $19                  
82A51E   INC $19                  
82A520   STA $18                  
82A522   DEC $18                  
82A524   LDA $18                  
82A526   AND #$0F                 
82A528   STA $18                  
82A52A   LDA $19                  
82A52C   AND #$0F                 
82A52E   STA $19                  
82A530   RTS                      
----------------         
--------sub start--------
82A531   REP #$10                 
82A533   LDA $0100                
82A536   BEQ $82A550              
82A538   LDA $0180                
82A53B   BEQ $82A555              
82A53D   SEP #$10                 
82A53F   JSL $80919A              
--------unidentified--------
82A543  .db $C2 $10 $F0 $04 $B0 $07 $80 $0A
82A54B  .db $AD $56 $01 $F0 $05 $A2 $80 $01
82A553  .db $80 $03              
----------------         
82A555   LDX #$0100               
82A558   RTS                      
----------------         
82A559   LDX $02                  
82A55B   JMP ($A55E,X)            
--------data--------     
82A55E  .db $64 $A5 $78 $A5 $A6 $A5
----------------         
82A564   LDA #$02                 
82A566   STA $02                  
82A568   LDX $0B                  
82A56A   LDA $C2BF,X              
82A56D   STA $1F                  
82A56F   LDA $C2C0,X              
82A572   CMP $1A4A                
82A575   BEQ $82A585              
82A577   RTS                      
----------------         
82A578   LDA $00FB                
82A57B   CMP $1F                  
82A57D   BNE $82A5A5              
82A57F   LDA #$21                 
82A581   JSL PlaySFX ;$809A53
82A585   LDA #$04                 
82A587   STA $02                  
82A589   LDA $0B                  
82A58B   LSR                      
82A58C   ADC $0B                  
82A58E   TAX                      
82A58F   LDA $C2CB,X              
82A592   STA $0013                
82A595   LDA $C2CC,X              
82A598   STA $0014                
82A59B   LDA $C2CD,X              
82A59E   STA $000A                
82A5A1   JSL $82C3B4              
82A5A5   RTS                      
----------------         
82A5A6   JSL $808F3B              
82A5AA   RTS                      
----------------         
82A5AB   LDX $02                  
82A5AD   JMP ($A5B0,X)            
--------data--------     
82A5B0  .db $BB $A5 $29 $A6      
----------------         
--------unidentified--------
82A5B4  .db $CA $A6              
----------------         
--------data--------     
82A5B6  .db $CF $A6              
----------------         
--------unidentified--------
82A5B8  .db $E2 $10 $60          
----------------         
82A5BB   LDA #$02                 
82A5BD   STA $02                  
82A5BF   LDA $11                  
82A5C1   STA $0B                  
82A5C3   TAX                      
82A5C4   REP #$10                 
82A5C6   LDY $C2DD,X              
82A5C9   LDA $0000,Y              
82A5CC   STA $19                  
82A5CE   INY                      
82A5CF   STY $1E                  
82A5D1   LDA $19                  
82A5D3   BMI $82A5F6              
82A5D5   AND #$0F                 
82A5D7   STA $18                  
82A5D9   REP #$21                 
82A5DB   LDA $0000,Y              
82A5DE   ADC #$5800               
82A5E1   STA $0010                
82A5E4   PHY                      
82A5E5   SEP #$30                 
82A5E7   LDA #$04                 
82A5E9   JSL $808D7B              
--------unidentified--------
82A5ED  .db $C2 $10 $7A $C8 $C8 $C6 $18 $D0
82A5F5  .db $E3                  
----------------         
82A5F6   LDA $19                  
82A5F8   AND #$0F                 
82A5FA   STA $19                  
82A5FC   ASL                      
82A5FD   REP #$31                 
82A5FF   AND #$00FF               
82A602   ADC $1E                  
82A604   STA $1C                  
82A606   TAX                      
82A607   SEP #$20                 
82A609   LDA #$00                 
82A60B   XBA                      
82A60C   LDA $0000,X              
82A60F   BMI $82A5B8              
82A611   PHA                      
82A612   LSR                      
82A613   LSR                      
82A614   LSR                      
82A615   TAX                      
82A616   LDY $1144,X              
82A619   PLA                      
82A61A   AND #$07                 
82A61C   TAX                      
82A61D   TYA                      
82A61E   AND $80B8,X              
82A621   SEP #$10                 
82A623   BEQ $82A628              
82A625   JMP $A6A9                
82A628   RTS                      
----------------         
82A629   LDA $19                  
82A62B   STA $1A                  
82A62D   STZ $1B                  
82A62F   REP #$10                 
82A631   LDX $1E                  
82A633   LDY $0000,X              
82A636   LDA $1400,Y              
82A639   CMP #$A0                 
82A63B   BNE $82A63F              
82A63D   INC $1B                  
82A63F   INX                      
82A640   INX                      
82A641   DEC $1A                  
82A643   BNE $82A633              
82A645   LDA $19                  
82A647   CMP $1B                  
82A649   BNE $82A6C7              
82A64B   LDA $0000,X              
82A64E   BMI $82A6A1              
82A650   SEP #$10                 
82A652   STA $1A                  
82A654   LSR                      
82A655   LSR                      
82A656   LSR                      
82A657   TAY                      
82A658   LDA $1144,Y              
82A65B   PHA                      
82A65C   LDA $1A                  
82A65E   AND #$07                 
82A660   TAX                      
82A661   PLA                      
82A662   ORA $80B8,X              
82A665   STA $1144,Y              
82A668   REP #$10                 
82A66A   LDX $1C                  
82A66C   LDA $0001,X              
82A66F   BPL $82A6A1              
82A671   SEP #$10                 
82A673   JSL $808F8E              
--------unidentified--------
82A677  .db $B0 $28 $A9 $0E $9D $0A $00 $A9
82A67F  .db $03 $9D $00 $00 $A4 $1C $B9 $01
82A687  .db $00 $29 $0F $9D $0B $00 $C2 $20
82A68F  .db $B9 $02 $00 $9D $28 $00 $E2 $20
82A697  .db $A9 $04 $85 $02 $A9 $78 $85 $0F
82A69F  .db $80 $26              
----------------         
82A6A1   SEP #$10                 
82A6A3   LDA #$21                 
82A6A5   JSL PlaySFX ;$809A53
82A6A9   REP #$10                 
82A6AB   LDX $1C                  
82A6AD   LDA $0001,X              
82A6B0   AND #$7F                 
82A6B2   STA $000A                
82A6B5   LDY $0002,X              
82A6B8   BMI $82A6C3              
82A6BA   STY $0013                
82A6BD   SEP #$10                 
82A6BF   JSL $82C3B4              
82A6C3   LDA #$06                 
82A6C5   STA $02                  
82A6C7   SEP #$10                 
82A6C9   RTS                      
----------------         
--------unidentified--------
82A6CA  .db $C6 $0F $F0 $DB $60  
----------------         
82A6CF   JSL $808F3B              
82A6D3   RTS                      
----------------         
82A6D4   LDX $02                  
82A6D6   JMP ($A6D9,X)            
--------data--------     
82A6D9  .db $DF $A6 $F8 $A6 $0B $A7
----------------         
82A6DF   LDA #$02                 
82A6E1   STA $02                  
82A6E3   STA $01                  
82A6E5   DEC                      
82A6E6   STA $00                  
82A6E8   LDY #$BC                 
82A6EA   LDA #$C3                 
82A6EC   JSL $8089A3              
82A6F0   LDA #$3B                 
82A6F2   STA $1B                  
82A6F4   LDA #$80                 
82A6F6   STA $1A                  
82A6F8   JSL $8089A9              
82A6FC   LDA $08                  
82A6FE   CMP #$50                 
82A700   BNE $82A706              
82A702   LDA #$04                 
82A704   STA $02                  
82A706   JSL $8088CE              
82A70A   RTS                      
----------------         
82A70B   JSL $808F3B              
82A70F   RTS                      
----------------         
--------unidentified--------
82A710  .db $A6 $0B $BD $D6 $C3 $85 $0D $BC
82A718  .db $D5 $C3 $B9 $D5 $C3 $85 $0F $C8
82A720  .db $C2 $31 $B9 $D5 $C3 $AA $69 $00
82A728  .db $50 $8D $10 $00 $9E $00 $14 $9E
82A730  .db $20 $14 $E2 $30 $A5 $0D $C8 $C8
82A738  .db $5A $22 $7B $8D $80 $7A $C6 $0F
82A740  .db $D0 $DE $22 $3B $8F $80 $60 $A6
82A748  .db $02 $FC $60 $A7 $20 $89 $A7 $C2
82A750  .db $21 $A5 $11 $E9 $AF $01 $49 $FF
82A758  .db $00 $1A $8D $74 $00 $E2 $20 $60
82A760  .db $66 $A7 $70 $A7 $88 $A7 $AD $AC
82A768  .db $00 $D0 $04 $A9 $02 $85 $02 $60
82A770  .db $C2 $20 $A5 $10 $18 $69 $20 $00
82A778  .db $85 $10 $E2 $20 $A9 $B0 $C5 $11
82A780  .db $B0 $06 $85 $11 $A9 $04 $85 $02
82A788  .db $60 $A2 $00 $20 $90 $A7 $A2 $80
82A790  .db $BD $00 $01 $29 $03 $F0 $1C $A5
82A798  .db $11 $18 $69 $06 $DD $11 $01 $90
82A7A0  .db $12 $85 $13 $BD $14 $01 $C9 $24
82A7A8  .db $B0 $0A $C9 $1C $90 $05 $A9 $1C
82A7B0  .db $9D $14 $01 $60 $A5 $13 $9D $11
82A7B8  .db $01 $C9 $A9 $90 $2B $BD $14 $01
82A7C0  .db $C9 $54 $90 $04 $C9 $5D $90 $20
82A7C8  .db $A9 $02 $9D $00 $01 $3A $9D $0D
82A7D0  .db $01 $9E $1C $01 $9E $1D $01 $9E
82A7D8  .db $3F $01 $A9 $04 $9D $02 $01 $9E
82A7E0  .db $03 $01 $9E $04 $01 $9E $05 $01
82A7E8  .db $60 $A6 $02 $7C $EE $A7 $F4 $A7
82A7F0  .db $0B $A8 $0B $A8 $A9 $02 $85 $02
82A7F8  .db $BD $DF $C3 $8D $10 $00 $BD $E0
82A800  .db $C3 $8D $11 $00 $A9 $04 $22 $7B
82A808  .db $8D $80 $60 $60 $AD $00 $01 $3A
82A810  .db $D0 $05 $A2 $00 $20 $1F $A8 $AD
82A818  .db $80 $01 $3A $D0 $6A $A2 $80 $A0
82A820  .db $01 $BD $11 $01 $C9 $19 $90 $16
82A828  .db $A0 $03 $C9 $E7 $B0 $34 $A0 $02
82A830  .db $BD $14 $01 $C9 $2A $90 $13 $A0
82A838  .db $00 $C9 $CC $B0 $19 $60 $BD $14
82A840  .db $01 $C9 $60 $90 $1D $C9 $80 $B0
82A848  .db $19 $60 $BD $11 $01 $C9 $50 $90
82A850  .db $11 $C9 $B0 $B0 $0D $60 $BD $11
82A858  .db $01 $C9 $60 $90 $05 $C9 $A0 $B0
82A860  .db $01 $60 $BD $1D $01 $F0 $08 $9E
82A868  .db $1D $01 $9E $3F $01 $80 $07 $9E
82A870  .db $1C $01 $98 $9D $0D $01 $FE $00
82A878  .db $01 $A9 $04 $9D $02 $01 $9E $03
82A880  .db $01 $9E $04 $01 $9E $05 $01 $60
82A888  .db $A6 $02 $7C $8D $A8 $93 $A8 $F7
82A890  .db $A8 $27 $A9 $A5 $0B $F0 $3F $AD
82A898  .db $45 $11 $29 $80 $D0 $08 $A9 $15
82A8A0  .db $22 $50 $9A $80 $80 $2D $A2 $00
82A8A8  .db $BD $E7 $C3 $8D $13 $00 $BD $E8
82A8B0  .db $C3 $8D $14 $00 $9C $0A $00 $DA
82A8B8  .db $22 $B4 $C3 $82 $FA $E8 $E8 $E0
82A8C0  .db $06 $90 $E5 $A9 $90 $8D $10 $00
82A8C8  .db $A9 $50 $8D $11 $00 $A9 $0E $22
82A8D0  .db $7B $8D $80 $4C $65 $A9 $AD $45
82A8D8  .db $11 $29 $80 $D0 $F6 $A9 $02 $85
82A8E0  .db $02 $64 $1F $AD $45 $11 $29 $80
82A8E8  .db $A9 $38 $85 $11 $A9 $C8 $85 $12
82A8F0  .db $A9 $15 $22 $50 $9A $80 $60 $A5
82A8F8  .db $1F $29 $01 $D0 $09 $A5 $11 $20
82A900  .db $6A $A9 $90 $02 $E6 $1F $A5 $1F
82A908  .db $29 $02 $D0 $0B $A5 $12 $20 $6A
82A910  .db $A9 $90 $04 $A9 $02 $04 $1F $A5
82A918  .db $1F $C9 $03 $D0 $09 $A9 $04 $85
82A920  .db $02 $A9 $80 $0C $45 $11 $60 $A6
82A928  .db $03 $7C $2C $A9 $34 $A9 $40 $A9
82A930  .db $51 $A9 $5E $A9 $A9 $02 $85 $03
82A938  .db $A9 $20 $85 $0F $8D $AC $00 $60
82A940  .db $C6 $0F $D0 $0C $A9 $04 $85 $03
82A948  .db $A9 $52 $85 $0F $22 $29 $9A $80
82A950  .db $60 $A9 $06 $85 $03 $9C $C8 $00
82A958  .db $A9 $21 $22 $53 $9A $80 $C6 $0F
82A960  .db $D0 $EE $9C $AC $00 $22 $3B $8F
82A968  .db $80 $60 $85 $10 $C2 $10 $A2 $00
82A970  .db $0B $BD $00 $00 $F0 $0E $BD $11
82A978  .db $00 $C5 $10 $D0 $07 $BD $14 $00
82A980  .db $C9 $48 $F0 $0F $C2 $21 $8A $69
82A988  .db $40 $00 $AA $C9 $80 $0D $E2 $20
82A990  .db $90 $DF $18 $E2 $10 $60
----------------         
82A996   LDX $0B                  
82A998   JMP ($A99B,X)            
--------unidentified--------
82A99B  .db $A3 $A9              
----------------         
--------data--------     
82A99D  .db $A3 $A9              
----------------         
--------unidentified--------
82A99F  .db $A3 $A9 $63 $AA      
----------------         
82A9A3   LDX $02                  
82A9A5   JMP ($A9A8,X)            
--------data--------     
82A9A8  .db $AC $A9 $DD $A9      
----------------         
82A9AC   LDA #$02                 
82A9AE   STA $02                  
82A9B0   REP #$20                 
82A9B2   LDX $0B                  
82A9B4   LDA $C3ED,X              
82A9B7   STA $11                  
82A9B9   SEP #$20                 
82A9BB   LDY $0D                  
82A9BD   LDA ($11),Y              
82A9BF   TAY                      
82A9C0   INC                      
82A9C1   STA $14                  
82A9C3   STA $15                  
82A9C5   LDA ($11),Y              
82A9C7   STA $17                  
82A9C9   STA $16                  
82A9CB   TAX                      
82A9CC   LDA $C3F9,X              
82A9CF   STA $1C,X                
82A9D1   DEX                      
82A9D2   BPL $82A9CC              
82A9D4   STZ $18                  
82A9D6   STZ $19                  
82A9D8   STZ $1A                  
82A9DA   STZ $1B                  
82A9DC   RTS                      
----------------         
82A9DD   LDX $03                  
82A9DF   JMP ($A9E2,X)            
--------data--------     
82A9E2  .db $E4 $A9              
----------------         
82A9E4   LDA $14                  
82A9E6   STA $15                  
82A9E8   LDA $17                  
82A9EA   STA $16                  
82A9EC   LDY $15                  
82A9EE   REP #$20                 
82A9F0   LDA ($11),Y              
82A9F2   STA $0010                
82A9F5   SEP #$20                 
82A9F7   LDX $16                  
82A9F9   LDA $0B                  
82A9FB   CMP #$04                 
82A9FD   BEQ $82AA32              
82A9FF   LDA $1C,X                
82AA01   INC                      
82AA02   CMP #$04                 
82AA04   STA $1C,X                
82AA06   BEQ $82AA1A              
82AA08   CMP #$08                 
82AA0A   BEQ $82AA1A              
82AA0C   CMP #$0C                 
82AA0E   BEQ $82AA1A              
82AA10   CMP #$0D                 
82AA12   BNE $82AA5A              
82AA14   LDA #$00                 
82AA16   STA $1C,X                
82AA18   BRA $82AA5A              
82AA1A   LDY #$00                 
82AA1C   LDA $0B                  
82AA1E   BEQ $82AA22              
82AA20   LDY #$0C                 
82AA22   TYA                      
82AA23   CLC                      
82AA24   ADC $1C,X                
82AA26   LSR                      
82AA27   LSR                      
82AA28   TAX                      
82AA29   LDA $C462,X              
82AA2C   JSL $808D7B              
82AA30   BRA $82AA5A              
--------unidentified--------
82AA32  .db $D6 $1C $10 $24 $B5 $18 $F0 $09
82AA3A  .db $F6 $18 $A6 $0B $BD $F3 $C3 $80
82AA42  .db $08 $D6 $18 $A6 $0B $E8 $BD $F3
82AA4A  .db $C3 $22 $7B $8D $80 $A5 $0B $4A
82AA52  .db $AA $BD $FD $C3 $A6 $16 $95 $1C
----------------         
82AA5A   INC $15                  
82AA5C   INC $15                  
82AA5E   DEC $16                  
82AA60   BPL $82A9EC              
82AA62   RTS                      
----------------         
--------unidentified--------
82AA63  .db $A6 $02 $7C $68 $AA $6C $AA $8B
82AA6B  .db $AA $A9 $02 $85 $02 $A4 $0D $BE
82AA73  .db $3D $C4 $BD $3D $C4 $E8 $86 $0D
82AA7B  .db $86 $0E $85 $10 $85 $0F $AA $BD
82AA83  .db $34 $C4 $95 $11 $CA $10 $F8 $60
82AA8B  .db $A6 $03 $7C $90 $AA $92 $AA $A5
82AA93  .db $0D $85 $0E $A5 $10 $85 $0F $A6
82AA9B  .db $0E $C2 $20 $BD $3D $C4 $8D $10
82AAA3  .db $00 $E2 $20 $A6 $0F $B5 $11 $1A
82AAAB  .db $C9 $07 $95 $11 $F0 $12 $C9 $15
82AAB3  .db $F0 $12 $C9 $23 $F0 $12 $C9 $24
82AABB  .db $D0 $02 $A9 $00 $95 $11 $80 $0E
82AAC3  .db $A9 $00 $80 $06 $A9 $01 $80 $02
82AACB  .db $A9 $02 $22 $1F $8E $80 $E6 $0E
82AAD3  .db $E6 $0E $C6 $0F $10 $C1 $60 $A6
82AADB  .db $02 $7C $DF $AA $E7 $AA $EF $AA
82AAE3  .db $26 $AB $60 $AB $A9 $02 $85 $02
82AAEB  .db $A2 $13 $80 $61 $C2 $10 $A2 $00
82AAF3  .db $02 $BD $00 $00 $F0 $1C $C9 $03
82AAFB  .db $F0 $18 $BD $11 $00 $38 $E9 $40
82AB03  .db $C9 $10 $B0 $0E $BD $14 $00 $38
82AB0B  .db $E9 $90 $C9 $10 $B0 $04 $A9 $04
82AB13  .db $85 $02 $C2 $21 $8A $69 $50 $00
82AB1B  .db $AA $C9 $80 $09 $E2 $20 $90 $D1
82AB23  .db $E2 $10 $60 $A9 $06 $85 $02 $A9
82AB2B  .db $07 $22 $53 $9A $80 $22 $8E $8F
82AB33  .db $80 $B0 $12 $A9 $0E $9D $0A $00
82AB3B  .db $A9 $03 $9D $00 $00 $C2 $20 $A9
82AB43  .db $C8 $00 $9D $28 $00 $E2 $30 $A9
82AB4B  .db $78 $85 $0F $A2 $14 $A9 $48 $8D
82AB53  .db $10 $00 $A9 $5A $8D $11 $00 $8A
82AB5B  .db $22 $7B $8D $80 $60 $C6 $0F $D0
82AB63  .db $15 $A9 $C8 $8D $13 $00 $A9 $00
82AB6B  .db $8D $14 $00 $9C $0A $00 $22 $B4
82AB73  .db $C3 $82 $22 $3B $8F $80 $60 $A6
82AB7B  .db $02 $7C $7F $AB $83 $AB $91 $AB
82AB83  .db $A9 $02 $85 $02 $64 $1B $64 $1D
82AB8B  .db $A9 $96 $85 $0F $80 $28 $AD $00
82AB93  .db $01 $C9 $04 $F0 $34 $AD $80 $01
82AB9B  .db $C9 $04 $F0 $2D $C6 $0F $D0 $29
82ABA3  .db $A9 $96 $85 $0F $64 $1E $64 $1F
82ABAB  .db $20 $CD $AB $A5 $1B $1A $C9 $03
82ABB3  .db $90 $02 $A9 $00 $85 $1B $A9 $30
82ABBB  .db $85 $1E $85 $1F $20 $CD $AB $A5
82ABC3  .db $1B $18 $69 $05 $A8 $22 $B0 $AD
82ABCB  .db $80 $60 $A6 $1B $BC $69 $C4 $B9
82ABD3  .db $69 $C4 $85 $1C $C2 $30 $A5 $1E
82ABDB  .db $BE $6A $C4 $9D $00 $14 $9D $02
82ABE3  .db $14 $9D $20 $14 $9D $22 $14 $9D
82ABEB  .db $40 $14 $9D $42 $14 $9D $60 $14
82ABF3  .db $9D $62 $14 $C8 $C8 $C6 $1C $D0
82ABFB  .db $DF $E2 $30 $60      
----------------         
82ABFF   LDX $02                  
82AC01   JMP ($AC04,X)            
--------data--------     
82AC04  .db $0A $AC $24 $AC $80 $AD
----------------         
82AC0A   LDA $00B1                
82AC0D   BNE $82AC12              
82AC0F   JMP $AD68                
82AC12   LDA #$02                 
82AC14   STA $02                  
82AC16   LDA $0B                  
82AC18   LSR                      
82AC19   TAX                      
82AC1A   ASL                      
82AC1B   ASL                      
82AC1C   STA $0B                  
82AC1E   LDA $C4AB,X              
82AC21   STA $03                  
82AC23   RTS                      
----------------         
82AC24   JSR $ADB9                
82AC27   LDX $03                  
82AC29   JMP ($AC2C,X)            
--------data--------     
82AC2C  .db $38 $AC $64 $AC $B2 $AC $0C $AD
----------------         
--------unidentified--------
82AC34  .db $78 $AD $7C $AD      
----------------         
82AC38   LDX $1D                  
82AC3A   JMP ($AC3D,X)            
--------unidentified--------
82AC3D  .db $41 $AC              
----------------         
--------data--------     
82AC3F  .db $4A $AC              
----------------         
82AC41   STZ $03                  
82AC43   LDA #$02                 
82AC45   STA $1D                  
82AC47   STZ $1E                  
82AC49   RTS                      
----------------         
82AC4A   LDA $1E                  
82AC4C   ORA #$20                 
82AC4E   JSL $808667              
82AC52   INC $1E                  
82AC54   LDA $1E                  
82AC56   CMP #$08                 
82AC58   BNE $82AC63              
82AC5A   LDA $1C                  
82AC5C   STA $03                  
82AC5E   STZ $1E                  
82AC60   JMP $8BBA                
82AC63   RTS                      
----------------         
82AC64   LDX $10                  
82AC66   JMP ($AC69,X)            
--------unidentified--------
82AC69  .db $6D $AC              
----------------         
--------data--------     
82AC6B  .db $8B $AC              
----------------         
82AC6D   ASL                      
82AC6E   TAX                      
82AC6F   LDA #$02                 
82AC71   STA $03                  
82AC73   REP #$20                 
82AC75   LDA $8BE86F,X            
82AC79   STA $12                  
82AC7B   LDA #$4E44               
82AC7E   STA $14                  
82AC80   SEP #$20                 
82AC82   LDA #$02                 
82AC84   STA $10                  
82AC86   LDA #$01                 
82AC88   STA $11                  
82AC8A   RTS                      
----------------         
82AC8B   DEC $11                  
82AC8D   BNE $82ACB1              
82AC8F   LDA #$01                 
82AC91   STA $11                  
82AC93   JSR $AD85                
82AC96   BEQ $82ACAB              
82AC98   BPL $82ACB1              
82AC9A   REP #$21                 
82AC9C   LDA $14                  
82AC9E   AND #$FFE0               
82ACA1   ADC #$0044               
82ACA4   STA $14                  
82ACA6   INC $12                  
82ACA8   SEP #$20                 
82ACAA   RTS                      
----------------         
82ACAB   LDA $16                  
82ACAD   STA $03                  
82ACAF   STZ $10                  
82ACB1   RTS                      
----------------         
82ACB2   LDX $04                  
82ACB4   JMP ($ACB7,X)            
--------data--------     
82ACB7  .db $BF $AC $CA $AC $DF $AC $E9 $AC
----------------         
82ACBF   LDA #$02                 
82ACC1   STA $04                  
82ACC3   STZ $1A                  
82ACC5   LDA #$FF                 
82ACC7   STA $18                  
82ACC9   RTS                      
----------------         
82ACCA   DEC $18                  
82ACCC   BNE $82ACDE              
82ACCE   LDA #$04                 
82ACD0   STA $04                  
82ACD2   LDX $1A ;<
82ACD4   LDA $C4BB,X              
82ACD7   STA $00FE ;Part of Pirate Intro Routine?
82ACDA   LDA #$10                 
82ACDC   STA $18                  
82ACDE   RTS                      
----------------         
82ACDF   DEC $18                  
82ACE1   BNE $82ACE8              
82ACE3   LDA $1A                  
82ACE5   JMP $AD1B                
82ACE8   RTS                      
----------------         
82ACE9   INC $1A                  
82ACEB   LDA $1A                  
82ACED   CMP #$03                 
82ACEF   BEQ $82ACFF              
82ACF1   STZ $00FE                
82ACF4   LDA #$02                 
82ACF6   STA $04                  
82ACF8   LDA #$14                 
82ACFA   STA $18                  
82ACFC   JMP $ADC9                
82ACFF   LDA #$04                 
82AD01   STA $02                  
82AD03   STZ $00AC                
82AD06   INC $00FE ;Increase FE ?
82AD09   JMP $ADC9                
82AD0C   LDX $04                  
82AD0E   JMP ($AD11,X)            
--------unidentified--------
82AD11  .db $19 $AD              
----------------         
--------data--------     
82AD13  .db $2E $AD $3A $AD $47 $AD
----------------         
--------unidentified--------
82AD19  .db $A9 $03              
----------------         
82AD1B   STA $19                  
82AD1D   LDA #$06                 
82AD1F   STA $03                  
82AD21   STA $1C                  
82AD23   STA $16                  
82AD25   LDA #$02                 
82AD27   STA $04                  
82AD29   LDA #$10                 
82AD2B   STA $18                  
82AD2D   RTS                      
----------------         
82AD2E   DEC $18                  
82AD30   BNE $82AD39              
82AD32   LDA #$04                 
82AD34   STA $04                  
82AD36   JMP $AC41                
82AD39   RTS                      
----------------         
82AD3A   LDA #$06                 
82AD3C   STA $04                  
82AD3E   LDA #$90                 
82AD40   STA $18                  
82AD42   LDA $19                  
82AD44   JMP $AC6D                
82AD47   DEC $18                  
82AD49   BNE $82AD77              
82AD4B   JSL $808574              
82AD4F   LDX $0B                  
82AD51   BNE $82AD5C              
82AD53   LDA #$04                 
82AD55   STA $03                  
82AD57   LDA #$06                 
82AD59   STA $04                  
82AD5B   RTS                            
--------unidentified--------
82AD5C  .db $BD $AB $C4 $F0 $04 $E6 $0B $80
82AD64  .db $B6
;SKIP BOSS INTRO ROUTINE (WHEN YOU PRESS START IN BOSS ROOM) for boss1 at least
82AD65   JSR $ADC9
82AD68   LDA #$04
82AD6A   STA $02 ;$0A02 ;Prevent Text from showing up
82AD6C   LDA #$08
82AD6E   STA $00FE ;Boss mode (prevent boss from playing his intro)
82AD71   STZ $00AC ;Allow you to move again
82AD74   STZ $0089 ;HDMA Settings, do not reset for dark room bosses    
82AD77   RTS                            
--------unidentified--------
82AD78  .db $A9 $04 $80 $9F $A9 $08 $80 $9B
----------------         
82AD80   JSL $808F3B              
82AD84   RTS                      
----------------         
--------sub start--------
82AD85   PEA #$838B               
82AD88   PLB                      
82AD89   LDX $0041                
82AD8C   LDA #$80                 
82AD8E   STA $1900,X              
82AD91   LDA #$02                 
82AD93   STA $1903,X              
82AD96   REP #$20                 
82AD98   LDA $14                  
82AD9A   STA $1901,X              
82AD9D   INC $14                  
82AD9F   LDA ($12)                
82ADA1   INC $12                  
82ADA3   SEP #$21                 
82ADA5   STA $1904,X              
82ADA8   LDA #$20                 
82ADAA   STA $1905,X              
82ADAD   TXA                      
82ADAE   ADC #$05                 
82ADB0   STA $0041                
82ADB3   LDA ($12)                
82ADB5   PLB                      
82ADB6   CMP #$00                 
82ADB8   RTS                      
----------------         
--------sub start--------
82ADB9   LDA $0165 ;Controller1 filtered
82ADBC   ORA $01E5 ;ora Controller2 filtered             
82ADBF   BIT #$10 ;IF Either of the player press Start
82ADC1   BEQ $82ADC8              
82ADC3   PLA ;Remove the RTS
82ADC4   PLA ;Remove the RTS
82ADC5   JMP $AD65 ;Go to skip boss intro routine
82ADC8   RTS                      
----------------         
82ADC9   JSL $80856E              
82ADCD   STZ $2123                
82ADD0   STZ $2124                
82ADD3   STZ $2125                
82ADD6   STZ $0084                
82ADD9   STZ $0085                
82ADDC   RTS                      
----------------         
--------sub start--------
82ADDD   LDA $0E00                
82ADE0   BEQ $82ADEA              
82ADE2   LDA #$0E                 
82ADE4   XBA                      
82ADE5   LDA #$00                 
82ADE7   JSR $AEAE                
82ADEA   LDA $0E20                
82ADED   BEQ $82ADF7              
82ADEF   LDA #$0E                 
82ADF1   XBA                      
82ADF2   LDA #$20                 
82ADF4   JSR $AEAE                
82ADF7   LDA $0E40                
82ADFA   BEQ $82AE04              
82ADFC   LDA #$0E                 
82ADFE   XBA                      
82ADFF   LDA #$40                 
82AE01   JSR $AEAE                
82AE04   LDA $0E60                
82AE07   BEQ $82AE11              
82AE09   LDA #$0E                 
82AE0B   XBA                      
82AE0C   LDA #$60                 
82AE0E   JSR $AEAE                
82AE11   LDA $0E80                
82AE14   BEQ $82AE1E              
82AE16   LDA #$0E                 
82AE18   XBA                      
82AE19   LDA #$80                 
82AE1B   JSR $AEAE                
82AE1E   LDA $0EA0                
82AE21   BEQ $82AE2B              
82AE23   LDA #$0E                 
82AE25   XBA                      
82AE26   LDA #$A0                 
82AE28   JSR $AEAE                
82AE2B   LDA $0EC0                
82AE2E   BEQ $82AE38              
82AE30   LDA #$0E                 
82AE32   XBA                      
82AE33   LDA #$C0                 
82AE35   JSR $AEAE                
82AE38   LDA $0EE0                
82AE3B   BEQ $82AE45              
82AE3D   LDA #$0E                 
82AE3F   XBA                      
82AE40   LDA #$E0                 
82AE42   JSR $AEAE                
82AE45   LDA $0F00                
82AE48   BEQ $82AE52              
82AE4A   LDA #$0F                 
82AE4C   XBA                      
82AE4D   LDA #$00                 
82AE4F   JSR $AEAE                
82AE52   LDA $0F20                
82AE55   BEQ $82AE5F              
82AE57   LDA #$0F                 
82AE59   XBA                      
82AE5A   LDA #$20                 
82AE5C   JSR $AEAE                
82AE5F   LDA $0F40                
82AE62   BEQ $82AE6C              
82AE64   LDA #$0F                 
82AE66   XBA                      
82AE67   LDA #$40                 
82AE69   JSR $AEAE                
82AE6C   LDA $0F60                
82AE6F   BEQ $82AE79              
82AE71   LDA #$0F                 
82AE73   XBA                      
82AE74   LDA #$60                 
82AE76   JSR $AEAE                
82AE79   LDA $0F80                
82AE7C   BEQ $82AE86              
82AE7E   LDA #$0F                 
82AE80   XBA                      
82AE81   LDA #$80                 
82AE83   JSR $AEAE                
82AE86   LDA $0FA0                
82AE89   BEQ $82AE93              
82AE8B   LDA #$0F                 
82AE8D   XBA                      
82AE8E   LDA #$A0                 
82AE90   JSR $AEAE                
82AE93   LDA $0FC0                
82AE96   BEQ $82AEA0              
82AE98   LDA #$0F                 
82AE9A   XBA                      
82AE9B   LDA #$C0                 
82AE9D   JSR $AEAE                
82AEA0   LDA $0FE0                
82AEA3   BEQ $82AEAD              
82AEA5   LDA #$0F                 
82AEA7   XBA                      
82AEA8   LDA #$E0                 
82AEAA   JSR $AEAE                
82AEAD   RTL                      
----------------         
--------sub start--------
82AEAE   TCD                      
82AEAF   LDX $02                  
82AEB1   JMP ($AEB4,X)            
--------data--------     
82AEB4  .db $BC $AE $F3 $AE $22 $AF $81 $AF
----------------         
82AEBC   LDA #$02                 
82AEBE   STA $02                  
82AEC0   DEC                      
82AEC1   STA $00                  
82AEC3   STA $01                  
82AEC5   STA $17                  
82AEC7   LDA #$34                 
82AEC9   STA $1B                  
82AECB   LDA $0B                  
82AECD   ASL                      
82AECE   ADC #$C9                 
82AED0   TAY                      
82AED1   LDA #$C4                 
82AED3   ADC #$00                 
82AED5   JSL $8089A3              
82AED9   LDA $0D                  
82AEDB   INC                      
82AEDC   BNE $82AEF2              
82AEDE   LDA #$02                 
82AEE0   STA $03                  
82AEE2   STA $00                  
82AEE4   STA $0F                  
82AEE6   LDA #$04                 
82AEE8   STZ $1E                  
82AEEA   STA $1F                  
82AEEC   LDA #$06                 
82AEEE   JSL PlaySFX ;$809A53
82AEF2   RTS                      
----------------         
82AEF3   LDA $03                  
82AEF5   BEQ $82AF1D              
82AEF7   REP #$21                 
82AEF9   LDA $1E                  
82AEFB   SBC #$002F               
82AEFE   STA $1E                  
82AF00   LDA $16                  
82AF02   CLC                      
82AF03   ADC $1E                  
82AF05   STA $16                  
82AF07   SEP #$20                 
82AF09   BPL $82AF1D              
82AF0B   LDA #$01                 
82AF0D   STA $00                  
82AF0F   STA $17                  
82AF11   LDA #$02                 
82AF13   STZ $1E                  
82AF15   STA $1F                  
82AF17   DEC $0F                  
82AF19   BNE $82AF1D              
82AF1B   STZ $03                  
82AF1D   JSL $8088CE              
82AF21   RTS                      
GrabFruit:
{      
82AF22   LDA $03                  
82AF24   BNE $82AF1D              
82AF26   LDA #$06                 
82AF28   STA $02                  
82AF2A   LDA $0B                  
82AF2C   CMP #$06                 
82AF2E   BEQ $82AF70              
82AF30   LDA #$1C
82AF32   JSL PlaySFX ;$809A53
82AF36   LDX $05                  
82AF38   STZ $013F,X              
82AF3B   LDA $0B ;Contains Collected fruit id ?
82AF3D   LSR                      
82AF3E   TAY                      
82AF3F   LDA $011D,X ;P1 Hearts
82AF42   CLC                      
82AF43   ADC $C4BE,Y ;Fruit Count Table
82AF46   CMP #$07                 
82AF48   BCS $82AF4E ;If new heart count < 7
82AF4A   STA $011D,X ;Add Hearts
82AF4D   RTS
}
----------------         
82AF4E   SBC #$07                 
82AF50   STA $011D,X              
82AF53   LDA $0157,X              
82AF56   INC                      
82AF57   CMP #$0B                 
82AF59   BCS $82AF65              
82AF5B   STA $0157,X              
82AF5E   LDA #$10                 
82AF60   JSL PlaySFX ;$809A53
82AF64   RTS                      
----------------         
--------unidentified--------
82AF65  .db $A9 $0A $9D $57 $01 $A9 $06 $9D
82AF6D  .db $1D $01 $60 $AD $CC $00 $C9 $09
82AF75  .db $B0 $03 $EE $CC $00 $A9 $2E $22
82AF7D  .db $53 $9A $80 $60      
----------------         
82AF81   LDA $0A                  
82AF83   STZ $0A                  
82AF85   BNE $82AF9B              
82AF87   LDA $0D                  
82AF89   LSR                      
82AF8A   LSR                      
82AF8B   LSR                      
82AF8C   TAX                      
82AF8D   LDA $0D                  
82AF8F   AND #$07                 
82AF91   TAY                      
82AF92   LDA $80B8,Y              
82AF95   ORA $1170,X              
82AF98   STA $1170,X              
82AF9B   JSL $808F3B              
82AF9F   RTS                      
----------------         
--------sub start--------
82AFA0   LDA $1040                
82AFA3   BEQ $82AFAD              
82AFA5   LDA #$10                 
82AFA7   XBA                      
82AFA8   LDA #$40                 
82AFAA   JSR $AFEF                
82AFAD   LDA $1060                
82AFB0   BEQ $82AFBA              
82AFB2   LDA #$10                 
82AFB4   XBA                      
82AFB5   LDA #$60                 
82AFB7   JSR $AFEF                
82AFBA   LDA $1080                
82AFBD   BEQ $82AFC7              
82AFBF   LDA #$10                 
82AFC1   XBA                      
82AFC2   LDA #$80                 
82AFC4   JSR $AFEF                
82AFC7   LDA $10A0                
82AFCA   BEQ $82AFD4              
82AFCC   LDA #$10                 
82AFCE   XBA                      
82AFCF   LDA #$A0                 
82AFD1   JSR $AFEF                
82AFD4   LDA $10C0                
82AFD7   BEQ $82AFE1              
82AFD9   LDA #$10                 
82AFDB   XBA                      
82AFDC   LDA #$C0                 
82AFDE   JSR $B121                
82AFE1   LDA $10E0                
82AFE4   BEQ $82AFEE              
82AFE6   LDA #$10                 
82AFE8   XBA                      
82AFE9   LDA #$E0                 
82AFEB   JSR $B121                
82AFEE   RTL                      
----------------         
--------sub start--------
82AFEF   TCD                      
82AFF0   LDX $02                  
82AFF2   JMP ($AFF5,X)            
--------data--------     
82AFF5  .db $FD $AF $FB $B0 $4C $B0 $00 $B1
----------------         
82AFFD   LDA $11                  
82AFFF   CLC                      
82B000   ADC #$F8                 
82B002   LSR                      
82B003   LSR                      
82B004   LSR                      
82B005   STA $0002                
82B008   STZ $0003                
82B00B   REP #$31                 
82B00D   LDA $14                  
82B00F   ADC #$FFF8               
82B012   AND #$00F8               
82B015   ASL                      
82B016   ASL                      
82B017   ADC $0002                
82B01A   STA $18                  
82B01C   TAX                      
82B01D   LDA #$8080               
82B020   STA $1400,X              
82B023   STA $1420,X              
82B026   SEP #$30                 
--------sub start--------
82B028   LDA #$02                 
82B02A   STA $02                  
82B02C   DEC                      
82B02D   STA $00                  
82B02F   STA $01                  
82B031   LDA #$36                 
82B033   LDX $0B                  
82B035   CPX #$0A                 
82B037   BEQ $82B03D              
82B039   CPX #$18                 
82B03B   BNE $82B03F              
82B03D   LDA #$34                 
82B03F   STA $1B                  
82B041   LDY $C4D9,X              
82B044   LDA $C4DA,X              
82B047   JSL $8089A3              
82B04B   RTS                      
----------------         
82B04C   LDA #$06                 
82B04E   STA $02                  
82B050   LDX $05                  
82B052   LDY $0142,X              
82B055   STZ $013F,X              
82B058   LDA $0140,X              
82B05B   BEQ $82B065              
82B05D   LDA $0141,X              
82B060   BEQ $82B065              
82B062   LDY $0143,X              
82B065   STY $04                  
82B067   LDA $0B                  
82B069   INC                      
82B06A   INC                      
82B06B   TAY                      
82B06C   LDA $00BD                
82B06F   CMP #$03                 
82B071   BEQ $82B086              
82B073   LDA $0142,X              
82B076   BEQ $82B0A2              
82B078   LDA $0140,X              
82B07B   BNE $82B086              
82B07D   LDA #$02                 
82B07F   STA $0140,X              
82B082   STZ $04                  
82B084   BRA $82B090              
82B086   LDA $0141,X              
82B089   BEQ $82B0A2              
82B08B   LDA $0140,X              
82B08E   BEQ $82B0A2              
82B090   TYA                      
82B091   STA $0143,X              
82B094   LDA $B6EC,Y              
82B097   STA $015C,X              
82B09A   LDA $B6ED,Y              
82B09D   STA $015D,X              
82B0A0   BRA $82B0B2              
82B0A2   TYA                      
82B0A3   STA $0142,X              
82B0A6   LDA $B6EC,Y              
82B0A9   STA $015A,X              
82B0AC   LDA $B6ED,Y              
82B0AF   STA $015B,X              
82B0B2   TXA                      
82B0B3   LSR                      
82B0B4   LSR                      
82B0B5   TAX                      
82B0B6   LDA #$02                 
82B0B8   STA $10C0,X              
82B0BB   LDA $0B                  
82B0BD   CLC                      
82B0BE   ADC #$0E                 
82B0C0   STA $10CB,X              
82B0C3   LDA $0D                  
82B0C5   LSR                      
82B0C6   TAX                      
82B0C7   LDA $1160,X              
82B0CA   BCC $82B0D3              
82B0CC   AND #$0F                 
82B0CE   STA $1160,X              
82B0D1   BRA $82B0D8              
82B0D3   AND #$F0                 
82B0D5   STA $1160,X              
82B0D8   LDA $04                  
82B0DA   BEQ $82B0FF              
82B0DC   STZ $02                  
82B0DE   DEC                      
82B0DF   DEC                      
82B0E0   STA $0B                  
82B0E2   LSR                      
82B0E3   ORA #$08                 
82B0E5   STA $10                  
82B0E7   LDA $0D                  
82B0E9   LSR                      
82B0EA   LDA $10                  
82B0EC   BCC $82B0F2              
82B0EE   ASL                      
82B0EF   ASL                      
82B0F0   ASL                      
82B0F1   ASL                      
82B0F2   ORA $1160,X              
82B0F5   STA $1160,X              
82B0F8   JSR $B028                
82B0FB   JSL $8088DF              
82B0FF   RTS                      
----------------         
82B100   REP #$30                 
82B102   LDX $18                  
82B104   LDA $7FF800,X            
82B108   STA $1400,X              
82B10B   LDA $7FF820,X            
82B10F   STA $1420,X              
82B112   SEP #$30                 
82B114   STZ $00                  
82B116   STZ $01                  
82B118   STZ $02                  
82B11A   STZ $03                  
82B11C   STZ $04                  
82B11E   STZ $05                  
82B120   RTS                      
----------------         
--------sub start--------
82B121   TCD                      
82B122   LDX $02                  
82B124   JMP ($B127,X)            
--------data--------     
82B127  .db $28 $B0 $20 $B1      
----------------         
--------unidentified--------
82B12B  .db $14 $B1 $14 $B1      
----------------         
--------sub start--------
82B12F   JSL $80B8A0              
82B133   LDA #$02                 
82B135   XBA                      
82B136   LDA #$00                 
82B138   TCD                      
82B139   LDA $00                  
82B13B   BEQ $82B142              
82B13D   LDX $0A                  
82B13F   JSR ($B159,X)            
82B142   REP #$21                 
82B144   TDC                      
82B145   ADC #$0050               
82B148   CMP #$0480               
82B14B   SEP #$20                 
82B14D   BCC $82B138              
82B14F   LDA #$00                 
82B151   XBA                      
82B152   LDA #$00                 
82B154   TCD                      
82B155   JMP $80B9C5              
--------data--------     
82B159  .db $6F $B1 $80 $B2 $44 $B3
----------------         
--------unidentified--------
82B15F  .db $F1 $B3              
----------------         
--------data--------     
82B161  .db $DA $B7 $BF $B8 $AB $B9
----------------         
--------unidentified--------
82B167  .db $D4 $BB              
----------------         
--------data--------     
82B169  .db $3B $BD $DA $BD $BE $BF
----------------         
--------sub start--------
82B16F   LDX $02                  
82B171   JSR ($B177,X)            
82B174   JMP $B24C                
--------data--------     
82B177  .db $7D $B1 $8A $B1 $E2 $B1
----------------         
--------sub start--------
82B17D   LDA #$02                 
82B17F   STA $02                  
82B181   STZ $30                  
82B183   STZ $32                  
82B185   STZ $13                  
82B187   JMP $B206                
--------sub start--------
82B18A   LDA $0049                
82B18D   AND #$C0                 
82B18F   ORA $0048                
82B192   BIT #$D0                 
82B194   BEQ $82B1A9              
82B196   LDA #$03                 
82B198   JSL PlaySFX ;$809A53
82B19C   LDA #$04                 
82B19E   STA $02                  
82B1A0   LDA #$01                 
82B1A2   STA $11                  
82B1A4   LDA $13                  
82B1A6   STZ $2B                  
82B1A8   RTS                      
----------------         
82B1A9   LDA $0048                
82B1AC   BIT #$21                 
82B1AE   BEQ $82B1BB              
82B1B0   LDA $13                  
82B1B2   INC                      
82B1B3   CMP #$03                 
82B1B5   BCC $82B1B9              
82B1B7   LDA #$00                 
82B1B9   BRA $82B1C9              
82B1BB   LDA $0048                
82B1BE   BIT #$02                 
82B1C0   BEQ $82B1D4              
82B1C2   LDA $13                  
82B1C4   DEC                      
82B1C5   BPL $82B1C9              
82B1C7   LDA #$02                 
82B1C9   STA $13                  
82B1CB   LDA #$06                 
82B1CD   JSL PlaySFX ;$809A53
82B1D1   JSR $B206
;No Input pressed this frame
82B1D4   REP #$20                 
82B1D6   INC $14
82B1D8   LDA $14
82B1DA   CMP #$00F0               
82B1DD   SEP #$20                 
82B1DF   BEQ $82B202              
82B1E1   RTS                      
----------------         
--------sub start--------
82B1E2   DEC $11                  
82B1E4   BNE $82B205              
82B1E6   LDY $2B                  
82B1E8   LDA $C533,Y              
82B1EB   BMI $82B1FB              
82B1ED   STA $11                  
82B1EF   INC $2B                  
82B1F1   LDX $C538,Y              
82B1F4   LDA $13                  
82B1F6   STA $28                  
82B1F8   JMP $B220                
82B1FB   LDA $13                  
82B1FD   INC                      
82B1FE   ASL                      
82B1FF   STA $00A9                
82B202   INC $00A8                
82B205   RTS                      
----------------         
--------sub start--------
82B206   STZ $14                  
82B208   STZ $15                  
82B20A   LDA #$02                 
82B20C   STA $28                  
82B20E   LDX #$AF                 
82B210   LDA $28                  
82B212   CMP $13                  
82B214   BNE $82B218              
82B216   LDX #$AD                 
82B218   JSR $B220                
82B21B   DEC $28                  
82B21D   BPL $82B20E              
82B21F   RTS                      
----------------         
--------sub start--------
82B220   REP #$31                 
82B222   LDA $28                  
82B224   ADC #$0005               
82B227   AND #$00FF               
82B22A   XBA                      
82B22B   LSR                      
82B22C   LSR                      
82B22D   LSR                      
82B22E   TAY                      
82B22F   TXA                      
82B230   XBA                      
82B231   LSR                      
82B232   LSR                      
82B233   LSR                      
82B234   TAX                      
82B235   LDA #$0010               
82B238   STA $29                  
82B23A   LDA $8AE400,X            
82B23E   STA $1E00,Y              
82B241   INX                      
82B242   INX                      
82B243   INY                      
82B244   INY                      
82B245   DEC $29                  
82B247   BNE $82B23A              
82B249   SEP #$30                 
82B24B   RTS                      
----------------         
82B24C   LDX $30                  
82B24E   JMP ($B251,X)            
--------data--------     
82B251  .db $55 $B2 $5D $B2      
----------------         
82B255   LDA #$05                 
82B257   STA $31                  
82B259   LDA #$02                 
82B25B   STA $30                  
82B25D   DEC $31                  
82B25F   BNE $82B27F              
82B261   STZ $30                  
82B263   INC $32                  
82B265   LDA $32                  
82B267   CMP #$06                 
82B269   BCC $82B273              
82B26B   LDA #$FF                 
82B26D   STA $32                  
82B26F   LDA #$B4                 
82B271   BRA $82B257              
82B273   LDY $32                  
82B275   LDX $C52D,Y              
82B278   LDA #$FF                 
82B27A   STA $28                  
82B27C   JMP $B220                
82B27F   RTS                      
----------------         
--------sub start--------
82B280   LDX $02                  
82B282   JSR ($B295,X)            
82B285   REP #$21                 
82B287   LDA $10                  
82B289   ADC #$0080               
82B28C   STA $10                  
82B28E   SEP #$20                 
82B290   XBA                      
82B291   STA $0078                
82B294   RTS                      
----------------         
--------data--------     
82B295  .db $9B $B2 $B1 $B2 $0E $B3
----------------         
--------sub start--------
82B29B   LDA #$02                 
82B29D   STA $02                  
82B29F   STZ $3F                  
82B2A1   LDX #$20                 
82B2A3   LDA $8AE500,X            
82B2A7   STA $1E20,X              
82B2AA   DEX                      
82B2AB   BNE $82B2A3              
82B2AD   JSR $B31E                
82B2B0   RTS                      
----------------         
--------sub start--------
82B2B1   LDA $0049                
82B2B4   AND #$C0                 
82B2B6   ORA $0048                
82B2B9   BIT #$D0                 
82B2BB   BEQ $82B2E4              
82B2BD   LDX #$60                 
82B2BF   LDA $3F                  
82B2C1   CLC                      
82B2C2   ADC #$03                 
82B2C4   ASL                      
82B2C5   ASL                      
82B2C6   ASL                      
82B2C7   ASL                      
82B2C8   ASL                      
82B2C9   TAY                      
82B2CA   JSR $B32E                
82B2CD   LDA $3F                  
82B2CF   ADC #$12                 
82B2D1   JSL $808667              
82B2D5   LDA #$03                 
82B2D7   JSL PlaySFX ;$809A53
82B2DB   LDA #$40                 
82B2DD   STA $3D                  
82B2DF   LDA #$04                 
82B2E1   STA $02                  
82B2E3   RTS                      
----------------         
82B2E4   LDA $0048                
82B2E7   BIT #$0C                 
82B2E9   BEQ $82B2F3              
82B2EB   LDA $3F                  
82B2ED   EOR #$01                 
82B2EF   STA $3F                  
82B2F1   BRA $82B2FE              
82B2F3   LDA $0048                
82B2F6   BIT #$03                 
82B2F8   BEQ $82B304              
82B2FA   DEC $3F                  
82B2FC   DEC $3F                  
82B2FE   LDA #$06                 
82B300   JSL PlaySFX ;$809A53
82B304   LDA $3F                  
82B306   AND #$03                 
82B308   STA $3F                  
82B30A   JSR $B31E                
82B30D   RTS                      
----------------         
--------sub start--------
82B30E   LDA $3D                  
82B310   BNE $82B31B              
82B312   LDA $3F                  
82B314   ASL                      
82B315   STA $00A9                
82B318   INC $00A8                
82B31B   DEC $3D                  
82B31D   RTS                      
----------------         
--------sub start--------
82B31E   LDA #$03                 
82B320   STA $3D                  
82B322   LDY #$C0                 
82B324   LDX #$40                 
82B326   LDA $3D                  
82B328   CMP $3F                  
82B32A   BNE $82B32E              
82B32C   LDX #$20                 
--------sub start--------
82B32E   LDA #$1F                 
82B330   STA $3E                  
82B332   LDA $8AE520,X            
82B336   STA $1E00,Y              
82B339   DEX                      
82B33A   DEY                      
82B33B   DEC $3E                  
82B33D   BPL $82B332              
82B33F   DEC $3D                  
82B341   BPL $82B324              
82B343   RTS                      
----------------         
--------sub start--------
82B344   LDX $02                  
82B346   JMP ($B349,X)            
--------data--------     
82B349  .db $4F $B3 $6C $B3      
----------------         
--------unidentified--------
82B34D  .db $58 $B3              
----------------         
82B34F   LDA #$02                 
82B351   STA $02                  
82B353   STZ $0F                  
82B355   STZ $3F                  
82B357   RTS                      
----------------         
--------unidentified--------
82B358  .db $A9 $02 $8D $A8 $00 $22 $74 $85
82B360  .db $80 $60              
----------------         
82B362   LDA #$03                 
82B364   STA $00A8                
82B367   JSL $808574              
82B36B   RTS                      
----------------         
82B36C   LDA $0048                
82B36F   BIT #$10                 
82B371   BNE $82B358              
82B373   AND #$C0                 
82B375   ORA $0049                
82B378   BIT #$C0                 
82B37A   BNE $82B362              
82B37C   LDX $03                  
82B37E   JMP ($B381,X)            
--------data--------     
82B381  .db $89 $B3 $A2 $B3 $CD $B3 $E5 $B3
----------------         
82B389   LDA #$02                 
82B38B   STA $03                  
82B38D   LDA $00B2                
82B390   ASL                      
82B391   TAX                      
82B392   REP #$20                 
82B394   LDA $8BE847,X            
82B398   STA $12                  
82B39A   LDA #$4E44               
82B39D   STA $14                  
82B39F   SEP #$20                 
82B3A1   RTS                      
----------------         
82B3A2   JSR $AD85                
82B3A5   BEQ $82B3C4              
82B3A7   BPL $82B3CC              
82B3A9   DEC                      
82B3AA   BMI $82B3BD              
82B3AC   REP #$21                 
82B3AE   LDA $14                  
82B3B0   AND #$FFE0               
82B3B3   ADC #$0044               
82B3B6   STA $14                  
82B3B8   INC $12                  
82B3BA   SEP #$20                 
82B3BC   RTS                      
----------------         
82B3BD   LDA #$04                 
82B3BF   STA $03                  
82B3C1   STZ $16                  
82B3C3   RTS                      
----------------         
82B3C4   LDA #$06                 
82B3C6   STA $03                  
82B3C8   LDA #$00                 
82B3CA   STA $16                  
82B3CC   RTS                      
----------------         
82B3CD   DEC $16                  
82B3CF   BNE $82B3E4              
82B3D1   LDA #$02                 
82B3D3   STA $03                  
82B3D5   JSL $808574              
82B3D9   REP #$20                 
82B3DB   LDA #$4E44               
82B3DE   STA $14                  
82B3E0   INC $12                  
82B3E2   SEP #$20                 
82B3E4   RTS                      
----------------         
82B3E5   DEC $16                  
82B3E7   BNE $82B3F0              
82B3E9   JSL $808574              
82B3ED   INC $00A8                
82B3F0   RTS                      
----------------         
--------unidentified--------
82B3F1  .db $A6 $02 $FC $08 $B4 $20 $B9 $B6
82B3F9  .db $0B $A9 $00 $EB $A9 $00 $5B $A9
82B401  .db $05 $22 $8E $AF $80 $2B $60 $0C
82B409  .db $B4 $8E $B4 $A9 $02 $85 $02 $A2
82B411  .db $20 $BF $20 $E4 $8A $9D $00 $1E
82B419  .db $CA $D0 $F6 $A9 $12 $8D $00 $1E
82B421  .db $8D $00 $1E $20 $C0 $B7 $A9 $06
82B429  .db $A2 $20 $20 $91 $B7 $A9 $0B $20
82B431  .db $91 $B7 $A9 $0C $20 $91 $B7 $A9
82B439  .db $0D $20 $91 $B7 $A9 $0E $20 $91
82B441  .db $B7 $A9 $10 $20 $91 $B7 $A9 $11
82B449  .db $20 $91 $B7 $A9 $13 $20 $91 $B7
82B451  .db $A9 $14 $20 $91 $B7 $A9 $00 $85
82B459  .db $3D $20 $86 $B7 $64 $3E $20 $52
82B461  .db $B7 $A2 $20 $86 $35 $64 $3F $64
82B469  .db $30 $AF $04 $FF $7F $85 $33 $AF
82B471  .db $05 $FF $7F $85 $31 $20 $B1 $B6
82B479  .db $AF $06 $FF $7F $85 $34 $AF $07
82B481  .db $FF $7F $85 $32 $AF $03 $FF $7F
82B489  .db $85 $36 $4C $23 $B6 $AD $48 $00
82B491  .db $89 $08 $F0 $15 $C6 $3F $A2 $20
82B499  .db $20 $B1 $B6 $A5 $33 $85 $38 $A9
82B4A1  .db $20 $C2 $10 $A2 $56 $02 $20 $4D
82B4A9  .db $B5 $AD $48 $00 $89 $24 $F0 $15
82B4B1  .db $E6 $3F $A5 $33 $85 $38 $A9 $20
82B4B9  .db $C2 $10 $A2 $56 $02 $20 $4D $B5
82B4C1  .db $A2 $20 $20 $B1 $B6 $A5 $3F $C9
82B4C9  .db $00 $10 $04 $A9 $05 $85 $3F $C9
82B4D1  .db $06 $90 $04 $A9 $00 $85 $3F $A9
82B4D9  .db $05 $85 $37 $A2 $20 $A5 $37 $C9
82B4E1  .db $05 $D0 $02 $A2 $2C $C5 $3F $D0
82B4E9  .db $02 $A2 $24 $20 $91 $B7 $C6 $37
82B4F1  .db $10 $E9 $A5 $3F $0A $AA $7C $FA
82B4F9  .db $B4 $06 $B5 $99 $B6 $8A $B5 $DE
82B501  .db $B5 $23 $B6 $8A $B6 $AD $48 $00
82B509  .db $89 $02 $F0 $02 $C6 $33 $AD $48
82B511  .db $00 $89 $01 $F0 $02 $E6 $33 $A5
82B519  .db $33 $10 $04 $A9 $03 $85 $33 $C9
82B521  .db $04 $90 $04 $A9 $00 $85 $33 $A2
82B529  .db $24 $A9 $16 $20 $91 $B7 $A5 $33
82B531  .db $85 $38 $8A $C2 $10 $A2 $56 $02
82B539  .db $20 $4D $B5 $A5 $33 $C5 $2F $F0
82B541  .db $0A $85 $2F $8F $04 $FF $7F $22
82B549  .db $59 $B6 $82 $60 $9F $01 $E8 $7F
82B551  .db $A9 $00 $EB $A5 $38 $A8 $B9 $4C
82B559  .db $C5 $9F $00 $E8 $7F $C2 $21 $8A
82B561  .db $69 $82 $00 $AA $A9 $00 $00 $E2
82B569  .db $20 $A5 $38 $0A $A8 $B9 $50 $C5
82B571  .db $9F $00 $E8 $7F $C8 $B9 $50 $C5
82B579  .db $9F $80 $E8 $7F $A9 $20 $9F $01
82B581  .db $E8 $7F $9F $41 $E8 $7F $E2 $10
82B589  .db $60 $A9 $09 $A2 $20 $20 $91 $B7
82B591  .db $AD $48 $00 $89 $02 $F0 $0F $20
82B599  .db $BB $B7 $22 $2F $9A $80 $C6 $3D
82B5A1  .db $10 $04 $A9 $12 $85 $3D $AD $48
82B5A9  .db $00 $89 $01 $F0 $12 $20 $BB $B7
82B5B1  .db $22 $2F $9A $80 $A5 $3D $1A $85
82B5B9  .db $3D $C9 $13 $90 $02 $64 $3D $AD
82B5C1  .db $48 $00 $0D $49 $00 $89 $C0 $F0
82B5C9  .db $0D $A9 $24 $85 $35 $A5 $3D $18
82B5D1  .db $69 $10 $22 $B2 $99 $80 $A5 $3D
82B5D9  .db $A6 $35 $4C $86 $B7 $AD $48 $00
82B5E1  .db $0D $49 $00 $89 $C0 $F0 $07 $A5
82B5E9  .db $3E $1A $22 $53 $9A $80 $A9 $0A
82B5F1  .db $A2 $20 $20 $91 $B7 $AD $48 $00
82B5F9  .db $89 $02 $F0 $06 $C6 $3E $22 $29
82B601  .db $9A $80 $AD $48 $00 $89 $01 $F0
82B609  .db $06 $E6 $3E $22 $29 $9A $80 $A5
82B611  .db $3E $10 $04 $A9 $30 $85 $3E $C9
82B619  .db $31 $90 $02 $64 $3E $A5 $3E $4C
82B621  .db $52 $B7 $AD $48 $00 $89 $03 $F0
82B629  .db $0F $A5 $36 $1A $29 $01 $85 $36
82B631  .db $8F $03 $FF $7F $22 $59 $B6 $82
82B639  .db $A2 $08 $86 $3A $CA $86 $3B $A5
82B641  .db $36 $D0 $07 $A2 $07 $86 $3A $E8
82B649  .db $86 $3B $A5 $3A $A2 $24 $20 $91
82B651  .db $B7 $A5 $3B $A2 $20 $4C $91 $B7
----------------         
--------sub start--------
82B659   LDA $7FFF01              
82B65D   STA $00C3                
82B660   LDA $7FFF04              
82B664   STA $1A50                
82B667   LDA $7FFF05              
82B66B   STA $1A51                
82B66E   LDA $7FFF06              
82B672   STA $1A52                
82B675   LDA $7FFF07              
82B679   STA $1A53                
82B67C   LDA $7FFF03              
82B680   STA $1A54                
82B683   CLC                      
82B684   ADC #$F7                 
82B686   JMP PlaySFX ;$809A53 ;JMP ??
--------unidentified--------
82B68A  .db $AD $48 $00 $89 $90 $F0 $07 $22
82B692  .db $35 $9A $80 $EE $A8 $00 $60 $AD
82B69A  .db $48 $00 $89 $03 $F0 $0F $A5 $31
82B6A2  .db $1A $29 $01 $85 $31 $8F $05 $FF
82B6AA  .db $7F $22 $59 $B6 $82 $A2 $24 $A5
82B6B2  .db $31 $18 $69 $17 $4C $91 $B7 $AD
82B6BA  .db $4E $00 $89 $0C $F0 $02 $C6 $30
82B6C2  .db $A5 $30 $4A $B0 $52 $A9 $0E $A2
82B6CA  .db $20 $20 $91 $B7 $A5 $32 $18 $69
82B6D2  .db $19 $20 $91 $B7 $AD $4E $00 $89
82B6DA  .db $02 $F0 $02 $C6 $34 $89 $01 $F0
82B6E2  .db $02 $E6 $34 $A5 $34 $10 $04 $A9
82B6EA  .db $03 $85 $34 $C9 $04 $90 $04 $A9
82B6F2  .db $00 $85 $34 $85 $38 $A9 $24 $C2
82B6FA  .db $10 $A2 $72 $02 $20 $4D $B5 $A2
82B702  .db $24 $A9 $16 $20 $91 $B7 $A5 $34
82B70A  .db $C5 $2E $F0 $0A $85 $2E $8F $06
82B712  .db $FF $7F $22 $59 $B6 $82 $60 $A2
82B71A  .db $20 $A9 $16 $20 $91 $B7 $A5 $34
82B722  .db $85 $38 $8A $C2 $10 $A2 $72 $02
82B72A  .db $20 $4D $B5 $AD $4E $00 $89 $03
82B732  .db $F0 $0F $A5 $32 $1A $29 $01 $85
82B73A  .db $32 $8F $07 $FF $7F $22 $59 $B6
82B742  .db $82 $A5 $32 $18 $69 $19 $A2 $24
82B74A  .db $20 $91 $B7 $A9 $0E $4C $91 $B7
82B752  .db $C2 $10 $A2 $1C $05 $A9 $20 $9F
82B75A  .db $01 $E8 $7F $9F $03 $E8 $7F $A9
82B762  .db $FF $85 $40 $A5 $3E $1A $85 $41
82B76A  .db $E6 $40 $38 $E9 $0A $10 $F7 $A5
82B772  .db $41 $18 $69 $30 $9F $02 $E8 $7F
82B77A  .db $A5 $40 $18 $69 $30 $9F $00 $E8
82B782  .db $7F $E2 $10 $60 $86 $39 $0A $AA
82B78A  .db $C2 $10 $BC $59 $DB $80 $09 $86
82B792  .db $39 $0A $AA $C2 $10 $BC $23 $DB
82B79A  .db $BE $00 $00 $B9 $02 $00 $85 $38
82B7A2  .db $B9 $03 $00 $9F $00 $E8 $7F $E8
82B7AA  .db $A5 $39 $9F $00 $E8 $7F $E8 $C8
82B7B2  .db $C6 $38 $D0 $EC $E2 $10 $A6 $39
82B7BA  .db $60 $A9 $20 $85 $35 $60 $A9 $00
82B7C2  .db $8F $00 $E8 $7F $8B $C2 $30 $A2
82B7CA  .db $00 $E8 $A0 $00 $E8 $C8 $A9 $FE
82B7D2  .db $07 $54 $7F $7F $E2 $30 $AB $60
----------------         
--------sub start--------
82B7DA   LDX $02                  
82B7DC   JMP ($B7DF,X)            
--------data--------     
82B7DF  .db $E3 $B7 $0D $B8      
----------------         
82B7E3   LDA #$02                 
82B7E5   STA $02                  
82B7E7   STA $01                  
82B7E9   LDA #$10                 
82B7EB   STA $0F                  
82B7ED   LDA $00B6                
82B7F0   ASL                      
82B7F1   TAX                      
82B7F2   LDA $C55C,X              
82B7F5   STA $11                  
82B7F7   LDA $C55D,X              
82B7FA   STA $14                  
82B7FC   LDA #$35                 
82B7FE   STA $1B                  
82B800   STZ $1A                  
82B802   STZ $0E                  
82B804   LDA #$C5                 
82B806   LDY #$58                 
82B808   JSL $8089A3              
82B80C   RTS                      
----------------         
82B80D   LDX $03                  
82B80F   JMP ($B812,X)            
--------data--------     
82B812  .db $16 $B8 $2E $B8      
----------------         
82B816   LDA $00AF                
82B819   BEQ $82B82D              
82B81B   DEC $0F                  
82B81D   BNE $82B82D              
82B81F   LDA #$02                 
82B821   STA $03                  
82B823   LDA #$03                 
82B825   JSL PlaySFX ;$809A53
82B829   LDA #$F0                 
82B82B   STA $0F                  
82B82D   RTS                      
----------------         
82B82E   JSL $8088CE              
82B832   DEC $0F                  
82B834   BNE $82B83A              
82B836   INC $00A8                
82B839   RTS                      
----------------         
--------sub start--------
82B83A   LDA $00BD                
82B83D   BIT #$01                 
82B83F   BEQ $82B84D              
82B841   LDA $0049                
82B844   AND #$C0                 
82B846   ORA $0048                
82B849   BIT #$D0                 
82B84B   BNE $82B860              
82B84D   LDA $00BD                
82B850   BIT #$02                 
82B852   BEQ $82B863              
82B854   LDA $004F                
82B857   AND #$C0                 
82B859   ORA $004E                
82B85C   BIT #$D0                 
82B85E   BEQ $82B863              
82B860   INC $00A8                
82B863   RTS                      
----------------         
--------sub start--------
82B864   STZ $00                  
82B866   LDX #$00                 
82B868   REP #$10                 
82B86A   TXY                      
82B86B   STX $02                  
82B86D   BRA $82B883              
82B86F   LDA $00                  
82B871   AND #$03                 
82B873   ASL                      
82B874   ASL                      
82B875   STA $02                  
82B877   REP #$21                 
82B879   TYA                      
82B87A   INC                      
82B87B   AND #$0003               
82B87E   ADC $02                  
82B880   TAY                      
82B881   SEP #$20                 
82B883   LDA $C566,Y              
82B886   STA $7FE800,X            
82B88A   LDA #$18                 
82B88C   STA $7FE801,X            
82B890   LDA $00                  
82B892   CMP #$09                 
82B894   BCC $82B8AD              
82B896   CMP #$15                 
82B898   BCS $82B8AD              
82B89A   REP #$20                 
82B89C   TXA                      
82B89D   AND #$003F               
82B8A0   CMP #$000E               
82B8A3   BNE $82B8AB              
82B8A5   TXA                      
82B8A6   CLC                      
82B8A7   ADC #$0020               
82B8AA   TAX                      
82B8AB   SEP #$20                 
82B8AD   INX                      
82B8AE   INX                      
82B8AF   TXA                      
82B8B0   AND #$3F                 
82B8B2   BNE $82B877              
82B8B4   LDA $00                  
82B8B6   INC $00                  
82B8B8   CMP #$1B                 
82B8BA   BNE $82B86F              
82B8BC   SEP #$10                 
82B8BE   RTL                      
----------------         
--------sub start--------
82B8BF   LDX $02                  
82B8C1   JMP ($B8C4,X)            
--------data--------     
82B8C4  .db $CC $B8              
----------------         
--------unidentified--------
82B8C6  .db $07 $B9 $83 $B9      
----------------         
--------data--------     
82B8CA  .db $97 $B9              
----------------         
82B8CC   LDA $00CC                
82B8CF   BNE $82B8E3              
82B8D1   LDA #$06                 
82B8D3   STA $02                  
82B8D5   LDA #$0D                 
82B8D7   JSL $8086C4              
82B8DB   LDA #$D0                 
82B8DD   STA $40                  
82B8DF   STZ $00A9                
82B8E2   RTS                      
----------------         
--------unidentified--------
82B8E3  .db $A9 $02 $85 $02 $A9 $36 $18 $6D
82B8EB  .db $CC $00 $22 $46 $87 $80 $A9 $28
82B8F3  .db $22 $C4 $86 $80 $A9 $29 $22 $C4
82B8FB  .db $86 $80 $A9 $01 $8D $A9 $00 $64
82B903  .db $3F $4C $67 $B9 $AD $49 $00 $29
82B90B  .db $C0 $0D $48 $00 $89 $D0 $F0 $2E
82B913  .db $A2 $02 $A9 $04 $85 $02 $A9 $1E
82B91B  .db $AC $A9 $00 $F0 $0E $8E $A9 $00
82B923  .db $1A $22 $46 $87 $80 $A9 $35 $18
82B92B  .db $6D $CC $00 $22 $46 $87 $80 $A9
82B933  .db $03 $22 $53 $9A $80 $AD $78 $00
82B93B  .db $49 $40 $8D $78 $00 $60 $AD $4F
82B943  .db $00 $29 $C0 $0D $4E $00 $89 $D0
82B94B  .db $F0 $04 $A2 $04 $80 $C4 $AD $48
82B953  .db $00 $0D $4E $00 $89 $2C $F0 $0C
82B95B  .db $CE $A9 $00 $A9 $06 $22 $53 $9A
82B963  .db $80 $20 $38 $B9 $AD $A9 $00 $29
82B96B  .db $01 $8D $A9 $00 $18 $69 $1C $22
82B973  .db $46 $87 $80 $A9 $1A $AC $A9 $00
82B97B  .db $F0 $01 $1A $22 $46 $87 $80 $60
82B983  .db $E6 $3F $A5 $3F $C9 $06 $F0 $EB
82B98B  .db $C9 $28 $D0 $07 $22 $35 $9A $80
82B993  .db $EE $A8 $00 $60      
----------------         
82B997   LDA $0049                
82B99A   AND #$C0                 
82B99C   ORA $0048                
82B99F   BIT #$D0                 
82B9A1   BNE $82B9A7              
82B9A3   DEC $40                  
82B9A5   BNE $82B9AA              
82B9A7   INC $00A8                
82B9AA   RTS                      
----------------         
--------sub start--------
82B9AB   LDX $02                  
82B9AD   JMP ($B9B0,X)            
--------data--------     
82B9B0  .db $B8 $B9 $26 $BA $64 $BB $68 $BB
----------------         
82B9B8   LDA $0B                  
82B9BA   BEQ $82B9C3              
82B9BC   LDA #$06                 
82B9BE   STA $02                  
82B9C0   JMP $BB68                
82B9C3   LDA #$02                 
82B9C5   STA $02                  
82B9C7   STZ $3C                  
82B9C9   LDA $00B6                
82B9CC   STA $3F                  
82B9CE   ASL                      
82B9CF   ASL                      
82B9D0   TAX                      
82B9D1   LDA $C5A4,X              
82B9D4   STA $3D                  
82B9D6   LDA $3F                  
82B9D8   STA $00F8                
82B9DB   ASL                      
82B9DC   ASL                      
82B9DD   STA $3E                  
82B9DF   TAX                      
82B9E0   LDA $C5A5,X              
82B9E3   JSL $80ADB0              
82B9E7   LDA #$94                 
82B9E9   STA $0010                
82B9EC   LDA #$E1                 
82B9EE   STA $0011                
82B9F1   LDX $3E                  
82B9F3   LDA $C5A2,X              
82B9F6   JSL $808D05              
82B9FA   LDA #$0C                 
82B9FC   JSL $80AF8E              
82BA00   LDA #$15                 
82BA02   STA $0080                
82BA05   LDA #$94                 
82BA07   STA $0010                
82BA0A   LDA #$E9                 
82BA0C   STA $0011                
82BA0F   LDX $3E                  
82BA11   LDA $C5A3,X              
82BA14   BEQ $82BA25              
82BA16   JSL $808D05              
--------unidentified--------
82BA1A  .db $A9 $0D $22 $8E $AF $80 $A9 $17
82BA22  .db $8D $80 $00          
----------------         
82BA25   RTS                      
----------------         
82BA26   STZ $30                  
82BA28   JSR $BBA0                
82BA2B   LDA $30                  
82BA2D   BNE $82BA34              
82BA2F   LDX $03                  
82BA31   JMP ($BA3C,X)            
82BA34   DEC                      
82BA35   BEQ $82BA39              
82BA37   INC $3C                  
82BA39   JMP $BAC0                
--------data--------     
82BA3C  .db $44 $BA $4E $BA      
----------------         
--------unidentified--------
82BA40  .db $EE $BA $03 $BB      
----------------         
82BA44   LDA $00AF                
82BA47   BEQ $82BA4D              
82BA49   LDA #$02                 
82BA4B   STA $03                  
82BA4D   RTS                      
----------------         
82BA4E   LDX $04                  
82BA50   JMP ($BA53,X)            
--------data--------     
82BA53  .db $5B $BA $73 $BA      
----------------         
--------unidentified--------
82BA57  .db $9E $BA $B6 $BA      
----------------         
82BA5B   LDA #$02                 
82BA5D   STA $04                  
82BA5F   LDA $3F                  
82BA61   ASL                      
82BA62   TAX                      
82BA63   REP #$20                 
82BA65   LDA $8BE84F,X            
82BA69   STA $12                  
82BA6B   LDA #$4E44               
82BA6E   STA $14                  
82BA70   SEP #$20                 
82BA72   RTS                      
----------------         
82BA73   JSR $AD85                
82BA76   BEQ $82BA95              
82BA78   BPL $82BA9D              
82BA7A   DEC                      
82BA7B   BMI $82BA8E              
82BA7D   REP #$21                 
82BA7F   LDA $14                  
82BA81   AND #$FFE0               
82BA84   ADC #$0044               
82BA87   STA $14                  
82BA89   INC $12                  
82BA8B   SEP #$20                 
82BA8D   RTS                      
----------------         
--------unidentified--------
82BA8E  .db $A9 $04 $85 $04 $64 $16 $60 $A9
82BA96  .db $06 $85 $04 $A9 $00 $85 $16
----------------         
82BA9D   RTS                      
----------------         
--------unidentified--------
82BA9E  .db $C6 $16 $D0 $13 $A9 $02 $85 $04
82BAA6  .db $22 $74 $85 $80 $C2 $20 $A9 $44
82BAAE  .db $4E $85 $14 $E6 $12 $E2 $20 $60
82BAB6  .db $C6 $16 $D0 $18 $A5 $3F $C9 $05
82BABE  .db $F0 $23              
----------------         
82BAC0   JSL $808574              
82BAC4   LDA $3C                  
82BAC6   BNE $82BACE              
82BAC8   INC $3F                  
82BACA   DEC $3D                  
82BACC   BNE $82BAD3              
82BACE   LDA #$04                 
82BAD0   STA $02                  
82BAD2   RTS                      
----------------         
--------unidentified--------
82BAD3  .db $A9 $04 $85 $03 $64 $04 $A9 $01
82BADB  .db $8D $AE $00 $22 $74 $95 $80 $60
82BAE3  .db $A9 $06 $85 $03 $64 $04 $22 $74
82BAEB  .db $85 $80 $60 $AD $AF $00 $D0 $36
82BAF3  .db $64 $03 $64 $04 $A9 $01 $8D $AE
82BAFB  .db $00 $22 $5E $95 $80 $4C $D6 $B9
82BB03  .db $A6 $04 $7C $08 $BB $10 $BB $2A
82BB0B  .db $BB $38 $BB $56 $BB $A9 $02 $85
82BB13  .db $04 $64 $2D $A5 $2D $29 $FC $4A
82BB1B  .db $AA $BD $9A $C5 $85 $2E $BD $9B
82BB23  .db $C5 $85 $2F $9C $70 $00 $60 $C6
82BB2B  .db $2E $D0 $09 $A9 $04 $85 $04 $A9
82BB33  .db $0F $8D $70 $00 $60 $C6 $2F $D0
82BB3B  .db $FB $E6 $2D $A5 $2D $C9 $10 $B0
82BB43  .db $06 $A9 $02 $85 $04 $80 $CC $A9
82BB4B  .db $06 $85 $04 $9C $70 $00 $A9 $10
82BB53  .db $85 $2E $60 $C6 $2E $D0 $FB $A9
82BB5B  .db $04 $85 $03 $E6 $3F $C6 $3D $80
82BB63  .db $8F                  
----------------         
82BB64   INC $00A8                
82BB67   RTS                      
----------------         
82BB68   LDA $00F8                
82BB6B   CMP #$03                 
82BB6D   BNE $82BB9F              
82BB6F   LDA $03                  
82BB71   BNE $82BB9B              
82BB73   INC $03                  
82BB75   INC $01                  
82BB77   LDA #$40                 
82BB79   STA $1A                  
82BB7B   LDA #$35                 
82BB7D   LDX $0B                  
82BB7F   CPX #$02                 
82BB81   BEQ $82BB85              
82BB83   LDA #$37                 
82BB85   STA $1B                  
82BB87   LDA $C594,X              
82BB8A   STA $11                  
82BB8C   LDA $C595,X              
82BB8F   STA $14                  
82BB91   LDY $C57C,X              
82BB94   LDA $C57D,X              
82BB97   JSL $8089A3              
--------unidentified--------
82BB9B  .db $22 $CE $88 $80      
----------------         
82BB9F   RTS                      
----------------         
--------sub start--------
82BBA0   LDA $00BD                
82BBA3   BIT #$01                 
82BBA5   BEQ $82BBB5              
82BBA7   LDA $0048                
82BBAA   BIT #$10                 
82BBAC   BNE $82BBCF              
82BBAE   ORA $0049                
82BBB1   BIT #$C0                 
82BBB3   BNE $82BBCA              
82BBB5   LDA $00BD                
82BBB8   BIT #$02                 
82BBBA   BEQ $82BBCE              
82BBBC   LDA $004E                
82BBBF   BIT #$10                 
82BBC1   BNE $82BBCF              
82BBC3   ORA $004F                
82BBC6   BIT #$C0                 
82BBC8   BEQ $82BBCE              
82BBCA   LDA #$01                 
82BBCC   STA $30                  
82BBCE   RTS                      
----------------         
--------unidentified--------
82BBCF  .db $A9 $02 $85 $30 $60 $A6 $02 $7C
82BBD7  .db $D9 $BB $E1 $BB $F5 $BB $6A $BC
82BBDF  .db $76 $BC $A5 $0B $D0 $09 $A9 $02
82BBE7  .db $85 $02 $A9 $1E $85 $30 $60 $A9
82BBEF  .db $06 $85 $02 $4C $76 $BC $A6 $03
82BBF7  .db $7C $FA $BB $00 $BC $21 $BC $52
82BBFF  .db $BC $C6 $30 $D0 $1C $AD $B2 $00
82BC07  .db $0A $AA $C2 $20 $BF $67 $E8 $8B
82BC0F  .db $85 $12 $A9 $44 $4E $85 $14 $E2
82BC17  .db $20 $A9 $02 $85 $03 $A9 $01 $85
82BC1F  .db $31 $60 $C6 $31 $D0 $2C $A9 $01
82BC27  .db $85 $31 $20 $85 $AD $F0 $1D $10
82BC2F  .db $21 $3A $30 $11 $C2 $21 $A5 $14
82BC37  .db $29 $E0 $FF $69 $44 $00 $85 $14
82BC3F  .db $E6 $12 $E2 $20 $60 $A9 $04 $85
82BC47  .db $03 $64 $30 $60 $A9 $04 $85 $02
82BC4F  .db $64 $30 $60 $C6 $30 $D0 $13 $A9
82BC57  .db $02 $85 $03 $22 $74 $85 $80 $C2
82BC5F  .db $20 $A9 $44 $4E $85 $14 $E6 $12
82BC67  .db $E2 $20 $60 $C6 $30 $D0 $07 $22
82BC6F  .db $74 $85 $80 $EE $A8 $00 $60 $A6
82BC77  .db $03 $7C $7B $BC $81 $BC $C7 $BC
82BC7F  .db $D3 $BC $A5 $0B $4A $3A $85 $0B
82BC87  .db $AD $B2 $00 $A8 $0A $05 $0B $AA
82BC8F  .db $BD $BE $C5 $30 $3C $85 $0B $A9
82BC97  .db $02 $C0 $02 $D0 $02 $A9 $04 $85
82BC9F  .db $03 $E6 $01 $64 $0E $A9 $40 $85
82BCA7  .db $1A $A5 $0B $4A $AA $BD $C6 $C5
82BCAF  .db $85 $1B $A6 $0B $BD $CA $C5 $85
82BCB7  .db $11 $BD $CB $C5 $85 $14 $BC $D2
82BCBF  .db $C5 $BD $D3 $C5 $22 $A3 $89 $80
82BCC7  .db $22 $A9 $89 $80 $22 $CE $88 $80
82BCCF  .db $60 $64 $00 $60 $A6 $04 $FC $E1
82BCD7  .db $BC $22 $A9 $89 $80 $22 $CE $88
82BCDF  .db $80 $60 $E7 $BC $F6 $BC $1F $BD
82BCE7  .db $A5 $0B $85 $04 $64 $32 $A9 $05
82BCEF  .db $85 $33 $A9 $07 $85 $34 $60 $C2
82BCF7  .db $20 $A5 $32 $F0 $05 $C6 $32 $E2
82BCFF  .db $20 $60 $E2 $20 $A5 $14 $C9 $24
82BD07  .db $90 $15 $C2 $21 $A5 $13 $E9 $7F
82BD0F  .db $01 $85 $13 $E2 $20 $C6 $34 $D0
82BD17  .db $06 $A9 $14 $85 $32 $80 $D3 $60
82BD1F  .db $C2 $20 $A5 $32 $F0 $05 $C6 $32
82BD27  .db $E2 $20 $60 $E2 $20 $A5 $06 $C9
82BD2F  .db $10 $D0 $08 $A9 $C6 $A0 $10 $22
82BD37  .db $A3 $89 $80 $60      
----------------         
--------sub start--------
82BD3B   LDX $02                  
82BD3D   JMP ($BD40,X)            
--------data--------     
82BD40  .db $48 $BD $CB $BD      
----------------         
--------unidentified--------
82BD44  .db $D1 $BD              
----------------         
--------data--------     
82BD46  .db $D5 $BD              
----------------         
82BD48   LDA $0B                  
82BD4A   CMP #$0A                 
82BD4C   BNE $82BD6F              
82BD4E   STZ $41                  
82BD50   LDA #$08                 
82BD52   STA $40                  
82BD54   LDA $00B6                
82BD57   CMP #$04                 
82BD59   BCC $82BD5D              
82BD5B   LDA #$03                 
82BD5D   INC                      
82BD5E   CMP $00C3                
82BD61   BCC $82BD6A              
82BD63   STA $00C3                
82BD66   STA $7FFF01              
82BD6A   LDA #$02                 
82BD6C   STA $02                  
82BD6E   RTS                      
----------------         
82BD6F   LDA $00B6                
82BD72   CMP #$04                 
82BD74   BNE $82BD7B              
82BD76   JSL $808F1E              
--------unidentified--------
82BD7A  .db $60                  
----------------         
82BD7B   LDA #$06                 
82BD7D   STA $02                  
82BD7F   STA $01                  
82BD81   LDX $0B                  
82BD83   LDA $C668,X              
82BD86   STA $0010                
82BD89   LDA $C669,X              
82BD8C   STA $0011                
82BD8F   LDX #$00                 
82BD91   JSL $808E7E              
82BD95   LDA #$34                 
82BD97   STA $1B                  
82BD99   STZ $1A                  
82BD9B   STZ $0E                  
82BD9D   LDA $00B6                
82BDA0   ASL                      
82BDA1   ASL                      
82BDA2   ADC $00B6                
82BDA5   STA $3F                  
82BDA7   LDA $0B                  
82BDA9   LSR                      
82BDAA   ADC $3F                  
82BDAC   TAY                      
82BDAD   LDA $C67F,Y              
82BDB0   ASL                      
82BDB1   TAX                      
82BDB2   LDY $C4C1,X              
82BDB5   LDA $C4C2,X              
82BDB8   JSL $8089A3              
82BDBC   LDA $0B                  
82BDBE   ASL                      
82BDBF   ASL                      
82BDC0   ASL                      
82BDC1   ASL                      
82BDC2   ADC #$40                 
82BDC4   STA $11                  
82BDC6   LDA #$A3                 
82BDC8   STA $14                  
82BDCA   RTS                      
----------------         
82BDCB   JSR $B83A                
82BDCE   JMP $BF95                
--------unidentified--------
82BDD1  .db $EE $A8 $00 $60      
----------------         
82BDD5   JSL $8088CE              
82BDD9   RTS                      
----------------         
--------sub start--------
82BDDA   LDX $02                  
82BDDC   JMP ($BDDF,X)            
--------data--------     
82BDDF  .db $E5 $BD $62 $BE $EA $BE
----------------         
82BDE5   LDA #$04                 
82BDE7   STA $02                  
82BDE9   LDA $0B                  
82BDEB   BNE $82BE61              
82BDED   LDA #$02                 
82BDEF   STA $02                  
82BDF1   STZ $41                  
82BDF3   LDA #$08                 
82BDF5   STA $40                  
82BDF7   STZ $35                  
82BDF9   LDA $00C3                
82BDFC   ASL                      
82BDFD   ASL                      
82BDFE   ADC $00C3                
82BE01   TAY                      
82BE02   LDX #$00                 
82BE04   LDA $C67A,Y              
82BE07   STA $30,X                
82BE09   INX                      
82BE0A   INY                      
82BE0B   CPX #$05                 
82BE0D   BNE $82BE04              
82BE0F   STZ $36                  
82BE11   LDA #$40                 
82BE13   STA $37                  
82BE15   JSL $808F73              
82BE19   BCS $82BE4E              
82BE1B   LDA #$03                 
82BE1D   STA $0000,X              
82BE20   DEC                      
82BE21   STA $0001,X              
82BE24   LDA #$34                 
82BE26   STA $001B,X              
82BE29   STZ $001A,X              
82BE2C   STZ $000E,X              
82BE2F   LDA #$12                 
82BE31   STA $000A,X              
82BE34   STA $000B,X              
82BE37   LDA $36                  
82BE39   ADC #$30                 
82BE3B   STA $0030,X              
82BE3E   LDA $37                  
82BE40   STA $0011,X              
82BE43   LDA #$63                 
82BE45   STA $0014,X              
82BE48   REP #$20                 
82BE4A   TDC                      
82BE4B   STA $0031,X              
82BE4E   SEP #$31                 
82BE50   LDA $37                  
82BE52   ADC #$1F                 
82BE54   STA $37                  
82BE56   INC $36                  
82BE58   LDA $36                  
82BE5A   CMP #$05                 
82BE5C   BNE $82BE15              
82BE5E   JMP $BF6A                
82BE61   RTS                      
----------------         
82BE62   LDX $03                  
82BE64   JMP ($BE67,X)            
--------data--------     
82BE67  .db $6D $BE $CC $BE      
----------------         
--------unidentified--------
82BE6B  .db $D9 $BE              
----------------         
82BE6D   JSR $BF95                
82BE70   LDA $0049                
82BE73   AND #$C0                 
82BE75   ORA $0048                
82BE78   BIT #$D0                 
82BE7A   BEQ $82BE7F              
82BE7C   JMP $BF0A                
82BE7F   LDA $0048                
82BE82   BIT #$02                 
82BE84   BEQ $82BE90              
82BE86   DEC $35                  
82BE88   BPL $82BE9E              
82BE8A   LDA #$04                 
82BE8C   STA $35                  
82BE8E   BRA $82BE9E              
82BE90   BIT #$01                 
82BE92   BEQ $82BEA7              
82BE94   INC $35                  
82BE96   LDA $35                  
82BE98   CMP #$05                 
82BE9A   BCC $82BE9E              
82BE9C   STZ $35                  
82BE9E   LDA #$06                 
82BEA0   JSL PlaySFX ;$809A53
82BEA4   JMP $BF6A                
82BEA7   LDX $35                  
82BEA9   BIT #$08                 
82BEAB   BEQ $82BEB9              
82BEAD   INC $30,X                
82BEAF   LDA $30,X                
82BEB1   CMP #$04                 
82BEB3   BCC $82BEC5              
82BEB5   STZ $30,X                
82BEB7   BRA $82BEC5              
82BEB9   BIT #$04                 
82BEBB   BEQ $82BECB              
82BEBD   DEC $30,X                
82BEBF   BPL $82BEC5              
82BEC1   LDA #$03                 
82BEC3   STA $30,X                
82BEC5   LDA #$06                 
82BEC7   JSL PlaySFX ;$809A53
82BECB   RTS                      
----------------         
82BECC   DEC $39                  
82BECE   BNE $82BED8              
82BED0   INC $00A8                
82BED3   LDA #$01                 
82BED5   STA $00A9                
82BED8   RTS                      
----------------         
--------unidentified--------
82BED9  .db $C6 $39 $D0 $0C $A9 $33 $22 $67
82BEE1  .db $86 $80 $EE $A8 $00 $9C $A9 $00
82BEE9  .db $60                  
----------------         
82BEEA   REP #$31                 
82BEEC   LDA $30                  
82BEEE   AND #$00FF               
82BEF1   ADC $31                  
82BEF3   TAX                      
82BEF4   LDA $0000,X              
82BEF7   SEP #$30                 
82BEF9   ASL                      
82BEFA   TAX                      
82BEFB   LDA $C4C2,X              
82BEFE   LDY $C4C1,X              
82BF01   JSL $8089A3              
82BF05   JSL $8088CE              
82BF09   RTS                      
----------------         
82BF0A   LDY #$01                 
82BF0C   STY $3A                  
82BF0E   LDY #$05                 
82BF10   STY $36                  
82BF12   LDX #$00                 
82BF14   LDA $30,X                
82BF16   CMP $C67A,Y              
82BF19   BNE $82BF39              
82BF1B   INY                      
82BF1C   INX                      
82BF1D   CPX #$05                 
82BF1F   BNE $82BF14              
82BF21   LDA #$03                 
82BF23   JSL PlaySFX ;$809A53
82BF27   LDA #$02                 
82BF29   STA $03                  
82BF2B   LDA $3A                  
82BF2D   STA $00C3                
82BF30   STA $7FFF01              
82BF34   LDA #$28                 
82BF36   STA $39                  
82BF38   RTS                      
----------------         
82BF39   INC $3A                  
82BF3B   LDA $36                  
82BF3D   CLC                      
82BF3E   ADC #$05                 
82BF40   STA $36                  
82BF42   TAY                      
82BF43   CMP #$19                 
82BF45   BNE $82BF12              
82BF47   LDA #$1A                 
82BF49   JSL PlaySFX ;$809A53
--------unidentified--------
82BF4D  .db $A9 $32 $22 $67 $86 $80 $A9 $04
82BF55  .db $85 $03 $A9 $60 $85 $39 $A9 $FF
82BF5D  .db $20 $62 $BF $A9 $00 $85 $28 $A2
82BF65  .db $C5 $4C $20 $B2 $60  
----------------         
82BF6A   LDA #$4D                 
82BF6C   STA $0011                
82BF6F   LDA #$46                 
82BF71   STA $0010                
82BF74   STZ $36                  
82BF76   LDX #$00                 
82BF78   LDA $36                  
82BF7A   CMP $35                  
82BF7C   BNE $82BF80              
82BF7E   LDX #$20                 
82BF80   JSL $808E7E              
82BF84   LDA $0010                
82BF87   ADC #$04                 
82BF89   STA $0010                
82BF8C   INC $36                  
82BF8E   LDA $36                  
82BF90   CMP #$05                 
82BF92   BNE $82BF76              
82BF94   RTS                      
----------------         
--------sub start--------
82BF95   DEC $40                  
82BF97   BNE $82BFBD              
82BF99   LDA #$08                 
82BF9B   STA $40                  
82BF9D   INC $41                  
82BF9F   LDA $41                  
82BFA1   CMP #$04                 
82BFA3   BCC $82BFA7              
82BFA5   STZ $41                  
82BFA7   LDY $41                  
82BFA9   LDX $C672,Y              
82BFAC   LDA #$FF                 
82BFAE   STA $28                  
82BFB0   JSR $B220                
82BFB3   LDY $41                  
82BFB5   LDX $C676,Y              
82BFB8   STZ $28                  
82BFBA   JMP $B220                
82BFBD   RTS                      
----------------         
--------sub start--------
82BFBE   LDX $02                  
82BFC0   JMP ($BFC3,X)            
--------unidentified--------
82BFC3  .db $CB $BF $F0 $BF      
----------------         
--------data--------     
82BFC7  .db $AF $C0 $0E $C1      
----------------         
--------unidentified--------
82BFCB  .db $A9 $02 $85 $02 $A6 $0B $F0 $05
82BFD3  .db $A9 $06 $85 $02 $60 $9C $FC $00
82BFDB  .db $9C $FD $00 $64 $2A $64 $2B $A9
82BFE3  .db $9F $85 $34 $A9 $F9 $85 $35 $A9
82BFEB  .db $08 $85 $31 $64 $30 $C2 $21 $A5
82BFF3  .db $2A $69 $60 $00 $85 $2A $E2 $20
82BFFB  .db $EB $8D $7E $00 $A5 $2B $29 $07
82C003  .db $F0 $05 $64 $36 $4C $99 $C0 $A5
82C00B  .db $36 $F0 $03 $4C $99 $C0 $E6 $36
82C013  .db $C2 $31 $AD $7E $00 $69 $F0 $00
82C01B  .db $29 $FF $00 $0A $0A $85 $32 $0A
82C023  .db $AA $A0 $20 $00 $A9 $00 $00 $9F
82C02B  .db $00 $E8 $7F $E8 $E8 $88 $D0 $F7
82C033  .db $E2 $30 $E6 $30 $A5 $30 $C5 $31
82C03B  .db $D0 $5C $F4 $8B $83 $AB $C2 $31
82C043  .db $A4 $34 $B9 $00 $00 $29 $FF $00
82C04B  .db $65 $32 $0A $AA $C8 $E2 $20 $B9
82C053  .db $00 $00 $10 $05 $3A $30 $56 $80
82C05B  .db $3E $85 $32 $C8 $B9 $00 $00 $85
82C063  .db $37 $C8 $B9 $00 $00 $9F $00 $E8
82C06B  .db $7F $A5 $37 $9F $01 $E8 $7F $E8
82C073  .db $E8 $C8 $C6 $32 $D0 $EC $B9 $00
82C07B  .db $00 $10 $0B $A5 $2A $D0 $02 $A9
82C083  .db $FF $8D $FC $00 $A9 $26 $85 $31
82C08B  .db $64 $30 $C8 $84 $34 $E2 $10 $AB
82C093  .db $A9 $05 $22 $8E $AF $80 $60 $AD
82C09B  .db $FD $00 $D0 $09 $AD $C4 $00 $D0
82C0A3  .db $04 $A9 $0A $80 $B4 $E2 $30 $A9
82C0AB  .db $04 $85 $02 $AB      
----------------         
82C0AF   RTS                      
----------------         
--------unidentified--------
82C0B0  .db $EE $FD $00 $AD $F7 $00 $18 $69
82C0B8  .db $30 $9F $00 $E8 $7F $A9 $48 $9F
82C0C0  .db $02 $E8 $7F $A9 $4D $9F $0A $E8
82C0C8  .db $7F $A9 $53 $9F $12 $E8 $7F $5A
82C0D0  .db $A0 $02 $00 $B9 $F4 $00 $4A $4A
82C0D8  .db $4A $4A $18 $69 $30 $9F $06 $E8
82C0E0  .db $7F $B9 $F4 $00 $29 $0F $18 $69
82C0E8  .db $30 $9F $08 $E8 $7F $C2 $21 $8A
82C0F0  .db $69 $08 $00 $AA $E2 $20 $88 $D0
82C0F8  .db $DA $7A $A9 $07 $85 $32 $A9 $20
82C100  .db $9F $01 $E8 $7F $E8 $E8 $C6 $32
82C108  .db $D0 $F6 $C8 $4C $79 $C0
----------------         
82C10E   LDX $03                  
82C110   JMP ($C113,X)            
--------unidentified--------
82C113  .db $19 $C1 $65 $C1      
----------------         
--------data--------     
82C117  .db $77 $C1              
----------------         
--------unidentified--------
82C119  .db $AD $FC $00 $F0 $46 $A8 $C8 $D0
82C121  .db $02 $A9 $00 $85 $13 $A9 $02 $85
82C129  .db $03 $3A $85 $01 $64 $0E $A9 $5F
82C131  .db $AC $C4 $00 $F0 $02 $A9 $6F $85
82C139  .db $31 $A9 $F8 $85 $14 $A9 $01 $85
82C141  .db $15 $A9 $80 $85 $11 $64 $12 $64
82C149  .db $28 $64 $29 $A9 $A0 $85 $2A $A9
82C151  .db $FF $85 $2B $A9 $3D $85 $1B $A9
82C159  .db $40 $85 $1A $A0 $93 $A9 $C6 $22
82C161  .db $A3 $89 $80 $60 $22 $07 $C0 $80
82C169  .db $A5 $15 $D0 $0A $A5 $14 $C5 $31
82C171  .db $D0 $04 $A9 $04 $85 $03
----------------         
82C177   JSL $8088CE              
82C17B   RTS                      
----------------         
--------sub start--------
82C17C   PEA #$8382               
82C17F   PLB                      
82C180   LDA $B7                  
82C182   ASL                      
82C183   LDX $B6                  
82C185   ADC $C538,X              
82C188   TAX                      
82C189   REP #$10                 
82C18B   LDY $C538,X              
82C18E   LDA $0000,Y              
82C191   BEQ $82C1ED              
82C193   STA $00                  
82C195   STZ $01                  
82C197   INY                      
82C198   REP #$20                 
82C19A   LDA $0000,Y              
82C19D   AND #$00FF               
82C1A0   TAX                      
82C1A1   LDA $C1F1,X              
82C1A4   STA $04                  
82C1A6   LDA $C213,X              
82C1A9   STA $06                  
82C1AB   LDX $0001,Y              
82C1AE   STX $02                  
82C1B0   STZ $08                  
82C1B2   LDA $02                  
82C1B4   LSR                      
82C1B5   TAX                      
82C1B6   LDA $06                  
82C1B8   STA $1400,X              
82C1BB   LDA $04                  
82C1BD   LDX $02                  
82C1BF   STA $7FE000,X            
82C1C3   INC                      
82C1C4   STA $7FE002,X            
82C1C8   LDA $08                  
82C1CA   BNE $82C1E6              
82C1CC   TXA                      
82C1CD   CLC                      
82C1CE   ADC #$0040               
82C1D1   STA $02                  
82C1D3   LDA $04                  
82C1D5   CLC                      
82C1D6   ADC #$0002               
82C1D9   STA $04                  
82C1DB   LDA $06                  
82C1DD   ORA #$0404               
82C1E0   STA $06                  
82C1E2   INC $08                  
82C1E4   BRA $82C1B2              
82C1E6   INY                      
82C1E7   INY                      
82C1E8   INY                      
82C1E9   DEC $00                  
82C1EB   BNE $82C19A              
82C1ED   SEP #$30                 
82C1EF   PLB                      
82C1F0   RTL                      
----------------         
--------data--------     
82C1F1  .db $80 $1F $84 $1F      
----------------         
--------unidentified--------
82C1F5  .db $88 $1F $8C $1F      
----------------         
--------data--------     
82C1F9  .db $90 $1F              
----------------         
--------unidentified--------
82C1FB  .db $94 $1F $98 $1F $9C $1F $A0 $1F
82C203  .db $A4 $1F $A8 $1F $AC $1F
----------------         
--------data--------     
82C209  .db $B0 $1F $B4 $1F      
----------------         
--------unidentified--------
82C20D  .db $B8 $1F $BC $1F $C0 $1F
----------------         
--------data--------     
82C213  .db $B0 $B2 $B0 $B2      
----------------         
--------unidentified--------
82C217  .db $B0 $B2 $B0 $B2      
----------------         
--------data--------     
82C21B  .db $B0 $B2              
----------------         
--------unidentified--------
82C21D  .db $B1 $B3 $B0 $B2 $B0 $B2 $B0 $B2
82C225  .db $B0 $B2 $B0 $B2 $B1 $B3
----------------         
--------data--------     
82C22B  .db $B0 $B2 $A0 $A2      
----------------         
--------unidentified--------
82C22F  .db $A0 $A2 $A0 $A2 $A0 $A2
----------------         
--------sub start--------
82C235   LDA $B7                  
82C237   ASL                      
82C238   LDX $B6                  
82C23A   ADC $F303,X              
82C23D   TAY                      
82C23E   REP #$11                 
82C240   LDX $F303,Y              
82C243   LDA $0000,X              
82C246   BNE $82C24B              
82C248   JMP $C2CB                
82C24B   STA $0E                  
82C24D   LDA #$60                 
82C24F   STA $05                  
82C251   STX $10                  
82C253   STZ $03                  
82C255   LDA #$01                 
82C257   STA $02                  
82C259   LDA $0004,X              
82C25C   BIT #$20                 
82C25E   BEQ $82C266              
82C260   LDA #$20                 
82C262   STA $02                  
82C264   BRA $82C284              
82C266   AND #$0F                 
82C268   CMP #$0F                 
82C26A   BNE $82C284              
82C26C   LDY $0002,X              
82C26F   TYX                      
82C270   LDA $05                  
82C272   STA $001400,X            
82C276   STA $001401,X            
82C27A   STA $001420,X            
82C27E   STA $001421,X            
82C282   BRA $82C2BD              
82C284   LDA $0004,X              
82C287   AND #$3F                 
82C289   STA $06                  
82C28B   AND #$0F                 
82C28D   STA $04                  
82C28F   LDY $0002,X              
82C292   TYX                      
82C293   LDA $05                  
82C295   STA $001400,X            
82C299   LDA $06                  
82C29B   BIT #$10                 
82C29D   BEQ $82C2B1              
82C29F   BIT #$20                 
82C2A1   BNE $82C2AB              
82C2A3   LDA $05                  
82C2A5   STA $001420,X            
82C2A9   BRA $82C2B1              
--------unidentified--------
82C2AB  .db $A5 $05 $9F $01 $14 $00
----------------         
82C2B1   REP #$21                 
82C2B3   TXA                      
82C2B4   ADC $02                  
82C2B6   TAX                      
82C2B7   SEP #$21                 
82C2B9   DEC $04                  
82C2BB   BNE $82C293              
82C2BD   INC $05                  
82C2BF   LDX $10                  
82C2C1   INX                      
82C2C2   INX                      
82C2C3   INX                      
82C2C4   INX                      
82C2C5   INX                      
82C2C6   INX                      
82C2C7   DEC $0E                  
82C2C9   BNE $82C251              
82C2CB   SEP #$10                 
82C2CD   RTL                      
----------------         
--------sub start--------
82C2CE   PEA #$8380               
82C2D1   PLB                      
82C2D2   LDA $B7                  
82C2D4   ASL                      
82C2D5   LDX $B6                  
82C2D7   ADC $E760,X              
82C2DA   TAX                      
82C2DB   REP #$10                 
82C2DD   LDY $E760,X              
82C2E0   LDA $0000,Y              
82C2E3   BEQ $82C325              
82C2E5   INY                      
82C2E6   STA $00                  
82C2E8   LDX #$0200               
82C2EB   LDA #$03                 
82C2ED   STA $00,X                
82C2EF   LDA $0000,Y              
82C2F2   STA $0A,X                
82C2F4   LDA $0001,Y              
82C2F7   STA $0B,X                
82C2F9   LDA $0002,Y              
82C2FC   AND #$7F                 
82C2FE   STA $0D,X                
82C300   LDA $0002,Y              
82C303   AND #$80                 
82C305   ASL                      
82C306   ROL                      
82C307   STA $0C,X                
82C309   LDA $0003,Y              
82C30C   STA $11,X                
82C30E   LDA $0004,Y              
82C311   STA $14,X                
82C313   REP #$21                 
82C315   TXA                      
82C316   ADC #$0050               
82C319   TAX                      
82C31A   TYA                      
82C31B   ADC #$0005               
82C31E   TAY                      
82C31F   SEP #$20                 
82C321   DEC $00                  
82C323   BNE $82C2EB              
82C325   SEP #$10                 
82C327   PLB                      
82C328   RTL                      
----------------         
--------sub start--------
82C329   PEA #$8382               
82C32C   PLB                      
82C32D   LDX $B6                  
82C32F   LDA $C461,X              
82C332   CLC                      
82C333   ADC $B7                  
82C335   TAX                      
82C336   LDY $C461,X              
82C339   BEQ $82C3B0              
82C33B   LDA $C4D7,Y              
82C33E   REP #$31                 
82C340   AND #$00FF               
82C343   ADC #$C4D8               
82C346   TAY                      
82C347   SEP #$20                 
82C349   LDA $0000,Y              
82C34C   BEQ $82C3B0              
82C34E   STA $0E                  
82C350   LDA #$D0                 
82C352   STA $0C                  
82C354   INY                      
82C355   STZ $0B                  
82C357   LDA $0002,Y              
82C35A   STA $0A                  
82C35C   LDA #$00                 
82C35E   XBA                      
82C35F   LDA $0003,Y              
82C362   AND #$7F                 
82C364   LSR                      
82C365   LSR                      
82C366   LSR                      
82C367   TAX                      
82C368   LDA $1144,X              
82C36B   PHA                      
82C36C   LDA $0003,Y              
82C36F   AND #$07                 
82C371   TAX                      
82C372   PLA                      
82C373   AND $8380B8,X            
82C377   BEQ $82C38B              
82C379   STY $22                  
82C37B   LDX $0000,Y              
82C37E   STX $13                  
82C380   SEP #$10                 
82C382   JSR $C3BE                
--------unidentified--------
82C385  .db $C2 $10 $A4 $22 $80 $1B
----------------         
82C38B   REP #$21                 
82C38D   LDX $0A                  
82C38F   LDA $0000,Y              
82C392   ADC $C457,X              
82C395   TAX                      
82C396   SEP #$20                 
82C398   LDA $0C                  
82C39A   STA $1400,X              
82C39D   STA $1401,X              
82C3A0   STA $1420,X              
82C3A3   STA $1421,X              
82C3A6   INY                      
82C3A7   INY                      
82C3A8   INY                      
82C3A9   INY                      
82C3AA   INC $0C                  
82C3AC   DEC $0E                  
82C3AE   BNE $82C355              
82C3B0   SEP #$10                 
82C3B2   PLB                      
82C3B3   RTL                      
----------------         
--------sub start--------
82C3B4   PHD                      
82C3B5   PEA #$0000               
82C3B8   PLD                      
82C3B9   JSR $C3BE                
82C3BC   PLD                      
82C3BD   RTL                      
----------------         
--------sub start--------
82C3BE   LDA $0A                  
82C3C0   LSR                      
82C3C1   TAX                      
82C3C2   LDA $82C452,X            
82C3C6   LSR                      
82C3C7   LSR                      
82C3C8   LSR                      
82C3C9   LSR                      
82C3CA   STA $00                  
82C3CC   LDA $82C452,X            
82C3D0   AND #$0F                 
82C3D2   STA $02                  
82C3D4   STA $06                  
82C3D6   REP #$10                 
82C3D8   LDX $13                  
82C3DA   STX $1F                  
82C3DC   LDA $00                  
82C3DE   STA $04                  
82C3E0   LDA $7FF800,X            
82C3E4   STA $1400,X              
82C3E7   INX                      
82C3E8   DEC $04                  
82C3EA   BNE $82C3E0              
82C3EC   REP #$21                 
82C3EE   LDA $1F                  
82C3F0   ADC #$0020               
82C3F3   TAX                      
82C3F4   SEP #$20                 
82C3F6   DEC $06                  
82C3F8   BNE $82C3DA              
82C3FA   SEP #$10                 
82C3FC   STZ $01                  
82C3FE   LDA $00                  
82C400   ASL                      
82C401   STA $00                  
82C403   REP #$20                 
82C405   LDA $B6                  
82C407   CMP #$1802               
82C40A   BEQ $82C444              
82C40C   LDA $13                  
82C40E   CLC                      
82C40F   ADC #$4FE0               
82C412   STA $16                  
82C414   REP #$21                 
82C416   LDA $16                  
82C418   ADC #$0020               
82C41B   STA $16                  
82C41D   LDX $40                  
82C41F   STA $1801,X              
82C422   LDA $00                  
82C424   STA $1803,X              
82C427   LDA #$80A7               
82C42A   STA $1805,X              
82C42D   SEP #$20                 
82C42F   LDA #$09                 
82C431   STA $1800,X              
82C434   LDA #$83                 
82C436   STA $1807,X              
82C439   TXA                      
82C43A   CLC                      
82C43B   ADC #$08                 
82C43D   STA $40                  
82C43F   DEC $02                  
82C441   BNE $82C414              
82C443   RTS                      
----------------         
--------unidentified--------
82C444  .db $A9 $2E $58 $85 $10 $E2 $20 $A2
82C44C  .db $00 $22 $C7 $8D $80 $60
----------------         
--------data--------     
82C452  .db $44                  
----------------         
--------unidentified--------
82C453  .db $24 $42 $43 $34      
----------------         
--------data--------     
82C457  .db $41 $00              
----------------         
--------unidentified--------
82C459  .db $20 $00              
----------------         
--------data--------     
82C45B  .db $01 $00              
----------------         
--------unidentified--------
82C45D  .db $21 $00 $20 $00      
----------------         
--------data--------     
82C461  .db $05 $15 $25 $3F $5D $00 $00 $00
82C469  .db $00                  
----------------         
--------unidentified--------
82C46A  .db $00 $01              
----------------         
--------data--------     
82C46C  .db $00                  
----------------         
--------unidentified--------
82C46D  .db $00                  
----------------         
--------data--------     
82C46E  .db $02 $00              
----------------         
--------unidentified--------
82C470  .db $00 $00              
----------------         
--------data--------     
82C472  .db $03 $00 $00 $00 $00 $00 $00
----------------         
--------unidentified--------
82C479  .db $00 $00 $00 $00      
----------------         
--------data--------     
82C47D  .db $00                  
----------------         
--------unidentified--------
82C47E  .db $04 $00 $05 $00 $06 $00 $07 $00
----------------         
--------data--------     
82C486  .db $00 $00 $00          
----------------         
--------unidentified--------
82C489  .db $08 $00              
----------------         
--------data--------     
82C48B  .db $00                  
----------------         
--------unidentified--------
82C48C  .db $00 $00              
----------------         
--------data--------     
82C48E  .db $00                  
----------------         
--------unidentified--------
82C48F  .db $00                  
----------------         
--------data--------     
82C490  .db $00                  
----------------         
--------unidentified--------
82C491  .db $00 $09 $0A $00 $00 $00 $0B $00
82C499  .db $0C $00 $0D $00 $00 $0E $00
----------------         
--------data--------     
82C4A0  .db $00 $00 $00          
----------------         
--------unidentified--------
82C4A3  .db $00 $00 $00 $00 $00 $00 $00 $00
82C4AB  .db $00 $00 $00 $00 $00 $00 $00 $00
82C4B3  .db $00 $00 $00 $00 $00 $00 $00 $00
82C4BB  .db $00 $00 $00          
----------------         
--------data--------     
82C4BE  .db $00 $00 $00          
----------------         
--------unidentified--------
82C4C1  .db $00 $00 $00 $00 $00 $00 $00 $00
82C4C9  .db $00 $0F $00 $00 $00 $00 $00 $00
82C4D1  .db $00 $10 $00 $00 $00 $00 $00 $10
----------------         
--------data--------     
82C4D9  .db $15 $1A              
----------------         
--------unidentified--------
82C4DB  .db $1F $24 $29 $2E $33 $38 $3D $42
82C4E3  .db $47 $4C $51 $56 $5B $01 $0E $00
82C4EB  .db $00 $00              
----------------         
--------data--------     
82C4ED  .db $01 $4E $03 $04 $00 $01 $0E $00
82C4F5  .db $00 $82              
----------------         
--------unidentified--------
82C4F7  .db $01 $0E $00 $00 $02 $01 $0E $00
82C4FF  .db $00 $03 $01 $4E $03 $04 $03 $01
82C507  .db $0E $00 $00 $84 $01 $0E $00 $00
82C50F  .db $01 $01 $4E $03 $04 $04 $01 $00
82C517  .db $01 $02 $05 $01 $8E $02 $04 $07
82C51F  .db $01 $4E $03 $04 $08 $01 $C0 $01
82C527  .db $02 $09 $01 $0E $00 $00 $8D $01
82C52F  .db $0E $00 $00 $02 $01 $0E $02 $00
82C537  .db $86                  
----------------         
--------data--------     
82C538  .db $05 $25 $45 $79 $B5 $21 $C6 $22
82C540  .db $C6 $23 $C6 $33 $C6  
----------------         
--------unidentified--------
82C545  .db $43 $C6 $5F $C6      
----------------         
--------data--------     
82C549  .db $90 $C6              
----------------         
--------unidentified--------
82C54B  .db $A3 $C6              
----------------         
--------data--------     
82C54D  .db $A7 $C6 $B7 $C6      
----------------         
--------unidentified--------
82C551  .db $D6 $C6 $F5 $C6      
----------------         
--------data--------     
82C555  .db $02 $C7 $09 $C7 $1C $C7 $29 $C7
82C55D  .db $4B $C7 $64 $C7 $65 $C7
----------------         
--------unidentified--------
82C563  .db $72 $C7 $88 $C7 $A1 $C7 $A8 $C7
----------------         
--------data--------     
82C56B  .db $CA $C7              
----------------         
--------unidentified--------
82C56D  .db $E3 $C7 $FF $C7 $0C $C8 $0D $C8
82C575  .db $26 $C8 $36 $C8 $5E $C8 $5F $C8
----------------         
--------data--------     
82C57D  .db $6C $C8 $76 $C8 $77 $C8
----------------         
--------unidentified--------
82C583  .db $8A $C8 $8B $C8      
----------------         
--------data--------     
82C587  .db $8C $C8              
----------------         
--------unidentified--------
82C589  .db $9F $C8 $B2 $C8      
----------------         
--------data--------     
82C58D  .db $B3 $C8              
----------------         
--------unidentified--------
82C58F  .db $C3 $C8              
----------------         
--------data--------     
82C591  .db $C4 $C8              
----------------         
--------unidentified--------
82C593  .db $DA $C8 $DB $C8 $F1 $C8 $F2 $C8
82C59B  .db $0B $C9 $0C $C9 $19 $C9 $32 $C9
82C5A3  .db $3F $C9 $52 $C9 $5C $C9 $6F $C9
82C5AB  .db $70 $C9 $8F $C9 $90 $C9
----------------         
--------data--------     
82C5B1  .db $91 $C9 $A4 $C9 $B7 $C9
----------------         
--------unidentified--------
82C5B7  .db $E2 $C9 $0D $CA $1A $CA $1B $CA
82C5BF  .db $2E $CA $2F $CA $60 $CA $6A $CA
82C5C7  .db $80 $CA $87 $CA $88 $CA $B0 $CA
82C5CF  .db $CC $CA $CD $CA $FB $CA $1A $CB
82C5D7  .db $1B $CB $1C $CB $2C $CB $39 $CB
82C5DF  .db $3A $CB $44 $CB $69 $CB $B7 $C9
82C5E7  .db $E2 $C9 $2F $CA $2F $CA
----------------         
--------data--------     
82C5ED  .db $6E $CB $81 $CB $A6 $CB
----------------         
--------unidentified--------
82C5F3  .db $CB $CB $F0 $CB $F1 $CB $F5 $CB
82C5FB  .db $F6 $CB $0F $CC $3A $CC $4D $CC
82C603  .db $54 $CC $61 $CC $74 $CC $75 $CC
82C60B  .db $82 $CC $AA $CC $B4 $CC $CA $CC
82C613  .db $CB $CC $CC $CC $D9 $CC $DA $CC
82C61B  .db $EA $CC $30 $CD $31 $CD
----------------         
--------data--------     
82C621  .db $00 $00 $05 $1A $18 $05 $1A $24
82C629  .db $05 $18 $88 $01 $18 $88 $03 $18
82C631  .db $B4 $03 $05 $1A $8C $02 $1A $B0
82C639  .db $02 $1A $30 $03 $1A $30 $04 $1A
82C641  .db $B4 $02              
----------------         
--------unidentified--------
82C643  .db $09 $00 $86 $02 $00 $0A $02 $00
82C64B  .db $8A $02 $08 $9A $02 $08 $9E $02
82C653  .db $08 $9A $04 $08 $9E $04 $02 $B4
82C65B  .db $05 $02 $38 $05 $10 $18 $84 $04
82C663  .db $08 $18 $05 $08 $98 $05 $08 $18
82C66B  .db $06 $08 $A4 $04 $08 $24 $05 $08
82C673  .db $A4 $05 $08 $28 $02 $08 $30 $02
82C67B  .db $1A $28 $05 $1A $2C $02 $08 $8C
82C683  .db $01 $08 $90 $01 $08 $94 $01 $08
82C68B  .db $98 $01 $08 $9C $01  
----------------         
--------data--------     
82C690  .db $06 $08 $1C $05 $08 $20 $05 $08
82C698  .db $A4 $03 $1A $8C $03 $1A $20 $02
82C6A0  .db $1A $B0 $03          
----------------         
--------unidentified--------
82C6A3  .db $01 $04 $38 $01      
----------------         
--------data--------     
82C6A7  .db $05 $18 $9A $02 $18 $36 $01 $18
82C6AF  .db $06 $06 $18 $B8 $05 $18 $38 $06
82C6B7  .db $0A $00 $04 $06 $00 $10 $06 $00
82C6BF  .db $A0 $04 $08 $2C $05 $08 $30 $05
82C6C7  .db $08 $38 $04 $08 $B8 $04 $08 $38
82C6CF  .db $05 $08 $B8 $05 $08 $38 $06
----------------         
--------unidentified--------
82C6D6  .db $0A $08 $84 $01 $08 $88 $05 $08
82C6DE  .db $08 $06 $08 $14 $03 $08 $94 $03
82C6E6  .db $08 $14 $04 $08 $94 $04 $08 $B0
82C6EE  .db $05 $08 $A8 $01 $08 $28 $02 $04
82C6F6  .db $1A $98 $03 $1A $A4 $03 $1A $30
82C6FE  .db $05 $1A $34 $03      
----------------         
--------data--------     
82C702  .db $02 $1A $98 $04 $1A $32 $02 $06
82C70A  .db $1A $90 $04 $1A $10 $05 $1A $98
82C712  .db $03 $1A $A0 $03 $1A $28 $04 $1A
82C71A  .db $2C $03 $04 $00 $04 $04 $00 $06
82C722  .db $06 $00 $38 $04 $00 $36 $06 $0B
82C72A  .db $00 $04 $02 $00 $04 $06 $00 $08
82C732  .db $06 $08 $0C $06 $08 $10 $06 $08
82C73A  .db $14 $06 $1A $08 $02 $1A $10 $02
82C742  .db $1A $18 $02 $1A $A4 $05 $1A $30
82C74A  .db $05 $08 $00 $10 $04 $00 $94 $03
82C752  .db $00 $14 $04 $00 $9C $02 $00 $A0
82C75A  .db $02 $00 $A8 $03 $00 $28 $04 $00
82C762  .db $2C $04 $00 $04 $1A $88 $04 $1A
82C76A  .db $18 $04 $1A $94 $04 $1A $28 $05
----------------         
--------unidentified--------
82C772  .db $07 $08 $98 $05 $08 $A0 $05 $08
82C77A  .db $14 $02 $08 $94 $02 $08 $14 $03
82C782  .db $08 $1C $04 $08 $A8 $05 $08 $00
82C78A  .db $1C $02 $00 $24 $02 $00 $A0 $05
82C792  .db $00 $20 $06 $00 $04 $01 $00 $B0
82C79A  .db $04 $1A $A0 $03 $1A $20 $04 $02
82C7A2  .db $08 $18 $03 $08 $20 $04 $0B $08
82C7AA  .db $04 $04 $08 $14 $05 $08 $28 $06
82C7B2  .db $08 $2C $06 $1C $08 $03 $1C $08
82C7BA  .db $04 $1C $14 $03 $1C $90 $05 $1C
82C7C2  .db $98 $05 $1C $28 $02 $1C $2C $02
----------------         
--------data--------     
82C7CA  .db $08 $1A $04 $02 $1A $88 $01 $1A
82C7D2  .db $88 $02 $1A $88 $04 $1A $0C $02
82C7DA  .db $08 $AC $01 $08 $30 $02 $08 $30
82C7E2  .db $06                  
----------------         
--------unidentified--------
82C7E3  .db $09 $08 $08 $01 $08 $0C $01 $08
82C7EB  .db $14 $06 $08 $18 $06 $08 $B0 $01
82C7F3  .db $08 $B0 $01 $08 $B0 $01 $08 $30
82C7FB  .db $01 $08 $2C $02 $04 $1A $90 $02
82C803  .db $1A $1C $02 $1A $20 $02 $1A $2C
82C80B  .db $05 $00 $08 $00 $04 $01 $00 $08
82C813  .db $01 $00 $0C $01 $00 $10 $01 $00
82C81B  .db $90 $01 $00 $18 $03 $00 $18 $04
82C823  .db $00 $1C $04 $05 $00 $34 $05 $00
82C82B  .db $10 $06 $00 $14 $06 $00 $04 $06
82C833  .db $00 $08 $06 $0D $00 $04 $06 $1A
82C83B  .db $88 $04 $1A $0C $05 $1A $90 $05
82C843  .db $1A $14 $06 $1A $28 $03 $1A $2C
82C84B  .db $04 $1A $2C $03 $1A $AC $02 $1A
82C853  .db $30 $03 $1A $B0 $03 $1A $B4 $02
82C85B  .db $1A $34 $03 $00 $04 $00 $8A $05
82C863  .db $00 $0A $06 $00 $B2 $05 $00 $32
82C86B  .db $06                  
----------------         
--------data--------     
82C86C  .db $03 $08 $82 $05 $08 $86 $05 $08
82C874  .db $06 $06 $00 $06 $08 $84 $01 $08
82C87C  .db $08 $01 $08 $34 $01 $08 $B8 $01
82C884  .db $08 $34 $06 $08 $B8 $05
----------------         
--------unidentified--------
82C88A  .db $00 $00              
----------------         
--------data--------     
82C88C  .db $06 $08 $04 $01 $08 $04 $06 $08
82C894  .db $9A $03 $08 $A2 $03 $08 $38 $01
82C89C  .db $08 $38 $06          
----------------         
--------unidentified--------
82C89F  .db $06 $02 $84 $05 $02 $04 $06 $02
82C8A7  .db $08 $06 $02 $34 $06 $02 $B8 $05
82C8AF  .db $02 $38 $06 $00      
----------------         
--------data--------     
82C8B3  .db $05 $02 $04 $01 $02 $04 $06 $02
82C8BB  .db $14 $01 $02 $2C $06 $02 $38 $06
----------------         
--------unidentified--------
82C8C3  .db $00                  
----------------         
--------data--------     
82C8C4  .db $07 $1A $08 $03 $1A $A0 $02 $1A
82C8CC  .db $A0 $03 $1A $28 $03 $02 $04 $01
82C8D4  .db $02 $04 $06 $02 $38 $03
----------------         
--------unidentified--------
82C8DA  .db $00 $07 $02 $CC $01 $02 $DC $01
82C8E2  .db $02 $EC $01 $02 $52 $04 $02 $56
82C8EA  .db $04 $02 $62 $04 $02 $66 $04 $00
82C8F2  .db $08 $02 $04 $03 $02 $84 $03 $02
82C8FA  .db $04 $04 $02 $04 $06 $02 $A4 $02
82C902  .db $02 $28 $01 $02 $A8 $02 $02 $38
82C90A  .db $06 $00 $04 $02 $04 $01 $02 $38
82C912  .db $01 $02 $18 $03 $02 $24 $03 $08
82C91A  .db $00 $04 $01 $00 $04 $06 $00 $38
82C922  .db $01 $00 $84 $01 $00 $88 $01 $00
82C92A  .db $58 $04 $00 $D8 $03 $00 $68 $04
82C932  .db $04 $02 $04 $01 $02 $08 $01 $02
82C93A  .db $34 $01 $02 $38 $01 $06 $02 $D0
82C942  .db $03 $02 $10 $05 $02 $D4 $03 $02
82C94A  .db $14 $05 $02 $AC $02 $02 $B4 $04
82C952  .db $03 $02 $88 $02 $02 $04 $06 $02
82C95A  .db $38 $06 $06 $02 $88 $03 $02 $08
82C962  .db $04 $02 $88 $04 $02 $B8 $05 $02
82C96A  .db $94 $04 $02 $98 $04 $00 $0A $1A
82C972  .db $30 $01 $1A $B0 $01 $02 $08 $01
82C97A  .db $02 $38 $01 $02 $B8 $01 $02 $D0
82C982  .db $02 $02 $D0 $03 $02 $A4 $05 $02
82C98A  .db $88 $01 $02 $F8 $03 $00 $00
----------------         
--------data--------     
82C991  .db $06 $00 $84 $02 $00 $88 $02 $00
82C999  .db $8C $02 $00 $B0 $02 $00 $B4 $02
82C9A1  .db $00 $B8 $02 $06 $00 $9C $03 $00
82C9A9  .db $A0 $03 $1A $18 $04 $1A $1C $04
82C9B1  .db $1A $20 $04 $1A $24 $04 $0E $00
82C9B9  .db $30 $01 $00 $B0 $01 $00 $B4 $01
82C9C1  .db $00 $38 $01 $00 $B8 $01 $00 $A8
82C9C9  .db $03 $00 $AC $03 $00 $B0 $03 $00
82C9D1  .db $B4 $03 $00 $B0 $05 $00 $30 $06
82C9D9  .db $00 $B4 $05 $00 $B8 $05 $00 $38
82C9E1  .db $06                  
----------------         
--------unidentified--------
82C9E2  .db $0E $00 $04 $03 $00 $08 $03 $00
82C9EA  .db $0C $03 $00 $10 $03 $00 $14 $03
82C9F2  .db $00 $18 $03 $00 $1C $01 $00 $9C
82C9FA  .db $01 $00 $20 $01 $00 $A0 $01 $00
82CA02  .db $A4 $02 $00 $A8 $02 $00 $B4 $02
82CA0A  .db $00 $B8 $02 $04 $1E $0C $02 $1E
82CA12  .db $10 $04 $1A $A2 $03 $1C $30 $05
82CA1A  .db $00 $06 $00 $DA $02 $00 $9A $03
82CA22  .db $00 $E2 $02 $00 $A2 $03 $00 $0C
82CA2A  .db $04 $00 $30 $03 $00 $10 $00 $9C
82CA32  .db $01 $00 $1C $02 $00 $9C $02 $00
82CA3A  .db $1C $03 $00 $1C $04 $00 $9C $04
82CA42  .db $00 $1C $05 $00 $9C $05 $00 $A0
82CA4A  .db $01 $00 $20 $02 $00 $A0 $02 $00
82CA52  .db $20 $03 $00 $20 $04 $00 $A0 $04
82CA5A  .db $00 $20 $05 $00 $A0 $05 $03 $1E
82CA62  .db $04 $02 $1C $08 $06 $1E $8C $05
82CA6A  .db $07 $1A $08 $02 $1A $08 $05 $1A
82CA72  .db $18 $05 $1A $9C $02 $1A $A8 $04
82CA7A  .db $1A $30 $06 $1A $34 $02 $02 $1A
82CA82  .db $94 $05 $1A $B0 $05 $00 $0D $00
82CA8A  .db $04 $01 $00 $84 $01 $00 $04 $06
82CA92  .db $00 $08 $06 $00 $88 $01 $00 $0C
82CA9A  .db $01 $00 $8C $01 $00 $14 $01 $00
82CAA2  .db $94 $01 $00 $24 $04 $00 $28 $04
82CAAA  .db $00 $38 $01 $00 $B8 $01 $09 $1C
82CAB2  .db $04 $04 $1E $88 $04 $1A $0C $05
82CABA  .db $1A $94 $02 $1C $18 $02 $1C $AC
82CAC2  .db $02 $1A $B4 $04 $1E $18 $04 $00
82CACA  .db $1C $04 $00 $0F $1A $88 $03 $1A
82CAD2  .db $88 $04 $1C $08 $05 $1C $20 $05
82CADA  .db $1C $B0 $03 $1A $34 $03 $00 $88
82CAE2  .db $02 $00 $98 $04 $00 $1C $04 $00
82CAEA  .db $20 $04 $00 $A4 $04 $00 $B0 $02
82CAF2  .db $00 $B4 $02 $00 $94 $04 $00 $A8
82CAFA  .db $04 $0A $00 $84 $03 $00 $88 $04
82CB02  .db $00 $84 $05 $00 $08 $06 $00 $20
82CB0A  .db $06 $00 $B8 $04 $00 $38 $05 $00
82CB12  .db $B8 $05 $00 $38 $06 $1C $A6 $02
82CB1A  .db $00 $00 $05 $1A $88 $02 $1A $94
82CB22  .db $03 $1A $10 $05 $1A $A0 $03 $1A
82CB2A  .db $24 $05 $04 $1C $10 $02 $1A $9C
82CB32  .db $03 $1A $A0 $03 $1C $2C $02 $00
82CB3A  .db $03 $1A $8C $04 $1E $18 $02 $1A
82CB42  .db $98 $04 $0C $00 $84 $05 $00 $04
82CB4A  .db $06 $00 $88 $05 $00 $08 $06 $00
82CB52  .db $0C $06 $00 $10 $06 $00 $2C $06
82CB5A  .db $00 $30 $06 $00 $B4 $05 $00 $34
82CB62  .db $06 $00 $B8 $05 $00 $38 $06 $00
82CB6A  .db $00 $00 $00 $00      
----------------         
--------data--------     
82CB6E  .db $06 $00 $AC $05 $00 $B0 $05 $00
82CB76  .db $B4 $05 $00 $2C $06 $00 $30 $06
82CB7E  .db $00 $34 $06 $0C $00 $84 $02 $00
82CB86  .db $04 $04 $00 $0C $05 $00 $10 $04
82CB8E  .db $00 $14 $01 $00 $1C $05 $00 $20
82CB96  .db $06 $00 $2C $01 $00 $AC $01 $00
82CB9E  .db $30 $05 $00 $34 $01 $00 $38 $01
82CBA6  .db $0C $00 $04 $03 $00 $84 $03 $00
82CBAE  .db $18 $06 $00 $1C $06 $00 $AC $05
82CBB6  .db $00 $2C $06 $00 $34 $05 $00 $38
82CBBE  .db $05 $1A $88 $03 $1A $08 $06 $1A
82CBC6  .db $0C $05 $1A $10 $06  
----------------         
--------unidentified--------
82CBCB  .db $0C $1A $08 $01 $1A $8C $03 $1A
82CBD3  .db $0C $04 $1A $14 $02 $1A $94 $03
82CBDB  .db $1A $9C $03 $1A $1C $06 $1A $20
82CBE3  .db $02 $1A $A0 $03 $1A $2C $02 $1A
82CBEB  .db $AC $03 $1A $B8 $02 $00 $01 $1C
82CBF3  .db $9C $05 $00 $08 $02 $04 $01 $02
82CBFB  .db $04 $06 $02 $10 $01 $02 $10 $06
82CC03  .db $02 $2C $01 $02 $2C $06 $02 $38
82CC0B  .db $01 $02 $38 $06 $0E $00 $04 $01
82CC13  .db $00 $84 $01 $00 $04 $02 $00 $84
82CC1B  .db $02 $00 $84 $04 $00 $04 $05 $00
82CC23  .db $84 $05 $00 $04 $06 $00 $9C $05
82CC2B  .db $00 $1C $06 $00 $2C $01 $00 $AC
82CC33  .db $01 $1A $98 $05 $1A $18 $06 $06
82CC3B  .db $00 $30 $01 $00 $B0 $01 $00 $34
82CC43  .db $01 $00 $B4 $01 $00 $38 $01 $00
82CC4B  .db $B8 $01 $02 $1A $10 $02 $1A $10
82CC53  .db $05 $04 $00 $84 $05 $00 $88 $05
82CC5B  .db $00 $B4 $05 $00 $B8 $05 $06 $1A
82CC63  .db $90 $03 $1A $1C $02 $1A $18 $05
82CC6B  .db $1A $A8 $03 $1A $28 $06 $1A $28
82CC73  .db $02 $00 $04 $1C $8C $05 $1C $A0
82CC7B  .db $05 $1C $88 $05 $1C $B4 $05 $0D
82CC83  .db $00 $04 $02 $00 $88 $01 $00 $88
82CC8B  .db $05 $00 $14 $03 $00 $2C $06 $00
82CC93  .db $1C $03 $00 $A0 $04 $00 $20 $02
82CC9B  .db $00 $24 $06 $00 $AC $01 $00 $B0
82CCA3  .db $01 $00 $B4 $01 $00 $34 $05 $03
82CCAB  .db $00 $98 $04 $00 $9C $04 $00 $A0
82CCB3  .db $04 $07 $00 $94 $04 $00 $28 $06
82CCBB  .db $00 $2C $06 $00 $B4 $04 $00 $B8
82CCC3  .db $04 $1A $20 $04 $1A $AC $02 $00
82CCCB  .db $00 $04 $00 $04 $01 $00 $84 $01
82CCD3  .db $00 $18 $03 $00 $98 $03 $00 $05
82CCDB  .db $1A $18 $03 $1A $18 $04 $1A $98
82CCE3  .db $04 $1A $24 $02 $1A $A4 $03 $17
82CCEB  .db $00 $90 $02 $00 $94 $02 $00 $98
82CCF3  .db $02 $00 $9C $02 $00 $10 $03 $00
82CCFB  .db $14 $03 $00 $18 $03 $00 $1C $03
82CD03  .db $00 $20 $03 $00 $90 $03 $00 $94
82CD0B  .db $03 $00 $9C $03 $00 $A0 $03 $00
82CD13  .db $10 $04 $00 $14 $04 $00 $18 $04
82CD1B  .db $00 $1C $04 $00 $20 $04 $00 $90
82CD23  .db $04 $00 $94 $04 $00 $98 $04 $00
82CD2B  .db $9C $04 $1A $8C $03 $00 $00 $5B
82CD33  .db $A5 $03 $48 $A5 $02 $48 $60 $68
82CD3B  .db $85 $02 $68 $85 $03 $60 $4E $69
82CD43  .db $6E $74 $65 $6E $64 $6F $20 $64
82CD4B  .db $61 $73 $68 $69 $20 $20 $20 $31
82CD53  .db $39 $39 $33 $2F $30 $34 $2F $32
82CD5B  .db $31 $20 $20 $20 $20 $20 $50 $72
82CD63  .db $6F $67 $72 $61 $6D $65 $64 $20
82CD6B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82CD73  .db $20 $53 $68 $69 $6E $6F $68 $61
82CD7B  .db $72 $61 $20 $20 $20 $20 $20 $57
82CD83  .db $41 $4C $54 $20 $44 $49 $53 $4E
82CD8B  .db $45 $59 $20 $20 $20 $20 $20 $20
82CD93  .db $47 $4F $4F $46 $20 $54 $52 $4F
82CD9B  .db $4F $50 $20 $20 $20 $20 $31 $39
82CDA3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82CDAB  .db $4D $20 $41 $6C $6C $72 $69 $67
82CDB3  .db $68 $74 $20 $72 $65 $73 $65 $72
82CDBB  .db $76 $65 $64 $20 $20 $20 $4E $69
82CDC3  .db $6E $74 $65 $6E $64 $6F $20 $64
82CDCB  .db $61 $73 $68 $69 $20 $20 $20 $31
82CDD3  .db $39 $39 $33 $2F $30 $34 $2F $32
82CDDB  .db $31 $20 $20 $20 $20 $20 $50 $72
82CDE3  .db $6F $67 $72 $61 $6D $65 $64 $20
82CDEB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82CDF3  .db $20 $53 $68 $69 $6E $6F $68 $61
82CDFB  .db $72 $61 $20 $20 $20 $20 $20 $57
82CE03  .db $41 $4C $54 $20 $44 $49 $53 $4E
82CE0B  .db $45 $59 $20 $20 $20 $20 $20 $20
82CE13  .db $47 $4F $4F $46 $20 $54 $52 $4F
82CE1B  .db $4F $50 $20 $20 $20 $20 $31 $39
82CE23  .db $39 $33 $20 $43 $41 $50 $43 $4F
82CE2B  .db $4D $20 $41 $6C $6C $72 $69 $67
82CE33  .db $68 $74 $20 $72 $65 $73 $65 $72
82CE3B  .db $76 $65 $64 $20 $20 $20 $4E $69
82CE43  .db $6E $74 $65 $6E $64 $6F $20 $64
82CE4B  .db $61 $73 $68 $69 $20 $20 $20 $31
82CE53  .db $39 $39 $33 $2F $30 $34 $2F $32
82CE5B  .db $31 $20 $20 $20 $20 $20 $50 $72
82CE63  .db $6F $67 $72 $61 $6D $65 $64 $20
82CE6B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82CE73  .db $20 $53 $68 $69 $6E $6F $68 $61
82CE7B  .db $72 $61 $20 $20 $20 $20 $20 $57
82CE83  .db $41 $4C $54 $20 $44 $49 $53 $4E
82CE8B  .db $45 $59 $20 $20 $20 $20 $20 $20
82CE93  .db $47 $4F $4F $46 $20 $54 $52 $4F
82CE9B  .db $4F $50 $20 $20 $20 $20 $31 $39
82CEA3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82CEAB  .db $4D $20 $41 $6C $6C $72 $69 $67
82CEB3  .db $68 $74 $20 $72 $65 $73 $65 $72
82CEBB  .db $76 $65 $64 $20 $20 $20 $4E $69
82CEC3  .db $6E $74 $65 $6E $64 $6F $20 $64
82CECB  .db $61 $73 $68 $69 $20 $20 $20 $31
82CED3  .db $39 $39 $33 $2F $30 $34 $2F $32
82CEDB  .db $31 $20 $20 $20 $20 $20 $50 $72
82CEE3  .db $6F $67 $72 $61 $6D $65 $64 $20
82CEEB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82CEF3  .db $20 $53 $68 $69 $6E $6F $68 $61
82CEFB  .db $72 $61 $20 $20 $20 $20 $20 $57
82CF03  .db $41 $4C $54 $20 $44 $49 $53 $4E
82CF0B  .db $45 $59 $20 $20 $20 $20 $20 $20
82CF13  .db $47 $4F $4F $46 $20 $54 $52 $4F
82CF1B  .db $4F $50 $20 $20 $20 $20 $31 $39
82CF23  .db $39 $33 $20 $43 $41 $50 $43 $4F
82CF2B  .db $4D $20 $41 $6C $6C $72 $69 $67
82CF33  .db $68 $74 $20 $72 $65 $73 $65 $72
82CF3B  .db $76 $65 $64 $20 $20 $20 $4E $69
82CF43  .db $6E $74 $65 $6E $64 $6F $20 $64
82CF4B  .db $61 $73 $68 $69 $20 $20 $20 $31
82CF53  .db $39 $39 $33 $2F $30 $34 $2F $32
82CF5B  .db $31 $20 $20 $20 $20 $20 $50 $72
82CF63  .db $6F $67 $72 $61 $6D $65 $64 $20
82CF6B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82CF73  .db $20 $53 $68 $69 $6E $6F $68 $61
82CF7B  .db $72 $61 $20 $20 $20 $20 $20 $57
82CF83  .db $41 $4C $54 $20 $44 $49 $53 $4E
82CF8B  .db $45 $59 $20 $20 $20 $20 $20 $20
82CF93  .db $47 $4F $4F $46 $20 $54 $52 $4F
82CF9B  .db $4F $50 $20 $20 $20 $20 $31 $39
82CFA3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82CFAB  .db $4D $20 $41 $6C $6C $72 $69 $67
82CFB3  .db $68 $74 $20 $72 $65 $73 $65 $72
82CFBB  .db $76 $65 $64 $20 $20 $20 $4E $69
82CFC3  .db $6E $74 $65 $6E $64 $6F $20 $64
82CFCB  .db $61 $73 $68 $69 $20 $20 $20 $31
82CFD3  .db $39 $39 $33 $2F $30 $34 $2F $32
82CFDB  .db $31 $20 $20 $20 $20 $20 $50 $72
82CFE3  .db $6F $67 $72 $61 $6D $65 $64 $20
82CFEB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82CFF3  .db $20 $53 $68 $69 $6E $6F $68 $61
82CFFB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D003  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D00B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D013  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D01B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D023  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D02B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D033  .db $68 $74 $20 $72 $65 $73 $65 $72
82D03B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D043  .db $6E $74 $65 $6E $64 $6F $20 $64
82D04B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D053  .db $39 $39 $33 $2F $30 $34 $2F $32
82D05B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D063  .db $6F $67 $72 $61 $6D $65 $64 $20
82D06B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D073  .db $20 $53 $68 $69 $6E $6F $68 $61
82D07B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D083  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D08B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D093  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D09B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D0A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D0AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D0B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D0BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D0C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D0CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D0D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D0DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D0E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D0EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D0F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D0FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D103  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D10B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D113  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D11B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D123  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D12B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D133  .db $68 $74 $20 $72 $65 $73 $65 $72
82D13B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D143  .db $6E $74 $65 $6E $64 $6F $20 $64
82D14B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D153  .db $39 $39 $33 $2F $30 $34 $2F $32
82D15B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D163  .db $6F $67 $72 $61 $6D $65 $64 $20
82D16B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D173  .db $20 $53 $68 $69 $6E $6F $68 $61
82D17B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D183  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D18B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D193  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D19B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D1A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D1AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D1B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D1BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D1C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D1CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D1D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D1DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D1E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D1EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D1F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D1FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D203  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D20B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D213  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D21B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D223  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D22B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D233  .db $68 $74 $20 $72 $65 $73 $65 $72
82D23B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D243  .db $6E $74 $65 $6E $64 $6F $20 $64
82D24B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D253  .db $39 $39 $33 $2F $30 $34 $2F $32
82D25B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D263  .db $6F $67 $72 $61 $6D $65 $64 $20
82D26B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D273  .db $20 $53 $68 $69 $6E $6F $68 $61
82D27B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D283  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D28B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D293  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D29B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D2A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D2AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D2B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D2BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D2C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D2CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D2D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D2DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D2E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D2EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D2F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D2FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D303  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D30B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D313  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D31B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D323  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D32B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D333  .db $68 $74 $20 $72 $65 $73 $65 $72
82D33B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D343  .db $6E $74 $65 $6E $64 $6F $20 $64
82D34B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D353  .db $39 $39 $33 $2F $30 $34 $2F $32
82D35B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D363  .db $6F $67 $72 $61 $6D $65 $64 $20
82D36B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D373  .db $20 $53 $68 $69 $6E $6F $68 $61
82D37B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D383  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D38B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D393  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D39B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D3A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D3AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D3B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D3BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D3C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D3CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D3D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D3DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D3E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D3EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D3F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D3FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D403  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D40B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D413  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D41B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D423  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D42B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D433  .db $68 $74 $20 $72 $65 $73 $65 $72
82D43B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D443  .db $6E $74 $65 $6E $64 $6F $20 $64
82D44B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D453  .db $39 $39 $33 $2F $30 $34 $2F $32
82D45B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D463  .db $6F $67 $72 $61 $6D $65 $64 $20
82D46B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D473  .db $20 $53 $68 $69 $6E $6F $68 $61
82D47B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D483  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D48B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D493  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D49B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D4A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D4AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D4B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D4BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D4C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D4CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D4D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D4DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D4E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D4EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D4F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D4FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D503  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D50B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D513  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D51B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D523  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D52B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D533  .db $68 $74 $20 $72 $65 $73 $65 $72
82D53B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D543  .db $6E $74 $65 $6E $64 $6F $20 $64
82D54B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D553  .db $39 $39 $33 $2F $30 $34 $2F $32
82D55B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D563  .db $6F $67 $72 $61 $6D $65 $64 $20
82D56B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D573  .db $20 $53 $68 $69 $6E $6F $68 $61
82D57B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D583  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D58B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D593  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D59B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D5A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D5AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D5B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D5BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D5C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D5CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D5D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D5DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D5E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D5EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D5F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D5FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D603  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D60B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D613  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D61B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D623  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D62B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D633  .db $68 $74 $20 $72 $65 $73 $65 $72
82D63B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D643  .db $6E $74 $65 $6E $64 $6F $20 $64
82D64B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D653  .db $39 $39 $33 $2F $30 $34 $2F $32
82D65B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D663  .db $6F $67 $72 $61 $6D $65 $64 $20
82D66B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D673  .db $20 $53 $68 $69 $6E $6F $68 $61
82D67B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D683  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D68B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D693  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D69B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D6A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D6AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D6B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D6BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D6C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D6CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D6D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D6DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D6E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D6EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D6F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D6FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D703  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D70B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D713  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D71B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D723  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D72B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D733  .db $68 $74 $20 $72 $65 $73 $65 $72
82D73B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D743  .db $6E $74 $65 $6E $64 $6F $20 $64
82D74B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D753  .db $39 $39 $33 $2F $30 $34 $2F $32
82D75B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D763  .db $6F $67 $72 $61 $6D $65 $64 $20
82D76B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D773  .db $20 $53 $68 $69 $6E $6F $68 $61
82D77B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D783  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D78B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D793  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D79B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D7A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D7AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D7B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D7BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D7C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D7CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D7D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D7DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D7E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D7EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D7F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D7FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D803  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D80B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D813  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D81B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D823  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D82B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D833  .db $68 $74 $20 $72 $65 $73 $65 $72
82D83B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D843  .db $6E $74 $65 $6E $64 $6F $20 $64
82D84B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D853  .db $39 $39 $33 $2F $30 $34 $2F $32
82D85B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D863  .db $6F $67 $72 $61 $6D $65 $64 $20
82D86B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D873  .db $20 $53 $68 $69 $6E $6F $68 $61
82D87B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D883  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D88B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D893  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D89B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D8A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D8AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D8B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D8BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D8C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D8CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D8D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D8DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D8E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D8EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D8F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D8FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82D903  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D90B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D913  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D91B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D923  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D92B  .db $4D $20 $41 $6C $6C $72 $69 $67
82D933  .db $68 $74 $20 $72 $65 $73 $65 $72
82D93B  .db $76 $65 $64 $20 $20 $20 $4E $69
82D943  .db $6E $74 $65 $6E $64 $6F $20 $64
82D94B  .db $61 $73 $68 $69 $20 $20 $20 $31
82D953  .db $39 $39 $33 $2F $30 $34 $2F $32
82D95B  .db $31 $20 $20 $20 $20 $20 $50 $72
82D963  .db $6F $67 $72 $61 $6D $65 $64 $20
82D96B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D973  .db $20 $53 $68 $69 $6E $6F $68 $61
82D97B  .db $72 $61 $20 $20 $20 $20 $20 $57
82D983  .db $41 $4C $54 $20 $44 $49 $53 $4E
82D98B  .db $45 $59 $20 $20 $20 $20 $20 $20
82D993  .db $47 $4F $4F $46 $20 $54 $52 $4F
82D99B  .db $4F $50 $20 $20 $20 $20 $31 $39
82D9A3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82D9AB  .db $4D $20 $41 $6C $6C $72 $69 $67
82D9B3  .db $68 $74 $20 $72 $65 $73 $65 $72
82D9BB  .db $76 $65 $64 $20 $20 $20 $4E $69
82D9C3  .db $6E $74 $65 $6E $64 $6F $20 $64
82D9CB  .db $61 $73 $68 $69 $20 $20 $20 $31
82D9D3  .db $39 $39 $33 $2F $30 $34 $2F $32
82D9DB  .db $31 $20 $20 $20 $20 $20 $50 $72
82D9E3  .db $6F $67 $72 $61 $6D $65 $64 $20
82D9EB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82D9F3  .db $20 $53 $68 $69 $6E $6F $68 $61
82D9FB  .db $72 $61 $20 $20 $20 $20 $20 $57
82DA03  .db $41 $4C $54 $20 $44 $49 $53 $4E
82DA0B  .db $45 $59 $20 $20 $20 $20 $20 $20
82DA13  .db $47 $4F $4F $46 $20 $54 $52 $4F
82DA1B  .db $4F $50 $20 $20 $20 $20 $31 $39
82DA23  .db $39 $33 $20 $43 $41 $50 $43 $4F
82DA2B  .db $4D $20 $41 $6C $6C $72 $69 $67
82DA33  .db $68 $74 $20 $72 $65 $73 $65 $72
82DA3B  .db $76 $65 $64 $20 $20 $20 $4E $69
82DA43  .db $6E $74 $65 $6E $64 $6F $20 $64
82DA4B  .db $61 $73 $68 $69 $20 $20 $20 $31
82DA53  .db $39 $39 $33 $2F $30 $34 $2F $32
82DA5B  .db $31 $20 $20 $20 $20 $20 $50 $72
82DA63  .db $6F $67 $72 $61 $6D $65 $64 $20
82DA6B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82DA73  .db $20 $53 $68 $69 $6E $6F $68 $61
82DA7B  .db $72 $61 $20 $20 $20 $20 $20 $57
82DA83  .db $41 $4C $54 $20 $44 $49 $53 $4E
82DA8B  .db $45 $59 $20 $20 $20 $20 $20 $20
82DA93  .db $47 $4F $4F $46 $20 $54 $52 $4F
82DA9B  .db $4F $50 $20 $20 $20 $20 $31 $39
82DAA3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82DAAB  .db $4D $20 $41 $6C $6C $72 $69 $67
82DAB3  .db $68 $74 $20 $72 $65 $73 $65 $72
82DABB  .db $76 $65 $64 $20 $20 $20 $4E $69
82DAC3  .db $6E $74 $65 $6E $64 $6F $20 $64
82DACB  .db $61 $73 $68 $69 $20 $20 $20 $31
82DAD3  .db $39 $39 $33 $2F $30 $34 $2F $32
82DADB  .db $31 $20 $20 $20 $20 $20 $50 $72
82DAE3  .db $6F $67 $72 $61 $6D $65 $64 $20
82DAEB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82DAF3  .db $20 $53 $68 $69 $6E $6F $68 $61
82DAFB  .db $72 $61 $20 $20 $20 $20 $20 $57
82DB03  .db $41 $4C $54 $20 $44 $49 $53 $4E
82DB0B  .db $45 $59 $20 $20 $20 $20 $20 $20
82DB13  .db $47 $4F $4F $46 $20 $54 $52 $4F
82DB1B  .db $4F $50 $20 $20 $20 $20 $31 $39
82DB23  .db $39 $33 $20 $43 $41 $50 $43 $4F
82DB2B  .db $4D $20 $41 $6C $6C $72 $69 $67
82DB33  .db $68 $74 $20 $72 $65 $73 $65 $72
82DB3B  .db $76 $65 $64 $20 $20 $20 $4E $69
82DB43  .db $6E $74 $65 $6E $64 $6F $20 $64
82DB4B  .db $61 $73 $68 $69 $20 $20 $20 $31
82DB53  .db $39 $39 $33 $2F $30 $34 $2F $32
82DB5B  .db $31 $20 $20 $20 $20 $20 $50 $72
82DB63  .db $6F $67 $72 $61 $6D $65 $64 $20
82DB6B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82DB73  .db $20 $53 $68 $69 $6E $6F $68 $61
82DB7B  .db $72 $61 $20 $20 $20 $20 $20 $57
82DB83  .db $41 $4C $54 $20 $44 $49 $53 $4E
82DB8B  .db $45 $59 $20 $20 $20 $20 $20 $20
82DB93  .db $47 $4F $4F $46 $20 $54 $52 $4F
82DB9B  .db $4F $50 $20 $20 $20 $20 $31 $39
82DBA3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82DBAB  .db $4D $20 $41 $6C $6C $72 $69 $67
82DBB3  .db $68 $74 $20 $72 $65 $73 $65 $72
82DBBB  .db $76 $65 $64 $20 $20 $20 $4E $69
82DBC3  .db $6E $74 $65 $6E $64 $6F $20 $64
82DBCB  .db $61 $73 $68 $69 $20 $20 $20 $31
82DBD3  .db $39 $39 $33 $2F $30 $34 $2F $32
82DBDB  .db $31 $20 $20 $20 $20 $20 $50 $72
82DBE3  .db $6F $67 $72 $61 $6D $65 $64 $20
82DBEB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82DBF3  .db $20 $53 $68 $69 $6E $6F $68 $61
82DBFB  .db $72 $61 $20 $20 $20 $20 $20 $57
82DC03  .db $41 $4C $54 $20 $44 $49 $53 $4E
82DC0B  .db $45 $59 $20 $20 $20 $20 $20 $20
82DC13  .db $47 $4F $4F $46 $20 $54 $52 $4F
82DC1B  .db $4F $50 $20 $20 $20 $20 $31 $39
82DC23  .db $39 $33 $20 $43 $41 $50 $43 $4F
82DC2B  .db $4D $20 $41 $6C $6C $72 $69 $67
82DC33  .db $68 $74 $20 $72 $65 $73 $65 $72
82DC3B  .db $76 $65 $64 $20 $20 $20 $4E $69
82DC43  .db $6E $74 $65 $6E $64 $6F $20 $64
82DC4B  .db $61 $73 $68 $69 $20 $20 $20 $31
82DC53  .db $39 $39 $33 $2F $30 $34 $2F $32
82DC5B  .db $31 $20 $20 $20 $20 $20 $50 $72
82DC63  .db $6F $67 $72 $61 $6D $65 $64 $20
82DC6B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82DC73  .db $20 $53 $68 $69 $6E $6F $68 $61
82DC7B  .db $72 $61 $20 $20 $20 $20 $20 $57
82DC83  .db $41 $4C $54 $20 $44 $49 $53 $4E
82DC8B  .db $45 $59 $20 $20 $20 $20 $20 $20
82DC93  .db $47 $4F $4F $46 $20 $54 $52 $4F
82DC9B  .db $4F $50 $20 $20 $20 $20 $31 $39
82DCA3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82DCAB  .db $4D $20 $41 $6C $6C $72 $69 $67
82DCB3  .db $68 $74 $20 $72 $65 $73 $65 $72
82DCBB  .db $76 $65 $64 $20 $20 $20 $4E $69
82DCC3  .db $6E $74 $65 $6E $64 $6F $20 $64
82DCCB  .db $61 $73 $68 $69 $20 $20 $20 $31
82DCD3  .db $39 $39 $33 $2F $30 $34 $2F $32
82DCDB  .db $31 $20 $20 $20 $20 $20 $50 $72
82DCE3  .db $6F $67 $72 $61 $6D $65 $64 $20
82DCEB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82DCF3  .db $20 $53 $68 $69 $6E $6F $68 $61
82DCFB  .db $72 $61 $20 $20 $20 $20 $20 $57
82DD03  .db $41 $4C $54 $20 $44 $49 $53 $4E
82DD0B  .db $45 $59 $20 $20 $20 $20 $20 $20
82DD13  .db $47 $4F $4F $46 $20 $54 $52 $4F
82DD1B  .db $4F $50 $20 $20 $20 $20 $31 $39
82DD23  .db $39 $33 $20 $43 $41 $50 $43 $4F
82DD2B  .db $4D $20 $41 $6C $6C $72 $69 $67
82DD33  .db $68 $74 $20 $72 $65 $73 $65 $72
82DD3B  .db $76 $65 $64 $20 $20 $20 $4E $69
82DD43  .db $6E $74 $65 $6E $64 $6F $20 $64
82DD4B  .db $61 $73 $68 $69 $20 $20 $20 $31
82DD53  .db $39 $39 $33 $2F $30 $34 $2F $32
82DD5B  .db $31 $20 $20 $20 $20 $20 $50 $72
82DD63  .db $6F $67 $72 $61 $6D $65 $64 $20
82DD6B  .db $62 $79 $20 $20 $20 $20 $4D $2E
82DD73  .db $20 $53 $68 $69 $6E $6F $68 $61
82DD7B  .db $72 $61 $20 $20 $20 $20 $20 $57
82DD83  .db $41 $4C $54 $20 $44 $49 $53 $4E
82DD8B  .db $45 $59 $20 $20 $20 $20 $20 $20
82DD93  .db $47 $4F $4F $46 $20 $54 $52 $4F
82DD9B  .db $4F $50 $20 $20 $20 $20 $31 $39
82DDA3  .db $39 $33 $20 $43 $41 $50 $43 $4F
82DDAB  .db $4D $20 $41 $6C $6C $72 $69 $67
82DDB3  .db $68 $74 $20 $72 $65 $73 $65 $72
82DDBB  .db $76 $65 $64 $20 $20 $20 $4E $69
82DDC3  .db $6E $74 $65 $6E $64 $6F $20 $64
82DDCB  .db $61 $73 $68 $69 $20 $20 $20 $31
82DDD3  .db $39 $39 $33 $2F $30 $34 $2F $32
82DDDB  .db $31 $20 $20 $20 $20 $20 $50 $72
82DDE3  .db $6F $67 $72 $61 $6D $65 $64 $20
82DDEB  .db $62 $79 $20 $20 $20 $20 $4D $2E
82DDF3  .db $20 $53 $68 $69 $6E $6F $68 $61
82DDFB  .db $72 $61 $20 $20 $20  
----------------         
--------data--------     
82DE00  .db $00 $31 $02 $1A $0A $05 $08 $1A
82DE08  .db $09 $05 $01 $05 $81 $06 $01 $12
82DE10  .db $00 $0F $02 $6F $0A $01 $08 $1B
82DE18  .db $88 $06 $08 $14 $01 $06 $81 $05
82DE20  .db $01 $04 $00 $12 $08 $1E $00 $04
82DE28  .db $02 $0D $00 $0F $01 $05 $00 $08
82DE30  .db $08 $07 $88 $04 $80 $02 $00 $1A
82DE38  .db $08 $0B $00 $07 $04 $0D $00 $04
82DE40  .db $02 $0B $00 $11 $02 $09 $00 $03
82DE48  .db $04 $22 $05 $11 $04 $1B $05 $03
82DE50  .db $01 $01 $09 $04 $08 $03 $88 $05
82DE58  .db $08 $01 $04 $0B $05 $0C $85 $04
82DE60  .db $05 $1B $01 $05 $09 $05 $01 $0C
82DE68  .db $09 $07 $01 $40 $09 $01 $08 $01
82DE70  .db $0A $01 $02 $04 $82 $02 $8A $01
82DE78  .db $88 $01 $81 $02 $01 $11 $81 $06
82DE80  .db $01 $14 $09 $0A $01 $03 $04 $01
82DE88  .db $06 $04 $04 $08 $06 $02 $02 $05
82DE90  .db $0A $0C $02 $08 $82 $04 $00 $00
----------------         
--------unidentified--------
82DE98  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82DED0  .db $00 $00 $00 $00 $00 $00 $00 $00
82DED8  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82DEF8  .db $00 $00 $00 $00 $00 $00 $00 $00
----------------         
--------data--------     
82DF00  .db $00 $15 $01 $14 $09 $04 $08 $04
82DF08  .db $0A $02 $02 $21 $00 $01 $01 $03
82DF10  .db $05 $02 $01 $02 $08 $05 $09 $03
82DF18  .db $01 $0D $05 $0C $01 $1D $81 $02
82DF20  .db $80 $06 $00 $44 $01 $05 $09 $02
82DF28  .db $08 $26 $88 $08 $08 $0D $88 $07
82DF30  .db $08 $0C $88 $08 $08 $09 $88 $07
82DF38  .db $08 $0D $0A $11 $08 $0D $0A $1D
82DF40  .db $02 $08 $06 $01 $04 $03 $44 $02
82DF48  .db $40 $05 $00 $17 $02 $0C $0A $11
82DF50  .db $02 $04 $04 $01 $44 $05 $40 $02
82DF58  .db $00 $13 $02 $53 $84 $05 $04 $72
82DF60  .db $05 $01 $01 $02 $81 $06 $01 $16
82DF68  .db $81 $06 $01 $50 $81 $05 $01 $10
82DF70  .db $05 $0A $01 $07 $09 $04 $01 $07
82DF78  .db $05 $0B $04 $05 $00 $00
----------------         
--------unidentified--------
82DF7E  .db $00 $00 $00 $00 $00 $00 $00 $00
82DF86  .db $00 $00 $00 $00 $00 $00 $00 $00
82DF8E  .db $00 $00 $00 $00 $00 $00 $00 $00
82DF96  .db $00 $00 $00 $00 $00 $00 $00 $00
82DF9E  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFA6  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFAE  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFB6  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFBE  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFC6  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFCE  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFD6  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFDE  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFE6  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFEE  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFF6  .db $00 $00 $00 $00 $00 $00 $00 $00
82DFFE  .db $00 $00              
----------------         
--------data--------     
82E000  .db $00 $3A $01 $25 $00 $32 $01 $11
82E008  .db $00 $0C $01 $17 $08 $71 $0A $02
82E010  .db $02 $10 $82 $06 $02 $01 $04 $03
82E018  .db $05 $0E $04 $04 $02 $05 $82 $06
82E020  .db $02 $07 $00 $3D $08 $02 $0A $04
82E028  .db $08 $11 $0A $05 $02 $22 $06 $01
82E030  .db $04 $0A $06 $01 $02 $18 $42 $03
82E038  .db $40 $05 $00 $31 $02 $04 $00 $13
82E040  .db $02 $35 $82 $07 $02 $30 $00 $01
82E048  .db $04 $04 $84 $07 $04 $01 $00 $2B
82E050  .db $01 $0E $00 $0F $04 $0D $00 $01
82E058  .db $80 $05 $00 $48 $00 $00
----------------         
--------unidentified--------
82E05E  .db $00 $00 $00 $00 $00 $00 $00 $00
82E066  .db $00 $00 $00 $00 $00 $00 $00 $00
82E06E  .db $00 $00 $00 $00 $00 $00 $00 $00
82E076  .db $00 $00 $00 $00 $00 $00 $00 $00
82E07E  .db $00 $00 $00 $00 $00 $00 $00 $00
82E086  .db $00 $00 $00 $00 $00 $00 $00 $00
82E08E  .db $00 $00 $00 $00 $00 $00 $00 $00
82E096  .db $00 $00 $00 $00 $00 $00 $00 $00
82E09E  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0A6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0AE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0B6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0BE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0C6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0CE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0D6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0DE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0E6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0EE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0F6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E0FE  .db $00 $00              
----------------         
--------data--------     
82E100  .db $00 $1F $01 $26 $81 $07 $01 $0B
82E108  .db $81 $08 $01 $15 $08 $03 $48 $01
82E110  .db $40 $1F $48 $01 $08 $4D $0A $01
82E118  .db $02 $04 $82 $07 $02 $08 $82 $06
82E120  .db $02 $05 $0A $01 $08 $19 $0A $09
82E128  .db $02 $0B $0A $01 $08 $02 $09 $03
82E130  .db $01 $01 $00 $0A $02 $06 $00 $37
82E138  .db $01 $04 $05 $03 $04 $14 $00 $01
82E140  .db $02 $06 $00 $0E $08 $08 $09 $05
82E148  .db $01 $14 $05 $06 $04 $03 $02 $07
82E150  .db $00 $06 $02 $06 $0A $04 $08 $05
82E158  .db $0A $03 $02 $20 $04 $09 $06 $04
82E160  .db $02 $0D $00 $0B $02 $27 $06 $04
82E168  .db $04 $07 $84 $09 $04 $2B $06 $01
82E170  .db $02 $05 $82 $02 $80 $06 $00 $43
82E178  .db $02 $08 $06 $02 $04 $20 $84 $08
82E180  .db $00 $10 $04 $0A $06 $02 $02 $16
82E188  .db $00 $14 $04 $14 $00 $00
----------------         
--------unidentified--------
82E18E  .db $00 $00 $00 $00 $00 $00 $00 $00
82E196  .db $00 $00 $00 $00 $00 $00 $00 $00
82E19E  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1A6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1AE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1B6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1BE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1C6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1CE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1D6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1DE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1E6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1EE  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1F6  .db $00 $00 $00 $00 $00 $00 $00 $00
82E1FE  .db $00 $00              
----------------         
--------data--------     
82E200  .db $00 $30 $02 $39 $04 $0D $06 $03
82E208  .db $02 $20 $06 $04 $04 $16 $00 $18
82E210  .db $04 $33 $00 $16 $04 $2C $00 $1C
82E218  .db $08 $25 $00 $01 $01 $0A $00 $03
82E220  .db $80 $06 $00 $30 $04 $05 $00 $0B
82E228  .db $01 $58 $00 $01 $08 $06 $88 $04
82E230  .db $08 $19 $00 $07 $08 $05 $00 $04
82E238  .db $01 $0F $05 $01 $04 $06 $84 $05
82E240  .db $04 $23 $00 $01 $01 $06 $81 $06
82E248  .db $01 $02 $00 $29 $08 $0D $00 $11
82E250  .db $01 $08 $81 $01 $80 $04 $00 $42
82E258  .db $02 $13 $04 $14 $84 $02 $80 $03
82E260  .db $00 $11 $00 $00      
----------------         
--------unidentified--------
82E264  .db $00 $00 $00 $00 $00 $00 $00 $00
82E26C  .db $00 $00 $00 $00 $00 $00 $00 $00
82E274  .db $00 $00 $00 $00 $00 $00 $00 $00
82E27C  .db $00 $00 $00 $00 $00 $00 $00 $00
82E284  .db $00 $00 $00 $00 $00 $00 $00 $00
82E28C  .db $00 $00 $00 $00 $00 $00 $00 $00
82E294  .db $00 $00 $00 $00 $00 $00 $00 $00
82E29C  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2A4  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2AC  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2B4  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2BC  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2C4  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2CC  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2D4  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2DC  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2E4  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2EC  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2F4  .db $00 $00 $00 $00 $00 $00 $00 $00
82E2FC  .db $00 $00 $00 $00      
----------------         
--------data--------     
82E300  .db $00 $1E $04 $07 $06 $03 $02 $43
82E308  .db $06 $07 $04 $4C $00 $01 $80 $08
82E310  .db $00 $6E $01 $0A $09 $03 $08 $04
82E318  .db $0A $0D $08 $03 $09 $02 $01 $03
82E320  .db $00 $0B $40 $0E $00 $4F $02 $08
82E328  .db $06 $02 $04 $24 $84 $04 $85 $02
82E330  .db $81 $03 $01 $0B $81 $09 $01 $01
82E338  .db $09 $05 $08 $12 $0A $04 $08 $11
82E340  .db $0A $09 $08 $2D $88 $05 $89 $03
82E348  .db $09 $01 $01 $78 $81 $09 $01 $12
82E350  .db $00 $01 $04 $03 $00 $48 $01 $09
82E358  .db $05 $03 $04 $02 $00 $01 $02 $11
82E360  .db $00 $04 $08 $01 $01 $03 $00 $00
----------------         
--------unidentified--------
82E368  .db $00 $00 $00 $00 $00 $00 $00 $00
82E370  .db $00 $00 $00 $00 $00 $00 $00 $00
82E378  .db $00 $00 $00 $00 $00 $00 $00 $00
82E380  .db $00 $00 $00 $00 $00 $00 $00 $00
82E388  .db $00 $00 $00 $00 $00 $00 $00 $00
82E390  .db $00 $00 $00 $00 $00 $00 $00 $00
82E398  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E3F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E400  .db $00 $6A $08 $09 $0A $04 $02 $16
82E408  .db $0A $03 $08 $5A $0A $02 $02 $05
82E410  .db $00 $02 $08 $01 $00 $01 $01 $1A
82E418  .db $05 $0D $01 $05 $05 $07 $04 $02
82E420  .db $06 $02 $02 $26 $0A $07 $08 $06
82E428  .db $0A $2E $02 $03 $06 $01 $04 $1B
82E430  .db $00 $01 $02 $03 $0A $05 $08 $10
82E438  .db $00 $01 $01 $02 $05 $03 $01 $02
82E440  .db $08 $11 $09 $0F $01 $7C $04 $04
82E448  .db $06 $02 $02 $14 $0A $02 $08 $06
82E450  .db $88 $07 $08 $31 $0A $03 $02 $2F
82E458  .db $04 $01 $05 $01 $01 $2B $05 $05
82E460  .db $04 $18 $06 $04 $02 $05 $00 $00
82E468  .db $00 $00 $00 $00 $00 $00 $00 $00
82E470  .db $00 $00 $00 $00 $00 $00 $00 $00
82E478  .db $00 $00 $00 $00 $00 $00 $00 $00
82E480  .db $00 $00 $00 $00 $00 $00 $00 $00
82E488  .db $00 $00 $00 $00 $00 $00 $00 $00
82E490  .db $00 $00 $00 $00 $00 $00 $00 $00
82E498  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E4F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E500  .db $00 $65 $01 $1F $09 $03 $08 $04
82E508  .db $88 $03 $80 $07 $00 $29 $01 $19
82E510  .db $09 $0A $08 $18 $88 $03 $80 $07
82E518  .db $00 $0E $01 $0E $09 $02 $08 $10
82E520  .db $02 $03 $82 $06 $80 $03 $00 $12
82E528  .db $04 $06 $06 $03 $02 $65 $04 $06
82E530  .db $00 $22 $40 $11 $00 $1E $08 $1A
82E538  .db $88 $04 $80 $06 $00 $13 $04 $1A
82E540  .db $05 $06 $01 $28 $00 $29 $01 $05
82E548  .db $00 $09 $01 $2A $00 $01 $02 $53
82E550  .db $00 $00 $00 $00 $00 $00 $00 $00
82E558  .db $00 $00 $00 $00 $00 $00 $00 $00
82E560  .db $00 $00 $00 $00 $00 $00 $00 $00
82E568  .db $00 $00 $00 $00 $00 $00 $00 $00
82E570  .db $00 $00 $00 $00 $00 $00 $00 $00
82E578  .db $00 $00 $00 $00 $00 $00 $00 $00
82E580  .db $00 $00 $00 $00 $00 $00 $00 $00
82E588  .db $00 $00 $00 $00 $00 $00 $00 $00
82E590  .db $00 $00 $00 $00 $00 $00 $00 $00
82E598  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E5F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E600  .db $00 $27 $02 $0F $0A $01 $08 $1E
82E608  .db $0A $01 $02 $12 $0A $02 $08 $1E
82E610  .db $0A $01 $02 $0A $06 $01 $04 $1B
82E618  .db $05 $03 $01 $18 $08 $0B $09 $02
82E620  .db $01 $38 $09 $01 $08 $16 $0A $02
82E628  .db $02 $38 $0A $02 $08 $0C $0A $02
82E630  .db $02 $1D $82 $06 $02 $07 $00 $01
82E638  .db $04 $01 $01 $2B $05 $09 $04 $0A
82E640  .db $02 $07 $0A $01 $08 $09 $0A $03
82E648  .db $02 $06 $04 $08 $84 $04 $80 $01
82E650  .db $00 $1B $08 $0A $0A $01 $02 $06
82E658  .db $00 $01 $04 $03 $01 $01 $00 $02
82E660  .db $04 $01 $02 $2E $06 $0A $04 $07
82E668  .db $02 $10 $06 $02 $04 $07 $06 $02
82E670  .db $02 $21 $06 $01 $04 $06 $44 $19
82E678  .db $04 $0F $44 $20 $04 $03 $01 $20
82E680  .db $05 $03 $04 $19 $05 $04 $01 $13
82E688  .db $04 $02 $02 $09 $00 $02 $04 $01
82E690  .db $01 $08 $00 $01 $04 $01 $00 $01
82E698  .db $02 $0B $00 $00 $00 $00 $00 $00
82E6A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E6F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E700  .db $00 $31 $01 $09 $08 $0D $09 $04
82E708  .db $01 $04 $81 $08 $01 $02 $05 $02
82E710  .db $04 $03 $00 $01 $02 $09 $00 $01
82E718  .db $08 $02 $01 $15 $00 $02 $02 $0E
82E720  .db $0A $06 $08 $03 $09 $04 $01 $08
82E728  .db $00 $25 $01 $08 $08 $01 $0A $09
82E730  .db $08 $02 $01 $10 $09 $05 $89 $01
82E738  .db $80 $09 $00 $0D $02 $1A $00 $02
82E740  .db $04 $01 $05 $06 $01 $22 $09 $05
82E748  .db $08 $0B $0A $03 $08 $07 $48 $01
82E750  .db $40 $0E $00 $05 $08 $03 $48 $04
82E758  .db $40 $0B $00 $12 $08 $0C $48 $03
82E760  .db $40 $0F $00 $0E $08 $07 $48 $05
82E768  .db $40 $0B $00 $03 $08 $13 $48 $02
82E770  .db $40 $0F $00 $06 $08 $0D $00 $01
82E778  .db $40 $0E $00 $08 $04 $01 $05 $03
82E780  .db $04 $02 $00 $01 $02 $04 $42 $01
82E788  .db $40 $1B $01 $04 $05 $07 $04 $11
82E790  .db $05 $5D $04 $0F $02 $01 $42 $05
82E798  .db $40 $04 $00 $12 $08 $21 $0A $03
82E7A0  .db $02 $3D $0A $0A $02 $0E $00 $00
82E7A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E7F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E800  .db $00 $59 $02 $09 $00 $01 $08 $32
82E808  .db $88 $06 $08 $01 $00 $04 $04 $3F
82E810  .db $00 $01 $01 $0E $81 $04 $01 $49
82E818  .db $00 $19 $40 $0B $00 $0C $02 $5D
82E820  .db $06 $01 $04 $1B $05 $0F $01 $0F
82E828  .db $09 $0F $08 $1B $09 $07 $01 $0A
82E830  .db $05 $0D $01 $23 $00 $1B $02 $08
82E838  .db $00 $35 $01 $82 $00 $02 $02 $39
82E840  .db $00 $00 $00 $00 $00 $00 $00 $00
82E848  .db $00 $00 $00 $00 $00 $00 $00 $00
82E850  .db $00 $00 $00 $00 $00 $00 $00 $00
82E858  .db $00 $00 $00 $00 $00 $00 $00 $00
82E860  .db $00 $00 $00 $00 $00 $00 $00 $00
82E868  .db $00 $00 $00 $00 $00 $00 $00 $00
82E870  .db $00 $00 $00 $00 $00 $00 $00 $00
82E878  .db $00 $00 $00 $00 $00 $00 $00 $00
82E880  .db $00 $00 $00 $00 $00 $00 $00 $00
82E888  .db $00 $00 $00 $00 $00 $00 $00 $00
82E890  .db $00 $00 $00 $00 $00 $00 $00 $00
82E898  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E8F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E900  .db $00 $5C $01 $0E $05 $03 $04 $34
82E908  .db $84 $0A $04 $08 $02 $0A $0A $01
82E910  .db $08 $02 $88 $04 $80 $06 $00 $13
82E918  .db $02 $07 $0A $07 $02 $15 $0A $04
82E920  .db $08 $1C $0A $03 $02 $44 $0A $2E
82E928  .db $08 $16 $09 $11 $01 $16 $81 $0B
82E930  .db $01 $0C $05 $05 $04 $01 $84 $09
82E938  .db $04 $13 $05 $03 $01 $03 $05 $02
82E940  .db $04 $28 $05 $02 $01 $44 $09 $1A
82E948  .db $01 $0F $00 $77 $04 $42 $00 $02
82E950  .db $02 $16 $82 $07 $00 $00 $00 $00
82E958  .db $00 $00 $00 $00 $00 $00 $00 $00
82E960  .db $00 $00 $00 $00 $00 $00 $00 $00
82E968  .db $00 $00 $00 $00 $00 $00 $00 $00
82E970  .db $00 $00 $00 $00 $00 $00 $00 $00
82E978  .db $00 $00 $00 $00 $00 $00 $00 $00
82E980  .db $00 $00 $00 $00 $00 $00 $00 $00
82E988  .db $00 $00 $00 $00 $00 $00 $00 $00
82E990  .db $00 $00 $00 $00 $00 $00 $00 $00
82E998  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82E9F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA00  .db $00 $44 $02 $01 $00 $02 $08 $11
82EA08  .db $00 $03 $08 $03 $00 $1E $04 $0F
82EA10  .db $00 $02 $02 $1C $00 $19 $04 $18
82EA18  .db $05 $01 $01 $30 $00 $01 $08 $13
82EA20  .db $02 $06 $82 $07 $02 $1A $0A $04
82EA28  .db $02 $0C $0A $01 $08 $06 $09 $0F
82EA30  .db $08 $2F $01 $06 $09 $04 $08 $05
82EA38  .db $09 $05 $01 $14 $05 $03 $04 $09
82EA40  .db $06 $02 $02 $03 $0A $03 $08 $09
82EA48  .db $09 $03 $01 $13 $05 $06 $04 $37
82EA50  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA58  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA60  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA68  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA70  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA78  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA80  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA88  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA90  .db $00 $00 $00 $00 $00 $00 $00 $00
82EA98  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EAF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB00  .db $00 $35 $01 $06 $00 $08 $02 $05
82EB08  .db $0A $07 $02 $26 $00 $01 $04 $15
82EB10  .db $05 $0E $01 $0D $05 $01 $04 $01
82EB18  .db $00 $01 $02 $08 $00 $01 $01 $16
82EB20  .db $09 $07 $08 $02 $09 $05 $01 $0A
82EB28  .db $05 $04 $01 $0F $09 $02 $08 $02
82EB30  .db $88 $07 $08 $02 $00 $14 $08 $35
82EB38  .db $09 $19 $08 $0E $0A $01 $02 $06
82EB40  .db $82 $09 $02 $17 $00 $01 $04 $02
82EB48  .db $05 $09 $04 $2B $06 $0F $02 $0E
82EB50  .db $06 $08 $02 $19 $0A $22 $02 $05
82EB58  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB60  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB68  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB70  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB78  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB80  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB88  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB90  .db $00 $00 $00 $00 $00 $00 $00 $00
82EB98  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EBF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC00  .db $00 $5A $01 $0E $00 $01 $08 $03
82EC08  .db $00 $01 $02 $1E $0A $01 $08 $02
82EC10  .db $01 $27 $00 $26 $02 $1F $00 $06
82EC18  .db $04 $09 $00 $1D $01 $15 $00 $0A
82EC20  .db $80 $06 $00 $0B $00 $00 $00 $00
82EC28  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC30  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC38  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC40  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC48  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC50  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC58  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC60  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC68  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC70  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC78  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC80  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC88  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC90  .db $00 $00 $00 $00 $00 $00 $00 $00
82EC98  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82ECF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED00  .db $00 $19 $08 $05 $88 $02 $80 $07
82ED08  .db $00 $09 $08 $09 $00 $05 $80 $0B
82ED10  .db $00 $08 $02 $09 $00 $07 $80 $08
82ED18  .db $00 $15 $80 $09 $00 $1C $80 $08
82ED20  .db $00 $18 $80 $0A $00 $18 $80 $08
82ED28  .db $00 $69 $00 $00 $00 $00 $00 $00
82ED30  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED38  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED40  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED48  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED50  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED58  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED60  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED68  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED70  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED78  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED80  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED88  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED90  .db $00 $00 $00 $00 $00 $00 $00 $00
82ED98  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EDF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE00  .db $00 $63 $04 $12 $05 $06 $01 $06
82EE08  .db $08 $17 $0A $05 $02 $0F $04 $06
82EE10  .db $05 $0C $04 $0B $01 $10 $00 $08
82EE18  .db $02 $67 $00 $FF $00 $34 $00 $00
82EE20  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE28  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE30  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE38  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE40  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE48  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE50  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE58  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE60  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE68  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE70  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE78  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE80  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE88  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE90  .db $00 $00 $00 $00 $00 $00 $00 $00
82EE98  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EED0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EED8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EEF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF00  .db $00 $42 $04 $0D $05 $03 $01 $19
82EF08  .db $05 $05 $04 $23 $06 $01 $02 $17
82EF10  .db $00 $03 $01 $18 $09 $01 $08 $02
82EF18  .db $02 $31 $08 $01 $01 $2E $09 $06
82EF20  .db $08 $20 $00 $4E $02 $1D $0A $01
82EF28  .db $08 $0F $00 $18 $04 $0A $02 $11
82EF30  .db $00 $0A $01 $0F $00 $01 $04 $01
82EF38  .db $00 $01 $02 $43 $00 $02 $04 $10
82EF40  .db $02 $08 $08 $02 $09 $03 $00 $00
82EF48  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF50  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF58  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF60  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF68  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF70  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF78  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF80  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF88  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF90  .db $00 $00 $00 $00 $00 $00 $00 $00
82EF98  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82EFF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F000  .db $00 $5F $02 $0B $00 $1F $80 $05
82F008  .db $00 $14 $01 $0D $05 $05 $04 $1D
82F010  .db $00 $0A $01 $13 $81 $06 $01 $03
82F018  .db $00 $23 $02 $0A $00 $03 $08 $01
82F020  .db $01 $33 $09 $01 $08 $0E $09 $06
82F028  .db $01 $06 $09 $07 $08 $08 $00 $05
82F030  .db $02 $03 $06 $01 $04 $0A $06 $04
82F038  .db $02 $03 $06 $1A $02 $2C $0A $17
82F040  .db $08 $08 $09 $01 $01 $0B $09 $01
82F048  .db $08 $09 $00 $03 $01 $01 $00 $05
82F050  .db $00 $00 $00 $00 $00 $00 $00 $00
82F058  .db $00 $00 $00 $00 $00 $00 $00 $00
82F060  .db $00 $00 $00 $00 $00 $00 $00 $00
82F068  .db $00 $00 $00 $00 $00 $00 $00 $00
82F070  .db $00 $00 $00 $00 $00 $00 $00 $00
82F078  .db $00 $00 $00 $00 $00 $00 $00 $00
82F080  .db $00 $00 $00 $00 $00 $00 $00 $00
82F088  .db $00 $00 $00 $00 $00 $00 $00 $00
82F090  .db $00 $00 $00 $00 $00 $00 $00 $00
82F098  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F0F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F100  .db $00 $40 $04 $07 $00 $01 $02 $12
82F108  .db $82 $04 $80 $05 $00 $1B $02 $1C
82F110  .db $00 $01 $04 $37 $05 $02 $01 $10
82F118  .db $81 $0B $01 $1F $00 $17 $01 $14
82F120  .db $09 $03 $08 $08 $09 $03 $01 $0C
82F128  .db $09 $04 $08 $05 $0A $04 $02 $04
82F130  .db $00 $0D $40 $14 $00 $0E $04 $0D
82F138  .db $06 $18 $02 $0C $00 $02 $01 $18
82F140  .db $08 $0E $02 $14 $0A $02 $08 $06
82F148  .db $00 $0F $40 $0C $00 $00 $00 $00
82F150  .db $00 $00 $00 $00 $00 $00 $00 $00
82F158  .db $00 $00 $00 $00 $00 $00 $00 $00
82F160  .db $00 $00 $00 $00 $00 $00 $00 $00
82F168  .db $00 $00 $00 $00 $00 $00 $00 $00
82F170  .db $00 $00 $00 $00 $00 $00 $00 $00
82F178  .db $00 $00 $00 $00 $00 $00 $00 $00
82F180  .db $00 $00 $00 $00 $00 $00 $00 $00
82F188  .db $00 $00 $00 $00 $00 $00 $00 $00
82F190  .db $00 $00 $00 $00 $00 $00 $00 $00
82F198  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F1F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F200  .db $00 $27 $02 $43 $82 $05 $02 $02
82F208  .db $00 $02 $08 $02 $00 $01 $01 $12
82F210  .db $08 $16 $88 $07 $08 $22 $0A $02
82F218  .db $02 $1F $82 $06 $02 $11 $00 $01
82F220  .db $04 $11 $05 $03 $01 $05 $08 $07
82F228  .db $88 $09 $08 $14 $00 $02 $01 $4E
82F230  .db $04 $06 $00 $02 $02 $27 $00 $03
82F238  .db $08 $04 $00 $04 $01 $1F $00 $05
82F240  .db $08 $0A $00 $01 $02 $14 $00 $01
82F248  .db $04 $08 $84 $05 $04 $09 $06 $01
82F250  .db $02 $08 $00 $0A $04 $13 $05 $03
82F258  .db $01 $09 $08 $0B $88 $05 $08 $09
82F260  .db $00 $44 $01 $15 $00 $01 $08 $0A
82F268  .db $0A $08 $08 $01 $88 $06 $08 $01
82F270  .db $00 $03 $01 $09 $00 $00 $00 $00
82F278  .db $00 $00 $00 $00 $00 $00 $00 $00
82F280  .db $00 $00 $00 $00 $00 $00 $00 $00
82F288  .db $00 $00 $00 $00 $00 $00 $00 $00
82F290  .db $00 $00 $00 $00 $00 $00 $00 $00
82F298  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F2F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F300  .db $00 $40 $01 $34 $81 $0A $89 $01
82F308  .db $09 $01 $08 $07 $0A $0C $02 $09
82F310  .db $0A $04 $08 $18 $88 $08 $0A $05
82F318  .db $02 $10 $00 $04 $04 $05 $05 $0D
82F320  .db $01 $0A $09 $06 $08 $03 $00 $0F
82F328  .db $08 $08 $00 $20 $02 $17 $0A $02
82F330  .db $08 $05 $00 $01 $01 $18 $09 $02
82F338  .db $89 $07 $88 $03 $08 $01 $09 $07
82F340  .db $01 $08 $00 $23 $08 $0A $00 $01
82F348  .db $02 $07 $06 $05 $04 $18 $06 $0F
82F350  .db $02 $4C $00 $03 $01 $07 $05 $0A
82F358  .db $01 $16 $09 $0F $89 $01 $88 $05
82F360  .db $80 $01 $00 $77 $00 $00 $00 $00
82F368  .db $00 $00 $00 $00 $00 $00 $00 $00
82F370  .db $00 $00 $00 $00 $00 $00 $00 $00
82F378  .db $00 $00 $00 $00 $00 $00 $00 $00
82F380  .db $00 $00 $00 $00 $00 $00 $00 $00
82F388  .db $00 $00 $00 $00 $00 $00 $00 $00
82F390  .db $00 $00 $00 $00 $00 $00 $00 $00
82F398  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F3F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F400  .db $00 $5B $02 $A7 $82 $02 $80 $02
82F408  .db $00 $02 $08 $01 $00 $01 $01 $17
82F410  .db $08 $0A $88 $06 $08 $08 $00 $11
82F418  .db $02 $18 $82 $06 $00 $05 $08 $01
82F420  .db $00 $01 $01 $21 $00 $01 $08 $04
82F428  .db $88 $06 $08 $04 $00 $01 $01 $23
82F430  .db $00 $19 $02 $30 $06 $05 $02 $10
82F438  .db $0A $07 $02 $1B $0A $07 $08 $04
82F440  .db $00 $2B $01 $0E $05 $02 $04 $16
82F448  .db $01 $2F $00 $01 $08 $09 $0A $14
82F450  .db $00 $00 $00 $00 $00 $00 $00 $00
82F458  .db $00 $00 $00 $00 $00 $00 $00 $00
82F460  .db $00 $00 $00 $00 $00 $00 $00 $00
82F468  .db $00 $00 $00 $00 $00 $00 $00 $00
82F470  .db $00 $00 $00 $00 $00 $00 $00 $00
82F478  .db $00 $00 $00 $00 $00 $00 $00 $00
82F480  .db $00 $00 $00 $00 $00 $00 $00 $00
82F488  .db $00 $00 $00 $00 $00 $00 $00 $00
82F490  .db $00 $00 $00 $00 $00 $00 $00 $00
82F498  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F4F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F500  .db $00 $E2 $01 $2C $81 $09 $09 $05
82F508  .db $08 $05 $0A $02 $02 $26 $0A $02
82F510  .db $08 $02 $88 $02 $89 $06 $09 $13
82F518  .db $01 $0F $05 $09 $01 $0A $00 $06
82F520  .db $80 $0B $00 $05 $01 $14 $08 $02
82F528  .db $0A $06 $02 $12 $0A $02 $08 $11
82F530  .db $0A $03 $02 $1F $06 $04 $04 $1E
82F538  .db $06 $09 $02 $05 $0A $13 $08 $03
82F540  .db $88 $08 $08 $02 $09 $20 $08 $02
82F548  .db $00 $0A $01 $25 $09 $13 $89 $07
82F550  .db $81 $01 $01 $07 $08 $03 $0A $06
82F558  .db $02 $08 $00 $10 $02 $05 $00 $00
82F560  .db $00 $00 $00 $00 $00 $00 $00 $00
82F568  .db $00 $00 $00 $00 $00 $00 $00 $00
82F570  .db $00 $00 $00 $00 $00 $00 $00 $00
82F578  .db $00 $00 $00 $00 $00 $00 $00 $00
82F580  .db $00 $00 $00 $00 $00 $00 $00 $00
82F588  .db $00 $00 $00 $00 $00 $00 $00 $00
82F590  .db $00 $00 $00 $00 $00 $00 $00 $00
82F598  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F5F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F600  .db $00 $FF $00 $C7 $02 $27 $00 $03
82F608  .db $08 $1C $00 $4A $01 $08 $05 $06
82F610  .db $04 $0C $05 $04 $01 $17 $00 $02
82F618  .db $08 $02 $00 $01 $02 $10 $08 $04
82F620  .db $00 $01 $01 $1D $81 $07 $01 $05
82F628  .db $00 $05 $02 $1C $08 $0B $00 $00
82F630  .db $00 $00 $00 $00 $00 $00 $00 $00
82F638  .db $00 $00 $00 $00 $00 $00 $00 $00
82F640  .db $00 $00 $00 $00 $00 $00 $00 $00
82F648  .db $00 $00 $00 $00 $00 $00 $00 $00
82F650  .db $00 $00 $00 $00 $00 $00 $00 $00
82F658  .db $00 $00 $00 $00 $00 $00 $00 $00
82F660  .db $00 $00 $00 $00 $00 $00 $00 $00
82F668  .db $00 $00 $00 $00 $00 $00 $00 $00
82F670  .db $00 $00 $00 $00 $00 $00 $00 $00
82F678  .db $00 $00 $00 $00 $00 $00 $00 $00
82F680  .db $00 $00 $00 $00 $00 $00 $00 $00
82F688  .db $00 $00 $00 $00 $00 $00 $00 $00
82F690  .db $00 $00 $00 $00 $00 $00 $00 $00
82F698  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F6F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F700  .db $00 $FF $00 $BF $01 $1C $09 $04
82F708  .db $08 $07 $0A $0E $02 $24 $04 $0C
82F710  .db $05 $04 $01 $04 $09 $04 $08 $18
82F718  .db $00 $01 $02 $05 $00 $0B $04 $0C
82F720  .db $06 $02 $02 $0A $0A $0C $08 $1F
82F728  .db $09 $08 $01 $43 $05 $0F $01 $05
82F730  .db $00 $00 $00 $00 $00 $00 $00 $00
82F738  .db $00 $00 $00 $00 $00 $00 $00 $00
82F740  .db $00 $00 $00 $00 $00 $00 $00 $00
82F748  .db $00 $00 $00 $00 $00 $00 $00 $00
82F750  .db $00 $00 $00 $00 $00 $00 $00 $00
82F758  .db $00 $00 $00 $00 $00 $00 $00 $00
82F760  .db $00 $00 $00 $00 $00 $00 $00 $00
82F768  .db $00 $00 $00 $00 $00 $00 $00 $00
82F770  .db $00 $00 $00 $00 $00 $00 $00 $00
82F778  .db $00 $00 $00 $00 $00 $00 $00 $00
82F780  .db $00 $00 $00 $00 $00 $00 $00 $00
82F788  .db $00 $00 $00 $00 $00 $00 $00 $00
82F790  .db $00 $00 $00 $00 $00 $00 $00 $00
82F798  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F7F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F800  .db $00 $83 $01 $4A $00 $0C $02 $8F
82F808  .db $00 $FF $00 $FF $00 $1C $00 $00
82F810  .db $00 $00 $00 $00 $00 $00 $00 $00
82F818  .db $00 $00 $00 $00 $00 $00 $00 $00
82F820  .db $00 $00 $00 $00 $00 $00 $00 $00
82F828  .db $00 $00 $00 $00 $00 $00 $00 $00
82F830  .db $00 $00 $00 $00 $00 $00 $00 $00
82F838  .db $00 $00 $00 $00 $00 $00 $00 $00
82F840  .db $00 $00 $00 $00 $00 $00 $00 $00
82F848  .db $00 $00 $00 $00 $00 $00 $00 $00
82F850  .db $00 $00 $00 $00 $00 $00 $00 $00
82F858  .db $00 $00 $00 $00 $00 $00 $00 $00
82F860  .db $00 $00 $00 $00 $00 $00 $00 $00
82F868  .db $00 $00 $00 $00 $00 $00 $00 $00
82F870  .db $00 $00 $00 $00 $00 $00 $00 $00
82F878  .db $00 $00 $00 $00 $00 $00 $00 $00
82F880  .db $00 $00 $00 $00 $00 $00 $00 $00
82F888  .db $00 $00 $00 $00 $00 $00 $00 $00
82F890  .db $00 $00 $00 $00 $00 $00 $00 $00
82F898  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F8F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F900  .db $00 $5B $02 $3B $00 $02 $04 $04
82F908  .db $05 $01 $01 $11 $00 $05 $08 $13
82F910  .db $00 $1A $04 $12 $00 $19 $01 $63
82F918  .db $00 $94 $10 $2D $00 $FF $00 $54
82F920  .db $00 $00 $00 $00 $00 $00 $00 $00
82F928  .db $00 $00 $00 $00 $00 $00 $00 $00
82F930  .db $00 $00 $00 $00 $00 $00 $00 $00
82F938  .db $00 $00 $00 $00 $00 $00 $00 $00
82F940  .db $00 $00 $00 $00 $00 $00 $00 $00
82F948  .db $00 $00 $00 $00 $00 $00 $00 $00
82F950  .db $00 $00 $00 $00 $00 $00 $00 $00
82F958  .db $00 $00 $00 $00 $00 $00 $00 $00
82F960  .db $00 $00 $00 $00 $00 $00 $00 $00
82F968  .db $00 $00 $00 $00 $00 $00 $00 $00
82F970  .db $00 $00 $00 $00 $00 $00 $00 $00
82F978  .db $00 $00 $00 $00 $00 $00 $00 $00
82F980  .db $00 $00 $00 $00 $00 $00 $00 $00
82F988  .db $00 $00 $00 $00 $00 $00 $00 $00
82F990  .db $00 $00 $00 $00 $00 $00 $00 $00
82F998  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9A0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9A8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9B0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9B8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9C0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9C8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9D0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9D8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9E0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9E8  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9F0  .db $00 $00 $00 $00 $00 $00 $00 $00
82F9F8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FA00  .db $00 $FF $00 $FF $00 $25 $02 $09
82FA08  .db $0A $04 $08 $16 $0A $06 $02 $0A
82FA10  .db $0A $03 $08 $06 $09 $04 $01 $32
82FA18  .db $08 $02 $02 $1F $04 $06 $05 $04
82FA20  .db $01 $35 $00 $02 $04 $01 $00 $01
82FA28  .db $02 $58 $00 $04 $02 $02 $00 $01
82FA30  .db $04 $15 $05 $01 $01 $06 $00 $01
82FA38  .db $08 $07 $00 $01 $01 $03 $05 $01
82FA40  .db $04 $05 $00 $05 $04 $01 $05 $1A
82FA48  .db $01 $06 $00 $01 $08 $0A $0A $13
82FA50  .db $08 $06 $09 $01 $01 $0B $04 $02
82FA58  .db $06 $02 $02 $1F $00 $01 $04 $13
82FA60  .db $05 $06 $01 $0B $00 $36 $01 $03
82FA68  .db $00 $00 $00 $00 $00 $00 $00 $00
82FA70  .db $00 $00 $00 $00 $00 $00 $00 $00
82FA78  .db $00 $00 $00 $00 $00 $00 $00 $00
82FA80  .db $00 $00 $00 $00 $00 $00 $00 $00
82FA88  .db $00 $00 $00 $00 $00 $00 $00 $00
82FA90  .db $00 $00 $00 $00 $00 $00 $00 $00
82FA98  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FAF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FB00  .db $00 $FF $00 $FF $00 $09 $01 $15
82FB08  .db $09 $04 $08 $06 $0A $04 $02 $14
82FB10  .db $0A $05 $02 $04 $0A $18 $08 $10
82FB18  .db $01 $10 $05 $08 $01 $07 $08 $05
82FB20  .db $0A $05 $02 $1A $00 $02 $08 $0B
82FB28  .db $09 $04 $01 $01 $00 $1E $02 $0D
82FB30  .db $00 $5E $02 $0A $0A $05 $08 $09
82FB38  .db $09 $0A $01 $09 $09 $01 $08 $06
82FB40  .db $00 $01 $01 $05 $05 $27 $01 $0D
82FB48  .db $00 $01 $08 $06 $00 $02 $02 $13
82FB50  .db $00 $09 $0A $0C $08 $0F $01 $08
82FB58  .db $08 $01 $02 $07 $08 $03 $09 $03
82FB60  .db $01 $0C $00 $02 $02 $16 $0A $01
82FB68  .db $08 $02 $01 $10 $04 $0A $05 $04
82FB70  .db $01 $09 $00 $00 $00 $00 $00 $00
82FB78  .db $00 $00 $00 $00 $00 $00 $00 $00
82FB80  .db $00 $00 $00 $00 $00 $00 $00 $00
82FB88  .db $00 $00 $00 $00 $00 $00 $00 $00
82FB90  .db $00 $00 $00 $00 $00 $00 $00 $00
82FB98  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FBF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC00  .db $00 $51 $08 $0E $09 $03 $01 $28
82FC08  .db $00 $02 $08 $01 $02 $03 $0A $02
82FC10  .db $08 $04 $09 $07 $08 $15 $00 $1A
82FC18  .db $08 $0F $0A $03 $02 $0F $0A $02
82FC20  .db $08 $02 $00 $02 $01 $0B $00 $4C
82FC28  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC30  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC38  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC40  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC48  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC50  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC58  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC60  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC68  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC70  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC78  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC80  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC88  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC90  .db $00 $00 $00 $00 $00 $00 $00 $00
82FC98  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FCF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD00  .db $00 $28 $02 $06 $08 $06 $0A $10
82FD08  .db $08 $07 $00 $03 $40 $0F $00 $1C
82FD10  .db $40 $20 $00 $1F $01 $05 $05 $11
82FD18  .db $01 $23 $09 $03 $08 $2B $00 $2B
82FD20  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD28  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD30  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD38  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD40  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD48  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD50  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD58  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD60  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD68  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD70  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD78  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD80  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD88  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD90  .db $00 $00 $00 $00 $00 $00 $00 $00
82FD98  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FDF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE00  .db $00 $4A $01 $0C $09 $02 $08 $1D
82FE08  .db $00 $15 $01 $09 $00 $01 $08 $11
82FE10  .db $00 $14 $08 $19 $00 $FF $00 $66
82FE18  .db $04 $66 $00 $02 $02 $17 $04 $17
82FE20  .db $00 $14 $02 $0E $00 $93 $00 $00
82FE28  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE30  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE38  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE40  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE48  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE50  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE58  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE60  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE68  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE70  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE78  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE80  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE88  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE90  .db $00 $00 $00 $00 $00 $00 $00 $00
82FE98  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FED0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FED8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FEF8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF00  .db $00 $25 $01 $0C $05 $03 $04 $12
82FF08  .db $00 $1B $01 $1A $00 $0B $04 $11
82FF10  .db $00 $05 $02 $0E $00 $38 $08 $19
82FF18  .db $0A $01 $02 $06 $08 $1E $09 $03
82FF20  .db $01 $17 $05 $02 $04 $32 $00 $FF
82FF28  .db $00 $FF $00 $16 $00 $00 $00 $00
82FF30  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF38  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF40  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF48  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF50  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF58  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF60  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF68  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF70  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF78  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF80  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF88  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF90  .db $00 $00 $00 $00 $00 $00 $00 $00
82FF98  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFA0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFA8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFB0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFB8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFC0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFC8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFD0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFD8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFE0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFE8  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFF0  .db $00 $00 $00 $00 $00 $00 $00 $00
82FFF8  .db $00 $00 $00 $00 $00 $00 $00 $00
