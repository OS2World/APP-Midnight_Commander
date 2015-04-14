/* mcpasswd.c - passwd program for mc
 * modified from  
 *
 * passwd.c - "passwd" program for /etc/passwd
 *
 * Author:  Kai Uwe Rommel <rommel@ars.muc.de>
 * Created: Wed Mar 16 1994
 */

static char *rcsid =
"$Id: passwd.c,v 1.1 1994/09/16 08:32:48 rommel Exp $";
static char *rcsrev = "$Revision: 1.1 $";

/*
 * $Log: passwd.c,v $
 * Revision 1.1  1994/09/16 08:32:48  rommel
 * Initial revision
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mcpwd.h"

#define SALT "mc"

extern char *crypt(char *, char*);

extern int getopt(int, char **, char*);
extern int optind;
extern char *optarg;

extern char *getpass(char *);
char *getline(const char *prompt);

int usage(void)
{
  printf("\nUsage: mcpasswd [-ad] <user>\n"
	 "\n       -a  add new user"
	 "\n       -d  delete user\n");
  exit(1);
}

int main(int argc, char **argv)
{
  struct passwd *pw, new;
  int opt, add = 0, delete = 0;
  char user[64], password[64], crypted[64];
  char *cp;

  while ( (opt = getopt(argc, argv, "ad?")) != EOF )
    switch ( opt )
    {
    case 'a':
      add = 1;
      break;
    case 'd':
      delete = 1;
      break;
    default:
      usage();
    }

  if (add && delete)
    usage();

  if (optind == argc)
  {
    if ((cp = getenv("USER")) == NULL)
      if ((cp = getenv("LOGNAME")) == NULL)
	usage();

    strcpy(user, cp);
  }
  else
    strcpy(user, argv[optind]);

  printf("User: %s\n", user);

  if ((pw = getpwnam(user)) != NULL)
  {
    if (add)
    {
      printf("User already exists.\n");
      return 1;
    }
  }
  else
  {
    if (!add)
    {
      printf("No such user.\n");
      return 1;
    }
    else
    {
      new.pw_name = user;
      new.pw_passwd = "*";

      do
      {
	cp = getline("User id: ");
	new.pw_uid = atoi(cp);
	if ((pw = getpwuid(new.pw_uid)) != NULL)
	  puts("User id already in use, please choose a different one.");
      }
      while (pw != NULL);

      cp = getline("Group id: ");
      new.pw_gid = atoi(cp);

      new.pw_gecos = strdup(getline("Full name: "));
      new.pw_dir   = strdup(getline("Home directory: "));
      new.pw_shell = strdup(getline("Command line shell: "));

      pw = &new;
    }
  }

  if (strcmp(pw->pw_passwd, "*"))
  {
    strcpy(password, getpass("Current password: "));

    if (strcmp(pw->pw_passwd, crypt(password, pw->pw_passwd)))
    {
      printf("Incorrect password.\n");
      return 1;
    }
  }
  
  if (delete)
  {
    pw->pw_uid = -1;

    if (setpwent(pw))
    {
      printf("Update of passwd file failed.\n");
      return 1;
    }

    return 0;
  }

  strcpy(password, getpass("New password: "));

  strcpy(crypted, getpass("Re-type new password: "));

  if (strcmp(password, crypted))
  {
    printf("New passwords don't match.\n");
    return 1;
  }
  
  strcpy(crypted, crypt(password, SALT));

  if (strcmp(pw->pw_passwd, crypted) == 0)
  {
    printf("Password unchanged.\n");
    return 1;
  }

  pw->pw_passwd = crypted;
    
  if (setpwent(pw))
  {
    printf("Update of passwd file failed.\n");
    return 1;
  }
 
  printf("Done.\n");
    
  return 0;
}

/* end of passwd.c */
