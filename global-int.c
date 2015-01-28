#include <stdio.h> /* printf */
#include <stdlib.h> /* exit */
#include <unistd.h> /* fork */
#include <sys/wait.h>  /* waitpid */
#include <sys/types.h> /* pid_t */

	int g_ant = 0;         /* global declaration */

void writeloop(char *text) {

	long i = 0;
	while (g_ant < 30) { /* print and increment g_ant only each 100000 iteration */
		if (++i % 100000 == 0) { /* % is the same as modulo */
			printf("%s: %d\n", text, ++g_ant);
		}
	}
}
/* Note: the following code does not do proper error checking
   of return values from functions, so this is not robust code,
   but coded this way to be easy to read */

int main(void) {
	pid_t pid;
	
	pid = fork();
	
	if (pid == 0) {
		writeloop("Child");
		exit(0);
	}	
	
	writeloop("Parent");
	waitpid(pid, NULL, 0);
 return 0;

}

