/* getpass.c */

#include <stdio.h>
#include <conio.h>

#define _PASSWORD_LEN 128

/* Issue prompt and read reply with echo turned off */
char *getpass (const char *prompt)
{
  static char pbuf[_PASSWORD_LEN+1];
  int c, i;

  fputs (prompt, stderr);
  fflush (stderr);
  i = 0;

  for (;;)
  {
    c = getch ();
    if (c == '\r' || c == '\n')
      break;
    if (c == '\b' || c == 127)
    {
      if (i > 0) --i;
    }
    else if (c == 0x15 || c == 0x1b)
      i = 0;
    else if (i < sizeof (pbuf)-1)
      pbuf[i++] = (char)c;
  }

  pbuf[i] = 0;
  fputs ("\r\n", stderr);
  fflush (stderr);

  return pbuf;
}

/* Issue prompt and read reply with echo turned on */
char *getline(const char *prompt)
{
  static char buffer[256];
  int c;

  fputs(prompt, stdout);
  fflush(stdout);
  fgets(buffer, sizeof(buffer), stdin);
  c = strlen(buffer);

  if (buffer[c - 1] == '\n')
    buffer[c - 1] = 0;

  return buffer;
}

/* end of getpass.c */
