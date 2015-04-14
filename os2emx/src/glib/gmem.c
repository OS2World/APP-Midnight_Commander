#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdlib.h>
#include <string.h>
#include "glib.h"


gpointer
g_malloc (gulong size)
{
  return malloc(size);
}


gpointer
g_realloc (gpointer mem,
	   gulong   size)
{ return realloc(mem,size);
}

void
g_free (gpointer mem)
{
  if(mem)free(mem);
}



