#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "../include/myfilefunctions.h"

int wordCount(FILE* fp, int* lines, int* words, int* chars) {
    if (!fp || !lines || !words || !chars) return 1;

    *lines = 0;
    *words = 0;
    *chars = 0;

    int ch;
    int in_word = 0;

    while ((ch = fgetc(fp)) != EOF) {
        (*chars)++;
        if (ch == '\n') {
            (*lines)++;
        }
        if (isspace(ch)) {
            in_word = 0;
        } else if (!in_word) {
            in_word = 1;
            (*words)++;
        }
    }
    return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches) {
    if (!fp || !search_str || !matches) return 1;

    char line[1024];
    int count = 0;
    int capacity = 10;
    *matches = malloc(capacity * sizeof(char*));

    while (fgets(line, sizeof(line), fp)) {
        if (strstr(line, search_str) != NULL) {
            if (count >= capacity) {
                capacity *= 2;
                *matches = realloc(*matches, capacity * sizeof(char*));
            }
            (*matches)[count] = strdup(line);
            count++;
        }
    }
    return count;
}
