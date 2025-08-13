/* A Bison parser, made by GNU Bison 2.4.2.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2006, 2009-2010 Free Software
   Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INT = 258,
     FLOAT = 259,
     IF = 260,
     ELSE = 261,
     FOR = 262,
     WHILE = 263,
     CONTINUE = 264,
     BREAK = 265,
     PRINTF = 266,
     DOUBLE = 267,
     CHAR = 268,
     VOID = 269,
     RETURN = 270,
     ADDOP = 271,
     SUBOP = 272,
     MULOP = 273,
     DIVOP = 274,
     INCOP = 275,
     DECOP = 276,
     ADDASSIGN = 277,
     EQUOP = 278,
     NEOP = 279,
     LT = 280,
     GT = 281,
     GE = 282,
     LE = 283,
     LPAREN = 284,
     RPAREN = 285,
     LBRACE = 286,
     RBRACE = 287,
     LBRACK = 288,
     RBRACK = 289,
     SEMI = 290,
     COMMA = 291,
     ASSIGN = 292,
     ID = 293,
     STRING = 294,
     ICONST = 295,
     FCONST = 296,
     CCONST = 297,
     OR = 298,
     AND = 299,
     UMINUS = 300,
     LOWER_THAN_ELSE = 301
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1685 of yacc.c  */
#line 15 "parser.y"

    char str_val[100];
    int int_val;
    float float_val;
    param_list* param_list_val;



/* Line 1685 of yacc.c  */
#line 106 "parser.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


