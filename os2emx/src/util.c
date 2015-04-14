#include<sys/types.h>
#include<sys/stat.h>
#include<sys/statfs.h>
#include<string.h>
#include<stdlib.h>


void os2_canon_str(char *s)
{ char *p=s;
  while(*s){ if(*s=='\\'&&*(s+1)=='\\')s++;
             *p++=*s++;
           }
  *p=0; 
}

int lstat (const char* pathname, struct stat *buffer)
{  int rc = stat (pathname, buffer);
   return rc;
}

int link (char *p1, char *p2)
{  return -1;
}


int mknod (char *path, int mode, int dev)
{ return -1;
}

int chown (char *path, int owner, int group)
{ return 0;
}

/* unistd.h */
/* Read the contents of the symbolic link PATH into no more tham
   LEN bytes of BUF. The contents are not null-terminated.
   Return the number of characters read, or -1 for errors */
int readlink (const char* path, char* buf, int len)
{ return -1;
}

/* unistd.h */
/* __USE_BSD || __USE_XOPEN_EXTENDED */
/* Make a symbolic link to FROM named TO */
int symlink (char *from, char *to)
{ return -1;
}

/* unistd.h */
/* Make PATH be the root directory (the starting point of absolute paths).
   This call is restricted to the super-user. */
int chroot(const char *path)
{ return -1;
}

/* sys/stat.h */
/* Create a new FIFO named PATH, with premission bits MODE. */
int mkfifo(const char *path, mode_t mode)
{ return -1; }

/* unistd.h */
/* Create a new session with the calling process at its leader.
   The process group IDs of the session and the calling process
   are set to the process ID of the calling proces, which is returned. */
pid_t setsid(void)
{ return -1; }

/* unistd.h */
/* Set the real user ID of the calling process to RUID
   and efective user ID of the calling process to EUID. */
int setreuid (uid_t ruid, uid_t euid)
{ return -1; }

/* grp.h */
/* __USE_SVID || __USE_BSD || __USE_XOPEN_EXTENDED */
/* Rewind the group-file stream. */
void setgrent(void)
{;} 
/* Close the group-file stream */
void endgrent(void)
{;} 
/* Read a group entry from group-file stream, opening it if necessary. */
struct group *getgrent(void)
{ return 0; }


/* sys/statfs.h */
/* Return information about the filesystem on which FILE resides */
int statfs(const char *file, struct statfs *buf)
{ return -1;
}


