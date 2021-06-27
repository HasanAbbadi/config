#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

int main(){

	// the list of words up to 16 characters maximum
	char words_list[][16] = {
		"school",
		"door",
		"civilization",
		"begin",
		"total",
		"cane",
		"boat",
		"craft",
		"period",
		"acquit",
		"swing",
		"tribute",
		"conservative",
		"calf",
		"passive",
		"rung",
		"screw",
		"episode",
		"union",
		"vertical",
		"dentist",
		"claim",
		"album",
		"wedding",
		"conversation",
		"network",
		"constitutional",
		"frog",
		"bring",
		"lunch",
		"glimpse",
		"bear",
		"national",
		"cabinet",
		"mosaic",
		"Koran",
		"hostility",
		"director",
		"countryside",
		"rally",
		"spot",
		"improve",
		"love",
		"imperial",
		"prayer",
		"spy",
		"prevent",
		"visual",
		"reach",
		"maximum",
		"sigh",
		"spray",
		"disappointment",
		"track",
		"dribble",
		"rice",
		"meaning",
		"breed",
		"leak",
		"twilight",
		"rebellion",
		"mine",
		"temple",
		"posture",
		"brainstorm",
		"parameter",
		"dismiss",
		"dry",
		"spokesperson",
		"grip",
		"index",
		"graphic",
		"recommendation",
		"division",
		"ideology",
		"offer",
		"switch",
		"honest",
		"prejudice",
		"freckle",
		"ideal",
		"countryside",
		"space",
		"mood",
		"heavy",
		"production",
		"spring",
		"introduction",
		"unanimous",
		"resolution",
		"interactive",
		"morale",
		"decorative",
		"bathtub",
		"telephone",
		"entry",
		"elbow",
		"word",
		"heal",
		"commerce",
		"collect",
		"pot",
		"concession",
		"speaker",
	};


	// random number
	int randomNum;
	srand(time(NULL));
	randomNum = rand() % 106;

	// setting game standards
	int lives = 6;
	int lengthOfWord = strlen(words_list[randomNum]);
	char guessedLetters[16];

	// variables used in the while loop
	int correctNum = 0;
	int c = -1;
	char guess[16];


	// clear the screen
	system("clear");

	// while not all the letters are guessed loop
	while(correctNum < lengthOfWord){

		// if there is no more lives
		if(lives == 0){
			printf("Game over!\n");
			break;
		}

		// print the guessed letters
		printf("====================\n");
		printf("Word:");
		int i;
		// print letter if guessed, print - otherwise
		for(i=0; i < lengthOfWord; i++){

			if(guessedLetters[i] >= 'a' && guessedLetters[i] <= 'z' ){
				printf("%c",words_list[randomNum][i]);
			} else {
				printf("-");
			}
		}

		printf(" (%i)", lengthOfWord);
		printf("\n====================\n");
		// prompt
		printf("\nEnter a letter ( 'quit' to quit ): ");
		fgets(guess,5,stdin);

		// if input = quit then break
		if(strcmp(guess, "quit") == 0){
			break;
		}

		// reject input more than one letter
		if(strlen(guess) > 2){
			system("clear");
			printf("\n\nPlease input one letter only.\n\n");
			continue;
		}

		printf("\n");
		char gueech;
		gueech = guess[0];


		// Checks if letter is in word
		if(strchr(words_list[randomNum], gueech)){

       			// Checks if letter has been already guessed before
			size_t lengthOfArray = sizeof(guessedLetters)/sizeof(guessedLetters[0]);
			//printf("Size of guessedLetter: %s\n",lengthOfArray);
			for(i=0; i < lengthOfWord; i++){

				//if(guessedLetters[i] >= 'a' && guessedLetters[i] <= 'z' ){
					if(gueech == guessedLetters[i]){
						printf("You have already guessed that!");
					} else{
       					int i;
       					int charNum = 0;
       					    for(i=0;words_list[randomNum][i];i++){

       					    	if(words_list[randomNum][i]==gueech){
       					          charNum++;
       						}

       					     }


       				//	system("clear");
       					correctNum = correctNum + charNum;
       					printf("==========================================\n");
       					printf("Correct! current status: %i / %i\n",correctNum,lengthOfWord);
       					printf("Lives:%i\n", lives);

       					// check the position of guessed letter
       					i=0;
       					for(i=0;i<lengthOfWord;i++){
       						if(words_list[randomNum][i] == gueech){
       							guessedLetters[i] = gueech;
       						}
       					}

					}
				//}
			}
			//int lengthOfArray = sizeof(isGuessd)/sizeof(isGuessd[0]);
		//	int w;
		//	for(w=0; w < 2; ++w){

       		//		if(gueech != guessedLetters[c]){

       		//			// how many occurences of the guessed letter is in the word
       		//			int i;
       		//			int charNum = 0;
       		//			    for(i=0;words_list[randomNum][i];i++){

       		//			    	if(words_list[randomNum][i]==gueech){
       		//			          charNum++;
       		//				}

       		//			     }


       		//		//	system("clear");
       		//			correctNum = correctNum + charNum;
       		//			printf("==========================================\n");
       		//			printf("Correct! current status: %i / %i\n",correctNum,lengthOfWord);
       		//			printf("Lives:%i\n", lives);

       		//			// check the position of guessed letter
       		//			i=0;
       		//			for(i=0;i<lengthOfWord;i++){
       		//				if(words_list[randomNum][i] == gueech){
       		//					guessedLetters[i] = gueech;
       		//				}
       		//			}
       		//		} else{
       		//			printf("You have already guessed that! try again\n");
		//			break;
		//			return 1;
       		//		}

       		//	}


		//}
		// if letter is not correct
	//	else{
	//		system("clear");
	//		lives = lives - 1;
	//		printf("==========================================\n");
	//		printf("Wrong! current status: %i / %i\n",correctNum,lengthOfWord);
	//		printf("Lives:%i\n", lives);
	}
	}

	// Revealing the word when lost
	if(lives == 0){
		printf("======================\n");
		printf("| ");
		printf("The word was:%s |",words_list[randomNum]);
		printf("\n======================\n");
	}
	return 0;
}

