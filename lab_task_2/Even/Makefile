all :
	gcc even.c -o even -std=c99
	gcc -E even.c > even.i 
	gcc -S -masm=intel even.i
	as -o even.o even.s
	objdump -M intel -d even.o > even.dump