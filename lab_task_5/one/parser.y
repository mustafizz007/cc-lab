%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "symtab.c"
    void yyerror();
    extern int lineno;
    extern int yylex();
%}

%union
{
    char str_val[100];
    int int_val;
}

%token INT IF ELSE WHILE CONTINUE BREAK PRINT DOUBLE CHAR VOID RETURN
%token ADDOP SUBOP MULOP DIVOP EQUOP LT GT
%token LPAREN RPAREN LBRACE RBRACE SEMI ASSIGN
%token<str_val> ID
%token ICONST
%token FCONST
%token CCONST

%left LT GT /*LT GT has lowest precedence*/
%left ADDOP 
%left MULOP /*MULOP has lowest precedence*/

%type<int_val> type exp constant

%start code

%%
code: program;

program: program program_unit | program_unit;

program_unit: declaration | function;

function: type ID LPAREN parameters RPAREN LBRACE statements RBRACE
        {
            printf("Function %s declared with return type %s\n", $2, typename[$1]);
        };

parameters: /* empty */ | parameter_list;

parameter_list: parameter_list SEMI type ID | type ID;

statements: statements statement | /* empty */ ;

statement: declaration
         | if_statement
         | while_statement
         | assignment
         | return_statement
         ;

declaration: type ID SEMI
            {
                //printf("%s\n", $2);
                //printf("%d\n", $1);
                insert($2, $1);
            }
            |type ID ASSIGN exp SEMI
            ;

type: INT {$$=INT_TYPE;}
    | DOUBLE {$$=REAL_TYPE;}
    | CHAR {$$=CHAR_TYPE;}
    | VOID {$$=UNDEF_TYPE;}
    ;

exp: constant
    {
        $$ = $1;
    }
    | ID 
      {
        if(idcheck($1))
        {
            $$ = gettype($1);
        }
        else
        {
            $$ = UNDEF_TYPE;
        }
      }
    | exp ADDOP exp { $$ = typecheck($1, $3); }
    | exp SUBOP exp { $$ = typecheck($1, $3); }
    | exp MULOP exp { $$ = typecheck($1, $3); }
    | exp GT exp
    {
        //printf("%d\n", $1);
        //printf("%d\n", $3);
        $$ = typecheck($1, $3);
    }
    | exp LT exp { $$ = typecheck($1, $3); }
    | ADDOP exp %prec MULOP { $$ = $2; }
    | SUBOP exp %prec MULOP { $$ = $2; }
    | LPAREN exp RPAREN { $$ = $2; }
    ;

constant: ICONST {$$=INT_TYPE;}
        | FCONST {$$=REAL_TYPE;}
        | CCONST {$$=CHAR_TYPE;}
        ;

if_statement: IF LPAREN exp RPAREN LBRACE statements RBRACE optional_else
        ;

while_statement: WHILE LPAREN exp RPAREN LBRACE statements RBRACE
               ;

return_statement: RETURN exp SEMI
                | RETURN SEMI
                ;

optional_else: ELSE IF LPAREN exp RPAREN LBRACE statements RBRACE 
              | ELSE LBRACE statements RBRACE 
              | 
              ;

assignment: ID ASSIGN exp SEMI
          {
              if(idcheck($1))
              {
                  int id_type = gettype($1);
                  int exp_type = $3;
                  if(typecheck(id_type, exp_type) == UNDEF_TYPE)
                  {
                      printf("Type mismatch in assignment at line %d\n", lineno);
                  }
              }
          };

%%

void yyerror ()
{
    printf("Syntax error at line %d\n", lineno);
    exit(1);
}

int main (int argc, char *argv[])
{
    yyparse();
    printf("Parsing finished!\n");	
    return 0;
}
