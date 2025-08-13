%option noyywrap

%{
#include "cal.tab.h"
%}

digit [0-9]
num {digit}+
letter[A-Za-z]
under[_]
id ({under}|{letter})({under}|{letter}|{digit})*

%%

"#include"      { /* ignore preprocessor directives */ }
"<stdio.h>"     { /* ignore header files */ }

"int"           { return INT; }
"char"          { return CHAR; }
"main"          { return MAIN; }
"for"           { return FOR; }
"if"            { return IF; }
"else"          { return ELSE; }
"return"        { return RETURN; }
"scanf"         { return SCANF; }
"printf"        { return PRINTF; }

"=="            { return EQ; }
"!="            { return NE; }
">="            { return GE; }
"<="            { return LE; }
">"             { return GT; }
"<"             { return LT; }
"&&"            { return AND; }
"||"            { return OR; }
"++"            { return INC; }
"--"            { return DEC; }

"="             { return ASSIGN; }
";"             { return SEMI; }
","             { return COMMA; }
"("             { return LPAREN; }
")"             { return RPAREN; }
"{"             { return LBRACE; }
"}"             { return RBRACE; }
"["             { return LBRACK; }
"]"             { return RBRACK; }
"&"             { return AMPERSAND; }
"*"             { return STAR; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"/"             { return DIV; }
"%"             { return MOD; }
"?"             { return QUESTION; }
":"             { return COLON; }

{num}           { yylval.ival = atoi(yytext); return NUMBER; }
\"([^\\\"]|\\.)*\"  { yylval.sval = strdup(yytext); return STRING; }
{id}            { yylval.sval = strdup(yytext); return ID; }

[ \t\n]+        { /* skip whitespace */ }
.               { /* ignore unknown characters */ }

%%


