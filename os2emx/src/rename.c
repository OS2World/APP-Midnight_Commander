#include<stdio.h>

#define BUFSIZE 0x4000

static
int copy(char *src, char *dst)
{ FILE *S=fopen(src,"rb"),*D;
  char buf[BUFSIZE];
  int n,rc=0;
  if(!S)return -1;
  D=fopen(dst,"wb");
  while((n=fread(buf,1,BUFSIZE,S))>0)
     { int nw;
       nw=fwrite(buf,1,n,D);
       if(nw!=n) break;
     }
  if(n&&!feof(S))rc=-1;    
  fclose(D);
  fclose(S);
  return rc;
} 
   


int my_rename(char *oldname, char *newname)
{ int rc;
  char tmp_backup[256];
  if(!tmpnam(tmp_backup))return -1;
  rc=unlink(tmp_backup);
  rc=copy(newname,tmp_backup);
  rc=unlink(newname);
  rc=rename(oldname,newname);
  if(rc)copy(tmp_backup,newname);
  unlink(tmp_backup);
  return rc;
}

