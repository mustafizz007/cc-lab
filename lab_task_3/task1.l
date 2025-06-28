%option noyywrap

%{
#include <stdio.h>
%}

KEYWORD     int|float|char|double|for|while|if|else|return
ID          [a-zA-Z_][a-zA-Z0-9_]*
NUM         -?[0-9]+(\.[0-9]+)?([eE][-+]?[0-9]+)?
CHARCONST   \'[^']\'
STRING      \"([^\"\n]|\\\")*\"
OPERATOR    (\+\+|\+|\-|\*|\/|==|!=|<=|>=|=|<|>|\&\&|\|\|)
DELIM       [ \t\r]
NEWLINE     \n

%%

{KEYWORD}     { printf("%s -> KEYWORD\n", yytext); }
{ID}          { printf("%s -> IDENTIFIER\n", yytext); }
{NUM}         { printf("%s -> NUMBER\n", yytext); }
{CHARCONST}   { printf("%s -> CHAR_CONSTANT\n", yytext); }
{STRING}      { printf("%s -> STRING_LITERAL\n", yytext); }
{OPERATOR}    { printf("%s -> OPERATOR\n", yytext); }

"("           { printf("%s -> LPAREN\n", yytext); }
")"           { printf("%s -> RPAREN\n", yytext); }
"{"           { printf("%s -> LBRACE\n", yytext); }
"}"           { printf("%s -> RBRACE\n", yytext); }
";"           { printf("%s -> SEMICOLON\n", yytext); }
","           { printf("%s -> COMMA\n", yytext); }
"&"           { printf("%s -> ADDRESS_OP\n", yytext); }

{DELIM}       { /* ignore space/tab */ }
{NEWLINE}     { /* ignore newline */ }
.             { printf("%s -> UNKNOWN\n", yytext); }

%%

int main() {
    yylex();
    return 0;
}
