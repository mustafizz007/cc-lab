%{
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>
%}

digit   [0-9]+
id      [a-zA-Z_][a-zA-Z0-9_]*

%%

"int"       { return INT_TYPE; }
"if"        { return IF; }
"else"      { return ELSE; }

"="         { return ASSIGN; }
"=="        { return EQ; }
"!="        { return NEQ; }
"%"         { return MOD; }
"&&"        { return AND; }
"\|\|"      { return OR; }

"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
";"         { return SEMI; }

{digit}     { yylval.ival = atoi(yytext); return INT_NUM; }
{id}        { yylval.sval = strdup(yytext); return ID; }

[ \t\n]     ; // skip whitespace
.           { printf("Unknown char: %s\n", yytext); }

%%

int yywrap() { return 1; }
