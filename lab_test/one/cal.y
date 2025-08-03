%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
extern int yylineno;
%}

%token INT PRINTF IF FOR BREAK RETURN MAIN
%token IDENTIFIER NUMBER STRING
%token LE GE LT GT EQ NE ASSIGN PLUS_ASSIGN INCREMENT
%token PLUS MINUS MULTIPLY DIVIDE MODULO
%token LPAREN RPAREN LBRACE RBRACE SEMICOLON COMMA

%left PLUS MINUS
%left MULTIPLY DIVIDE MODULO
%right ASSIGN PLUS_ASSIGN
%nonassoc LE GE LT GT EQ NE
%nonassoc IF

%start program

%%

program: function
       ;

function: INT MAIN LPAREN RPAREN LBRACE statements RBRACE
        ;

statements: /* empty */
          | statements statement
          ;

statement: declaration
         | assignment
         | printf_stmt
         | if_stmt
         | for_stmt
         | break_stmt
         | return_stmt
         | compound_stmt
         ;

declaration: INT declaration_list SEMICOLON
           ;

declaration_list: IDENTIFIER
                | IDENTIFIER ASSIGN expression
                | declaration_list COMMA IDENTIFIER
                | declaration_list COMMA IDENTIFIER ASSIGN expression
                ;

assignment: IDENTIFIER ASSIGN expression SEMICOLON
          | IDENTIFIER PLUS_ASSIGN expression SEMICOLON
          | IDENTIFIER INCREMENT SEMICOLON
          ;

expression: term
          | expression PLUS term
          | expression MINUS term
          ;

term: factor
    | term MULTIPLY factor
    | term DIVIDE factor
    | term MODULO factor
    ;

factor: IDENTIFIER
      | NUMBER
      | LPAREN expression RPAREN
      ;

printf_stmt: PRINTF LPAREN STRING COMMA expression RPAREN SEMICOLON
           ;

if_stmt: IF LPAREN condition RPAREN statement
       ;

condition: expression LE expression
         | expression GE expression
         | expression LT expression
         | expression GT expression
         | expression EQ expression
         | expression NE expression
         | expression
         ;

for_stmt: FOR LPAREN for_init SEMICOLON condition SEMICOLON for_update RPAREN statement
        ;

for_init: IDENTIFIER ASSIGN expression
        ;

for_update: IDENTIFIER INCREMENT
          ;

break_stmt: BREAK SEMICOLON
          ;

return_stmt: RETURN expression SEMICOLON
           ;

compound_stmt: LBRACE statements RBRACE
             ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Parse error: %s\n", s);
}

int main() {
    printf("Starting Prime Number Sum Parser...\n");
    if (yyparse() == 0) {
        printf("Parsing finished !\n");
    } else {
        printf("Parsing failed - syntax errors found.\n");
    }
    return 0;
}