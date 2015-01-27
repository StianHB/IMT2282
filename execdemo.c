#include <stdio.h>        /* printf */
     #include <unistd.h>       /* execve */
     int main(int argc, char *argv[]) {
       
	if(argc < 2) {
        
		 printf("Usage: %s path1 [path2 [..]]\n", argv[0]);
	
	return 1;
 	}	

       char *path[2];

       path[0] = argv[argc-1];

       path[1] = NULL;

       printf("Et program som lett tryner, men enkel demo av exec\n");

       execve(path[0], path, NULL);

       printf("Denne blir aldri skrevet ut med mindre execve feilet\n");

return 0; 
}
