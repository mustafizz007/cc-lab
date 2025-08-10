all :
	gcc min.c -o min -std=c99
	gcc -E min.c > min.i 
	gcc -S -masm=intel min.i
	as -o min.o min.s
	objdump -M intel -d min.o > min.dump