#ifndef KEYBOARDTS_H
#define KEYBOARDTS_H

#include "TS_DISCO_F429ZI.h"

enum KeyboardState{
    RELASED,
    BUTTON_0,
    BUTTON_1,
    BUTTON_2,
    BUTTON_3};

class KeyboardTs
{
    private:    
        TS_DISCO_F429ZI ts;
        TS_StateTypeDef TS_State;
        uint8_t iOffsetX;
    public:
        KeyboardTs(char cSetColumn = 0);
        enum KeyboardState eRead();
};


#endif