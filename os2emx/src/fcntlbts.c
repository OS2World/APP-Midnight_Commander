#include<sys/fcntl.h>
#include "src/hetnet.h"


unsigned flags_to_mc(unsigned flags)
{ unsigned rc=0;
  if(flags&O_RDONLY)rc|=MC_O_RDONLY;
  if(flags&O_WRONLY)rc|=MC_O_WRONLY;
  if(flags&O_RDWR)rc|=MC_O_RDWR;
  if(flags&O_CREAT)rc|=MC_O_CREAT;
  if(flags&O_EXCL)rc|=MC_O_EXCL;
  if(flags&O_NOCTTY)rc|=MC_O_NOCTTY;
  if(flags&O_TRUNC)rc|=MC_O_TRUNC;
  if(flags&O_APPEND)rc|=MC_O_APPEND;
  if(flags&O_NDELAY)rc|=MC_O_RDONLY;
  if(flags&O_SYNC)rc|=MC_O_SYNC;
  return rc;
}
unsigned flags_from_mc(unsigned flags)
{ unsigned rc=0;

  if(flags&MC_O_RDONLY)rc|=O_RDONLY;
  if(flags&MC_O_WRONLY)rc|=O_WRONLY;
  if(flags&MC_O_RDWR)rc|=O_RDWR;
  if(flags&MC_O_CREAT)rc|=O_CREAT;
  if(flags&MC_O_EXCL)rc|=O_EXCL;
  if(flags&MC_O_NOCTTY)rc|=O_NOCTTY;
  if(flags&MC_O_TRUNC)rc|=O_TRUNC;
  if(flags&MC_O_APPEND)rc|=O_APPEND;
  if(flags&MC_O_NDELAY)rc|=O_RDONLY;
  if(flags&MC_O_SYNC)rc|=O_SYNC;
  return rc;
}
