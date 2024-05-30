/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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
     T_IF = 258,
     T_ELSE = 259,
     T_WHILE = 260,
     T_FOR = 261,
     T_RETURN = 262,
     T_INT_DECL = 263,
     T_DOUBLE_DECL = 264,
     T_STRING_DECL = 265,
     T_BOOL_DECL = 266,
     T_PLUS = 267,
     T_MINUS = 268,
     T_MULT = 269,
     T_DIV = 270,
     T_MODULO = 271,
     T_EQUAL = 272,
     T_EQUAL_EQ = 273,
     T_NOT_EQUAL = 274,
     T_LOGICAL_AND = 275,
     T_LOGICAL_OR = 276,
     T_NOT = 277,
     T_SC = 278,
     T_COMMA = 279,
     T_DOT = 280,
     T_INT = 281,
     T_DOUBLE = 282,
     T_BOOLEAN = 283,
     T_ID = 284,
     T_STRING = 285,
     T_LEFT_PAREN = 286,
     T_RIGHT_PAREN = 287,
     T_LEFT_BRACE = 288,
     T_RIGHT_BRACE = 289,
     T_BOOLEAN_DECL = 290,
     T_T = 291,
     T_F = 292,
     T_GREATER_EQ = 293,
     T_GREATER = 294,
     T_LESS_EQ = 295,
     T_LESS = 296,
     UMINUS = 297
   };
#endif
/* Tokens.  */
#define T_IF 258
#define T_ELSE 259
#define T_WHILE 260
#define T_FOR 261
#define T_RETURN 262
#define T_INT_DECL 263
#define T_DOUBLE_DECL 264
#define T_STRING_DECL 265
#define T_BOOL_DECL 266
#define T_PLUS 267
#define T_MINUS 268
#define T_MULT 269
#define T_DIV 270
#define T_MODULO 271
#define T_EQUAL 272
#define T_EQUAL_EQ 273
#define T_NOT_EQUAL 274
#define T_LOGICAL_AND 275
#define T_LOGICAL_OR 276
#define T_NOT 277
#define T_SC 278
#define T_COMMA 279
#define T_DOT 280
#define T_INT 281
#define T_DOUBLE 282
#define T_BOOLEAN 283
#define T_ID 284
#define T_STRING 285
#define T_LEFT_PAREN 286
#define T_RIGHT_PAREN 287
#define T_LEFT_BRACE 288
#define T_RIGHT_BRACE 289
#define T_BOOLEAN_DECL 290
#define T_T 291
#define T_F 292
#define T_GREATER_EQ 293
#define T_GREATER 294
#define T_LESS_EQ 295
#define T_LESS 296
#define UMINUS 297




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 55 "parser.y"
{
    int int_value;
    double double_value;
    int bool_value;
    char* string_value;
}
/* Line 1529 of yacc.c.  */
#line 140 "parser.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

