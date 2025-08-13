%option noyywrap

%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "cal.tab.h"
	
	int lineno = 1; // initialize to 1
	void yyerror();
%}

alpha     [a-zA-Z]
digit     [0-9]
alnum     {alpha}|{digit}
print     [ -~]

ID        {alpha}{alnum}*
ICONST    [0-9]{digit}*
FCONST    {digit}*"."{digit}+
CCONST    (\'{print}\')
STRING    \"{print}*\"
%%

"#include".*\n  { lineno++; } /* Skip preprocessor directives */
"//".*          { } 

"int"      { return INT; }
"float"    { return FLOAT; }
"double"   { return DOUBLE; }
"char"	   { return CHAR; }
"void"     { return VOID; }

"if"	   { return IF; }
"else"	   { return ELSE; }
"for"      { return FOR; }
"while"    { return WHILE; }
"continue" { return CONTINUE; }
"break"    { return BREAK; }
"printf"   { return PRINTF; }
"scanf"    { return SCANF; }
"return"   { return RETURN; }

"+"        { return ADDOP; }
"-"        { return SUBOP; }
"*"        { return MULOP; }
"/"        { return DIVOP; }
"++"       { return INCOP; }
"--"       { return DECOP; }
"+="       { return ADDASSIGN; }
"*="       { return MULASSIGN; }

"=="       { return EQUOP; }
"!="       { return NEOP; }
">"        { return GT; }
"<"        { return LT; }
">="       { return GE; }
"<="       { return LE; }
"&&"       { return AND; }
"||"       { return OR; }

"?"        { return QUESTION; }
":"        { return COLON; }

"("        { return LPAREN; }
")"        { return RPAREN; }
"{"        { return LBRACE; }
"}"        { return RBRACE; }
"["        { return LBRACK; }
"]"        { return RBRACK; }
";"        { return SEMI; }
","        { return COMMA; }
"="        { return ASSIGN; }
"&"        { return AMPERSAND; }

{ID}        { strcpy(yylval.str_val, yytext); return ID; }
{ICONST}    { yylval.int_val = atoi(yytext); return ICONST; }
{FCONST}    { yylval.float_val = atof(yytext); return FCONST; }
{CCONST}    { return CCONST; }
{STRING}    { strcpy(yylval.str_val, yytext); return STRING; }

"\n"        { lineno += 1; }
[ \t\r\f]+  

.           { yyerror("Unrecognized character"); }
