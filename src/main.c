#include <stdio.h>
#include <stdlib.h>
#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main() {
    printf("--- Testing String Functions ---\n");
    char str1[100] = "Hello";
    char str2[] = " World";
    
    printf("Length of '%s': %d\n", str1, mystrlen(str1));
    
    mystrcat(str1, str2);
    printf("After mystrcat: %s\n", str1);

    char copy_target[100];
    mystrcpy(copy_target, str1);
    printf("After mystrcpy: %s\n", copy_target);

    printf("\n--- Testing File Functions ---\n");
    FILE* temp = fopen("sample_test.txt", "w+");
    if (temp) {
        fputs("Operating Systems Assignment 1\nLearning C build process\nOperating Systems is fun\n", temp);
        rewind(temp);

        int lines = 0, words = 0, chars = 0;
        if (wordCount(temp, &lines, &words, &chars) == 0) {
            printf("WordCount -> Lines: %d, Words: %d, Chars: %d\n", lines, words, chars);
        }

        rewind(temp);
        char** matches = NULL;
        int count = mygrep(temp, "Operating", &matches);
        printf("Grep matches for 'Operating': %d\n", count);
        for (int i = 0; i < count; i++) {
            printf(" Match %d: %s", i + 1, matches[i]);
            free(matches[i]);
        }
        free(matches);
        fclose(temp);
        remove("sample_test.txt");
    }

    return 0;
}
