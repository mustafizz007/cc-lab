%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
extern int yylineno;
%}

%token INCLUDE INT CHAR FLOAT PRINTF SCANF IF ELSE SWITCH CASE DEFAULT BREAK RETURN MAIN
%token IDENTIFIER INTEGER FLOAT_NUM STRING CHARACTER HEADER_FILE HEADER_INCOMPLETE
%token NE EQ ASSIGN PLUS MINUS MULTIPLY DIVIDE
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA AMPERSAND COLON

%left PLUS MINUS
%left MULTIPLY DIVIDE
%right ASSIGN
%nonassoc NE EQ
%nonassoc IF
%nonassoc ELSE

%start program

%%

program: includes function
       | function
       ;

includes: include_stmt
        | includes include_stmt
        ;

include_stmt: INCLUDE HEADER_FILE
            | INCLUDE HEADER_INCOMPLETE
            ;

function: INT MAIN LPAREN RPAREN LBRACE statements RBRACE
        ;

statements: /* empty */
          | statements statement
          ;

statement: declaration
         | assignment
         | printf_stmt
         | scanf_stmt
         | if_stmt
         | switch_stmt
         | break_stmt
         | return_stmt
         | compound_stmt
         | standalone_number
         ;

standalone_number: INTEGER
                 ;

declaration: type_specifier declaration_list SEMICOLON
           ;

type_specifier: INT
              | CHAR
              | FLOAT
              ;

declaration_list: IDENTIFIER
                | declaration_list COMMA IDENTIFIER
                ;

assignment: IDENTIFIER ASSIGN expression SEMICOLON
          ;

expression: term
          | expression PLUS term
          | expression MINUS term
          ;

term: factor
    | term MULTIPLY factor
    | term DIVIDE factor
    ;

factor: IDENTIFIER
      | INTEGER
      | FLOAT_NUM
      | CHARACTER
      | LPAREN expression RPAREN
      ;

printf_stmt: PRINTF LPAREN STRING RPAREN SEMICOLON
           | PRINTF LPAREN STRING COMMA expression RPAREN SEMICOLON
           ;

scanf_stmt: SCANF LPAREN STRING COMMA AMPERSAND IDENTIFIER RPAREN SEMICOLON
          | SCANF LPAREN STRING COMMA AMPERSAND IDENTIFIER COMMA AMPERSAND IDENTIFIER RPAREN SEMICOLON
          ;

if_stmt: IF LPAREN condition RPAREN statement %prec IF
       | IF LPAREN condition RPAREN statement ELSE statement
       ;

condition: expression NE expression
         | expression EQ expression
         ;

switch_stmt: SWITCH LPAREN IDENTIFIER RPAREN LBRACE case_list RBRACE
           ;

case_list: case_item
         | case_list case_item
         ;

case_item: CASE CHARACTER COLON case_statements
         | DEFAULT COLON case_statements
         ;

case_statements: case_statement
               | case_statements case_statement
               ;

case_statement: printf_stmt
              | if_stmt
              | break_stmt
              ;

break_stmt: BREAK SEMICOLON
          ;

return_stmt: RETURN INTEGER SEMICOLON
           ;

compound_stmt: LBRACE statements RBRACE
             ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}

int main() {
    printf("Starting C Calculator Parser with includes...\n");
    if (yyparse() == 0) {
        printf("Parsing completed successfully!\n");
        printf("Your C calculator program syntax is correct.\n");
    } else {
        printf("Parsing failed - syntax errors found.\n");
    }
    return 0;
}