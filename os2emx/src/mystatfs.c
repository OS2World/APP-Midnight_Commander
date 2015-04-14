/* Various utilities - OS/2 versions
   Copyright (C) 1994, 1995, 1996 the Free Software Foundation.

   Written 1994, 1995, 1996 by:
   Juan Grigera, Miguel de Icaza, Janne Kukonlehto, Dugan Porter,
   Jakub Jelinek, Mauricio Plaza.

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
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  */

#include <config.h>

#define INCL_DOS
#define INCL_PM
#define INCL_DOSPROCESS
#define INCL_DOSFILEMGR
#define INCL_DOSDEVICES   /* Device values */
#define INCL_DOSDATETIME
#define INCL_DOSERRORS
#include <os2.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <ctype.h>
#include <sys/stat.h>
#include <errno.h>
#include <io.h>
#include <fcntl.h>
#include <signal.h>		/* my_system */
#include <limits.h>		/* INT_MAX */
#include <sys/time.h>		/* select: timeout */
#include <sys/param.h>
#include <sys/stat.h>
#include <stdarg.h>
#include <process.h>
#include "src/fs.h"
#include "src/util.h"
#include "src/dialog.h"

#ifndef ENOTEMPTY
#define ENOTEMPTY ERROR_DIR_NOT_EMPTY
#endif


static char x_device[32],x_mpoint[32];

int 
os2_my_statfs (struct my_statfs *myfs_stats, char *path)
{
    PFSALLOCATE pBuf;
    PFSINFO     pFsInfo;
    ULONG       lghBuf;

    ULONG       diskNum = 0;
    ULONG       logical = 0;

    UCHAR       szDeviceName[3] = "A:";
    PBYTE       pszFSDName      = NULL;  /* pointer to FS name            */
    APIRET      rc              = NO_ERROR; /* Return code                */
    BYTE        fsqBuffer[sizeof(FSQBUFFER2) + (3 * CCHMAXPATH)] = {0};
    ULONG       cbBuffer   = sizeof(fsqBuffer);        /* Buffer length) */
    PFSQBUFFER2 pfsqBuffer = (PFSQBUFFER2) fsqBuffer;

    int i, len = 0;

    /* ------------------------------------------------------------------ */
    if(strchr(path,'#'))
       { memset(myfs_stats,0,sizeof(*myfs_stats));
         return -1;
       }
    /* ------------------------------------------------------------------ */

    lghBuf = sizeof(FSALLOCATE);
    pBuf = (PFSALLOCATE) malloc(lghBuf);

    /* Get the free number of Bytes */
    rc = DosQueryFSInfo(0L, FSIL_ALLOC, (PVOID) pBuf, lghBuf);
    /* KBytes available */
    myfs_stats->avail = pBuf->cSectorUnit * pBuf->cUnitAvail * pBuf->cbSector / 1024;
    /* KBytes total */
    myfs_stats->total = pBuf->cSectorUnit * pBuf->cUnit * pBuf->cbSector / 1024; 
    myfs_stats->nfree = pBuf->cUnitAvail;
    myfs_stats->nodes = pBuf->cSectorUnit * pBuf->cUnit; //pBuf->cbSector;

    lghBuf  = sizeof(FSINFO);
    pFsInfo = (PFSINFO) malloc(lghBuf);
    rc      = DosQueryFSInfo(0L, 
                             FSIL_VOLSER, 
                             (PVOID) pFsInfo, 
                             lghBuf);
    /* Get name */
    strcpy(x_device,pFsInfo->vol.szVolLabel);    /* Label of the Disk */
    myfs_stats->device = x_device;    

    /* Get the current disk for DosQueryFSAttach */
    rc = DosQueryCurrentDisk(&diskNum, &logical);

    szDeviceName[0] = (UCHAR) (diskNum + (ULONG) 'A' - 1);
    /* Now get the type of the disk */
    rc = DosQueryFSAttach(szDeviceName, 
                          0L, 
                          FSAIL_QUERYNAME, 
                          pfsqBuffer, 
                          &cbBuffer);

    pszFSDName = pfsqBuffer->szName + pfsqBuffer->cbName + 1;
    strcpy(x_mpoint,pszFSDName);    /* FAT, HPFS ... */
    myfs_stats->mpoint = x_mpoint; 

    myfs_stats->type = pBuf->idFileSystem;
    /* What is about 3 ?*/
    if (myfs_stats->type == 0) {
       myfs_stats->typename = "Local Disk";
    } else {
       myfs_stats->typename = "Other Device";
    }

    free(pBuf);
    free(pFsInfo);
    return 0;
}

