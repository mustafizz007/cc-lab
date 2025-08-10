%{
    #include <stdio.h>
    void yyerror(char *s);
    int yylex(void);
%}

%token INT_TYPE INC GREATER NOT_EQUAL SEQUAL INT_NUM FLOAT_TYPE FLOAT_NUM ASSIGN SEMI ID ADD SUB MUL DIV MOD EQUAL IF ELSE LPREN RPREN LCB RCB WHILE

%start stmts

%%

stmts : stmts stmt
      | /* empty */
      ;

stmt : dec_stmt
     | while_stmt
     | increment
     ;

increment : ID INC SEMI;

dec_stmt : INT_TYPE ID ASSIGN expr SEMI;



while_stmt : WHILE LPREN condition RPREN block;

block : LCB stmts RCB;

condition : expr SEQUAL expr
          ;

expr : ID
     | INT_NUM
     | expr ADD expr
     | expr SUB expr
     | expr MUL expr
     | expr DIV expr
     | expr MOD expr
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