%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char *s);
int yylex(void);
%}

%union {
    int ival;
    char* sval;
}

%token <ival> INT_NUM
%token <sval> ID

%token INT_TYPE IF ELSE ASSIGN EQ NEQ MOD AND OR
%token LPAREN RPAREN LBRACE RBRACE SEMI

%type <ival> expr condition

%start stmts

%%

stmts:
    stmts stmt
    | /* empty */
    ;

stmt:
      decl_stmt
    | assign_stmt
    | if_stmt
    ;

decl_stmt:
    INT_TYPE ID ASSIGN INT_NUM SEMI
    ;

assign_stmt:
    ID ASSIGN INT_NUM SEMI
    ;

if_stmt:
    IF LPAREN condition RPAREN block ELSE block
    ;

block:
    LBRACE stmts RBRACE
    ;

condition:
      expr EQ INT_NUM         { $$ = 0; }
    | expr NEQ INT_NUM        { $$ = 0; }
    | condition AND condition { $$ = 0; }
    | condition OR condition  { $$ = 0; }
    | LPAREN condition RPAREN { $$ = 0; }
    ;

expr:
      ID               { $$ = 0; }
    | ID MOD INT_NUM   { $$ = 0; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}

int main(void) {
    yyparse();
    printf("Parsing completed\n");
    return 0;
}