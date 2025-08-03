%{
#include "cal.tab.h"
#include <stdio.h>
#include <stdlib.h>
%}

%option yylineno

%%

"#include"      { return INCLUDE; }
"int"           { return INT; }
"char"          { return CHAR; }
"float"         { return FLOAT; }
"printf"        { return PRINTF; }
"scanf"         { return SCANF; }
"if"            { return IF; }
"else"          { return ELSE; }
"switch"        { return SWITCH; }
"case"          { return CASE; }
"default"       { return DEFAULT; }
"break"         { return BREAK; }
"return"        { return RETURN; }
"main"          { return MAIN; }

[a-zA-Z_][a-zA-Z0-9_]*      { return IDENTIFIER; }
[0-9]+                      { return INTEGER; }
[0-9]*\.[0-9]+              { return FLOAT_NUM; }
\"[^\"]*\"                  { return STRING; }
'[^']'                      { return CHARACTER; }
"<stdio.h"                  { return HEADER_INCOMPLETE; }
"<"[^>]*">"                 { return HEADER_FILE; }

"!="            { return NE; }
"=="            { return EQ; }
"="             { return ASSIGN; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULTIPLY; }
"/"             { return DIVIDE; }

"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
";"             { return SEMICOLON; }
","             { return COMMA; }
"&"             { return AMPERSAND; }
":"             { return COLON; }

[ \t\n]+        { /* ignore whitespace and newlines */ }
"//".*          { /* ignore comments */ }

.               { return yytext[0]; }

%%

int yywrap() {
    return 1;
}