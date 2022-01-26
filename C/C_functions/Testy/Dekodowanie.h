
enum KeywordCode {LD, ST, RST};
enum TokenType {KEYWORD, NUMBER, STRING};
enum Stan {TOKEN, DELIMITER};

unsigned char ucFindTokensInString(char *pcString);
enum Result eStringToKeyword (char pcStr[], enum KeywordCode *peKeywordCode);
void DecodeTokens(void);
void DecodeMsg(char *pcString);
