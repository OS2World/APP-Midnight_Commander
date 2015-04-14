#include<stdarg.h>
#include<stdio.h>


#define STDLOGNAME "c:/home/work/tools/mc-4.5.4/src/_mcdbg.log"

static char *std_log_name=0;


static char *get_log_name(void)
/*---------------------------*/
{ return std_log_name?std_log_name:STDLOGNAME;
}

void stdlog(char *fmt,...)
/*=======================*/
{  FILE *F;
   char buf[4086]="";
   va_list argptr;
   va_start(argptr, fmt);
   vsprintf(buf, fmt, argptr);
   va_end(argptr);
   F=fopen(get_log_name(),"at");
   if(F){ fprintf(F,buf);
          fclose(F);
        }
}

void logtof(char *file, char *fmt,...)
/*===============================*/
{  FILE *F;
   char buf[4086]="";
   va_list argptr;
   va_start(argptr, fmt);
   vsprintf(buf, fmt, argptr);
   va_end(argptr);
   F=fopen(file,"at");
   if(F){ fprintf(F,buf);
          fclose(F);
        }
}

