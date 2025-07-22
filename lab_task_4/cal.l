%option noyywrap

%{
#include "cal.tab.h"
%}

digit [0-9]
num {digit}{digit}*
delim [ \t\n]
letter[A-Za-z]
under[_]
float_num{num}*[.]{num}

%%

ws {}


"int" {return (INT_TYPE);}
"float" {return (FLOAT_TYPE);}

"=" {return(ASSIGN);}
";" {return(SEMI);}
">" {return (GREATER);}
"if" {return (IF);}
"(" { return (LPREN); }
")" { return (RPREN); }
"{" {return (LCB);}
"}" {return (RCB);}

{num} {yylval = atoi(yytext); return (INT_NUM);}
{float_num} {yylval = atof(yytext); return(FLOAT_NUM);}


"+" {return (ADD);}
"-" {return (SUB);}
"*" {return (MUL);}
"/" {return (DIV);}



({under}|{letter})({under}|{letter}|{digit})* {return (ID);}


%%


