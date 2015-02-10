#include <stdio.h>     /* printf */
#include <stdlib.h>    /* exit */
#include <unistd.h>    /* fork */
#include <pthread.h> 
#include <semaphore.h> 
#define SHARED 0

int g_ant = 0;
sem_t bin;

void *writeloop( void *arg ) {

	while( g_ant < 10 ) {
		sem_wait(&bin);
		if( g_ant >= 10 ) exit(0);
		g_ant++;
		usleep(rand()%10);
		printf("%d\n", g_ant);
		sem_post(&bin);

	}
	exit(0);
}

int main( void ) {
	pthread_t tid;
	sem_init(&bin, SHARED, 1);
	pthread_create(&tid, NULL, writeloop, NULL);

	writeloop(NULL);

	pthread_join(tid, NULL);

	return 0;
}
