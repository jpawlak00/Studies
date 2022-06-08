#include "LedLcd.h"
#include "KeyboardTs.h"
#define BUT_LENGTH 80

LedLcd :: LedLcd(char cSetColumn)
{  
    lcd.Clear(LCD_COLOR_BLACK);
    cColumn = cSetColumn;
    On(1);
}

void LedLcd :: On(uint8_t ucLedNr)
{  
    int iColor;
    for (char cRowCtr = 0; cRowCtr<4; cRowCtr++) {
        if(cRowCtr == ucLedNr){
            iColor = LCD_COLOR_GREEN;
        }
        else{
            iColor = LCD_COLOR_BLUE;
        }
        DrawButton(cColumn,cRowCtr,iColor);
    }
}    

void LedLcd :: DrawButton(uint16_t uiColumn, uint16_t uiRow, int iColor)
{   
    lcd.SetTextColor(LCD_COLOR_GREEN);
    lcd.DrawRect(BUT_LENGTH*uiColumn, uiRow*BUT_LENGTH, 79, 79);
    lcd.SetTextColor(iColor);
    lcd.FillRect(BUT_LENGTH*uiColumn + 1, BUT_LENGTH*uiRow + 1, 78, 78);
    lcd.SetBackColor(LCD_COLOR_RED);
    lcd.SetTextColor(LCD_COLOR_WHITE);
    lcd.SetFont(&Font24);
    char cTemp[] = "0";
    cTemp[0] = '0' + uiRow;
    lcd.DisplayStringAt(BUT_LENGTH*uiColumn, BUT_LENGTH*uiRow, (uint8_t *) cTemp, LEFT_MODE);   
}

