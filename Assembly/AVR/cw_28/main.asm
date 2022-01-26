 /*
 * cw_28 .asm
 *
 *  Created: 10/6/2021 3:43:31 PM
 *   Author: student
 */ 

 //PINY 1-4

 ldi R16, $1E
 ldi R17, $0

MainLoop:
rcall LEDPulse
rjmp MainLoop


 LEDPulse:
     OUT DDRB, R16      //ustawiam port na OUTPUT(1)
     OUT PORTB, R16     //ustawianie stanu pinu (1, wysoki)
     OUT DDRB, R17      //ustawiam port na INPUT(0)
     IN R24, PINB       //odczyt stanu pinu

     ldi R24, 1         //zeby sprawdzic czy potem bedzie stan niski

     OUT DDRB, R16      //na INPUT
     OUT PORTB, R17     //stan niski
     OUT DDRB, R17      //na OUTPUT
     IN R24, PINB       
     ret
