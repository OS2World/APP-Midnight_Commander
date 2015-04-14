/* pwd.h - /etc/passwd access library
 *
 * Author:  Kai Uwe Rommel <rommel@jonas>
 * Created: Mon Mar 28 1994
 */

/* $Id: pwd.h,v 1.1 1994/09/16 08:32:48 rommel Exp $ */

/*
 * $Log: pwd.h,v $
 * Revision 1.1  1994/09/16 08:32:48  rommel
 * Initial revision
 * 
 */

#ifndef _PWD_H
#define _PWD_H

struct passwd
{
  char *pw_name;
  char *pw_passwd;
  int   pw_uid;
  int   pw_gid;
  char *pw_age;
  char *pw_comment;
  char *pw_gecos;
  char *pw_dir;
  char *pw_shell;
};


#define gcos_name(x, y)  x

struct passwd *getpwnam(char *name);
struct passwd *getpwuid(int uid);
int setpwent(struct passwd *);

#endif /* _PWD_H */

/* end of pwd.h */
