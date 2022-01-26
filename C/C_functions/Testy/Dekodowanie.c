#include "LancuchyZnakowe.h"
#include "LancuchyZnakoweKonwersje.h"
#include "Dekodowanie.h"
#define NULL 0
#define MAX_TOKEN_NR 3
#define MAX_KEYWORD_STRING_LTH 10
#define MAX_KEYWORD_NR 3

//enum KeywordCode {LD, ST, RST};

union TokenValue{
	enum KeywordCode eKeyword;
	unsigned int uiNumber;
	char *pcString;
};

//enum TokenType {KEYWORD, NUMBER, STRING};

struct Token{
	enum TokenType eType;
	union TokenValue uValue;
};

struct Token asToken[MAX_TOKEN_NR];

struct Keyword{
	enum KeywordCode eCode;
	char cString[MAX_KEYWORD_STRING_LTH + 1];
};

struct Keyword asKeywordList[MAX_KEYWORD_NR]=
{
	{RST, "reset"},
	{LD, "load" },
	{ST, "store"}
};

unsigned char ucTokenNr;

//enum Stan {TOKEN, DELIMITER};

unsigned char ucFindTokensInString(char *pcString){
	
	unsigned char ucCharacterCounter;
	unsigned char ucTokenNr = 0;
	unsigned char ucCurrentCharacter;
	enum Stan eStan=DELIMITER;
	
	for(ucCharacterCounter = 0; ;ucCharacterCounter++){
		ucCurrentCharacter = pcString[ucCharacterCounter];
		switch(eStan){
			case TOKEN:
			{
				if(ucTokenNr == MAX_TOKEN_NR){
					return ucTokenNr;
				}
				else if(ucCurrentCharacter == NULL){
					return ucTokenNr;
				}
				else if(ucCurrentCharacter != ' '){
					eStan = TOKEN;
				}
				else{
					eStan = DELIMITER;
				}
				break;
			}
			case DELIMITER:
			{
				if(ucCurrentCharacter == NULL){
					return ucTokenNr;
				}
				else if(ucCurrentCharacter == ' '){
					eStan = DELIMITER;
				}
				else{
					eStan = TOKEN;
					asToken[ucTokenNr].uValue.pcString = pcString + ucCharacterCounter;
					ucTokenNr++;
				}
				break;
			}
		}
	}
}

enum Result eStringToKeyword (char pcStr[], enum KeywordCode *peKeywordCode){

	unsigned char ucKeywordCounter;
	
	for(ucKeywordCounter = 0; ucKeywordCounter < MAX_KEYWORD_NR; ucKeywordCounter++){
		if(EQUAL == eCompareString(asKeywordList[ucKeywordCounter].cString, pcStr)){
			*peKeywordCode = asKeywordList[ucKeywordCounter].eCode;
			return OK;
		}
	}
	return ERROR;
}

void DecodeTokens(void){
	
	unsigned char ucTokenCounter;
	struct Token *psCurrentToken;
	unsigned int uiTokenValue;
	enum KeywordCode eTokenCode;

	for(ucTokenCounter = 0; ucTokenCounter < ucTokenNr; ucTokenCounter++){
		psCurrentToken = &asToken[ucTokenCounter];
		if(OK == eHexStringToUInt(psCurrentToken->uValue.pcString, &uiTokenValue)){
			psCurrentToken->eType = NUMBER;
			psCurrentToken->uValue.uiNumber = uiTokenValue;
		}
		else if(OK == eStringToKeyword(psCurrentToken->uValue.pcString, &eTokenCode)){
			psCurrentToken->eType = KEYWORD;
			psCurrentToken->uValue.eKeyword = eTokenCode;
		}
		else{
			psCurrentToken->eType = STRING;
		}
	}
}
void DecodeMsg(char *pcString){
	ucTokenNr = ucFindTokensInString(pcString);
	ReplaceCharactersInString(pcString, ' ', NULL);
	DecodeTokens();
}
