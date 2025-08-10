all :
	gcc factorial.c -o factorial -std=c99
	gcc -E factorial.c > factorial.i 
	gcc -S -masm=intel even.i
	as -o factorial.o factorial.s
	objdump -M intel -d factorial.o > factorial.dump