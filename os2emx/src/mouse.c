#include <config.h>
#include "src/mouse.h"

#define  INCL_DOS
#define  INCL_VIO
#define  INCL_KBD
#define  INCL_MOU
#define  INCL_DOSPROCESS

#include <os2.h>
#include <stdio.h>
#include <string.h>
#include <stddef.h>
#include <string.h>
#include <stdlib.h>
#include <sys/time.h>

#define MOU_BUFF_SIZE 0x200
static int MouseBuffer[MOU_BUFF_SIZE]; 
static int MouseBufferHead,MouseBufferTail;

static MouDataValid=0;

int mouse_has_data()
{ return MouDataValid;
}

static
int mouse_getch()
{ int rc=-1;
  if(MouseBufferHead!=MouseBufferTail)
    { rc=MouseBuffer[MouseBufferTail++];
      MouseBufferTail%=MOU_BUFF_SIZE;
      MouDataValid--;
    }
  return rc;
}

static
void mouse_to_buff(int event, int col, int row)
{  int d=MouseBufferTail-MouseBufferHead;
   if(d<=0)d+=MOU_BUFF_SIZE;
   if(d>2){ MouseBuffer[MouseBufferHead++]=event;
            MouseBufferHead%=MOU_BUFF_SIZE;
            MouseBuffer[MouseBufferHead++]=col;
            MouseBufferHead%=MOU_BUFF_SIZE;
            MouseBuffer[MouseBufferHead++]=row;
            MouseBufferHead%=MOU_BUFF_SIZE;
            MouDataValid+=3;  
          } 
/*   DosBeep(600,50); */
}

#define BTN1 1
#define BTN2 2
#define BTN3 3
#define BTUP 4
#define MMOT 128

static int mouse_Quit=0;
static MOUEVENTINFO mouev;
static HMOU hmou;

static 
void ReadMouse(void *Data)
{
     static int oldfs = 0; 
     USHORT     fWait = MOU_WAIT;
     NOPTRRECT  mourt = { 0,0,24,79 };

     mourt.cRow=GetScrCols()-1;
     mourt.cCol=GetScrRows()-1;

     MouOpen(NULL,&hmou);
     MouDrawPtr(hmou);

     do
     {
          MouReadEventQue(&mouev,&fWait,hmou);

          if(mouev.time)
          { MouRemovePtr(&mourt,hmou);
            if(mouev.fs & MOUSE_BN1_DOWN )
                 mouse_to_buff(BTN1, mouev.col, mouev.row);
            else if(mouev.fs & MOUSE_BN2_DOWN )
                 mouse_to_buff(BTN2, mouev.col, mouev.row);
            else if(mouev.fs & MOUSE_BN3_DOWN )
                 mouse_to_buff(BTN3, mouev.col, mouev.row);
            else if(mouev.fs & MOUSE_MOTION_WITH_BN1_DOWN )
                 mouse_to_buff(BTN1|MMOT, mouev.col, mouev.row);
            else if(mouev.fs & MOUSE_MOTION_WITH_BN2_DOWN )
                 mouse_to_buff(BTN2|MMOT, mouev.col, mouev.row);
            else if(mouev.fs & MOUSE_MOTION_WITH_BN3_DOWN )
                 mouse_to_buff(BTN3|MMOT, mouev.col, mouev.row);
            if(!mouev.fs)
               { if(oldfs) mouse_to_buff(BTUP, mouev.col, mouev.row);
                 else mouse_to_buff(0, mouev.col, mouev.row);
               }
            oldfs=mouev.fs;
            MouDrawPtr(hmou);
          }

     }while(!mouse_Quit );

     DosExit(EXIT_THREAD, 0L );
}


#define STACK_SIZE_MOUTHRD  32768

int os2_create_mouse_thread(void)
{ int sValue;
  return _beginthread(  ReadMouse,
                        NULL,
                        STACK_SIZE_MOUTHRD,
                        &sValue)<0?-1:0;
}

/* This macros were stolen from gpm 0.15 */
#define GET_TIME(tv) (gettimeofday(&tv, (struct timezone *)NULL))
#define DIF_TIME(t1,t2) ((t2.tv_sec -t1.tv_sec) *1000+ \
			 (t2.tv_usec-t1.tv_usec)/1000)

extern int double_click_speed;
			 
int os2_mouse_get_event (Gpm_Event *ev)
{
    int btn;
    static struct timeval tv1 = { 0, 0 }; /* Force first click as single */
    static struct timeval tv2;
    static int clicks;

    /* Decode Xterm mouse information to a GPM style event */

    /* Variable btn has following meaning: */
    /* 0 = btn1 dn, 1 = btn2 dn, 2 = btn3 dn, 3 = btn up */
    btn = mouse_getch ();
    if(btn<0)return -1; 
        
    /* There seems to be no way of knowing which button was released */
    /* So we assume all the buttons were released */
    if(!btn){
        ev->type = GPM_MOVE;
        ev->buttons = 0;
	GET_TIME (tv1);
    } else if (btn == BTUP){
        ev->type = GPM_UP | (GPM_SINGLE << clicks);
        ev->buttons = 0;
	GET_TIME (tv1);
	clicks = 0;
    } else {
        ev->type = btn&MMOT?GPM_DRAG:GPM_DOWN;
	GET_TIME (tv2);
	if (tv1.tv_sec && (DIF_TIME (tv1,tv2) < double_click_speed)){
	    clicks++;
	    clicks %= 3;
	} else
	    clicks = 0;
	
        switch (btn&0xF) {
	case BTN1:
            ev->buttons = GPM_B_LEFT;
            break;
	case BTN2:
            ev->buttons = GPM_B_RIGHT;
            break;
	case BTN3:
            ev->buttons = GPM_B_MIDDLE;
            break;
	default:
            /* Nothing */
            break;
        }
    }

    ev->x = mouse_getch () +1;
    ev->y = mouse_getch () +1;
    return 0;
}



