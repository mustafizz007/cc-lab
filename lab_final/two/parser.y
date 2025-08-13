%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "symtab.h"
    void yyerror();
    extern int lineno;
    extern int yylex();
    
    int param_count = 0;
    int arg_count = 0;
%}

%union
{
    char str_val[100];
    int int_val;
    float float_val;
    param_list* param_list_val;
}

%token INT FLOAT IF ELSE FOR WHILE CONTINUE BREAK PRINTF DOUBLE CHAR VOID RETURN
%token ADDOP SUBOP MULOP DIVOP INCOP DECOP ADDASSIGN
%token EQUOP NEOP LT GT GE LE
%token LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK SEMI COMMA ASSIGN
%token<str_val> ID STRING
%token<int_val> ICONST
%token<float_val> FCONST
%token CCONST

%left COMMA
%right ASSIGN ADDASSIGN
%left OR
%left AND
%left EQUOP NEOP
%left LT GT GE LE  
%left ADDOP SUBOP
%left MULOP DIVOP
%right UMINUS
%left INCOP DECOP
%left LBRACK RBRACK LPAREN RPAREN
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%type<int_val> type exp constant function_call
%type<param_list_val> param_list arg_list

%start program

%%

program: translation_units ;

translation_units: translation_units translation_unit
                 | translation_unit
                 ;

translation_unit: function_declaration
                | function_definition
                | declaration
                ;

function_declaration: type ID LPAREN param_list RPAREN SEMI
                    {
                        insert_function($2, $1, $4, param_count);
                        param_count = 0;
                    }
                    ;

function_definition: type ID LPAREN param_list RPAREN 
                   {
                       insert_function($2, $1, $4, param_count);
                       param_count = 0;
                       enter_scope();
                   }
                   LBRACE statements RBRACE
                   {
                       exit_scope();
                   }
                   ;

param_list: param_list COMMA type ID
          {
              add_param(&$$, $3);
              param_count++;
          }
          | type ID
          {
              $$ = NULL;
              add_param(&$$, $1);
              param_count = 1;
          }
          | /* empty */
          {
              $$ = NULL;
              param_count = 0;
          }
          ;

statements: statements statement
          | /* empty */
          ;

statement: declaration SEMI
         | assignment SEMI
         | if_statement
         | for_statement
         | while_statement
         | return_statement
         | function_call SEMI
         | block_statement
         | exp SEMI
         ;

block_statement: LBRACE 
               {
                   enter_scope();
               }
               statements RBRACE
               {
                   exit_scope();
               }
               ;

declaration: type ID
           {
               insert($2, $1);
           }
           | type ID LBRACK ICONST RBRACK
           {
               insert_array($2, $1, $4);
           }
           | type ID ASSIGN exp
           {
               insert($2, $1);
               if(typecheck($1, $4) == UNDEF_TYPE)
               {
                   printf("In line no %d, Type mismatch in declaration assignment.\n", lineno);
               }
           }
           ;

assignment: ID ASSIGN exp
          {
              if(idcheck($1))
              {
                  int id_type = gettype($1);
                  if(typecheck(id_type, $3) == UNDEF_TYPE)
                  {
                      printf("In line no %d, Type mismatch in assignment.\n", lineno);
                  }
              }
          }
          | ID LBRACK exp RBRACK ASSIGN exp
          {
              if(idcheck($1))
              {
                  int id_type = gettype($1);
                  if(typecheck(id_type, $6) == UNDEF_TYPE)
                  {
                      printf("In line no %d, Type mismatch in array assignment.\n", lineno);
                  }
              }
          }
          | ID ADDASSIGN exp
          {
              if(idcheck($1))
              {
                  int id_type = gettype($1);
                  if(typecheck(id_type, $3) == UNDEF_TYPE)
                  {
                      printf("In line no %d, Type mismatch in += assignment.\n", lineno);
                  }
              }
          }
          ;

type: INT     {$$=INT_TYPE;}
    | FLOAT   {$$=REAL_TYPE;}
    | DOUBLE  {$$=REAL_TYPE;}
    | CHAR    {$$=CHAR_TYPE;}
    | VOID    {$$=UNDEF_TYPE;}
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
   | ID LBRACK exp RBRACK
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
   | ID INCOP
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
   | ID DECOP
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
   | function_call
   {
       $$ = $1;
   }
   | exp ADDOP exp { $$ = typecheck($1, $3); }
   | exp SUBOP exp { $$ = typecheck($1, $3); }
   | exp MULOP exp { $$ = typecheck($1, $3); }
   | exp DIVOP exp { $$ = typecheck($1, $3); }
   | exp GT exp    { $$ = typecheck($1, $3); }
   | exp LT exp    { $$ = typecheck($1, $3); }
   | exp GE exp    { $$ = typecheck($1, $3); }
   | exp LE exp    { $$ = typecheck($1, $3); }
   | exp EQUOP exp { $$ = typecheck($1, $3); }
   | exp NEOP exp  { $$ = typecheck($1, $3); }
   | ADDOP exp %prec UMINUS { $$ = $2; }
   | SUBOP exp %prec UMINUS { $$ = $2; }
   | LPAREN exp RPAREN { $$ = $2; }
   ;

constant: ICONST {$$=INT_TYPE;}
        | FCONST {$$=REAL_TYPE;}
        | CCONST {$$=CHAR_TYPE;}
        ;

function_call: ID LPAREN arg_list RPAREN
             {
                 $$ = check_function_call($1, $3, arg_count);
                 arg_count = 0;
             }
             | ID LPAREN RPAREN
             {
                 $$ = check_function_call($1, NULL, 0);
             }
             | PRINTF LPAREN arg_list RPAREN
             {
                 $$ = INT_TYPE; // printf returns int
                 arg_count = 0;
             }
             ;

arg_list: arg_list COMMA exp
        {
            add_param(&$$, $3);
            arg_count++;
        }
        | arg_list COMMA STRING
        {
            add_param(&$$, CHAR_TYPE);
            arg_count++;
        }
        | exp
        {
            $$ = NULL;
            add_param(&$$, $1);
            arg_count = 1;
        }
        | STRING
        {
            $$ = NULL;
            add_param(&$$, CHAR_TYPE);
            arg_count = 1;
        }
        ;

if_statement: IF LPAREN exp RPAREN statement %prec LOWER_THAN_ELSE
            | IF LPAREN exp RPAREN statement ELSE statement
            ;

for_statement: FOR LPAREN for_init SEMI exp SEMI for_update RPAREN statement
             ;

for_init: ID ASSIGN exp
        {
            if(idcheck($1))
            {
                int id_type = gettype($1);
                if(typecheck(id_type, $3) == UNDEF_TYPE)
                {
                    printf("In line no %d, Type mismatch in for loop initialization.\n", lineno);
                }
            }
        }
        | declaration
        | /* empty */
        ;

for_update: ID ASSIGN exp
          {
              if(idcheck($1))
              {
                  int id_type = gettype($1);
                  if(typecheck(id_type, $3) == UNDEF_TYPE)
                  {
                      printf("In line no %d, Type mismatch in for loop update.\n", lineno);
                  }
              }
          }
          | ID INCOP
          {
              if(!idcheck($1))
              {
                  printf("In line no %d, Variable %s not declared in for loop update.\n", lineno, $1);
              }
          }
          | ID DECOP
          {
              if(!idcheck($1))
              {
                  printf("In line no %d, Variable %s not declared in for loop update.\n", lineno, $1);
              }
          }
          | /* empty */
          ;

while_statement: WHILE LPAREN exp RPAREN statement
               ;

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
    printf("Semantic analysis completed!\n");
    return 0;
}
