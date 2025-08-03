%{
#include "cal.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%option yylineno

%%

"int"           { return INT; }
"printf"        { return PRINTF; }
"if"            { return IF; }
"for"           { return FOR; }
"break"         { return BREAK; }
"return"        { return RETURN; }
"main"          { return MAIN; }

[a-zA-Z_][a-zA-Z0-9_]*  { return IDENTIFIER; }
[0-9]+                  { return NUMBER; }
\"[^\"]*\"              { return STRING; }

"<="            { return LE; }
">="            { return GE; }
"<"             { return LT; }
">"             { return GT; }
"=="            { return EQ; }
"!="            { return NE; }
"="             { return ASSIGN; }
"+="            { return PLUS_ASSIGN; }
"++"            { return INCREMENT; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULTIPLY; }
"/"             { return DIVIDE; }
"%"             { return MODULO; }

"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
";"             { return SEMICOLON; }
","             { return COMMA; }

[ \t\n]+        { /* ignore whitespace and newlines */ }
"//".*          { /* ignore comments */ }

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}