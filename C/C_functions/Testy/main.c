#include "LancuchyZnakowe.h"
#include "LancuchyZnakoweKonwersje.h"
#include "Dekodowanie.h"

void TestOf_CopyString(){
	
	char pcSourceString[] = "SrcString";
	char pcDestString[] = "DestString";
	char pcEmptyDestString[] = "";
	
	printf("CopyString\n\n");
	
	printf("Test 1 - ");
	// kopiowanie do pustego stringu
	CopyString(pcSourceString, pcEmptyDestString);
	if (eCompareString(pcEmptyDestString, pcSourceString) == EQUAL) printf("OK\n"); else printf("Error\n");
	
	printf("Test 2 - ");
	// kopiowanie do niepustego stringu, kopiowanie znaku NULL
	CopyString(pcSourceString, pcDestString);
	if (eCompareString(pcSourceString, pcEmptyDestString) == EQUAL) printf("OK\n"); else printf("Error\n\n");
}

void TestOf_eCompareString(){
	
	char pcForComparision[] = "qwertyuiop";
	char pcSame[] = "qwertyuiop";
	char pcDifferent[] = "asdfghjkl";
	char pcExtraCharAtTheEnd[] = "qwertyuiopa";
	
	printf("eCompareString\n\n");
	
	printf("Test 1 - ");
	// porównanie identycznych stringow
	if (eCompareString(pcForComparision, pcSame) == EQUAL) printf("OK\n"); else printf("Error\n");
	
	printf("Test 2 - ");
	// porównanie roznych stringow
	if (eCompareString(pcForComparision, pcDifferent) == EQUAL) printf("OK\n"); else printf("Error\n");
	
	printf("Test 3 - ");
	// dodatkowy char na koncu 
	if (eCompareString(pcForComparision, pcExtraCharAtTheEnd) == EQUAL) printf("OK\n"); else printf("Error\n\n");
}

void TestOf_AppendString(){
	
	char pcToAppend[] = "Additional word";
	char pcDest[22] = "Base+";
	char pcCorrectOutput[] = "Base+Additional word";
	
	printf("AppendString\n\n");
	
	printf("Test 1 - ");
	// dodanie stringu na miejsce NULLA
	AppendString (pcToAppend, pcDest);
	if (eCompareString(pcCorrectOutput, pcDest) == EQUAL) printf("OK\n"); else printf("Error\n\n");	
}

void TestOf_ReplaceCharactersInString(){
	
	char pcStrToEdit[] = "xkxdemix gorniczo hutniczx";
	char pcStrToCompare[] = "akademia gorniczo hutnicza";
		
	printf("ReplaceCharactersInString\n\n");
	
	printf("Test 1 - ");
	// zamiana znaku
	ReplaceCharactersInString(pcStrToEdit, 'x', 'a');
	if (eCompareString(pcStrToEdit, pcStrToCompare) == EQUAL) printf("OK\n"); else printf("Error\n\n");	 
}


void TestOf_UIntToHexStr(){
	
	unsigned int uiDecValue = 65535;
	unsigned int uiDecValueOver4HexChars = 65536;
	char cDestString[7];
	char cDestStrFilled[] = "xxxxxxxxxx";
	char cExpectedValue[] = "0xFFFF";
		
	printf("UIntToHexStr\n\n");
	
	printf("Test 1 - ");
	// zamiana int na hex string 
	UIntToHexStr(uiDecValue, cDestString);
	if (eCompareString(cExpectedValue, cDestString) == EQUAL) printf("OK\n"); else printf("Error\n");	
	
	printf("Test 2 - ");
	// niepusta tablica docelowa 
	UIntToHexStr(uiDecValue, cDestStrFilled);
	if (eCompareString(cExpectedValue, cDestStrFilled) == EQUAL) printf("OK\n"); else printf("Error\n");
	
	printf("Test 3 - ");
	// oczekiwana wartosc wieksza niz 0xFFFF  
	UIntToHexStr(uiDecValueOver4HexChars, cDestStrFilled);
	if (eCompareString(cExpectedValue, cDestStrFilled) == EQUAL) printf("OK\n"); else printf("Error\n\n");	
}

void TestOf_eHexStringToUInt(){

	char cCorrectHexStr[] = {"0xFFFF"};
	char cWrongFirstCharHexStr[] = {"1xFFFF"};
	char cWrongSecondCharHexStr[] = {"0bFFFF"};
	char cNullAtThirdPlaceHexStr[] = {"0x"};
	char cTooLongHexString[] = {"0xFFFFF"};
	unsigned int uiOutputValue;

	printf("eHexStringToUInt\n\n");
	
	printf("Test 1 - ");
	// poprawny hex string
	eHexStringToUInt (cCorrectHexStr, &uiOutputValue);
	if (uiOutputValue == 65535) printf("OK\n"); else printf("Error\n");	
	
	printf("Test 2 - ");
	// pierwszy char nie jest zerem 
	eHexStringToUInt (cWrongFirstCharHexStr, &uiOutputValue);
	if (uiOutputValue == 65535) printf("OK\n"); else printf("Error\n");
	
	printf("Test 3 - ");
	// drugi char nie jest x  
	eHexStringToUInt (cWrongSecondCharHexStr, &uiOutputValue);
	if (uiOutputValue == 65535) printf("OK\n"); else printf("Error\n");
	
	printf("Test 4 - ");
	// NULL na trzecim miejscu 
	eHexStringToUInt (cNullAtThirdPlaceHexStr, &uiOutputValue);
	if (uiOutputValue == 65535) printf("OK\n"); else printf("Error\n");
	
	printf("Test 4 - ");
	// za dlugi string 
	eHexStringToUInt (cTooLongHexString, &uiOutputValue);
	if (uiOutputValue == 65535) printf("OK\n"); else printf("Error\n");
}


void TestOf_AppendUIntToString(){

	char cString[15] = "xxxxx";
	char cEmptyStr[] = "";
	char cExpectedValue1[] = "xxxxx0xFFFF";
	char cExpectedValue2[] = "0xFFFF";
	unsigned int uiInputValue = 65355;

	printf("AppendUIntToString\n\n");
	
	printf("Test 1 - ");
	// dodanie liczby hex do stringu
	AppendUIntToString(uiInputValue, cString);
	if (eCompareString(cExpectedValue1, cString) == EQUAL) printf("OK\n"); else printf("Error\n");
	
	printf("Test 2 - ");
	// pusty string
	AppendUIntToString(uiInputValue, cEmptyStr);
	if (eCompareString(cExpectedValue2, cEmptyStr) == EQUAL) printf("OK\n"); else printf("Error\n\n");
}


int main(){}

