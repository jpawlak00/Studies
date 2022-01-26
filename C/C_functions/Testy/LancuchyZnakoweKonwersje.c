#include "LancuchyZnakowe.h"
#include "LancuchyZnakoweKonwersje.h"
#include "Dekodowanie.h"

#define NULL 0

void UIntToHexStr (unsigned int uiValue, char pcStr[]){
	
	char cTetradCounter;
	char cCurrentTetrad;
	
	pcStr[0] = '0';
	pcStr[1] = 'x';
	pcStr[6] = NULL;
	
	for (cTetradCounter = 0; cTetradCounter < 4; cTetradCounter++){
		cCurrentTetrad = (uiValue >> (cTetradCounter * 4)) & 0xF;
		if(cCurrentTetrad < 10){
			pcStr[5 - cTetradCounter] = '0' + cCurrentTetrad;
		}
		else{
		pcStr[5 - cTetradCounter] = 'A' + (cCurrentTetrad - 10);
		}
	}
}


//enum Result {OK, ERROR};
 
enum Result eHexStringToUInt (char pcStr[], unsigned int *puiValue){
	
	char cCharacterCounter;
	char cCurrentCharacter;
	
	*puiValue = 0;
	
	if((pcStr[0] != '0') || (pcStr[1] != 'x') || (pcStr[2] == NULL)){ 
		return ERROR; 
	}
	for(cCharacterCounter = 2; pcStr[cCharacterCounter] != NULL; cCharacterCounter++){
		
		cCurrentCharacter = pcStr[cCharacterCounter];
		
		*puiValue = *puiValue << 4;
		
		if (cCharacterCounter == 6){
			return ERROR;
		}
		if((cCurrentCharacter >= '0') && (cCurrentCharacter <= '9')){
			*puiValue = (*puiValue | cCurrentCharacter - '0');	
		}
		else if((cCurrentCharacter <= 'F') && (cCurrentCharacter >= 'A')){
			*puiValue = (*puiValue | cCurrentCharacter - 'A' + 10);	
		} 
		else{
			return ERROR;
		}
	}
	return OK;
}


void AppendUIntToString(unsigned int uiValue, char pcDestinationStr[]){
	
	unsigned char ucCharacterCounter;
	
	for(ucCharacterCounter = 0; pcDestinationStr[ucCharacterCounter] != NULL; ucCharacterCounter++){}
  UIntToHexStr(uiValue, &pcDestinationStr[ucCharacterCounter]);
}
