#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <semaphore.h>

#define SHARED 0
#define THINKERS 5
#define THINKING 0
#define HUNGRY 1
#define EATING 2

sem_t sem[THINKERS];
pthread_mutex_t mutex;
int state[THINKERS];
void philosopher( int n );
void takeForks( int n );
void putForks( int n );
void test( int n );
int main( void ) {

	pthread_t tid[THINKERS];
	for(int i = 0; i < THINKERS; i++){
		sem_init(&sem[i], SHARED, 1);
	}

	printf("Starting threads...\n");

	for(int i = 0; i < THINKERS; i++){
		pthread_create(&tid[i], NULL, philosopher, i);
	}

	printf("Closing threads...\n");  // Programflow will not come here...

	for(int i = 0; i < THINKERS; i++){
		pthread_join(&tid[i], NULL);
	}

	return 0;

}

void philosopher( int n ) {
	
	while(1) {
		usleep( rand() % 10000 );  // Thinking
		printf("Time to eat, %d\n", n);	
		takeForks( n );
		usleep( rand() % 1000 );   // Eating
		printf("Done eating, %d\n", n);
		putForks( n );
	}
}

void takeForks( int n ) {

	pthread_mutex_lock( &mutex );
	state[n] = HUNGRY;
	test( n );
	pthread_mutex_unlock( &mutex );
	sem_wait(&sem[n]);
}

void putForks( int n ) {

	pthread_mutex_lock( &mutex );
	state[n] = THINKING;
	test( (n + THINKERS - 1) % THINKERS );
	test( (n + 1) % THINKERS );
	pthread_mutex_unlock( &mutex );
}

void test( int n ) { 

	if(state[n] == HUNGRY && state[(n + THINKERS - 1) % THINKERS] != EATING && state[(n + 1) % THINKERS] != EATING) {
	       state[n] = EATING;
	       sem_post(&sem[n]);
	}
}

	
