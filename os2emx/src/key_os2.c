/* Keyboard support routines for OS/2 system.


   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  

*/

#include <config.h>

#define INCL_KBD
#include <os2.h>
#include <stdio.h>
#include <string.h>
#include <sys/select.h>
#include <sys/time.h>
#include <errno.h>
#include "src/mouse.h"
#include "src/global.h"
#include "src/main.h"
#include "src/key.h"
#include "src/main.h"
#include "src/tty.h"


extern int  (*os_get_key_code)(int no_delay);
extern int  (*os_get_event)(Gpm_Event *event, int redo_event, int block);
extern int  (*os_get_modifier)(void);

int os2_get_key_code (int no_delay)
{
    unsigned int        inp_ch;

    if (no_delay) {
        /* Check if any input pending, otherwise return */
	nodelay (stdscr, TRUE);
        inp_ch = SLang_input_pending(0);
        if (inp_ch == 0) {
           return 0;
        }
    } 

    if (no_delay) {
       return (VKtoCurses(inp_ch));
    }

    do {
      if(SLang_input_pending(0)>0){
         inp_ch = SLang_getkey();
         if (!inp_ch)
            inp_ch = (SLang_getkey() << 8);
         if (inp_ch) return (VKtoCurses(inp_ch));
      } else 
         if(mouse_has_data())return 0;
      _sleep2(10);
    } while (!no_delay);
    return 0;
}

static int getch_with_delay (void)
{
    int c=0;

    while (1) {
	/* Try to get a character */
	c = os2_get_key_code (0);
	if (c != ERR)
	    break;
    }
    /* Success -> return the character */
    return c;
}

int os2_get_event (Gpm_Event *event, int redo_event, int block)
{
    int c;    
    static Gpm_Event ev;  /* Mouse event */

    refresh ();
    doupdate ();
    vfs_timeout_handler ();

/*-----------------------------------------------------------------------*/
    /* Repeat if using mouse */
    if(redo_event)
     { if(os2_mouse_get_event(&ev))_sleep2(mou_auto_repeat);      
       *event=ev;
       return EV_MOUSE;
     }
/*-----------------------------------------------------------------------*/
    c = block ? getch_with_delay () : os2_get_key_code (1);
    if (!c) {
        if(os2_mouse_get_event(&ev)) {       
           /* Code is -1, no mouse event */
            return EV_NONE; 
        } else {
            *event = ev; 
            return EV_MOUSE;
        }
    }

    return c;
}

int os2_get_modifier()
{ int   rc=0,f;
  KBDINFO I;
  f=KbdGetStatus(&I,0);
  if(!f)
   { f=I.fsState;
     if(f&0x0003)rc|=SHIFT_PRESSED;
     if(f&0x0004)rc|=CONTROL_PRESSED;
     if(f&0x0200)rc|=ALTL_PRESSED;
     if(f&0x0800)rc|=ALTR_PRESSED;
   }
  return rc;
}

int os2_init_key (char *term)
{  
   os_get_key_code=os2_get_key_code;
   os_get_event=os2_get_event;
   os_get_modifier=os2_get_modifier;
   return 1;
}


void OS_Setup_Console(char *term, int kbd, int mouse)
{ static char *lines,*columns; 
  if(term&&strncmp(term,"xterm",5)) 
     { int c=GetScrCols(),r=GetScrRows();  /* VIO */
       char buf[256];
       sprintf(buf,"LINES=%i",r);   lines=strdup(buf);   putenv(lines);
       sprintf(buf,"COLUMNS=%i",c); columns=strdup(buf); putenv(columns);
       if(kbd&&mouse)os2_create_mouse_thread();
       if(kbd)os_init_key=os2_init_key;
     }
}
