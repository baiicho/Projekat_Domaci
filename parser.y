%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#include "AST.h"  // Uključujemo AST.h da bismo definisali ASTNode

int yylex();
int line;
char *yytext;
void yyerror(const char *msg);

ASTNode* root = NULL;

%}

%union {
    int int_value;
    double double_value;
    int bool_value;
    char* string_value;
    struct ASTNode* node;
}

%token T_IF T_ELSE T_WHILE T_FOR T_RETURN
%token T_INT_DECL T_DOUBLE_DECL T_STRING_DECL T_BOOL_DECL
%token T_PLUS T_MINUS T_MULT T_DIV T_MODULO
%token T_EQUAL T_EQUAL_EQ T_NOT_EQUAL T_LOGICAL_AND T_LOGICAL_OR T_NOT
%token T_SC T_COMMA T_DOT
%token <int_value>T_INT
%token <double_value>T_DOUBLE
%token <bool_value>T_BOOLEAN
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

%type <node> exp stat S

%%

S: S stat { $$ = create_node("S", NULL, $1, $2, NULL); root = $$; }
    | { $$ = NULL; }
;

stat: T_ID T_EQUAL exp T_SC { $$ = create_node("assign", $1, $3, NULL, NULL); }
    | T_INT_DECL T_ID T_EQUAL exp T_SC { $$ = create_node("int_decl", $2, $4, NULL, NULL); }
    | T_DOUBLE_DECL T_ID T_EQUAL exp T_SC { $$ = create_node("double_decl", $2, $4, NULL, NULL); }
    | T_BOOL_DECL T_ID T_EQUAL exp T_SC { $$ = create_node("bool_decl", $2, $4, NULL, NULL); }
    | T_STRING_DECL T_ID T_EQUAL T_STRING T_SC { $$ = create_node("string_decl", $2, create_node("string", $4, NULL, NULL, NULL), NULL, NULL); }
    | T_WHILE T_LEFT_PAREN exp T_RIGHT_PAREN T_LEFT_BRACE S T_RIGHT_BRACE { $$ = create_node("while", NULL, $3, $6, NULL); }
    | T_FOR T_LEFT_PAREN exp T_SC exp T_SC exp T_RIGHT_PAREN T_LEFT_BRACE S T_RIGHT_BRACE { $$ = create_node("for", NULL, $3, create_node("for_mid", NULL, $5, $7, NULL), $10); }
    | T_IF T_LEFT_PAREN exp T_RIGHT_PAREN stat { $$ = create_node("if", NULL, $3, $5, NULL); }
    | T_IF T_LEFT_PAREN exp T_RIGHT_PAREN T_LEFT_BRACE S T_RIGHT_BRACE { $$ = create_node("if", NULL, $3, $6, NULL); }
    | T_IF T_LEFT_PAREN exp T_RIGHT_PAREN T_LEFT_BRACE S T_RIGHT_BRACE T_ELSE T_LEFT_BRACE S T_RIGHT_BRACE { $$ = create_node("if_else", NULL, $3, $6, $10); }
    | T_RETURN exp T_SC { $$ = create_node("return", NULL, $2, NULL, NULL); }
    | T_BOOLEAN_DECL T_ID T_EQUAL T_T T_SC { $$ = create_node("bool_decl", $2, create_node("bool", "true", NULL, NULL, NULL), NULL, NULL); }
    | T_BOOLEAN_DECL T_ID T_EQUAL T_F T_SC { $$ = create_node("bool_decl", $2, create_node("bool", "false", NULL, NULL, NULL), NULL, NULL); }
;

exp: T_ID { $$ = create_node("id", $1, NULL, NULL, NULL); }
    | T_INT { char buffer[20]; sprintf(buffer, "%d", $1); $$ = create_node("int", buffer, NULL, NULL, NULL); }
    | T_DOUBLE { char buffer[20]; sprintf(buffer, "%f", $1); $$ = create_node("double", buffer, NULL, NULL, NULL); }
    | T_T { $$ = create_node("bool", "true", NULL, NULL, NULL); }
    | T_F { $$ = create_node("bool", "false", NULL, NULL, NULL); }
    | T_STRING { $$ = create_node("string", $1, NULL, NULL, NULL); }
    | exp T_PLUS exp { $$ = create_node("plus", NULL, $1, $3, NULL); }
    | exp T_MINUS exp { $$ = create_node("minus", NULL, $1, $3, NULL); }
    | exp T_MULT exp { $$ = create_node("mult", NULL, $1, $3, NULL); }
    | exp T_DIV exp { $$ = create_node("div", NULL, $1, $3, NULL); }
    | exp T_MODULO exp { $$ = create_node("mod", NULL, $1, $3, NULL); }
    | exp T_LESS exp { $$ = create_node("less", NULL, $1, $3, NULL); }
    | exp T_GREATER exp { $$ = create_node("greater", NULL, $1, $3, NULL); }
    | exp T_LESS_EQ exp { $$ = create_node("less_eq", NULL, $1, $3, NULL); }
    | exp T_GREATER_EQ exp { $$ = create_node("greater_eq", NULL, $1, $3, NULL); }
    | exp T_EQUAL exp { $$ = create_node("equal", NULL, $1, $3, NULL); }
    | exp T_EQUAL_EQ exp { $$ = create_node("equal_eq", NULL, $1, $3, NULL); }
    | exp T_NOT_EQUAL exp { $$ = create_node("not_equal", NULL, $1, $3, NULL); }
    | exp T_LOGICAL_AND exp { $$ = create_node("logical_and", NULL, $1, $3, NULL); }
    | exp T_LOGICAL_OR exp { $$ = create_node("logical_or", NULL, $1, $3, NULL); }
    | T_NOT exp %prec UMINUS { $$ = create_node("not", NULL, $2, NULL, NULL); }
    | T_LEFT_PAREN exp T_RIGHT_PAREN { $$ = $2; }
;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: symbol: %s at line %d\n", yytext, line);
}

int main() {
    line = 1;
    int res = yyparse();
    if (res == 0) {
        printf("Valid input.\n");
        print_ast(root, 0);
    } else {
        printf("Not valid input.\n");
    }
    return 0;
}
