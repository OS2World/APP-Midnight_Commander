/* attrib command for OS/2

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

#define INCL_DOSFILEMGR
#include <os2.h>
#include <string.h>
#include <stdio.h>
/* for chmod and stat */
#include <io.h>
#include <sys\types.h>
#include <sys\stat.h>

int get_attrib (char *filename)
{
    mode_t st;

    HFILE       fHandle    = 0L;
    ULONG       fInfoLevel = 1;  /* 1st Level Info: Standard attributs */
    FILESTATUS3 fInfoBuf;
    ULONG       fInfoBufSize;
    ULONG      fAction    = 0;
    APIRET      rc;

    fInfoBufSize = sizeof(FILESTATUS3);
    rc = DosOpen((PSZ) filename,
                 &fHandle,
                 &fAction,
                 (ULONG) 0,
                 FILE_NORMAL,
                 OPEN_ACTION_OPEN_IF_EXISTS,
                 (OPEN_ACCESS_READONLY | OPEN_SHARE_DENYNONE),
                 (PEAOP2) NULL);
    if (rc != 0) {
       return -1;
    }

    rc = DosQueryFileInfo(fHandle, fInfoLevel, &fInfoBuf, fInfoBufSize);
    DosClose(fHandle);
    if (rc != 0) {
       return -1;  /* error ! */
    } else {
       st = fInfoBuf.attrFile;
    }

    if (st & FILE_DIRECTORY)
    	st = -1;
    return st;
}


int set_attrib (char *filename, ULONG st)
{
    HFILE       fHandle    = 0L;
    ULONG       fInfoLevel = 1;  /* 1st Level Info: Standard attributs */
    FILESTATUS3 fInfoBuf;
    ULONG       fInfoBufSize;
    ULONG       fAction    = 0L;
    APIRET      rc;

    if (!(st & FILE_READONLY))
       chmod(filename, (S_IWRITE | S_IREAD));
    fInfoBufSize = sizeof(FILESTATUS3);
    rc = DosOpen((PSZ) filename,
                 &fHandle,
                 &fAction,
                 (ULONG) 0,
                 FILE_NORMAL,
                 OPEN_ACTION_OPEN_IF_EXISTS,
                 (OPEN_ACCESS_READWRITE | OPEN_SHARE_DENYNONE),
                 0L);
    if (rc != 0) {
       return rc;
    }

    rc = DosQueryFileInfo(fHandle, fInfoLevel, &fInfoBuf, fInfoBufSize);
    if (rc!=0) {
       DosClose(fHandle);
       return rc;
    }
    fInfoBuf.attrFile = st;
    rc = DosSetFileInfo(fHandle, fInfoLevel, &fInfoBuf, fInfoBufSize);
    rc = DosClose(fHandle);
    return rc;
}

