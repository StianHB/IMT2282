#include <stdio.h>     /* printf */
#include <stdlib.h>    /* exit */
#include <unistd.h>    /* fork */
#include <pthread.h> 
#include <semaphore.h> 
#define SHARED 0

sem_t sem[6];     /* one semaphore for each thread */

struct threadargs {
  int id;         /* thread number */
  int sec;        /* how many seconds to sleep */
  int signal[6];  /* which threads to signal when done */
};


/* thread function: start by waiting on my own semaphore if it has been
 * initialized to 0; do my work (sleeping); signal the threads that
 * should start when I finish; exit
*/
void* tfunc(void *arg) {
  struct threadargs *targs=arg;
  sem_wait(&sem[targs->id]);	// VENT PÅ DIN EGEN SEMAFOR
  printf("Tråd %d kjører\n", targs->id);
  sleep(targs->sec);
  printf("Tråd %d er ferdig og vekker kanskje andre...\n", targs->id);
	// ITERER OVER signal-ARRAYET OG VEKK TRÅD nr i HVIS signal[i] er 1

	for(int i = 0; i < 6; i++) {
		if( targs->signal[i] ) {
			
			printf("Vekker tråd %d \n", i);
			sem_post(&sem[i]);
		}
	}
}

int main(void)
{
  int i,j;
  pthread_t tid[6];
  struct threadargs *targs[6];

  /* allocate memory for threadargs and zero out semaphore signals */
  for(i=0;i<6;i++) { 
    targs[i] = (struct threadargs*) malloc(sizeof(struct threadargs));
	for(j=0;j<6;j++) { 
		targs[i]->signal[j]=0;
	}
  }

// setter opp thread nr 0
targs[0]->id=0;             /* thread number 0 */
targs[0]->sec=1;            /* how long to sleep */
targs[0]->signal[1]=1;      /* which threads to wake up when done */
targs[0]->signal[4]=1;

// setter opp thread nr 1
targs[1]->id=1;
targs[1]->sec=2;            /* how long to sleep */
targs[1]->signal[3]=1;      /* which threads to wake up when done */

// setter opp thread nr 2 
targs[2]->id=2;
targs[2]->sec=3;            /* how long to sleep */

// setter opp thread nr 3
targs[3]->id=3;
targs[3]->sec=2;            /* how long to sleep */

// setter opp thread nr 4
targs[4]->id=4;
targs[4]->sec=3;
targs[4]->signal[5]=1;

// setter opp thread nr 5
targs[5]->id=5;
targs[5]->sec=3;

 
sem_init(&sem[0], SHARED, 1); 
sem_init(&sem[1], SHARED, 0); 
sem_init(&sem[2], SHARED, 1); 
sem_init(&sem[3], SHARED, 0); 
sem_init(&sem[4], SHARED, 0); 
sem_init(&sem[5], SHARED, 0); 

// START TRÅDEN

for(int i = 0; i < 6; i++) {

pthread_create(&tid[i], NULL, tfunc, targs[i]);

}

for(i=0;i<6;i++) pthread_join(tid[i], NULL);

  return 0;
}

