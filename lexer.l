%{
#include <string.h>
#include "parser.tab.h"
extern int line;
%}


%%


"true"                              { return T_T; }
"false"                             { return T_F; }
while                               { return T_WHILE; }
for                                 { return T_FOR; }
if                                  { return T_IF; }
else                                { return T_ELSE; }
int                                 { return  T_INT_DECL; }
double                              { return  T_DOUBLE_DECL; }
boolean                             { return T_BOOL_DECL; }
'true'                              { return T_TRUE; }
'false'                             { return T_FALSE; }
string                              { return  T_STRING_DECL; }
return                              { return  T_RETURN; }

\"([^\"\\]|\\.)*\"                  { yylval.string_value = strdup(yytext); return T_STRING; }
[0-9]+                              { yylval.int_value = atoi(yytext); return T_INT; }
[0-9]+[eE][+-]?[0-9]+               { yylval.double_value = atof(yytext); return T_DOUBLE; }
[0-9]*\.[0-9]+([eE][+-]?[0-9]+)?    { yylval.double_value = atof(yytext); return T_DOUBLE; }
[a-zA-Z][a-zA-Z0-9_]{0,30}          { 
                                       if(strlen(yytext) <= 31) {
                                           yylval.string_value = strdup(yytext); 
                                           return T_ID; 
                                       } else {
                                           fprintf(stderr, "Error at line %d. String length limit is 31\n", line); 
                                           exit(1);
                                       } 
                                    }

"{"                                 { return T_LEFT_BRACE; }
"}"                                 { return T_RIGHT_BRACE; }
"("                                 { return T_LEFT_PAREN; }
")"                                 { return T_RIGHT_PAREN; }
";"                                 { return T_SC; }
","                                 { return T_COMMA; }
"."                                 { return T_DOT; }

"+"                                 { return T_PLUS; }
"-"                                 { return T_MINUS; }
"*"                                 { return T_MULT; }
"/"                                 { return T_DIV; }
"%"                                 { return T_MODULO; }
"<"                                 { return T_LESS; }
"<="                                { return T_LESS_EQ; }
">"                                 { return T_GREATER; }
">="                                { return T_GREATER_EQ; }
"="                                 { return T_EQUAL; }
"=="                                { return T_EQUAL_EQ; }
"!="                                { return T_NOT_EQUAL; }
"&&"                                { return T_LOGICAL_AND; }
"||"                                { return T_LOGICAL_OR; }
"!"                                 { return T_NOT; }
\n                                  { line++; }
"//"(.)*\n                          { /* Ignore single-line comments */ }
"/*"([^*]|\*+[^*/])*\*+"/"          { /* Ignore multi-line comments */ }
[ \t\r\f\v]+                        { /* Ignore whitespace */ }
.                                   { fprintf(stderr, "Error: symbol %s at line %d\n", yytext, line); }
%%