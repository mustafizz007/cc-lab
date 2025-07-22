%{
    #include <stdio.h>
    void yyerror(char *s);
    int yylex(void);
%}

%token INT_TYPE INT_NUM FLOAT_TYPE FLOAT_NUM ASSIGN SEMI ID ADD SUB MUL DIV MOD EQUAL IF ELSE LPREN RPREN LCB RCB

%start stmts

%%

stmts : stmts stmt
      | /* empty */
      ;

stmt : dec_stmt
     | assign_stmt
     | if_stmt
     ;

dec_stmt : INT_TYPE ID SEMI
         | INT_TYPE ID ASSIGN expr SEMI
         ;

assign_stmt : ID ASSIGN expr SEMI ;

if_stmt : IF LPREN condition RPREN block
        | IF LPREN condition RPREN block ELSE block
        ;

block : LCB stmts RCB ;

condition : expr EQUAL expr
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