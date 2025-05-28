all :
	gcc prime.c -o prime -std=c99
	gcc -E prime.c > prime.i 
	gcc -S -masm=intel prime.i
	as -o prime.o prime.s
	objdump -M intel -d prime.o > prime.dump