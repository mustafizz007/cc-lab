#include<stdio.h>

int main()
{
    int id;
    scanf("my id: %d", id);

    int sum = id + 2;
    printf("%d ", sum);
    //gcc -o HelloWorld HelloWorld.c
    //gcc -E HelloWorld.c > HelloWorld.i 
    //gcc -S -masm=intel HelloWorld.i
    //as -o HelloWorld.o HelloWorld.s
    //objdump -M intel -d HelloWorld.o > HelloWorld.dump
}