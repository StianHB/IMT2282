#include <stdio.h>
#include <stdlib.h> 
#include <unistd.h> 
#include <sys/wait.h> 
#include <sys/types.h> 

void process(int number, int time) {	
	printf("Prosess %d kjører\n", number);
	sleep(time);
	printf("Prosess %d kjørte i %d sekunder\n", number, time);
}

int main( void ) {
	pid_t p,q,r;
	
	p=fork();
	
	if (p == 0) {
		process(0,1);
		return 0;
	} else if ( p != 0 ) {
		q = fork();
		if (q == 0) {
			process(2,3);
			return 0;
		} 
	}

	waitpid(p,NULL,0);
	p = fork();
	if ( p == 0 ) {
		process(1,2);
		return 0;
	} else if ( p != 0 ) {
		r = fork();
		if ( r == 0 ) {
			process(4,3);
			return 0;
		}
	}
	
	waitpid(q,NULL,0);
	q = fork();
	if ( q == 0 ) {
		process(3,2);
		return 0;
	}
	
	waitpid(r,NULL,0);
	r = fork();
	if ( r == 0 ) {
		process(5,3);
		return 0;
	}

	return 0;
}
