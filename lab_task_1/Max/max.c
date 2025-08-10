
#include <stdio.h>

int main(void) {
    int a, b, c;
    printf("Enter three numbers: ");
    scanf("%d %d %d", &a, &b, &c);

    if (a >= b && a >= c)
        printf("Max: %d\n", a);
    else if (b >= a && b >= c)
        printf("Max: %d\n", b);
    else
        printf("Max: %d\n", c);

    return 0;
}
