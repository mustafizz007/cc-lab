%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    void yyerror(char *s);
    int yylex(void);
%}

%union {
    int ival;
    char *sval;
}

%token <ival> NUMBER
%token <sval> ID STRING
%token INT CHAR MAIN FOR IF ELSE RETURN SCANF PRINTF
%token EQ NE GE LE GT LT AND OR INC DEC
%token ASSIGN SEMI COMMA LPAREN RPAREN LBRACE RBRACE LBRACK RBRACK
%token AMPERSAND STAR PLUS MINUS DIV MOD QUESTION COLON

%type <ival> expr condition assignment

%right ASSIGN
%left OR
%left AND  
%left EQ NE
%left GT LT GE LE
%left PLUS MINUS
%left STAR DIV MOD
%right UMINUS QUESTION COLON
%left LBRACK RBRACK LPAREN RPAREN
%left INC DEC

%start program

%%

program: function_def ;

function_def: INT MAIN LPAREN RPAREN LBRACE stmt_list RBRACE ;

stmt_list: stmt_list stmt
         | /* empty */
         ;

stmt: declaration SEMI
    | assignment SEMI
    | for_stmt
    | if_stmt  
    | function_call SEMI
    | RETURN expr SEMI
    | LBRACE stmt_list RBRACE
    | expr SEMI
    ;

declaration: INT var_list
           | CHAR STAR var_list array_decl
           ;

var_list: ID
        | var_list COMMA ID
        ;

array_decl: LBRACK RBRACK ASSIGN LBRACE init_list RBRACE
          | /* empty */
          ;

init_list: STRING
         | init_list COMMA STRING
         ;

assignment: ID ASSIGN expr                { $$ = $3; }
          | ID LBRACK expr RBRACK ASSIGN expr { $$ = $6; }
          ;

expr: NUMBER                              { $$ = $1; }
    | ID                                  { $$ = 0; }
    | AMPERSAND ID                        { $$ = 0; }
    | expr PLUS expr                      { $$ = $1 + $3; }
    | expr MINUS expr                     { $$ = $1 - $3; }
    | expr STAR expr                      { $$ = $1 * $3; }
    | expr DIV expr                       { $$ = $3 != 0 ? $1 / $3 : 0; }
    | expr MOD expr                       { $$ = $3 != 0 ? $1 % $3 : 0; }
    | expr QUESTION STRING COLON STRING   { $$ = 0; }
    | ID LBRACK expr RBRACK               { $$ = 0; }
    | LPAREN expr RPAREN                  { $$ = $2; }
    | ID INC                              { $$ = 0; }
    | ID DEC                              { $$ = 0; }
    | MINUS expr %prec UMINUS             { $$ = -$2; }
    ;

for_stmt: FOR LPAREN for_init SEMI condition SEMI for_update RPAREN stmt ;

for_init: INT ID ASSIGN expr
        | ID ASSIGN expr
        | /* empty */
        ;

for_update: ID INC
          | ID DEC
          | ID ASSIGN expr
          | /* empty */
          ;

condition: expr EQ expr                   { $$ = ($1 == $3); }
         | expr NE expr                   { $$ = ($1 != $3); }
         | expr GT expr                   { $$ = ($1 > $3); }
         | expr LT expr                   { $$ = ($1 < $3); }
         | expr GE expr                   { $$ = ($1 >= $3); }
         | expr LE expr                   { $$ = ($1 <= $3); }
         | condition AND condition        { $$ = ($1 && $3); }
         | condition OR condition         { $$ = ($1 || $3); }
         | expr                           { $$ = $1; }
         ;

if_stmt: IF LPAREN condition RPAREN stmt
       | IF LPAREN condition RPAREN stmt ELSE stmt
       ;

function_call: PRINTF LPAREN arg_list RPAREN
             | SCANF LPAREN arg_list RPAREN
             ;

arg_list: arg_list COMMA arg
        | arg
        | /* empty */
        ;

arg: STRING
   | expr
   ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}

int main(void) {
    yyparse();
    printf("Parsing completed successfully!\n");
    return 0;
}