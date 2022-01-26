#define NULL 0

enum Result {OK, ERROR};
 
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

char cCorrectInputHexString[] = {"0xFFFF"};
char cWrongFirstCharInputHexString[] = {"1xFFFF"};
char cWrongSecondCharInputHexString[] = {"0bFFFF"};
char cNullAtThirdPlaceInputHexString[] = {"0x"};
char cTooLongInputHexString[] = {"0xFFFFF"};

unsigned int uiOutputValue;

int main(){
	enum Result ResultCorrectStr = eHexStringToUInt (cCorrectInputHexString, &uiOutputValue); 
	enum Result ResultNot0AsFirstChar = eHexStringToUInt (cWrongFirstCharInputHexString, &uiOutputValue);
	enum Result ResultNotxAsSecondChar = eHexStringToUInt (cWrongSecondCharInputHexString, &uiOutputValue);
	enum Result ResultNullAtThirdPlace = eHexStringToUInt (cNullAtThirdPlaceInputHexString, &uiOutputValue);
	enum Result ResultStringTooLong = eHexStringToUInt (cTooLongInputHexString, &uiOutputValue);
}
