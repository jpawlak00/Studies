#include "KeyboardTs.h"
#define BUT_LENGTH 80
#define TS_WIDTH 272
#define TS_LENGTH 420

KeyboardTs :: KeyboardTs(char cSetColumn){
    ts.Init(TS_LENGTH, TS_WIDTH);
    iOffsetX = cSetColumn * BUT_LENGTH;
}

enum KeyboardState eButtonArray[] = {BUTTON_0, BUTTON_1, BUTTON_2, BUTTON_3, RELASED,};

enum KeyboardState KeyboardTs :: eRead(void){
    ts.GetState(&TS_State);
    if (TS_State.TouchDetected){
        if ((iOffsetX <= TS_State.X) && TS_State.X <= (BUT_LENGTH + iOffsetX)){
            return(eButtonArray[TS_State.Y / BUT_LENGTH]); 
        }
    }
}
    
