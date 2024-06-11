#ifndef AST_H
#define AST_H

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

// Definišemo strukturu za AST čvorove
typedef struct ASTNode {
    char* type;
    char* value;
    struct ASTNode* left;
    struct ASTNode* right;
    struct ASTNode* next;
} ASTNode;

// Funkcija za kreiranje novog čvora
ASTNode* create_node(char* type, char* value, ASTNode* left, ASTNode* right, ASTNode* next) {
    ASTNode* node = (ASTNode*)malloc(sizeof(ASTNode));
    node->type = strdup(type);
    node->value = value ? strdup(value) : NULL;
    node->left = left;
    node->right = right;
    node->next = next;
    return node;
}

// Funkcija za štampanje AST-a
void print_ast(ASTNode* node, int depth) {
    if (node == NULL) return;
    for (int i = 0; i < depth; ++i) printf("  ");
    printf("%s", node->type);
    if (node->value) printf(": %s", node->value);
    printf("\n");
    print_ast(node->left, depth + 1);
    print_ast(node->right, depth + 1);
    print_ast(node->next, depth);
}

#endif
