#define NULL '\0'

void CopyString(char pcSource[], char pcDestination[]){
  
	unsigned char ucCharacterCounter;
	
	for(ucCharacterCounter = 0; pcSource[ucCharacterCounter] != NULL; ucCharacterCounter++){
		pcDestination[ucCharacterCounter] = pcSource[ucCharacterCounter];
	}
	pcDestination[ucCharacterCounter] = NULL;
}

char acCopySource[] = {"SRCSTRING"};
char acCopyDest[256];

int main(){
	CopyString(acCopySource, acCopyDest);
	return 0;
}
