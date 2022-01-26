#define NULL '\0'

enum compResult {DIFFERENT, EQUAL};
enum compResult eCompareString(char pcStr1[], char pcStr2[]){
		
	unsigned char ucCharacterCounter;
	
	for(ucCharacterCounter = 0; (pcStr1[ucCharacterCounter] || pcStr2[ucCharacterCounter]) != NULL; ucCharacterCounter++){
		if(pcStr1[ucCharacterCounter] != pcStr2[ucCharacterCounter]){
			return DIFFERENT;
		}
	}
	return EQUAL;
}

char acStrForComparition1[] = {"qwerty"};
char acStrForComparition2[] = {"qwerty"};

int main()
{
	enum compResult eCompTest = eCompareString(acStrForComparition1, acStrForComparition2);
}




    /*if (eCompareString(forComparition2, forComparition1) == EQUAL)
    {
        compResult= 1;
    }
    else if (eCompareString(forComparition2, forComparition1) == DIFFERENT)
    {
        compResult= 2;
    }
		return 0;*/
