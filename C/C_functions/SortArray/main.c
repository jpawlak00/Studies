#include <stdio.h>
#include <stdlib.h>

//predefinitions
int* RandomArray(int, int, int*);
void PrintArray(int, int[]);

void SortArray(int n, int* Array){

    int* ArrayPointer = Array;
    int temp;

    for(int i = 0; i < n; i++){
        for(int j = i + 1; j < n; j++){
            if (*(ArrayPointer + i) < *(ArrayPointer + j)){
                temp = *(ArrayPointer + j);
                *(ArrayPointer + j) = *(ArrayPointer + i);
                *(ArrayPointer + i) = temp;
                }
        }
    }
}




// pass n
int n = 10;
// pass range
int range = 100;

int main(){
// init array
int TestArray[n];
RandomArray(n, range, TestArray);
PrintArray(n, TestArray);
SortArray(n,TestArray);
PrintArray(n, TestArray);
}

int* RandomArray(int n, int range, int* Array){

    int* ArrayPointer = Array;
    int random;
    //random number init
    srand(time(0));

    for(int i = 0; i < n; i++){
        //generate random number
        random = rand() % range;
        *(ArrayPointer + i) = random;
    }
    return Array;
}

void PrintArray(int size, int Array[]){

    int n = size;
    printf("\n");
    for(int i = 0; i < n; i++){
        printf("%d ", Array[i]);
    }
}
