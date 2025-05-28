all :
	gcc max.c -o max -std=c99
	gcc -E max.c > max.i 
	gcc -S -masm=intel max.i
	as -o max.o max.s
	objdump -M intel -d max.o > max.dump