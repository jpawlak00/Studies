#include "mbed.h"
#include "KeyboardTsLcd.h"

KeyboardTsLcd Keyboard(0);
LedLcd LedMirror(2);
int main()
{
    while(1){
         Keyboard.eRead();

            switch(Keyboard.pKeyboard->eRead()) {
            case BUTTON_0:
                LedMirror.On(3);
                break;
            case BUTTON_1:
                LedMirror.On(2);
                break;
            case BUTTON_2:
                LedMirror.On(1);
                break;
            case BUTTON_3:
                LedMirror.On(0);
                break;
            default :
                break;
        }
        wait(0.1);
    }
}