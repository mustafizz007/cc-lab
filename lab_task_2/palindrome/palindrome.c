#include <stdio.h>
#include <string.h>

int main(void) {
    char str[100];
    int i, len, flag = 1;
    printf("Enter a string: ");
    scanf("%s", str);
    len = strlen(str);
    for (i = 0; i < len / 2; i++) {
        if (str[i] != str[len - i - 1]) {
            flag = 0;
            break;
        }
    }
    if (flag) printf("Palindrome\n");
    else printf("Not a palindrome\n");
    return 0;
}
