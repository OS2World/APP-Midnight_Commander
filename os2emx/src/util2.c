#include<sys/types.h>
#include<sys/stat.h>
#include<sys/statfs.h>
#include<string.h>
#include<stdlib.h>

extern char *shell;
extern char *home_dir;

static int unix_shell;

int is_unix_shell()
{ return unix_shell; }

void OS_adjust()
{ char *d=0,*p=shell; 
  while(*p){ *p=*p=='/'?'\\':*p; p++; }
  p=shell+strlen(shell)-2;
  if(!strcmp(p,"sh"))unix_shell=1;
  d=_getcwd2(NULL,0);
  _chdir2(home_dir);
  home_dir=_getcwd2(NULL,0);
  if(d) { _chdir2(d); free(d); }
} 

