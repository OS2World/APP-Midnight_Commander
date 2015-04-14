#include "glib.h"
#include<stdarg.h>

void
g_log (const gchar    *log_domain,
       GLogLevelFlags  log_level,
       const gchar    *format,
       ...)
{
  va_list args;
  
  va_start (args, format);
/*  g_logv (log_domain, log_level, format, args); */
  va_end (args);
}

