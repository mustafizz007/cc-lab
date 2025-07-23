%{
    #include <stdio.h>
    void yyerror(char *s);
    int yylex(void);
%}

%token SWITCH BREAK GREATER NOT_EQUAL CASE DEFAULT COLON INT_TYPE INT_NUM FLOAT_TYPE FLOAT_NUM ASSIGN SEMI ID ADD SUB MUL DIV MOD EQUAL IF ELSE LPREN RPREN LCB RCB

%start stmts

%%

stmts : stmts stmt
      | /* empty */
      ;

stmt : dec_stmt
     | ass_stmt
     | switch_stmt
     ;

dec_stmt : INT_TYPE ID ASSIGN expr SEMI ;

ass_stmt : ID ASSIGN expr SEMI ;

switch_stmt : SWITCH LPREN condition RPREN LCB case_list RCB ;

case_list : case_list case_stmt
          | case_stmt
          ;

case_stmt : CASE INT_NUM COLON stmts BREAK SEMI
          | DEFAULT COLON stmts
          ;

condition : expr ;

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