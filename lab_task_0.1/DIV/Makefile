all: 
	gcc div.c -o div -std=c99
	gcc -E div.c > div.i 
	gcc -S -masm=intel div.i
	as -o div.o div.s
	objdump -M intel -d div.o > div.dump