#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <string.h>

int main(){
	int item;
	int random;
	char pcitem[9];

	printf("Choose one:\n1. Rock\n2. Paper\n3. Scissors\n");
	scanf("%i", &item);

	if(item < 1 || item > 3){
		printf("Invalid number!\n");
		return 1;
	}

	srand(time(NULL));
	random = (rand() % 3) + 1;

	if(random == 1){
		strcpy(pcitem, "Rock");
	} else if(random == 2){
		strcpy(pcitem, "Paper");
	} else if(random == 3){
		strcpy(pcitem, "Scissors");
	}

	sleep(1);

	printf("PC have chosen : %s\n", pcitem);

	if(item == random){
		printf("It's a tie!\n");
		return 1;
	}

	if(item != 3 && item > random){
		printf("You've won!\n");
	} else if(item == 3 && random == 2){
		printf("You've won!\n");
	} else {
		printf("You've lost :(\n");
	}

	return 0;
}

