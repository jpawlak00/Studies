#ifndef LEDLCD_H
#define LEDLCD_H

#include "LCD_DISCO_F429ZI.h"
#include "KeyboardTs.h"

class LedLcd
{
    private:
        LCD_DISCO_F429ZI lcd; 
        char cColumn;
        void DrawButton(uint16_t uiColumn, uint16_t uiRow, int iColor);
    public:
        LedLcd(char cSetColumn = 0);
        void On(uint8_t);
};


#endif