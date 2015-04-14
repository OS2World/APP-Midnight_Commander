#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <os2.h>

int get_drive()
{ return _getdrive();
}

int chg_drive(int drive)
{ _chdrive(drive);
   return _getdrive();
}

int get_logical_drives(int *DrivesAvail)
{  unsigned long uDriveNum, uDriveMap;
   int nDrivesAvail = 0,i;
   DosQueryCurrentDisk(&uDriveNum, &uDriveMap);
   for (i = 0; i < 26; i++)
      if ( uDriveMap & (1 << i) )DrivesAvail[nDrivesAvail++]='A'+i;
   DrivesAvail[nDrivesAvail]=0; 
   return nDrivesAvail;
}

