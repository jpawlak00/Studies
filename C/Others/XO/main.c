#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>

char board[3][3];
const char PLAYER = 'X';
const char COMPUTER = 'O';


void resetBoard();
void printBoard();
int checkFreeSpaces();
void playerMove();
void computerMove();
char checkWinner();
void printWinner(char);




int main(){
char winner = ' ';
resetBoard();
while( winner == ' ' && checkFreeSpaces() != 0){
    printBoard();
    playerMove();
    computerMove();
    winner = checkWinner();
}
winner = checkWinner();
printBoard();
printWinner(winner);


return 0;
}

void resetBoard(){

    for(char i = 0; i < 3; i++){
        for(char j = 0; j < 3; j++){
            board[i][j] = ' ';
        }
    }

}
void printBoard(){
    printf("\n| %c | %c | %c |", board[0][0], board[0][1], board[0][2]);
    printf("\n|---|---|---|");
    printf("\n| %c | %c | %c |", board[1][0], board[1][1], board[1][2]);
    printf("\n|---|---|---|");
    printf("\n| %c | %c | %c |", board[2][0], board[2][1], board[2][2]);
    printf("\n|---|---|---|");

}
int checkFreeSpaces(){
    int freeSpacesCtr = 0;

    for(char i = 0; i < 3; i++){
        for(char j = 0; j < 3; j++){
            if (board[i][j] == ' ')
                freeSpacesCtr++;
        }
    }
    return freeSpacesCtr;
}
void playerMove(){

    int x;
    int y;
    while(1){
        printf("\n\nEnter row: ");
        scanf("%d", &x);
        printf("\n\nEnter column: ");
        scanf("%d", &y);
        if (board[x-1][y-1] != ' ')
            printf("\n\nPlace occupied!!!");
        else
            break;
}
    x = x - 1;
    y = y - 1;

    board[x][y] = PLAYER;
}
void computerMove(){
    int x;
    int y;
    srand(time(0));

    while(1){
        x = (rand()%3);
        y = (rand()%3);
        if (board[x][y] == ' '){
            board[x][y] = 'O';
            break;
        }
    }
};

char checkWinner(){
    for(char i=0; i<3; i++){
        if ((board[i][0] == board[i][1]) && (board[i][1] == board[i][2]))
            return board[i][0];
        else if ((board[0][i] == board[1][i]) && (board[1][i] == board[2][i]))
            return board[i][0];
            //diagonals
        else if ((board[0][0] == board[1][1]) && (board[1][1] == board[2][2]))
            return board[0][0];
        else if ((board[0][2] == board[1][1]) && (board[1][1] == board[2][0]))
            return board[0][2];
        else
            return ' ';
    }
}

void printWinner(char Winner){
    char cwin[] = "COMPUTER";
    char pwin[] = "PLAYER";
    if (Winner == 'O')
        printf("\n\nTHE WINNER IS %s", cwin);
    else if (Winner == 'X')
        printf("\n\nTHE WINNER IS %s", pwin);
    else
        printf("\n\nDRAW");
    return 0;
}









