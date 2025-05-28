all :    
	gcc mul.c -o mul -std=c99
	gcc -E mul.c > mul.i 
	gcc -S -masm=intel mul.i
	as -o mul.o mul.s
	objdump -M intel -d mul.o > mul.dump