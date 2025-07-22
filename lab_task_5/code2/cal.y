%{
    #include <stdio.h>
    void yyerror(char *s);
    int yylex(void);
%}

%token INT_TYPE INT_NUM FLOAT_TYPE FLOAT_NUM ASSIGN SEMI ID ADD SUB MUL DIV IF GREATER LPREN RPREN LCB RCB NOT_EQUAL
%start stmts

%%

stmts : stmts stmt | ;

stmt : ass_stmt | if_stmt;


ass_stmt : ID ASSIGN expr SEMI;


if_stmt : IF LPREN condition RPREN LCB stmts RCB;

condition : ID NOT_EQUAL INT_NUM;

expr : ID
     | INT_NUM
     | FLOAT_NUM
     | expr ADD expr
     | expr SUB expr
     | expr MUL expr
     | expr DIV expr
     ;


%%

void yyerror(char *s) 
{
    fprintf(stderr, "error: %s\n", s);
}
int main(void) 
{
    yyparse();
    printf("Parsing finished\n");
    return 0;
}