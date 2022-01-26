#define NULL '\0'

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


char cStringHex[] = {"xxxxxxxxxx"};
int main(){
	UIntToHexStr(65535, cStringHex);
}
