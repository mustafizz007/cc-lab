#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

int isKeyword(char *word) {
    const char *keywords[] = {
        "int", "float", "char", "if", "else", "for", "while", "return", "void"
    };
    int numKeywords = sizeof(keywords) / sizeof(keywords[0]);
    for (int i = 0; i < numKeywords; i++) {
        if (strcmp(word, keywords[i]) == 0)
            return 1;
    }
    return 0;
}

int isInteger(char *str) {
    int i = 0;
    if (str[0] == '-' || str[0] == '+') i++;
    for (; str[i] != '\0'; i++) {
        if (!isdigit(str[i])) return 0;
    }
    return 1;
}

int isFloat(char *str) {
    int i = 0, hasDot = 0;
    if (str[0] == '-' || str[0] == '+') i++;
    for (; str[i] != '\0'; i++) {
        if (str[i] == '.') {
            if (hasDot) return 0;  // multiple dots
            hasDot = 1;
        } else if (!isdigit(str[i])) {
            return 0;
        }
    }
    return hasDot;
}

int isIdentifier(char *str) {
    if (!isalpha(str[0]) && str[0] != '_')
        return 0;
    for (int i = 1; str[i] != '\0'; i++) {
        if (!isalnum(str[i]) && str[i] != '_')
            return 0;
    }
    return 1;
}

int isOperator(char *str) {
    const char *operators[] = {"+", "-", "*", "/", "=", "==", "<", ">", "<=", ">=", "!="};
    int numOps = sizeof(operators) / sizeof(operators[0]);
    for (int i = 0; i < numOps; i++) {
        if (strcmp(str, operators[i]) == 0)
            return 1;
    }
    return 0;
}

int main() {
    char input[1000];
    char *token;
    const char delimiters[] = " \t\n";

    printf("Enter code line: ");
    fgets(input, sizeof(input), stdin);

    token = strtok(input, delimiters);
    while (token != NULL) {
        if (isKeyword(token))
            printf("Keyword: %s\n", token);
        else if (isInteger(token))
            printf("Integer: %s\n", token);
        else if (isFloat(token))
            printf("Float: %s\n", token);
        else if (isOperator(token))
            printf("Operator: %s\n", token);
        else if (isIdentifier(token))
            printf("Identifier: %s\n", token);
        else
            printf("Unknown token: %s\n", token);

        token = strtok(NULL, delimiters);
    }

    return 0;
}
