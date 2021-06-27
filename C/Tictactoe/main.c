#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(){
	char xory;
	int num;
	char slot[] = {1,2,3,4,5,6,7,8,9};
	printf("x or y ? ");
	scanf("%c",&xory);
	printf("\nYou're %c\n",xory);


	// the board
	int i;
	// loop
	int w = 0;
	while(w == 0){

		// winning system
		if(slot[0] == xory && slot[1] == xory && slot[2] == xory){
			w = 1;
			break;
		} else if(slot[3] == xory && slot[4] == xory && slot[5] == xory){
			w = 1;
			break;
		} else if(slot[6] == xory && slot[7] == xory && slot[8] == xory){
			w = 1;
			break;
		} else if(slot[0] == xory && slot[4] == xory && slot[8] == xory){
			w = 1;
			break;
		} else if(slot[2] == xory && slot[4] == xory && slot[6] == xory){
			w = 1;
			break;
		} else if(slot[1] == xory && slot[4] == xory && slot[7] == xory){
			w = 1;
			break;
		} else if(slot[3] == xory && slot[4] == xory && slot[5] == xory){
			w = 1;
			break;
		} else if(slot[0] == xory && slot[3] == xory && slot[6] == xory){
			w = 1;
			break;
		} else if(slot[2] == xory && slot[5] == xory && slot[8] == xory){
			w = 1;
			break;
		}

		char pcxory;

		if(slot[0] == pcxory && slot[1] == pcxory && slot[2] == pcxory){
			w = 0;
			break;
		} else if(slot[3] == pcxory && slot[4] == pcxory && slot[5] == pcxory){
			w = 0;
			break;
		} else if(slot[6] == pcxory && slot[7] == pcxory && slot[8] == pcxory){
			w = 0;
			break;
		} else if(slot[0] == pcxory && slot[4] == pcxory && slot[8] == pcxory){
			w = 0;
			break;
		} else if(slot[2] == pcxory && slot[4] == pcxory && slot[6] == pcxory){
			w = 0;
			break;
		} else if(slot[1] == pcxory && slot[4] == pcxory && slot[7] == pcxory){
			w = 0;
			break;
		} else if(slot[3] == pcxory && slot[4] == pcxory && slot[5] == pcxory){
			w = 0;
			break;
		} else if(slot[0] == pcxory && slot[3] == pcxory && slot[6] == pcxory){
			w = 0;
			break;
		} else if(slot[2] == pcxory && slot[5] == pcxory && slot[8] == pcxory){
			w = 0;
			break;
		}

		// if all slots are occupied then break

		if(slot[0] >= 'a' && slot[1] >= 'a' && slot[2] >= 'a' && slot[3] >= 'a' && slot[4] >= 'a' &&\
				slot[5] >= 'a' && slot[6] >= 'a' && slot[7] >= 'a' && slot[8]){
			w = 0;
			break;
		}

		printf("-------------\n");
		printf("|");
		for(i=0; i<3; ++i){
			if(slot[i] >= 1 && slot[i] <= 9){
				printf(" %i |", slot[i]);
			} else {
				printf(" %c |", slot[i]);
			}
		}

		printf("\n|");

		for(i=3; i<6; ++i){
			if(slot[i] >= 1 && slot[i] <= 9){
				printf(" %i |", slot[i]);
			} else {
				printf(" %c |", slot[i]);
			}
		}

		printf("\n|");

		for(i=6; i<9; ++i){
			if(slot[i] >= 1 && slot[i] <= 9){
				printf(" %i |", slot[i]);
			} else {
				printf(" %c |", slot[i]);
			}
		}
		printf("\n-------------\n");

		printf("Choose a square: ");
		scanf("%i",&num);

		// check if square is occupied
		if(!(slot[num] >= 1) && !(slot[num] <= 9)){
			printf("\nThat Square is occupied, please choose another one.");
		} else {
			num = num - 1;
			slot[num] = xory;
		}

		int random;
		srand(time(NULL));
		random = rand() % 9;

		while(slot[random] >= 'a' && slot[random] <= 'z'){
			srand(time(NULL));
			random = rand() % 9;

		}

		if(xory == 'y'){
			pcxory = 'x';
		} else {

			pcxory = 'y';
		}

		slot[random] = pcxory;

	}

	if(w == 0){
		printf("\n\nYou've lost :(\n\n");
	} else {
		printf("\n\nYou've won!\n\n");
	}

	printf("It ended with:\n");
		printf("-------------\n");
		printf("|");
		for(i=0; i<3; ++i){
			if(slot[i] >= 1 && slot[i] <= 9){
				printf(" %i |", slot[i]);
			} else {
				printf(" %c |", slot[i]);
			}
		}

		printf("\n|");

		for(i=3; i<6; ++i){
			if(slot[i] >= 1 && slot[i] <= 9){
				printf(" %i |", slot[i]);
			} else {
				printf(" %c |", slot[i]);
			}
		}

		printf("\n|");

		for(i=6; i<9; ++i){
			if(slot[i] >= 1 && slot[i] <= 9){
				printf(" %i |", slot[i]);
			} else {
				printf(" %c |", slot[i]);
			}
		}
		printf("\n-------------\n");
	return 0;

}

