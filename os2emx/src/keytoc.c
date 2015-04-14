/* Keyboard support routines.
	for OS/2 system.

   20. April 97: Alexander Dong (ado)

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


#define INCL_BASE
#define INCL_NOPM
#define INCL_VIO
#define INCL_KBD
#define INCL_DOS
#define INCL_DOSERRORS
#define INCL_WININPUT
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


/* Code to read keystrokes in a separate thread */

typedef struct kbdcodes {
  UCHAR ascii;
  UCHAR scan;
  USHORT shift;  /* .ado: change for mc */
} KBDCODES;


int VKtoCurses (int vkcode);

/* -------------------------------------------------------------- */
/* DEFINITIONS:
      Return from SLANG: KeyCode:  0xaaaabbcc

      where: aaaa = Flags
             bb   = Scan code
             cc   = ASCII-code (if available)

   if no flags (CTRL and ALT) is set, cc will be returned.
   If CTRL is pressed, cc is already the XCTRL(code).
   case cc is:
       0xE0: The scan code will be used for the following keys:
              Insert:  0x52,      DEL:       0x53,
              Page_Up: 0x49,      Page_Down: 0x51,
              Pos1:    0x47,      Ende:      0x4F,
              Up:      0x48,      Down:      0x50,
              Left:    0x4B,      Right:     0x4D,

       0x00: The function keys are defined as:
                F1: 3b00, F2: 3c00 ... F10: 4400, F11: 8500, F12: 8600.
           With ALT-bit set:
           ALT(F1): 6800, 6900,... ALT(F10): 7100, ALT(F11): 8b00
                                                   ALT(F12): 8c00

           Mapping for ALT(key_code):
                For Mapping with normal keys, only the scan code can be 
                used. (see struct ALT_table)
        
   Special keys:
        ENTER (number block): 0xaaaaE00D
        + (number block):     0xaaaa4E2B        Normal: 1B2B
        - (number block):     0xaaaa4A2D        Normal: 352D
        * (number block):     0xaaaa372A        Normal: 1B2A
        / (number block):     0xaaaaE02F
*/
/* -------------------------------------------------------------- */
#define RIGHT_SHIFT_PRESSED             1
#define LEFT_SHIFT_PRESSED              2
#define CTRL_PRESSED                    4
#define ALT_PRESSED                     8
#define SCROLL_LOCK_MODE                16
#define NUM_LOCK_MODE                   32
#define CAPS_LOCK_MODE                  64
#define INSERT_MODE                     128
#define LEFT_CTRL_PRESSED               256
#define LEFT_ALT_PRESSED                512
#define RIGHT_CTRL_PRESSED              1024
#define RIGHT_ALT_PRESSED               2048
#define SCROLL_LOCK_PRESSED             4096
#define NUM_LOCK_PRESSED                8192
#define CAPS_LOCK_PRESSED               16384
#define SYSREQ                          32768
/* -------------------------------------------------------------- */

/* Static Tables */
static
struct {
    int key_code;
    int vkcode;
} fkt_table [] = {
    { KEY_F(1),  0x3B },
    { KEY_F(2),  0x3C },
    { KEY_F(3),  0x3D },
    { KEY_F(4),  0x3E },
    { KEY_F(5),  0x3F },
    { KEY_F(6),  0x40 },
    { KEY_F(7),  0x41 },
    { KEY_F(8),  0x42 },
    { KEY_F(9),  0x43 },
    { KEY_F(10), 0x44 },
    { KEY_F(11), 0x85 },
    { KEY_F(12), 0x86 },
    { KEY_F(11), 0x54 },  /* Shift-F */
    { KEY_F(12), 0x55 },
    { KEY_F(13), 0x56 },
    { KEY_F(11), 0x57 },
    { KEY_F(12), 0x58 },
    { KEY_F(13), 0x59 },
    { KEY_F(11), 0x5A },
    { KEY_F(12), 0x5B },
    { KEY_F(13), 0x5C },
    { KEY_F(11), 0x5D },
    { 0, 0}
};		

static
struct {
    int key_code;
    int vkcode;
} ALT_table [] = {
    { ALT('1'),  0x78 },
    { ALT('2'),  0x79 },
    { ALT('3'),  0x7A },
    { ALT('4'),  0x7B },
    { ALT('5'),  0x7C },
    { ALT('6'),  0x7D },
    { ALT('7'),  0x7E },
    { ALT('8'),  0x7F },
    { ALT('9'),  0x80 },
    { ALT('0'),  0x81 },
/*  { ALT('-'),  0x82 },  only numpad '+' '-' '*' */
/*  { ALT('\\'), 0x2B },  only numpad '+' '-' '*' */
    { ALT('='),  0x83 },
    { ALT('*'),  0x37 }, /* numpad */
    { ALT('-'),  0x4A }, /* numpad */
    { ALT('+'),  0x4E }, /* numpad */
    { ALT('/'),  0xA4 }, /* numpad */
    { ALT('a'),  0x1E },
    { ALT('b'),  0x30 },
    { ALT('c'),  0x2E },
    { ALT('d'),  0x20 },
    { ALT('e'),  0x12 },
    { ALT('f'),  0x21 },
    { ALT('g'),  0x22 },
    { ALT('h'),  0x23 },
    { ALT('i'),  0x17 },
    { ALT('j'),  0x24 },
    { ALT('k'),  0x25 },
    { ALT('l'),  0x26 },
    { ALT('m'),  0x32 },
    { ALT('n'),  0x31 },
    { ALT('o'),  0x18 },
    { ALT('p'),  0x19 },
    { ALT('q'),  0x10 },
    { ALT('r'),  0x13 },
    { ALT('s'),  0x1F },
    { ALT('t'),  0x14 },
    { ALT('u'),  0x16 },
    { ALT('v'),  0x2F },
    { ALT('w'),  0x11 },
    { ALT('x'),  0x2D },
    { ALT('y'),  0x15 },
    { ALT('z'),  0x2C },
    { ALT('\n'),  0x1C },    
    { ALT('\n'),  0xA6 },  /* numpad */
    { ALT('\b'),  0x0E },
    { ALT(ESC_CHAR),  0x01 },
    { ALT('['),  0x1A },
    { ALT(']'),  0x1B },
    { ALT(';'),  0x27 },
    { ALT('\''),  0x28 },
    { ALT('`'),  0x29 },
    { ALT(','),  0x33 },
    { ALT('.'),  0x34 },
    { ALT('/'),  0x35 },
    { ALT(' '),  0x39 },
    { ALT(KEY_F(1)),  0x68 },
    { ALT(KEY_F(2)),  0x69 },
    { ALT(KEY_F(3)),  0x6A },
    { ALT(KEY_F(4)),  0x6B },
    { ALT(KEY_F(5)),  0x6C },
    { ALT(KEY_F(6)),  0x6D },
    { ALT(KEY_F(7)),  0x6E },
    { ALT(KEY_F(8)),  0x6F },
    { ALT(KEY_F(9)),  0x70 },
    { ALT(KEY_F(10)),  0x71 },
    { ALT(KEY_F(11)),  0x8B },
    { ALT(KEY_F(12)),  0x8C },
    { 0, 0}
};		

static
struct {
    int key_code;
    int vkcode;
} CTR_table [] = {
    { 0, 0}
};		


static
struct {
    int key_code;
    int vkcode;
} movement [] = {
    { KEY_BTAB,  0x0f },  /* Shift-Tab */
    { KEY_IC,    0x52 },
    { KEY_IC,    0x92 },  /* Ctrl-Ins */
    { KEY_IC,    0x04 },  /* Shift-Ins */
    { KEY_DC,    0x53 },
    { KEY_DC,    0x93 },  /* Ctrl-Del */
    { KEY_DC,    0x05 },  /* Shift-Del */
    { KEY_PPAGE, 0x49 },
    { KEY_PPAGE, 0x84 },  /* Ctrl-PgUp */
    { KEY_NPAGE, 0x51 },
    { KEY_NPAGE, 0x76 },  /* Ctrl-PgDn */
    { KEY_LEFT,  0x4B },
    { KEY_LEFT,  0x73 },  /* Ctrl-Left */
    { KEY_RIGHT, 0x4D },
    { KEY_RIGHT, 0x74 },  /* Ctrl-Right */
    { KEY_UP,    0x48 },
    { KEY_UP,    0x8D },  /* Ctrl-Up */
    { KEY_DOWN,  0x50 },
    { KEY_DOWN,  0x91 },  /* Ctrl-Dw */
    { KEY_HOME,  0x47 },
    { KEY_HOME,  0x77 },  /* Ctrl-Home */ 
    { KEY_END,	 0x4F },
    { KEY_END,	 0x75 },  /* Ctrl-End */
    { ALT(KEY_HOME), 0x97 },
    { ALT(KEY_UP), 0x98 },
    { ALT(KEY_PPAGE), 0x99 },
    { ALT(KEY_LEFT), 0x9B },
    { ALT(KEY_RIGHT), 0x9D },
    { ALT(KEY_END), 0x9F },
    { ALT(KEY_HOME), 0x97 },
    { ALT(KEY_DOWN), 0xA0 },
    { ALT(KEY_NPAGE), 0xA1 },
    { ALT(KEY_IC), 0xA2 },
    { ALT(KEY_DC), 0xA3 },
    { ALT('\t'), 0xA5 },
    { 0, 0}
};		


static
struct {
    int key_code;
    int vkcode;
} special [] = {
    { KEY_KP_ADD, 0x4e2b },
    { KEY_KP_SUBTRACT, 0x4a2d },
    { KEY_KP_MULTIPLY, 0x372a },
    { 0, 0}
};

int spVKtoCurses( int a_vkc)
{ int i;
  for (i=0;  special[i].vkcode != 0 || special[i].key_code != 0; i++) 
	if (a_vkc&0xFFFF == special[i].vkcode) 
  	     return (special[i].key_code);
  return 0;
}


int VKtoCurses (int a_vkc)
{
   unsigned char scanCode;
   unsigned char asciiCode;
   register int i;
   int rtnCode = 0;

   scanCode = (unsigned char) ((a_vkc & 0x0000FFFF) >> 8);
   asciiCode = (unsigned char) (a_vkc & 0x000000FF);
 /* stdlog("%04x %02x\n",a_vkc,scanCode);  */ 

   rtnCode = asciiCode;

   /* Scan Movement codes */
   if (asciiCode == 0) {
      /* Replace key code with that in table */
      for (i=0;  movement[i].vkcode != 0 || movement[i].key_code != 0; i++) 
	if (scanCode == movement[i].vkcode) 
  	     return (movement[i].key_code);
      /* Function-key detected */
      for (i=0;  fkt_table[i].vkcode != 0 || fkt_table[i].key_code != 0; i++) 
	if (scanCode == fkt_table[i].vkcode) 
  	     return (fkt_table[i].key_code);
      /* ALT - KEY */
      for (i=0;  ALT_table[i].vkcode != 0 || ALT_table[i].key_code != 0; i++) 
                if (scanCode == ALT_table[i].vkcode) 
                 	     return (ALT_table[i].key_code);
   }

   if (asciiCode == 0x0d) {
      return '\n';
   }

   return rtnCode;
}



