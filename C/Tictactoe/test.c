#include <stdio.h>
#include <unistd.h>

int main(){
	printf("98%%");
	fflush(stdout);
	sleep(5);
	printf("\b\b\b99%%");
	fflush(stdout);
	return 0;
}

