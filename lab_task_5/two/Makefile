input = input.txt
output = output.txt

main: lexer.l parser.y symtab.c symtab.h
	bison -d parser.y 
	flex lexer.l 
	gcc parser.tab.c lex.yy.c -o analyzer
	./analyzer < $(input) > $(output)
	


