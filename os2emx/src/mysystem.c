#include <config.h>
#include <string.h>
#include <stdlib.h>
#include <process.h>
#include "src/fs.h"
#include "src/util.h"
#include "src/dialog.h"

static int 
os_startp (const char *shell, const char *command, const char *parm) 
{  
   if (parm) { 
         char *argv[256],*par=strdup(parm),*p,i=0;
         argv[i++]=strdup(shell); 
         argv[i++]=strdup("/c"); 
         argv[i++]=strdup(command); 
         p=strtok(par," ");
         while(p) {
             argv[i++]=strdup(p);
             p=strtok(0," ");
         }
         argv[i]=0; 
         spawnvp (P_WAIT,shell,argv);
         i=0;
         while(argv[i])free(argv[i++]);
         free(par);
    } else {
         spawnlp (P_WAIT, 
              (char *) shell, 
              (char *) shell, 
              "/c", 
              (char *) command, 
              (char *) 0);
    }
    return 0;
}

static int 
ux_startp (int flags, const char *shell, const char *command) 
{  
  if (flags & EXECUTE_AS_SHELL)
	    spawnl  (P_WAIT, shell, shell, "-c", command, (char *) 0);
  else
	    spawnlp (P_WAIT, shell, shell, command, (char *) 0);
  return 0;
}

int my_system (int as_shell_command, const char *Shell, const char *command)
{
   char *sh;            /* This is the shell -- always! */
   char *cmd;           /* This is the command (only the command) */
   char *parm;          /* This is the parameter (can be more than one) */
   register int length, i;
   char temp[4096];     /* That's enough! */
   sh = getenv ("COMSPEC"); 
   if (strcmp(sh, Shell)) {
      /* unix shell */
      cmd  = (char *) Shell;
      parm = (char *) command;
      return ux_startp(as_shell_command,Shell,command);
   } else {
      /* look into the command and take out the program */
      if (command) {
         strcpy(temp, command);
         length = strlen(command);
         for (i=length-1; i>=0; i--) {
            if (command[i] == ' ') {
               temp[i] = (char) 0;
               length--;
            } else 
                break;
         }
         if (i==-1) {
            /* only blanks */
            return -1;
         }
         if (parm = strchr(temp, (char) ' ')) {
            *parm = (char) 0;
            parm++;
         }
         cmd  = (char *) temp;
         length=strlen(cmd);
         for(i=0;i<length;i++)if(cmd[i]=='/')cmd[i]='\\';
      } else {
         /* command is NULL */
         cmd = parm = NULL;
      }
   }
   return os_startp(sh, cmd, parm);
}


static char tmp_buf[256];
static int  tmp_cnt;

char *tmpnam_ext(char *sfx)
/*-------------------------*/
{ char    *p=getenv("TMP"); 
  unsigned t=time(0)<<8|(0xFF&tmp_cnt++);  
  if(p){ strcpy(tmp_buf,p); 
         p=tmp_buf;
         while(*p) { if(*p=='/')*p='\\'; p++; } 
         if(*(p-1)!='\\'){ *p++='\\'; *p=0; }
       }
  else p=tmp_buf;
  sprintf(p,"%08x%s",t,sfx);
  return tmp_buf;
}