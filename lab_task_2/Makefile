input = input.txt
output = output.txt

main:
	flex task1.l
	gcc lex.yy.c
	./a.exe <input1.txt> output1.txt
	./a.exe <input2.txt> output2.txt
	./a.exe <input3.txt> output3.txt
	./a.exe <input4.txt> output4.txt
	./a.exe <input5.txt> output5.txt


main2:
	bison -d cal2.y
	flex cal2.l
	gcc cal2.tab.c lex.yy.c
	a < $(input) > $(output) #./a < $(input) > $(output)
