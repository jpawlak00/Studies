 /*
 * cw_37 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

 //SQUARE

 ldi R16, 8

 SquareDigit:
     ldi R30, low(Table << 1)    //inicjalizacja rejestru Z, << mnozenie x2
     ldi R31, high(Table << 1)
     add R30, R16
     lpm R16, Z
 ret


 Table: .db 0, 1, 4, 9, 16, 25, 36, 49, 64, 81





























/*NIEDOKONCZONY SQUARE
//SQUARE FUNCTION

ldi R30, low(Table << 1)    //inicjalizacja rejestru
ldi R31, high(Table << 1)

//9^=9+9+9+9...


ldi R16,0
Square:                             //podaje argument funkcji x^2
    push R16 
    Square1: 
            dec R16              //ustawia pozycje
            brbs 1, DUPA
            adiw R30:R31, 1
            rjmp Square1         //---
                DUPA: 
                    pop R16//lpm R16, Z       //pop R16
                    add R17, R16
                    add R18, R16
                        Loop1:dec R17
                        brbs 1, End
                            add R16, R18
                            rjmp Loop1
    End: ret

Table: .db 0, 1, 2, 3, 4, 5, 6, 7, 8, 9*/

