#define NULL '\0'
void ReplaceCharactersInString(char pcString[], char cOldChar, char cNewChar){
	
	unsigned char ucCharacterCounter;
	
	for (ucCharacterCounter = 0; pcString[ucCharacterCounter] != NULL; ucCharacterCounter++){
		if (pcString[ucCharacterCounter] == cOldChar){
			pcString[ucCharacterCounter] = cNewChar;
    }
	}
}

char acCharReplTestString[] = {"test xxxx yyyy"};

int main()
{
	ReplaceCharactersInString(acCharReplTestString,'x','q');
	return 0;
}
