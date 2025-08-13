%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    void yyerror();
    extern int lineno;
    extern int yylex();
%}

%union
{
    char str_val[100];
    int int_val;
    float float_val;
}

%token INT FLOAT IF ELSE FOR WHILE CONTINUE BREAK PRINTF SCANF DOUBLE CHAR VOID RETURN
%token ADDOP SUBOP MULOP DIVOP INCOP DECOP ADDASSIGN MULASSIGN
%token EQUOP NEOP LT GT GE LE AND OR
%token QUESTION COLON
%token LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK SEMI COMMA ASSIGN AMPERSAND
%token<str_val> ID STRING
%token<int_val> ICONST
%token<float_val> FCONST
%token CCONST

%left COMMA
%right ASSIGN ADDASSIGN MULASSIGN
%left OR
%left AND
%left EQUOP NEOP
%left LT GT GE LE  
%left ADDOP SUBOP
%left MULOP DIVOP
%right UMINUS
%right QUESTION COLON
%left INCOP DECOP
%left LBRACK RBRACK LPAREN RPAREN
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%start program

%%

program: translation_units ;

translation_units: translation_units translation_unit
                 | translation_unit
                 ;

translation_unit: function_definition
                | declaration SEMI
                ;

function_definition: type ID LPAREN param_list RPAREN LBRACE statements RBRACE
                   | type ID LPAREN RPAREN LBRACE statements RBRACE
                   ;

param_list: param_list COMMA type ID
          | type ID
          ;

statements: statements statement
          | /* empty */
          ;

statement: declaration SEMI
         | assignment SEMI
         | assignment  /* Allow assignment without semicolon in certain contexts */
         | if_statement
         | for_statement
         | while_statement
         | return_statement
         | function_call SEMI
         | block_statement
         | exp SEMI
         ;

block_statement: LBRACE statements RBRACE ;

declaration: type id_list
           | type MULOP ID LBRACK RBRACK ASSIGN LBRACE init_list RBRACE
           ;

id_list: ID
       | ID LBRACK ICONST RBRACK
       | ID ASSIGN exp
       | id_list COMMA ID
       | id_list COMMA ID LBRACK ICONST RBRACK
       | id_list COMMA ID ASSIGN exp
       ;

init_list: init_list COMMA STRING
         | STRING
         ;

assignment: ID ASSIGN exp
          | ID LBRACK exp RBRACK ASSIGN exp
          | ID ADDASSIGN exp
          | ID MULASSIGN exp
          ;

type: INT
    | FLOAT
    | DOUBLE
    | CHAR
    | VOID
    ;

exp: ICONST
   | FCONST
   | STRING
   | ID
   | ID LBRACK exp RBRACK
   | ID INCOP
   | ID DECOP
   | function_call
   | exp ADDOP exp
   | exp SUBOP exp
   | exp MULOP exp
   | exp DIVOP exp
   | exp GT exp
   | exp LT exp
   | exp GE exp
   | exp LE exp
   | exp EQUOP exp
   | exp NEOP exp
   | exp AND exp
   | exp OR exp
   | exp QUESTION STRING COLON STRING
   | exp QUESTION exp COLON exp
   | ADDOP exp %prec UMINUS
   | SUBOP exp %prec UMINUS
   | LPAREN exp RPAREN
   | AMPERSAND ID
   ;

function_call: ID LPAREN arg_list RPAREN
             | ID LPAREN RPAREN
             | PRINTF LPAREN arg_list RPAREN
             | SCANF LPAREN arg_list RPAREN
             ;

arg_list: arg_list COMMA arg
        | arg
        ;

arg: exp
   ;

if_statement: IF LPAREN exp RPAREN statement %prec LOWER_THAN_ELSE
            | IF LPAREN exp RPAREN statement ELSE statement
            ;

for_statement: FOR LPAREN for_init SEMI exp SEMI for_update RPAREN statement ;

for_init: assignment
        | declaration
        | /* empty */
        ;

for_update: assignment
          | exp
          | /* empty */
          ;

while_statement: WHILE LPAREN exp RPAREN statement ;

return_statement: RETURN exp SEMI
                | RETURN SEMI
                ;

%%

void yyerror ()
{
    printf("Syntax error at line %d\n", lineno);
    exit(1);
}

int main (int argc, char *argv[])
{
    yyparse();
    printf("Parsing completed successfully!\n");
    return 0;
}
