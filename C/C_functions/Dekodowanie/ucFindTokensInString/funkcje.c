#include "funkcje.h"

#define NULL 0


//enum compResult {DIFFERENT, EQUAL};
enum compResult eCompareString(char pcStr1[], char pcStr2[]){
		
	unsigned char ucCharacterCounter;
	
	for(ucCharacterCounter = 0; (pcStr1[ucCharacterCounter] || pcStr2[ucCharacterCounter]) != NULL; ucCharacterCounter++){
		if(pcStr1[ucCharacterCounter] != pcStr2[ucCharacterCounter]){
			return DIFFERENT;
		}
	}
	return EQUAL;
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

void ReplaceCharactersInString(char pcString[], char cOldChar, char cNewChar){
	
	unsigned char ucCharacterCounter;
	
	for (ucCharacterCounter = 0; pcString[ucCharacterCounter] != NULL; ucCharacterCounter++){
		if (pcString[ucCharacterCounter] == cOldChar){
			pcString[ucCharacterCounter] = cNewChar;
    }
	}
}
