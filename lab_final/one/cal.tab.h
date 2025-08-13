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
     NUMBER = 258,
     ID = 259,
     STRING = 260,
     INT = 261,
     CHAR = 262,
     MAIN = 263,
     FOR = 264,
     IF = 265,
     ELSE = 266,
     RETURN = 267,
     SCANF = 268,
     PRINTF = 269,
     EQ = 270,
     NE = 271,
     GE = 272,
     LE = 273,
     GT = 274,
     LT = 275,
     AND = 276,
     OR = 277,
     INC = 278,
     DEC = 279,
     ASSIGN = 280,
     SEMI = 281,
     COMMA = 282,
     LPAREN = 283,
     RPAREN = 284,
     LBRACE = 285,
     RBRACE = 286,
     LBRACK = 287,
     RBRACK = 288,
     AMPERSAND = 289,
     STAR = 290,
     PLUS = 291,
     MINUS = 292,
     DIV = 293,
     MOD = 294,
     QUESTION = 295,
     COLON = 296,
     UMINUS = 297
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1685 of yacc.c  */
#line 9 "cal.y"

    int ival;
    char *sval;



/* Line 1685 of yacc.c  */
#line 100 "cal.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


