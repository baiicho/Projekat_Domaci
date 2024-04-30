%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int yylex();
int line;
char *yytext;
void yyerror(const char *msg);
%}

%union {
    int int_value;
    double double_value;
    int bool_value;
    char* string_value;
}

%token T_IF T_ELSE T_WHILE T_FOR T_RETURN
%token T_INT_DECL T_DOUBLE_DECL T_STRING_DECL T_BOOL_DECL
%token T_PLUS T_MINUS T_MULT T_DIV T_MODULO
%token T_EQUAL T_EQUAL_EQ T_NOT_EQUAL T_LOGICAL_AND T_LOGICAL_OR T_NOT
%token T_SC T_COMMA T_DOT
%token <int_value>T_INT
%token <double_value>T_DOUBLE
%token <bool_value>T_BOOLEAN
%token T_TRUE T_FALSE
%token <string_value>T_ID T_STRING
%token T_LEFT_PAREN T_RIGHT_PAREN T_LEFT_BRACE T_RIGHT_BRACE
%token T_BOOLEAN_DECL
%token T_T
%token T_F



%left T_LOGICAL_OR
%left T_LOGICAL_AND
%left T_EQUAL T_EQUAL_EQ T_NOT_EQUAL
%left T_LESS T_LESS_EQ T_GREATER T_GREATER_EQ
%left T_PLUS T_MINUS
%left T_MULT T_DIV T_MODULO
%right T_NOT UMINUS

%type <int_value> exp
%type <string_value> stat

%%

S: S stat                                           { }
    |
;

stat: exp T_SC                                                          { printf("Result: %d\n", $1); }
    | T_INT_DECL T_ID T_EQUAL exp T_SC                                  { printf("Var decl %s with val %d\n", $2, $4);  }
    | T_DOUBLE_DECL T_ID T_EQUAL T_DOUBLE T_SC                          { printf("Var decl %s with val %f\n", $2, $4); }
    | T_BOOL_DECL T_ID T_EQUAL exp T_SC                                 { printf("Var decl %s with val %s\n", $2, $4 == 1 ? "true" : "false"); }
    | T_STRING_DECL T_ID T_EQUAL T_STRING T_SC                          { printf("Var decl %s with str \"%s\"\n", $2, $4); }
    | T_ID T_EQUAL exp T_SC                                             { printf("%s = %d\n", $1, $3); }
    | T_LEFT_BRACE S T_RIGHT_BRACE                                      {  }
    | T_LEFT_PAREN S T_RIGHT_PAREN                                      {  }
    | T_WHILE T_LEFT_PAREN exp T_RIGHT_PAREN stat                       { printf("WHILE loop\n"); }
    | T_FOR T_LEFT_PAREN exp T_SC exp T_SC exp T_RIGHT_PAREN stat       { printf("FOR loop\n"); }
    | T_IF T_LEFT_PAREN exp T_RIGHT_PAREN stat                          { printf("IF condition\n"); }
    | T_IF T_LEFT_PAREN exp T_RIGHT_PAREN stat T_ELSE stat              { printf("IF ELSE condition\n"); }
    | T_RETURN exp T_SC                                                 { printf("RETURN\n"); }
    | T_BOOLEAN_DECL T_ID T_EQUAL T_T T_SC                              { printf("Deklaracija var %s sa true\n", $2); }
    | T_BOOLEAN_DECL T_ID T_EQUAL T_F T_SC                              { printf("Deklaracija var %s sa false\n", $2); }
;

exp:
    T_ID                                                                { $$ = 0; }
    | T_INT                                                             { $$ = $1; }
    | T_DOUBLE                                                          { $$ = $1; }
    | T_BOOLEAN                                                         { $$ = $1; }
    | T_TRUE                                                            { $$ = 1; }
    | T_FALSE                                                           { $$ = 0; }
    | T_STRING                                                          { $$ = 0; }
    | exp T_PLUS exp                                                    { $$ = $1 + $3; }
    | exp T_MINUS exp                                                   { $$ = $1 - $3; }
    | exp T_MULT exp                                                    { $$ = $1 * $3; }
    | exp T_DIV exp                                                     { $$ = $1 / $3; }
    | exp T_MODULO exp                                                  { $$ = $1 % $3; }
    | exp T_LESS exp                                                    { $$ = ($1 < $3) ? 1 : 0; }
    | exp T_GREATER exp                                                 { $$ = ($1 > $3) ? 1 : 0; }
    | exp T_LESS_EQ exp                                                 { $$ = ($1 <= $3) ? 1 : 0; }
    | exp T_GREATER_EQ exp                                              { $$ = ($1 >= $3) ? 1 : 0; }
    | exp T_EQUAL exp                                                   { $$ = ($1 = $3) ? 1 : 0; }
    | exp T_EQUAL_EQ exp                                                { $$ = ($1 == $3) ? 1 : 0; }
    | exp T_NOT_EQUAL exp                                               { $$ = ($1 != $3) ? 1 : 0; }
    | exp T_LOGICAL_AND exp                                             { $$ = ($1 && $3) ? 1 : 0; }
    | exp T_LOGICAL_OR exp                                              { $$ = ($1 || $3) ? 1 : 0; }
    | T_NOT exp %prec UMINUS                                            { $$ = !$2; }
    | T_LEFT_PAREN exp T_RIGHT_PAREN                                    { $$ = $2; }
;

%%

int main(){
    line = 1;
    int res = yyparse();
    if(res == 0) {
        printf("Valid input.\n");
    }
    else {
        printf("Not valid input.\n");
    }
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: symbol: %s at line %d\n", yytext, line);
}