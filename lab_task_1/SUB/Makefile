all:
	gcc sub.c -o sub -std=c99
	gcc -E sub.c > sub.i 
	gcc -S -masm=intel sub.i
	as -o sub.o sub.s
	objdump -M intel -d sub.o > sub.dump