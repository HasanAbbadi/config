#include <stdio.h>
#include <string.h>

int main(){
    double x,y;
    char o[1];
    printf("Insert First number: ");
    scanf(" %lf", &x);
    printf("\nInsert a rule ( * , - , + , / ): ");
    scanf(" %s", &o);
    printf("\nInsert Second number: ");
    scanf(" %lf", &y);
    printf("\n");

    if (strcmp( o , "*" ) == 0){
        double result = x * y;
        printf("%.2lf %s %.2lf = %.2lf \n", x, o, y, result);
    }
    else if(strcmp( o , "+" ) == 0){
        double result = x + y;
        printf("%.2lf %s %.2lf = %.2lf \n", x, o, y, result);
    }
    else if(strcmp( o , "-" ) == 0){
        double result = x - y;
        printf("%.2lf %s %.2lf = %.2lf \n", x, o, y, result);
    }
    else if(strcmp( o , "/" ) == 0){
        double result = x / y;
        printf("%.2lf %s %.2lf = %.2lf \n", x, o, y, result);
    }
    else {
        printf("%s is not a valid rule.\n", o);
        return 1;
    }
    return 0;
}
