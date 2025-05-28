	
all :
	gcc sum.c -o sum -std=c99
	gcc -E sum.c > sum.i 
	gcc -S -masm=intel sum.i
	as -o sum.o sum.s
	objdump -M intel -d sum.o > sum.dump