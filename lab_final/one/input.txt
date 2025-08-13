#include <stdio.h>

int main() {
    int choice, num;
    char *menu[] = {"Check even/odd", "Print square", "Print cube"};

    for (int i = 0; i < 3; i++)
        printf("%d. %s\n", i + 1, menu[i]);

    printf("Enter your choice: ");
    scanf("%d", &choice);

    if (choice >= 1 && choice <= 3) {
        printf("Enter a number: ");
        scanf("%d", &num);

        for (int i = choice; i <= choice; i++) {  
            if (i == 1)
                printf("%d is %s\n", num, num % 2 ? "odd" : "even");
            else if (i == 2)
                printf("Square of %d is %d\n", num, num * num);
            else
                printf("Cube of %d is %d\n", num, num * num * num);
        }
    } else {
        printf("Invalid choice!\n");
    }

    return 0;
}
