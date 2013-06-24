/* glibconfig.h */
/* This is a generated file.  Please modify `configure.in' */

#ifndef GLIBCONFIG_H
#define GLIBCONFIG_H

#ifdef __cplusplus
extern "C" {
#endif /* __cplusplus */

#include <limits.h>
#include <float.h>
#ifndef OS2EMX
#include <pthread.h>
#endif
#include <sys/types.h>
#ifndef OS2EMX
#include <sys/poll.h>
#endif

#define G_MINFLOAT FLT_MIN
#define G_MAXFLOAT FLT_MAX
#define G_MINDOUBLE DBL_MIN
#define G_MAXDOUBLE DBL_MAX
#define G_MINSHORT SHRT_MIN
#define G_MAXSHORT SHRT_MAX
#define G_MININT INT_MIN
#define G_MAXINT INT_MAX
#define G_MINLONG LONG_MIN
#define G_MAXLONG LONG_MAX

typedef signed char gint8;
typedef unsigned char guint8;
typedef signed short gint16;
typedef unsigned short guint16;
typedef signed int gint32;
typedef unsigned int guint32;

#if defined (__GNUC__) && __GNUC__ >= 2 && __GNUC_MINOR__ >= 8
#  define GLIB_WARNINGS_MAKE_PEOPLE_CRY __extension__
#else
#  define GLIB_WARNINGS_MAKE_PEOPLE_CRY
#endif

#define G_HAVE_GINT64 1

GLIB_WARNINGS_MAKE_PEOPLE_CRY typedef signed long long gint64;
GLIB_WARNINGS_MAKE_PEOPLE_CRY typedef unsigned long long guint64;

#define G_GINT64_CONSTANT(val)	(GLIB_WARNINGS_MAKE_PEOPLE_CRY (val##LL))

#define GPOINTER_TO_INT(p)	((gint)(p))
#define GPOINTER_TO_UINT(p)	((guint)(p))

#define GINT_TO_POINTER(i)	((gpointer)(i))
#define GUINT_TO_POINTER(u)	((gpointer)(u))

#ifdef NeXT /* @#%@! NeXTStep */
# define g_ATEXIT(proc)	(!atexit (proc))
#else
# define g_ATEXIT(proc)	(atexit (proc))
#endif

#define g_memmove(d,s,n) G_STMT_START { memmove ((d), (s), (n)); } G_STMT_END

#define GLIB_MAJOR_VERSION 1
#define GLIB_MINOR_VERSION 1
#define GLIB_MICRO_VERSION 9
#define GLIB_INTERFACE_AGE 0
#define GLIB_BINARY_AGE 0


#ifdef	__cplusplus
#define	G_HAVE_INLINE	1
#else	/* !__cplusplus */
#define G_HAVE_INLINE 1
#define G_HAVE___INLINE 1
#define G_HAVE___INLINE__ 1
#endif	/* !__cplusplus */

#define G_BYTE_ORDER G_LITTLE_ENDIAN

#define G_THREADS_ENABLED

/* definitions for the default mutex implementation */
#ifndef OS2EMX
typedef struct _GStaticMutex GStaticMutex;
struct _GStaticMutex 
{
  pthread_mutex_t default_mutex;
  struct _GMutex* runtime_mutex;
};
#define G_STATIC_MUTEX_INIT { PTHREAD_MUTEX_INITIALIZER, NULL }
#define g_static_mutex_get_mutex(mutex)   ( g_thread_use_default_impl ? (GMutex*)&(mutex).default_mutex :     g_static_mutex_get_mutex_impl(&(mutex).runtime_mutex) )
#endif

#define GINT16_TO_LE(val)	((gint16) (val))
#define GUINT16_TO_LE(val)	((guint16) (val))
#define GINT16_TO_BE(val)	((gint16) GUINT16_SWAP_LE_BE (val))
#define GUINT16_TO_BE(val)	(GUINT16_SWAP_LE_BE (val))

#define GINT32_TO_LE(val)	((gint32) (val))
#define GUINT32_TO_LE(val)	((guint32) (val))
#define GINT32_TO_BE(val)	((gint32) GUINT32_SWAP_LE_BE (val))
#define GUINT32_TO_BE(val)	(GUINT32_SWAP_LE_BE (val))

#define GINT64_TO_LE(val)	((gint64) (val))
#define GUINT64_TO_LE(val)	((guint64) (val))
#define GINT64_TO_BE(val)	((gint64) GUINT64_SWAP_LE_BE (val))
#define GUINT64_TO_BE(val)	(GUINT64_SWAP_LE_BE (val))

#define GLONG_TO_LE(val)	((glong) GINT32_TO_LE (val))
#define GULONG_TO_LE(val)	((gulong) GUINT32_TO_LE (val))
#define GLONG_TO_BE(val)	((glong) GINT32_TO_BE (val))
#define GULONG_TO_BE(val)	((gulong) GUINT32_TO_BE (val))

#define GINT_TO_LE(val)		((gint) GINT32_TO_LE (val))
#define GUINT_TO_LE(val)	((guint) GUINT32_TO_LE (val))
#define GINT_TO_BE(val)		((gint) GINT32_TO_BE (val))
#define GUINT_TO_BE(val)	((guint) GUINT32_TO_BE (val))

#define G_HAVE_WCHAR_H 1
#define G_HAVE_WCTYPE_H 1

#ifdef __cplusplus
}
#endif /* __cplusplus */

#ifdef OS2EMX
#define SIZEOF_LONG 4
#endif

#endif /* GLIBCONFIG_H */

