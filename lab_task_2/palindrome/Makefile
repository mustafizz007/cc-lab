all :
	gcc palindrome.c -o palindrome -std=c99
	gcc -E palindrome.c > palindrome.i 
	gcc -S -masm=intel palindrome.i
	as -o palindrome.o palindrome.s
	objdump -M intel -d palindrome.o > palindrome.dump