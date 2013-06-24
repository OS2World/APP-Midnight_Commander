dnl aclocal.m4 generated automatically by aclocal 1.3

dnl Copyright (C) 1994, 1995, 1996, 1997, 1998 Free Software Foundation, Inc.
dnl This Makefile.in is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY, to the extent permitted by law; without
dnl even the implied warranty of MERCHANTABILITY or FITNESS FOR A
dnl PARTICULAR PURPOSE.

dnl
dnl XView & SlingShot library checking
dnl (c) 1995 Jakub Jelinek
dnl

dnl Set xview_includes, xview_libraries, and no_xview (initially yes).
dnl Also sets xview_no_private_headers to yes if there are no xview_private
dnl headers in the system.
AC_DEFUN(AC_PATH_XVIEW,
[
no_xview=yes
AC_ARG_WITH(xview, [--with-xview              Use the XView toolkit],no_xview=)

AC_ARG_WITH(xview-includes, [--with-xview-includes=path  Specifies XView includes directory],
[
if test x$withval = xyes; then
    AC_MSG_WARN(Usage is: --with-xview-includes=path)
    xview_includes=NONE
    no_xview=
else
    xview_includes=$withval
fi
],
[
xview_includes=NONE
])dnl
AC_ARG_WITH(xview-libraries, [--with-xview-libraries=path  Specifies XView libraries directory],
[
if test x$withval = xyes; then
    AC_MSG_WARN(Usage is: --with-xview-libraries=path)
    xview_libraries=NONE
    no_xview=
else
    xview_libraries=$withval
fi
],
[
xview_libraries=NONE
])dnl

if test "$no_xview" != yes; then
    if test "$no_x" = yes; then
        no_xview=yes
    fi
fi
if test "$no_xview" != yes; then
AC_MSG_CHECKING(for XView)
if test x$xview_libraries = xNONE; then 
    if test x$xview_includes = xNONE; then
AC_CACHE_VAL(ac_cv_path_xview,
[
    no_xview=yes
AC_PATH_XVIEW_XMKMF
    if test "x$no_xview" = xyes; then
AC_PATH_XVIEW_DIRECT
    fi
    if test "x$no_xview" = xyes; then
        ac_cv_path_xview="no_xview=yes"
    else
        ac_cv_path_xview="no_xview= ac_xview_includes=$ac_xview_includes ac_xview_libraries=$ac_xview_libraries ac_xview_no_private_headers=$ac_xview_no_private_headers"
    fi
])dnl
        eval "$ac_cv_path_xview"
    fi
fi

if test "x$no_xview" = xyes; then
    AC_MSG_RESULT(no)
else
    if test "x$xview_includes" = x || test "x$xview_includes" = xNONE; then
        xview_includes=$ac_xview_includes
    fi
    if test "x$xview_libraries" = x || test "x$xview_libraries" = xNONE; then
        xview_libraries=$ac_xview_libraries
    fi
    xview_no_private_headers=$ac_xview_no_private_headers
    ac_cv_path_xview="no_xview= ac_xview_includes=$xview_includes ac_xview_libraries=$xview_libraries ac_xview_no_private_headers=$ac_xview_no_private_headers" 
    if test "x$xview_libraries" != x; then
	ac_msg_xview="libraries $xview_libraries"
    else
    	ac_msg_xview=""
    fi
    if test "x$xview_includes" != x; then
        if test "x$ac_msg_xview" != x; then
	    ac_msg_xview="$ac_msg_xview, "
	fi
	ac_msg_xview="${ac_msg_xview}headers $xview_includes"
    fi
    if test "x$xview_no_private_headers" = xyes; then
        if test "x$ac_msg_xview" != x; then
	    ac_msg_xview="$ac_msg_xview, "
	fi
	ac_msg_xview="${ac_msg_xview}without xview_private headers"
    fi	
    AC_MSG_RESULT([$ac_msg_xview])
fi
fi
])

dnl Internal subroutine of AC_PATH_XVIEW
dnl Set ac_xview_includes, ac_xview_libraries, and no_xview (initially yes).
AC_DEFUN(AC_PATH_XVIEW_XMKMF,
[rm -fr conftestdir
if mkdir conftestdir; then
  cd conftestdir
  # Make sure to not put "make" in the Imakefile rules, since we grep it out.
  cat > Imakefile <<'EOF'
#include <XView.tmpl>
acfindxv:
	@echo 'ac_im_library_dest="${LIBRARY_DEST}"; ac_im_header_dest="${HEADER_DEST}"'
EOF
  if (xmkmf) >/dev/null 2>/dev/null && test -f Makefile; then
    no_xview=
    # GNU make sometimes prints "make[1]: Entering...", which would confuse us.
    eval `make acfindxv 2>/dev/null | grep -v make`
    # Screen out bogus values from the imake configuration.
    if test -f "$ac_im_header_dest/xview/xview.h"; then
        ac_xview_includes="$ac_im_header_dest"
    else
	no_xview=yes
    fi
    if test -d "$ac_im_library_dest"; then
        ac_xview_libraries="$ac_im_library_dest"
    else
	no_xview=yes
    fi
  fi
  if test "x$no_xview" != xyes; then
    if test -f "$ac_xview_includes/xview_private/draw_impl.h"; then
	ac_xview_no_private_headers=
    else
	ac_xview_no_private_headers=yes
    fi
  fi
  cd ..
  rm -fr conftestdir
fi
])

dnl Internal subroutine of AC_PATH_XVIEW
dnl Set ac_xview_includes, ac_xview_libraries, and no_xview (initially yes).
AC_DEFUN(AC_PATH_XVIEW_DIRECT,
[test -z "$xview_direct_test_library" && xview_direct_test_library=xview
test -z "$xview_direct_test_function" && xview_direct_test_function=xv_unique_key
test -z "$xview_direct_test_include" && xview_direct_test_include=xview/xview.h
AC_TRY_CPP([#include <$xview_direct_test_include>],
[no_xview= ac_xview_includes=],
[  for ac_dir in               \
    $OPENWINHOME/include    \
    /usr/openwin/include      \
    /usr/openwin/share/include \
                              \
    /usr/X11R6/include        \
    /usr/X11R5/include        \
    /usr/X11R4/include        \
                              \
    /usr/include/X11R6        \
    /usr/include/X11R5        \
    /usr/include/X11R4        \
                              \
    /usr/local/X11R6/include  \
    /usr/local/X11R5/include  \
    /usr/local/X11R4/include  \
                              \
    /usr/local/include/X11R6  \
    /usr/local/include/X11R5  \
    /usr/local/include/X11R4  \
                              \
    /usr/X11/include          \
    /usr/include/X11          \
    /usr/local/X11/include    \
    /usr/local/include/X11    \
                              \
    /usr/X386/include         \
    /usr/x386/include         \
    /usr/XFree86/include/X11  \
                              \
    /usr/include              \
    /usr/local/include        \
    /usr/unsupported/include  \
    /usr/athena/include       \
    /usr/local/x11r5/include  \
    /usr/lpp/Xamples/include  \
    ; \
  do
    if test -r "$ac_dir/$xview_direct_test_include"; then
      no_xview= ac_xview_includes=$ac_dir
      break
    fi
  done])

if test "x$no_xview" != xyes; then
    if test "x$ac_xview_includes" != x; then
        if test -f "$ac_xview_includes/xview_private/draw_impl.h"; then
	    ac_xview_no_private_headers=
        else
	    ac_xview_no_private_headers=yes
        fi
    else
AC_TRY_CPP([#include <xview_private/draw_impl.h>],
[ac_xview_no_private_headers=],[ac_xview_no_private_headers=yes])
    fi
fi

# Check for the libraries.
# See if we find them without any special options.
# Don't add to $LIBS permanently.
ac_save_LIBS="$LIBS"
ac_save_LDFLAGS="$LDFLAGS"
LDFLAGS="$LDFLAGS $X_LIBS"
LIBS="-l$xview_direct_test_library -lolgx $X_EXTRA_LIBS -lX11 $X_PRE_LIBS $LIBS"
AC_TRY_LINK([#include <$xview_direct_test_include>
], [${xview_direct_test_function}()],
[LIBS="$ac_save_LIBS" LDFLAGS="$ac_save_LDFLAGS" no_xview= ac_xview_libraries=],
[LIBS="$ac_save_LIBS" LDFLAGS="$ac_save_LDFLAGS"
# First see if replacing the include by lib works.
for ac_dir in `echo "$ac_xview_includes" | sed s/include/lib/` \
    $OPENWINHOME/lib    \
    $OPENWINHOME/share/lib \
    /usr/openwin/lib      \
    /usr/openwin/share/lib \
                          \
    /usr/X11R6/lib        \
    /usr/X11R5/lib        \
    /usr/X11R4/lib        \
                          \
    /usr/lib/X11R6        \
    /usr/lib/X11R5        \
    /usr/lib/X11R4        \
                          \
    /usr/local/X11R6/lib  \
    /usr/local/X11R5/lib  \
    /usr/local/X11R4/lib  \
                          \
    /usr/local/lib/X11R6  \
    /usr/local/lib/X11R5  \
    /usr/local/lib/X11R4  \
                          \
    /usr/X11/lib          \
    /usr/lib/X11          \
    /usr/local/X11/lib    \
    /usr/local/lib/X11    \
                          \
    /usr/X386/lib         \
    /usr/x386/lib         \
    /usr/XFree86/lib/X11  \
                          \
    /usr/lib              \
    /usr/local/lib        \
    /usr/unsupported/lib  \
    /usr/athena/lib       \
    /usr/local/x11r5/lib  \
    /usr/lpp/Xamples/lib  \
    ; \
do
  for ac_extension in a so sl; do
    if test -r $ac_dir/lib${xview_direct_test_library}.$ac_extension; then
      no_xview= ac_xview_libraries=$ac_dir
      break 2
    fi
  done
done])])

dnl Substitute XVIEW_LIBS and XVIEW_CFLAGS and 
dnl HAVE_XVIEW, which is either yes or no.
dnl Both contain X_LIBS resp. X_CFLAGS inside
dnl Also substitutes HAVE_XVIEW_PRIVATE_HEADERS
dnl if there are xview_private headers in the system
AC_DEFUN(AC_PATH_XVIEW_XTRA,
[AC_REQUIRE([AC_PATH_XVIEW])dnl
if test "$no_xview" = yes; then 
  # Not all programs may use this symbol, but it does not hurt to define it.
  XVIEW_CFLAGS="$X_CFGLAGS $XVIEW_CFLAGS -DXVIEW_MISSING"
else
  if test -n "$xview_includes"; then
    XVIEW_CFLAGS="$X_CFLAGS $XVIEW_CFGLAGS"
    if test "$xview_includes" != "$x_includes"; then
      XVIEW_CPPFLAGS="-I$xview_includes"
    fi
  fi

  # It would be nice to have a more robust check for the -R ld option than
  # just checking for Solaris.
  # It would also be nice to do this for all -L options, not just this one.
  if test -n "$xview_libraries"; then
    if test "$xview_libraries" = "$x_libraries"; then
      XVIEW_LIBS="$X_LIBS $XVIEW_LIBS"
    else
      XVIEW_LIBS="$X_LIBS $XVIEW_LIBS -L$xview_libraries"
      if test "`(uname) 2>/dev/null`" = SunOS &&
        uname -r | grep '^5' >/dev/null; then
        XVIEW_LIBS="$XVIEW_LIBS -R$xview_libraries"
      fi
    fi
  fi
fi
if test "x$no_xview" = xyes; then
  HAVE_XVIEW=no
else
  HAVE_XVIEW=yes
fi
if test "x$xview_no_private_headers" = xyes; then
  HAVE_XVIEW_PRIVATE_HEADERS=no
else
  HAVE_XVIEW_PRIVATE_HEADERS=yes
fi
AC_SUBST(XVIEW_CFLAGS)dnl
AC_SUBST(XVIEW_CPPFLAGS)dnl
AC_SUBST(XVIEW_LIBS)dnl
AC_SUBST(HAVE_XVIEW)dnl
AC_SUBST(HAVE_XVIEW_PRIVATE_HEADERS)dnl
])dnl

dnl Internal subroutine of AC_PATH_SLINGSHOT
AC_DEFUN(AC_PATH_SLINGSHOT_DIRECT,
[
AC_TRY_CPP([#include <sspkg/rectobj.h>],[no_ss= ac_ss_includes=],
[  for ac_dir in               \
    $OPENWINHOME/include    \
    /usr/openwin/include      \
    /usr/openwin/share/include \
                              \
    /usr/X11R6/include        \
    /usr/X11R5/include        \
    /usr/X11R4/include        \
                              \
    /usr/include/X11R6        \
    /usr/include/X11R5        \
    /usr/include/X11R4        \
                              \
    /usr/local/X11R6/include  \
    /usr/local/X11R5/include  \
    /usr/local/X11R4/include  \
                              \
    /usr/local/include/X11R6  \
    /usr/local/include/X11R5  \
    /usr/local/include/X11R4  \
                              \
    /usr/X11/include          \
    /usr/include/X11          \
    /usr/local/X11/include    \
    /usr/local/include/X11    \
                              \
    /usr/X386/include         \
    /usr/x386/include         \
    /usr/XFree86/include/X11  \
                              \
    /usr/include              \
    /usr/local/include        \
    /usr/unsupported/include  \
    /usr/athena/include       \
    /usr/local/x11r5/include  \
    /usr/lpp/Xamples/include  \
    ; \
  do
    if test -r "$ac_dir/sspkg/rectobj.h"; then
      no_ss= ac_ss_includes=$ac_dir
      break
    fi
  done])

# Check for the libraries.
# See if we find them without any special options.
# Don't add to $LIBS permanently.
ac_save_LIBS="$LIBS"
ac_save_LDFLAGS="$LDFLAGS"
LDFLAGS="$LDFLAGS $XVIEW_LIBS"
LIBS="-lsspkg -lm -lxview -lolgx $X_EXTRA_LIBS -lX11 $X_PRE_LIBS $LIBS"
AC_TRY_LINK([#include <sspkg/rectobj.h>
], [rectobj_get_selected_list()],
[LIBS="$ac_save_LIBS" LDFLAGS="$ac_save_LDFLAGS" no_ss= ac_ss_libraries=],
[LIBS="$ac_save_LIBS" LDFLAGS="$ac_save_LDFLAGS"
# First see if replacing the include by lib works.
for ac_dir in `echo "$ac_ss_includes" | sed s/include/lib/` \
    $OPENWINHOME/lib    \
    $OPENWINHOME/share/lib \
    /usr/openwin/lib      \
    /usr/openwin/share/lib \
                          \
    /usr/X11R6/lib        \
    /usr/X11R5/lib        \
    /usr/X11R4/lib        \
                          \
    /usr/lib/X11R6        \
    /usr/lib/X11R5        \
    /usr/lib/X11R4        \
                          \
    /usr/local/X11R6/lib  \
    /usr/local/X11R5/lib  \
    /usr/local/X11R4/lib  \
                          \
    /usr/local/lib/X11R6  \
    /usr/local/lib/X11R5  \
    /usr/local/lib/X11R4  \
                          \
    /usr/X11/lib          \
    /usr/lib/X11          \
    /usr/local/X11/lib    \
    /usr/local/lib/X11    \
                          \
    /usr/X386/lib         \
    /usr/x386/lib         \
    /usr/XFree86/lib/X11  \
                          \
    /usr/lib              \
    /usr/local/lib        \
    /usr/unsupported/lib  \
    /usr/athena/lib       \
    /usr/local/x11r5/lib  \
    /usr/lpp/Xamples/lib  \
    ; \
do
  for ac_extension in a so sl; do
    if test -r $ac_dir/libsspkg.$ac_extension; then
      no_ss= ac_ss_libraries=$ac_dir
      break 2
    fi
  done
done])])

dnl Set ss_includes, ss_libraries, and no_ss (initially yes).
AC_DEFUN(AC_PATH_SLINGSHOT,
[AC_REQUIRE([AC_PATH_XVIEW_XTRA])dnl
AC_MSG_CHECKING(for SlingShot)
AC_ARG_WITH(ss, [--with-ss         Use the SlingShot extension])

AC_ARG_WITH(ss-includes, [--with-ss-includes=path  Specifies SlingShot includes directory],
[
if test x$withval = xyes; then
    AC_MSG_WARN(Usage is: --with-ss-includes=path)
    ss_includes=NONE
else
    ss_includes=$withval
fi
],
[
ss_includes=NONE
])dnl
AC_ARG_WITH(ss-libraries, [--with-ss-libraries=path  Specifies SlingShot libraries directory],
[
if test x$withval = xyes; then
    AC_MSG_WARN(Usage is: --with-ss-libraries=path)
    ss_libraries=NONE
else
    ss_libraries=$withval
fi
],
[
ss_libraries=NONE
])dnl

if test "x$with_ss" = xno; then
    no_ss=yes
else
    if test "x$ss_includes" != xNONE && test "x$ss_libraries" != xNONE; then
        no_ss=
    else
AC_CACHE_VAL(ac_cv_path_ss,
[
    no_ss=yes
AC_PATH_SLINGSHOT_DIRECT
    if test "x$no_ss" = xyes; then
        ac_cv_path_ss="ac_noss=yes"
    else
        ac_cv_path_ss="ac_ss_includes=$ac_ss_includes ac_ss_libraries=$ac_ss_libraries"
    fi
])dnl
        eval "$ac_cv_path_ss"
    fi
fi
fi
if test "x$no_ss" = xyes; then
    AC_MSG_RESULT(no)
else
    if test "x$ss_includes" = x || test "x$ss_includes" = xNONE; then
        ss_includes=$ac_ss_includes
    fi
    if test "x$ss_libraries" = x || test "x$ss_libraries" = xNONE; then
        ss_libraries=$ac_ss_libraries
    fi
    ac_cv_path_ss="no_ss= ac_ss_includes=$ss_includes ac_ss_libraries=$ss_libraries" 
    if test "x$ss_libraries" = x; then
        if test "x$ss_includes" = x; then
	    AC_MSG_RESULT(yes)
	else
    	    AC_MSG_RESULT([headers $ss_includes])
	fi
    else
        if test "x$ss_includes" = x; then
    	    AC_MSG_RESULT([libraries $ss_libraries])
	else
    	    AC_MSG_RESULT([libraries $ss_libraries, headers $ss_includes])
	fi
    fi
fi
])

dnl Substitute SLINGSHOT_LIBS and SLINGSHOT_CFLAGS and 
dnl HAVE_SLINGSHOT, which is either yes or no.
dnl Both contain XVIEW_LIBS resp. XVIEW_CFLAGS inside
AC_DEFUN(AC_PATH_SLINGSHOT_XTRA,
[AC_REQUIRE([AC_PATH_SLINGSHOT])dnl
if test "$no_ss" = yes; then 
  # Not all programs may use this symbol, but it does not hurt to define it.
  SLINGSHOT_CFLAGS="$XVIEW_CFGLAGS $SLINGSHOT_CFLAGS -DSLINGSHOT_MISSING"
else
  if test -n "$ss_includes"; then
    SLINGSHOT_CFLAGS="$XVIEW_CFLAGS $SLINGSHOT_CFGLAGS -I$ss_includes"
  fi

  # It would be nice to have a more robust check for the -R ld option than
  # just checking for Solaris.
  # It would also be nice to do this for all -L options, not just this one.
  if test -n "$ss_libraries"; then
    SLINGSHOT_LIBS="$XVIEW_LIBS $SLINGSHOT_LIBS -L$ss_libraries"
    if test "`(uname) 2>/dev/null`" = SunOS &&
      uname -r | grep '^5' >/dev/null; then
      SLINGSHOT_LIBS="$SLINGSHOT_LIBS -R$ss_libraries"
    fi
  fi
fi
if test "x$no_ss" = xyes; then
  HAVE_SLINGSHOT=no
else
  HAVE_SLINGSHOT=yes
fi
AC_SUBST(SLINGSHOT_CFLAGS)dnl
AC_SUBST(SLINGSHOT_LIBS)dnl
AC_SUBST(HAVE_SLINGSHOT)dnl
])dnl

dnl
dnl XView library checking end
dnl

dnl
dnl Check for size of d_name dirent member
dnl
AC_DEFUN(AC_SHORT_D_NAME_LEN, [
AC_MSG_CHECKING(filename fits on dirent.d_name)
AC_CACHE_VAL(ac_cv_dnamesize, [
OCFLAGS="$CFLAGS"
CFLAGS="$CFLAGS -I$srcdir"
AC_TRY_RUN([
#include <src/fs.h>

main ()
{
   struct dirent ddd;

   if (sizeof (ddd.d_name) < 12)
	exit (0);
   else
   	exit (1); 
}

],[
    ac_cv_dnamesize="no"
], [
    ac_cv_dnamesize="yes"
], [
# Cannot find out, so assume no
    ac_cv_dnamesize="no"
])
CFLAGS="$OCFLAGS"
])
if test x$ac_cv_dnamesize = xno; then
    AC_DEFINE(NEED_EXTRA_DIRENT_BUFFER)
fi
AC_MSG_RESULT($ac_cv_dnamesize)
])

dnl
dnl Filesystem information detection
dnl
dnl To get information about the disk, mount points, etc.
dnl

AC_DEFUN(AC_GET_FS_INFO, [
    AC_CHECK_HEADERS(fcntl.h sys/dustat.h sys/param.h sys/statfs.h sys/fstyp.h)
    AC_CHECK_HEADERS(mnttab.h mntent.h utime.h sys/statvfs.h sys/vfs.h)
    AC_CHECK_HEADERS(sys/mount.h sys/filsys.h sys/fs_types.h)
    AC_CHECK_FUNCS(getmntinfo)

    dnl This configure.in code has been stolen from GNU fileutils-3.12.  Its
    dnl job is to detect a method to get list of mounted filesystems.

    AC_MSG_CHECKING([for d_ino member in directory struct])
    AC_CACHE_VAL(fu_cv_sys_d_ino_in_dirent,
    [AC_TRY_LINK([
#include <sys/types.h>
#ifdef HAVE_DIRENT_H
# include <dirent.h>
#else /* not HAVE_DIRENT_H */
# define dirent direct
# ifdef HAVE_SYS_NDIR_H
#  include <sys/ndir.h>
# endif /* HAVE_SYS_NDIR_H */
# ifdef HAVE_SYS_DIR_H
#  include <sys/dir.h>
# endif /* HAVE_SYS_DIR_H */
# ifdef HAVE_NDIR_H
#  include <ndir.h>
# endif /* HAVE_NDIR_H */
#endif /* HAVE_DIRENT_H */
    ],
      [struct dirent dp; dp.d_ino = 0;],
	fu_cv_sys_d_ino_in_dirent=yes,
	fu_cv_sys_d_ino_in_dirent=no)])
    AC_MSG_RESULT($fu_cv_sys_d_ino_in_dirent)
    if test $fu_cv_sys_d_ino_in_dirent = yes; then
      AC_DEFINE(D_INO_IN_DIRENT)
    fi

    # Determine how to get the list of mounted filesystems.
    list_mounted_fs=

    # If the getmntent function is available but not in the standard library,
    # make sure LIBS contains -lsun (on Irix4) or -lseq (on PTX).
    AC_FUNC_GETMNTENT

    if test $ac_cv_func_getmntent = yes; then

      # This system has the getmntent function.
      # Determine whether it's the one-argument variant or the two-argument one.

      if test -z "$list_mounted_fs"; then
	# SVR4
	AC_MSG_CHECKING([for two-argument getmntent function])
	AC_CACHE_VAL(fu_cv_sys_mounted_getmntent2,
	[AC_EGREP_HEADER(getmntent, sys/mnttab.h,
	  fu_cv_sys_mounted_getmntent2=yes,
	  fu_cv_sys_mounted_getmntent2=no)])
	AC_MSG_RESULT($fu_cv_sys_mounted_getmntent2)
	if test $fu_cv_sys_mounted_getmntent2 = yes; then
	  list_mounted_fs=found
	  AC_DEFINE(MOUNTED_GETMNTENT2)
	fi
      fi

      if test -z "$list_mounted_fs"; then
	# 4.3BSD, SunOS, HP-UX, Dynix, Irix
	AC_MSG_CHECKING([for one-argument getmntent function])
	AC_CACHE_VAL(fu_cv_sys_mounted_getmntent1,
		     [test $ac_cv_header_mntent_h = yes \
		       && fu_cv_sys_mounted_getmntent1=yes \
		       || fu_cv_sys_mounted_getmntent1=no])
	AC_MSG_RESULT($fu_cv_sys_mounted_getmntent1)
	if test $fu_cv_sys_mounted_getmntent1 = yes; then
	  list_mounted_fs=found
	  AC_DEFINE(MOUNTED_GETMNTENT1)
	fi
      fi

      if test -z "$list_mounted_fs"; then
	AC_WARN([could not determine how to read list of mounted fs])
	CPPFLAGS="$CPPFLAGS -DNO_INFOMOUNT"
      fi

    fi

    if test -z "$list_mounted_fs"; then
      # DEC Alpha running OSF/1.
      AC_MSG_CHECKING([for getfsstat function])
      AC_CACHE_VAL(fu_cv_sys_mounted_getsstat,
      [AC_TRY_LINK([
#include <sys/types.h>
#include <sys/mount.h>
#include <sys/fs_types.h>],
      [struct statfs *stats;
      numsys = getfsstat ((struct statfs *)0, 0L, MNT_WAIT); ],
	fu_cv_sys_mounted_getsstat=yes,
	fu_cv_sys_mounted_getsstat=no)])
      AC_MSG_RESULT($fu_cv_sys_mounted_getsstat)
      if test $fu_cv_sys_mounted_getsstat = yes; then
	list_mounted_fs=found
	AC_DEFINE(MOUNTED_GETFSSTAT)
      fi
    fi

    if test -z "$list_mounted_fs"; then
      # AIX.
      AC_MSG_CHECKING([for mntctl function and struct vmount])
      AC_CACHE_VAL(fu_cv_sys_mounted_vmount,
      [AC_TRY_CPP([#include <fshelp.h>],
	fu_cv_sys_mounted_vmount=yes,
	fu_cv_sys_mounted_vmount=no)])
      AC_MSG_RESULT($fu_cv_sys_mounted_vmount)
      if test $fu_cv_sys_mounted_vmount = yes; then
	list_mounted_fs=found
	AC_DEFINE(MOUNTED_VMOUNT)
      fi
    fi

    if test -z "$list_mounted_fs"; then
      # SVR3
      AC_MSG_CHECKING([for existence of three headers])
      AC_CACHE_VAL(fu_cv_sys_mounted_fread_fstyp,
	[AC_TRY_CPP([
#include <sys/statfs.h>
#include <sys/fstyp.h>
#include <mnttab.h>],
		    fu_cv_sys_mounted_fread_fstyp=yes,
		    fu_cv_sys_mounted_fread_fstyp=no)])
      AC_MSG_RESULT($fu_cv_sys_mounted_fread_fstyp)
      if test $fu_cv_sys_mounted_fread_fstyp = yes; then
	list_mounted_fs=found
	AC_DEFINE(MOUNTED_FREAD_FSTYP)
      fi
    fi

    if test -z "$list_mounted_fs"; then
      # 4.4BSD and DEC OSF/1.
      AC_MSG_CHECKING([for getmntinfo function])
      AC_CACHE_VAL(fu_cv_sys_mounted_getmntinfo,
	[
	  ok=
	  if test $ac_cv_func_getmntinfo = yes; then
	    AC_EGREP_HEADER(f_type;, sys/mount.h,
			    ok=yes)
	  fi
	  test -n "$ok" \
	      && fu_cv_sys_mounted_getmntinfo=yes \
	      || fu_cv_sys_mounted_getmntinfo=no
	])
      AC_MSG_RESULT($fu_cv_sys_mounted_getmntinfo)
      if test $fu_cv_sys_mounted_getmntinfo = yes; then
	list_mounted_fs=found
	AC_DEFINE(MOUNTED_GETMNTINFO)
      fi
    fi

    # FIXME: add a test for netbsd-1.1 here

    if test -z "$list_mounted_fs"; then
      # Ultrix
      AC_MSG_CHECKING([for getmnt function])
      AC_CACHE_VAL(fu_cv_sys_mounted_getmnt,
	[AC_TRY_CPP([
#include <sys/fs_types.h>
#include <sys/mount.h>],
		    fu_cv_sys_mounted_getmnt=yes,
		    fu_cv_sys_mounted_getmnt=no)])
      AC_MSG_RESULT($fu_cv_sys_mounted_getmnt)
      if test $fu_cv_sys_mounted_getmnt = yes; then
	list_mounted_fs=found
	AC_DEFINE(MOUNTED_GETMNT)
      fi
    fi

    if test -z "$list_mounted_fs"; then
      # SVR2
    AC_MSG_CHECKING([whether it is possible to resort to fread on /etc/mnttab])
      AC_CACHE_VAL(fu_cv_sys_mounted_fread,
	[AC_TRY_CPP([#include <mnttab.h>],
		    fu_cv_sys_mounted_fread=yes,
		    fu_cv_sys_mounted_fread=no)])
      AC_MSG_RESULT($fu_cv_sys_mounted_fread)
      if test $fu_cv_sys_mounted_fread = yes; then
	list_mounted_fs=found
	AC_DEFINE(MOUNTED_FREAD)
      fi
    fi

    if test -z "$list_mounted_fs"; then
      AC_MSG_WARN([could not determine how to read list of mounted fs])
      CPPFLAGS="$CPPFLAGS -DNO_INFOMOUNT"
      # FIXME -- no need to abort building the whole package
      # Can't build mountlist.c or anything that needs its functions
    fi

dnl This configure.in code has been stolen from GNU fileutils-3.12.  Its
dnl job is to detect a method to get file system information.

    AC_CHECKING(how to get filesystem space usage)
    space=no

    # Here we'll compromise a little (and perform only the link test)
    # since it seems there are no variants of the statvfs function.
    if test $space = no; then
      # SVR4
      AC_CHECK_FUNCS(statvfs)
      if test $ac_cv_func_statvfs = yes; then
	space=yes
	AC_DEFINE(STAT_STATVFS)
      fi
    fi

    if test $space = no; then
      # DEC Alpha running OSF/1
      AC_MSG_CHECKING([for 3-argument statfs function (DEC OSF/1)])
      AC_CACHE_VAL(fu_cv_sys_stat_statfs3_osf1,
      [AC_TRY_RUN([
#include <sys/param.h>
#include <sys/types.h>
#include <sys/mount.h>
      main ()
      {
	struct statfs fsd;
	fsd.f_fsize = 0;
	exit (statfs (".", &fsd, sizeof (struct statfs)));
      }],
      fu_cv_sys_stat_statfs3_osf1=yes,
      fu_cv_sys_stat_statfs3_osf1=no,
      fu_cv_sys_stat_statfs3_osf1=no)])
      AC_MSG_RESULT($fu_cv_sys_stat_statfs3_osf1)
      if test $fu_cv_sys_stat_statfs3_osf1 = yes; then
	space=yes
	AC_DEFINE(STAT_STATFS3_OSF1)
      fi
    fi

    if test $space = no; then
    # AIX
      AC_MSG_CHECKING([for two-argument statfs with statfs.bsize member (AIX, 4.3BSD)])
      AC_CACHE_VAL(fu_cv_sys_stat_statfs2_bsize,
      [AC_TRY_RUN([
#ifdef HAVE_SYS_PARAM_H
#include <sys/param.h>
#endif
#ifdef HAVE_SYS_MOUNT_H
#include <sys/mount.h>
#endif
#ifdef HAVE_SYS_VFS_H
#include <sys/vfs.h>
#endif
      main ()
      {
      struct statfs fsd;
      fsd.f_bsize = 0;
      exit (statfs (".", &fsd));
      }],
      fu_cv_sys_stat_statfs2_bsize=yes,
      fu_cv_sys_stat_statfs2_bsize=no,
      fu_cv_sys_stat_statfs2_bsize=no)])
      AC_MSG_RESULT($fu_cv_sys_stat_statfs2_bsize)
      if test $fu_cv_sys_stat_statfs2_bsize = yes; then
	space=yes
	AC_DEFINE(STAT_STATFS2_BSIZE)
      fi
    fi

    if test $space = no; then
    # SVR3
      AC_MSG_CHECKING([for four-argument statfs (AIX-3.2.5, SVR3)])
      AC_CACHE_VAL(fu_cv_sys_stat_statfs4,
      [AC_TRY_RUN([#include <sys/types.h>
#include <sys/statfs.h>
      main ()
      {
      struct statfs fsd;
      exit (statfs (".", &fsd, sizeof fsd, 0));
      }],
	fu_cv_sys_stat_statfs4=yes,
	fu_cv_sys_stat_statfs4=no,
	fu_cv_sys_stat_statfs4=no)])
      AC_MSG_RESULT($fu_cv_sys_stat_statfs4)
      if test $fu_cv_sys_stat_statfs4 = yes; then
	space=yes
	AC_DEFINE(STAT_STATFS4)
      fi
    fi

    if test $space = no; then
    # 4.4BSD and NetBSD
      AC_MSG_CHECKING([for two-argument statfs with statfs.fsize dnl
    member (4.4BSD and NetBSD)])
      AC_CACHE_VAL(fu_cv_sys_stat_statfs2_fsize,
      [AC_TRY_RUN([#include <sys/types.h>
#ifdef HAVE_SYS_PARAM_H
#include <sys/param.h>
#endif
#ifdef HAVE_SYS_MOUNT_H
#include <sys/mount.h>
#endif
      main ()
      {
      struct statfs fsd;
      fsd.f_fsize = 0;
      exit (statfs (".", &fsd));
      }],
      fu_cv_sys_stat_statfs2_fsize=yes,
      fu_cv_sys_stat_statfs2_fsize=no,
      fu_cv_sys_stat_statfs2_fsize=no)])
      AC_MSG_RESULT($fu_cv_sys_stat_statfs2_fsize)
      if test $fu_cv_sys_stat_statfs2_fsize = yes; then
	space=yes
	AC_DEFINE(STAT_STATFS2_FSIZE)
      fi
    fi

    if test $space = no; then
      # Ultrix
      AC_MSG_CHECKING([for two-argument statfs with struct fs_data (Ultrix)])
      AC_CACHE_VAL(fu_cv_sys_stat_fs_data,
      [AC_TRY_RUN([
#include <sys/types.h>
#ifdef HAVE_SYS_PARAM_H
#include <sys/param.h>
#endif
#ifdef HAVE_SYS_MOUNT_H
#include <sys/mount.h>
#endif
#ifdef HAVE_SYS_FS_TYPES_H
#include <sys/fs_types.h>
#endif
      main ()
      {
      struct fs_data fsd;
      /* Ultrix's statfs returns 1 for success,
	 0 for not mounted, -1 for failure.  */
      exit (statfs (".", &fsd) != 1);
      }],
      fu_cv_sys_stat_fs_data=yes,
      fu_cv_sys_stat_fs_data=no,
      fu_cv_sys_stat_fs_data=no)])
      AC_MSG_RESULT($fu_cv_sys_stat_fs_data)
      if test $fu_cv_sys_stat_fs_data = yes; then
	space=yes
	AC_DEFINE(STAT_STATFS2_FS_DATA)
      fi
    fi

    dnl Not supported
    dnl if test $space = no; then
    dnl # SVR2
    dnl AC_TRY_CPP([#include <sys/filsys.h>],
    dnl   AC_DEFINE(STAT_READ_FILSYS) space=yes)
    dnl fi
])

dnl AC_CHECK_HEADER_IN_PATH(HEADER-FILE, ADDITIONAL_PATH, ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND])
AC_DEFUN(AC_CHECK_HEADER_IN_PATH,
[dnl Do the transliteration at runtime so arg 1 can be a shell variable.
ac_safe=`echo "$1" | tr './\055' '___'`
AC_MSG_CHECKING([for $1])
AC_CACHE_VAL(ac_cv_header_in_path_$ac_safe,
[AC_TRY_CPP([#include <$1>], ac_header_in_path=yes, [
  ac_header_in_path_found=no
  for ac_header_in_path_value in [$2]; do
    ac_in_path_save_CPPFLAGS=$CPPFLAGS
    CPPFLAGS="$CPPFLAGS -I$ac_header_in_path_value"
    AC_TRY_CPP([#include <$1>], [
ac_header_in_path_found=yes
ac_header_in_path=$ac_header_in_path_value
], )
    CPPFLAGS=$ac_in_path_save_CPPFLAGS
    if test x$ac_header_in_path_found = xyes; then
        break
    fi
  done
  if test $ac_header_in_path_found = xno; then
    ac_header_in_path=no
  fi
])
  eval "ac_cv_header_in_path_$ac_safe=$ac_header_in_path"
])dnl
eval "ac_header_in_path=`echo '$ac_cv_header_in_path_'$ac_safe`"
if test "$ac_header_in_path" = no; then
  AC_MSG_RESULT(no)
ifelse([$4], , , [$4
])dnl
else
  if test -n "$ac_header_in_path"; then
      AC_MSG_RESULT($ac_header_in_path)
  else
      AC_MSG_RESULT(yes)
  fi
  if test x$ac_header_in_path = xyes; then
      ac_header_in_path=
      eval "ac_cv_header_in_path_$ac_safe="
  fi
  ifelse([$3], , , [$3
])dnl
fi
])

dnl Hope I can check for libXpm only in the X11 library directory
AC_DEFUN(AC_LIB_XPM, [
AC_MSG_CHECKING(for -lXpm)
AC_CACHE_VAL(ac_cv_has_xpm, [
    ac_cv_has_xpm=no
    if test x$no_x = xyes; then
	:
    else
        has_xpm_save_LIBS=$LIBS
	LIBS="-lXpm $X_EXTRA_LIBS -lX11 $X_PRE_LIBS $LIBS"
	has_xpm_save_LDFLAGS=$LDFLAGS
	LDFLAGS="$LDFLAGS $X_LIBS"
	has_xpm_save_CFLAGS=$CFLAGS
	CFLAGS="$CFLAGS $X_CFLAGS"
	AC_TRY_LINK([
#include <X11/Xlib.h>
#include <X11/xpm.h>
], [XpmLibraryVersion();], ac_cv_has_xpm=yes)
	CFLAGS="$has_xpm_save_CFLAGS"
	LDFLAGS="$has_xpm_save_LDFLAGS"
	LIBS="$has_xpm_save_LIBS"
    fi
])
AC_MSG_RESULT($ac_cv_has_xpm)
])

dnl Hope I can check for libXext only in the X11 library directory
dnl and shape.h will be in X11/extensions/shape.h
AC_DEFUN(AC_X_SHAPE_EXTENSION, [
AC_MSG_CHECKING(for X11 non-rectangular shape extension)
AC_CACHE_VAL(ac_cv_has_shape, [
    ac_cv_has_shape=no
    if test x$no_x = xyes; then
	:
    else
        has_shape_save_LIBS=$LIBS
	LIBS="-lXext $X_EXTRA_LIBS -lX11 $X_PRE_LIBS $LIBS"
	has_shape_save_LDFLAGS=$LDFLAGS
	LDFLAGS="$LDFLAGS $X_LIBS"
	has_shape_save_CFLAGS=$CFLAGS
	CFLAGS="$CFLAGS $X_CFLAGS"
	AC_TRY_LINK([
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/extensions/shape.h>
], [
Display *dpy = (Display *)NULL;
int a, b;
XShapeQueryVersion(dpy,&a,&b);
], ac_cv_has_shape=yes)
	CFLAGS="$has_shape_save_CFLAGS"
	LDFLAGS="$has_shape_save_LDFLAGS"
	LIBS="$has_shape_save_LIBS"
    fi
])
AC_MSG_RESULT($ac_cv_has_shape)
])

dnl AC_TRY_WARNINGS(INCLUDES, FUNCTION-BODY,
dnl             ACTION-IF-NO-WARNINGS [, ACTION-IF-WARNINGS-OR-ERROR])
AC_DEFUN(AC_TRY_WARNINGS,
[cat > conftest.$ac_ext <<EOF
dnl This sometimes fails to find confdefs.h, for some reason.
dnl [#]line __oline__ "[$]0"
[#]line __oline__ "configure"
#include "confdefs.h"
[$1]
int main() { return 0; }
int t() {
[$2]
; return 0; }
EOF
ac_compile_warn='${CC-cc} -c $CFLAGS $CPPFLAGS conftest.$ac_ext 2>&1'
if { if eval $ac_compile_warn; then :; else echo arning; fi; } | grep arning 1>&AC_FD_CC 2>&AC_FD_CC; then
  ifelse([$4], , :, [rm -rf conftest*
  $4])
ifelse([$3], , , [else
  rm -rf conftest*
  $3
])dnl
fi
rm -f conftest*]
)

dnl Find if make is GNU make.
AC_DEFUN(AC_PROG_GNU_MAKE,
[AC_MSG_CHECKING(whether we are using GNU make)
set dummy ${MAKE-make}; ac_make=[$]2
AC_CACHE_VAL(ac_cv_prog_gnu_make,
[cat > conftestmake <<\EOF
all:
	@echo ' '
EOF
if ${MAKE-make} --version -f conftestmake 2>/dev/null | grep GNU >/dev/null 2>&1; then
  ac_cv_prog_gnu_make=yes
else
  ac_cv_prog_gnu_make=no
fi
rm -f conftestmake])dnl
if test $ac_cv_prog_gnu_make = yes; then
  AC_MSG_RESULT(yes)
  GNU_MAKE="GNU_MAKE=yes"
else
  AC_MSG_RESULT(no)
  GNU_MAKE= 
fi
AC_SUBST([GNU_MAKE])dnl
])

dnl 
dnl Local additions to Autoconf macros.
dnl Copyright (C) 1992, 1994, 1995 Free Software Foundation, Inc.
dnl Fran�ois Pinard <pinard@iro.umontreal.ca>, 1992.

dnl ## ----------------------------------------- ##
dnl ## ANSIfy the C compiler whenever possible.  ##
dnl ## ----------------------------------------- ##

dnl @defmac AC_PROG_CC_STDC
dnl @maindex PROG_CC_STDC
dnl @ovindex CC
dnl If the C compiler in not in ANSI C mode by default, try to add an option
dnl to output variable @code{CC} to make it so.  This macro tries various
dnl options that select ANSI C on some system or another.  It considers the
dnl compiler to be in ANSI C mode if it defines @code{__STDC__} to 1 and
dnl handles function prototypes correctly.
dnl 
dnl If you use this macro, you should check after calling it whether the C
dnl compiler has been set to accept ANSI C; if not, the shell variable
dnl @code{ac_cv_prog_cc_stdc} is set to @samp{no}.  If you wrote your source
dnl code in ANSI C, you can make an un-ANSIfied copy of it by using the
dnl program @code{ansi2knr}, which comes with Ghostscript.
dnl @end defmac

dnl Unixware 2.1 defines __STDC__ to 1 only when some useful extensions are
dnl turned off. They are on by default and turned off with the option -Xc. 
dnl The consequence is that __STDC__ is defined but e.g. struct sigaction
dnl is not defined. -- Norbert 

dnl Below all tests but the one for HP-UX are removed. They caused more
dnl problems than they soved, sigh. -- Norbert

AC_DEFUN(MC_HPUX_PROG_CC_STDC,
[AC_MSG_CHECKING(for ${CC-cc} option to accept ANSI C)
AC_CACHE_VAL(ac_cv_prog_cc_stdc,
[ac_cv_prog_cc_stdc=no
ac_save_CFLAGS="$CFLAGS"
dnl Don't try gcc -ansi; that turns off useful extensions and
dnl breaks some systems' header files.
dnl AIX			-qlanglvl=ansi      (removed -- Norbert)
dnl Ultrix and OSF/1	-std1               (removed -- Norbert)
dnl HP-UX		-Aa -D_HPUX_SOURCE
dnl SVR4		-Xc                 (removed -- Norbert)
for ac_arg in "" "-Aa -D_HPUX_SOURCE" 
do
  CFLAGS="$ac_save_CFLAGS $ac_arg"
  AC_TRY_COMPILE(
[#include <signal.h>
#if !defined(__STDC__) || __STDC__ != 1
choke me
#endif	
], [int test (int i, double x);
struct sigaction sa;
struct s1 {int (*f) (int a);};
struct s2 {int (*f) (double a);};],
[ac_cv_prog_cc_stdc="$ac_arg"; break])
done
CFLAGS="$ac_save_CFLAGS"
])
AC_MSG_RESULT($ac_cv_prog_cc_stdc)
case "x$ac_cv_prog_cc_stdc" in
  x|xno) ;;
  *) CC="$CC $ac_cv_prog_cc_stdc" ;;
esac
])

dnl aclocal.m4 generated automatically by aclocal 1.2f

dnl Copyright (C) 1994, 1995, 1996, 1997, 1998 Free Software Foundation, Inc.
dnl This Makefile.in is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY, to the extent permitted by law; without
dnl even the implied warranty of MERCHANTABILITY or FITNESS FOR A
dnl PARTICULAR PURPOSE.


# progtest.m4 from gettext 0.32
# Search path for a program which passes the given test.
# Ulrich Drepper <drepper@cygnus.com>, 1996.
#
# This file file be copied and used freely without restrictions.  It can
# be used in projects which are not available under the GNU Public License
# but which still want to provide support for the GNU gettext functionality.
# Please note that the actual code is *not* freely available.

# serial 1

dnl AM_PATH_PROG_WITH_TEST(VARIABLE, PROG-TO-CHECK-FOR,
dnl   TEST-PERFORMED-ON-FOUND_PROGRAM [, VALUE-IF-NOT-FOUND [, PATH]])
AC_DEFUN(AM_PATH_PROG_WITH_TEST,
[# Extract the first word of "$2", so it can be a program name with args.
set dummy $2; ac_word=[$]2
AC_MSG_CHECKING([for $ac_word])
AC_CACHE_VAL(ac_cv_path_$1,
[case "[$]$1" in
  /*)
  ac_cv_path_$1="[$]$1" # Let the user override the test with a path.
  ;;
  *)
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}:"
  for ac_dir in ifelse([$5], , $PATH, [$5]); do
    test -z "$ac_dir" && ac_dir=.
    if test -f $ac_dir/$ac_word; then
      if [$3]; then
	ac_cv_path_$1="$ac_dir/$ac_word"
	break
      fi
    fi
  done
  IFS="$ac_save_ifs"
dnl If no 4th arg is given, leave the cache variable unset,
dnl so AC_PATH_PROGS will keep looking.
ifelse([$4], , , [  test -z "[$]ac_cv_path_$1" && ac_cv_path_$1="$4"
])dnl
  ;;
esac])dnl
$1="$ac_cv_path_$1"
if test -n "[$]$1"; then
  AC_MSG_RESULT([$]$1)
else
  AC_MSG_RESULT(no)
fi
AC_SUBST($1)dnl
])


# lcmessage.m4 from gettext 0.32
# Check whether LC_MESSAGES is available in <locale.h>.
# Ulrich Drepper <drepper@cygnus.com>, 1995.
#
# This file file be copied and used freely without restrictions.  It can
# be used in projects which are not available under the GNU Public License
# but which still want to provide support for the GNU gettext functionality.
# Please note that the actual code is *not* freely available.

# serial 1

AC_DEFUN(AM_LC_MESSAGES,
  [if test $ac_cv_header_locale_h = yes; then
    AC_CACHE_CHECK([for LC_MESSAGES], am_cv_val_LC_MESSAGES,
      [AC_TRY_LINK([#include <locale.h>], [return LC_MESSAGES],
       am_cv_val_LC_MESSAGES=yes, am_cv_val_LC_MESSAGES=no)])
    if test $am_cv_val_LC_MESSAGES = yes; then
      AC_DEFINE(HAVE_LC_MESSAGES)
    fi
  fi])



# gettext.m4 from gettext 0.32
# Macro to add for using GNU gettext.
# Ulrich Drepper <drepper@cygnus.com>, 1995.
#
# This file file be copied and used freely without restrictions.  It can
# be used in projects which are not available under the GNU Public License
# but which still want to provide support for the GNU gettext functionality.
# Please note that the actual code is *not* freely available.

# serial 3

AC_DEFUN(AM_WITH_NLS,
  [AC_MSG_CHECKING([whether NLS is requested])
    dnl Default is enabled NLS
    AC_ARG_ENABLE(nls,
      [  --disable-nls           do not use Native Language Support],
      USE_NLS=$enableval, USE_NLS=yes)
    AC_MSG_RESULT($USE_NLS)
    AC_SUBST(USE_NLS)

    USE_INCLUDED_LIBINTL=no

    dnl If we use NLS figure out what method
    if test "$USE_NLS" = "yes"; then
      AC_DEFINE(ENABLE_NLS)
      AC_MSG_CHECKING([whether included gettext is requested])
      AC_ARG_WITH(included-gettext,
        [  --with-included-gettext use the GNU gettext library included here],
        nls_cv_force_use_gnu_gettext=$withval,
        nls_cv_force_use_gnu_gettext=no)
      AC_MSG_RESULT($nls_cv_force_use_gnu_gettext)

      nls_cv_use_gnu_gettext="$nls_cv_force_use_gnu_gettext"
      if test "$nls_cv_force_use_gnu_gettext" != "yes"; then
        dnl User does not insist on using GNU NLS library.  Figure out what
        dnl to use.  If gettext or catgets are available (in this order) we
        dnl use this.  Else we have to fall back to GNU NLS library.
	dnl catgets is only used if permitted by option --with-catgets.
	nls_cv_header_intl=
	nls_cv_header_libgt=
	CATOBJEXT=NONE

	AC_CHECK_HEADER(libintl.h,
	  [AC_CACHE_CHECK([for gettext in libc], gt_cv_func_gettext_libc,
	    [AC_TRY_LINK([#include <libintl.h>], [return (int) gettext ("")],
	       gt_cv_func_gettext_libc=yes, gt_cv_func_gettext_libc=no)])

	   if test "$gt_cv_func_gettext_libc" != "yes"; then
	     AC_CHECK_LIB(intl, bindtextdomain,
	       [AC_CACHE_CHECK([for gettext in libintl],
		 gt_cv_func_gettext_libintl,
		 [AC_TRY_LINK([], [return (int) gettext ("")],
		 gt_cv_func_gettext_libintl=yes,
		 gt_cv_func_gettext_libintl=no)])])
	   fi

	   if test "$gt_cv_func_gettext_libc" = "yes" \
	      || test "$gt_cv_func_gettext_libintl" = "yes"; then
	      AC_DEFINE(HAVE_GETTEXT)
	      AM_PATH_PROG_WITH_TEST(MSGFMT, msgfmt,
		[test -z "`$ac_dir/$ac_word -h 2>&1 | grep 'dv '`"], no)dnl
	      if test "$MSGFMT" != "no"; then
		AC_CHECK_FUNCS(dcgettext)
		AC_PATH_PROG(GMSGFMT, gmsgfmt, $MSGFMT)
		AM_PATH_PROG_WITH_TEST(XGETTEXT, xgettext,
		  [test -z "`$ac_dir/$ac_word -h 2>&1 | grep '(HELP)'`"], :)
		AC_TRY_LINK(, [extern int _nl_msg_cat_cntr;
			       return _nl_msg_cat_cntr],
		  [CATOBJEXT=.gmo
		   DATADIRNAME=share],
		  [CATOBJEXT=.mo
		   DATADIRNAME=lib])
		INSTOBJEXT=.mo
	      fi
	    fi
	])

        if test "$CATOBJEXT" = "NONE"; then
	  AC_MSG_CHECKING([whether catgets can be used])
	  AC_ARG_WITH(catgets,
	    [  --with-catgets          use catgets functions if available],
	    nls_cv_use_catgets=$withval, nls_cv_use_catgets=no)
	  AC_MSG_RESULT($nls_cv_use_catgets)

	  if test "$nls_cv_use_catgets" = "yes"; then
	    dnl No gettext in C library.  Try catgets next.
	    AC_CHECK_LIB(i, main)
	    AC_CHECK_FUNC(catgets,
	      [AC_DEFINE(HAVE_CATGETS)
	       INTLOBJS="\$(CATOBJS)"
	       AC_PATH_PROG(GENCAT, gencat, no)dnl
	       if test "$GENCAT" != "no"; then
		 AC_PATH_PROG(GMSGFMT, gmsgfmt, no)
		 if test "$GMSGFMT" = "no"; then
		   AM_PATH_PROG_WITH_TEST(GMSGFMT, msgfmt,
		    [test -z "`$ac_dir/$ac_word -h 2>&1 | grep 'dv '`"], no)
		 fi
		 AM_PATH_PROG_WITH_TEST(XGETTEXT, xgettext,
		   [test -z "`$ac_dir/$ac_word -h 2>&1 | grep '(HELP)'`"], :)
		 USE_INCLUDED_LIBINTL=yes
		 CATOBJEXT=.cat
		 INSTOBJEXT=.cat
		 DATADIRNAME=lib
		 INTLDEPS='$(top_builddir)/intl/libintl.a'
		 INTLLIBS=$INTLDEPS
		 LIBS=`echo $LIBS | sed -e 's/-lintl//'`
		 nls_cv_header_intl=intl/libintl.h
		 nls_cv_header_libgt=intl/libgettext.h
	       fi])
	  fi
        fi

        if test "$CATOBJEXT" = "NONE"; then
	  dnl Neither gettext nor catgets in included in the C library.
	  dnl Fall back on GNU gettext library.
	  nls_cv_use_gnu_gettext=yes
        fi
      fi

      if test "$nls_cv_use_gnu_gettext" = "yes"; then
        dnl Mark actions used to generate GNU NLS library.
        INTLOBJS="\$(GETTOBJS)"
        AM_PATH_PROG_WITH_TEST(MSGFMT, msgfmt,
	  [test -z "`$ac_dir/$ac_word -h 2>&1 | grep 'dv '`"], msgfmt)
        AC_PATH_PROG(GMSGFMT, gmsgfmt, $MSGFMT)
        AM_PATH_PROG_WITH_TEST(XGETTEXT, xgettext,
	  [test -z "`$ac_dir/$ac_word -h 2>&1 | grep '(HELP)'`"], :)
        AC_SUBST(MSGFMT)
	USE_INCLUDED_LIBINTL=yes
        CATOBJEXT=.gmo
        INSTOBJEXT=.mo
        DATADIRNAME=share
	INTLDEPS='$(top_builddir)/intl/libintl.a'
	INTLLIBS=$INTLDEPS
	LIBS=`echo $LIBS | sed -e 's/-lintl//'`
        nls_cv_header_intl=intl/libintl.h
        nls_cv_header_libgt=intl/libgettext.h
      fi

      dnl Test whether we really found GNU xgettext.
      if test "$XGETTEXT" != ":"; then
	dnl If it is no GNU xgettext we define it as : so that the
	dnl Makefiles still can work.
	if $XGETTEXT --omit-header /dev/null 2> /dev/null; then
	  : ;
	else
	  AC_MSG_RESULT(
	    [found xgettext programs is not GNU xgettext; ignore it])
	  XGETTEXT=":"
	fi
      fi

      # We need to process the po/ directory.
      POSUB=po
    else
      DATADIRNAME=share
      nls_cv_header_intl=intl/libintl.h
      nls_cv_header_libgt=intl/libgettext.h
    fi

    # If this is used in GNU gettext we have to set USE_NLS to `yes'
    # because some of the sources are only built for this goal.
    if test "$PACKAGE" = gettext; then
      USE_NLS=yes
      USE_INCLUDED_LIBINTL=yes
    fi

    dnl These rules are solely for the distribution goal.  While doing this
    dnl we only have to keep exactly one list of the available catalogs
    dnl in configure.in.
    for lang in $ALL_LINGUAS; do
      GMOFILES="$GMOFILES $lang.gmo"
      POFILES="$POFILES $lang.po"
    done

    dnl Make all variables we use known to autoconf.
    AC_SUBST(USE_INCLUDED_LIBINTL)
    AC_SUBST(CATALOGS)
    AC_SUBST(CATOBJEXT)
    AC_SUBST(DATADIRNAME)
    AC_SUBST(GMOFILES)
    AC_SUBST(INSTOBJEXT)
    AC_SUBST(INTLDEPS)
    AC_SUBST(INTLLIBS)
    AC_SUBST(INTLOBJS)
    AC_SUBST(POFILES)
    AC_SUBST(POSUB)
  ])

AC_DEFUN(AM_GNU_GETTEXT,
  [AC_REQUIRE([AC_PROG_MAKE_SET])dnl
   AC_REQUIRE([AC_PROG_CC])dnl
   AC_REQUIRE([AC_PROG_RANLIB])dnl
   AC_REQUIRE([AC_ISC_POSIX])dnl
   AC_REQUIRE([AC_HEADER_STDC])dnl
   AC_REQUIRE([AC_C_CONST])dnl
   AC_REQUIRE([AC_C_INLINE])dnl
   AC_REQUIRE([AC_TYPE_OFF_T])dnl
   AC_REQUIRE([AC_TYPE_SIZE_T])dnl
   AC_REQUIRE([AC_FUNC_ALLOCA])dnl
   AC_REQUIRE([AC_FUNC_MMAP])dnl

   AC_CHECK_HEADERS([argz.h limits.h locale.h nl_types.h malloc.h string.h \
unistd.h values.h sys/param.h])
   AC_CHECK_FUNCS([getcwd munmap putenv setenv setlocale strchr strcasecmp \
__argz_count __argz_stringify __argz_next])

   if test "${ac_cv_func_stpcpy+set}" != "set"; then
     AC_CHECK_FUNCS(stpcpy)
   fi
   if test "${ac_cv_func_stpcpy}" = "yes"; then
     AC_DEFINE(HAVE_STPCPY)
   fi

   AM_LC_MESSAGES
   AM_WITH_NLS

   if test "x$CATOBJEXT" != "x"; then
     if test "x$ALL_LINGUAS" = "x"; then
       LINGUAS=
     else
       AC_MSG_CHECKING(for catalogs to be installed)
       NEW_LINGUAS=
       for lang in ${LINGUAS=$ALL_LINGUAS}; do
         case "$ALL_LINGUAS" in
          *$lang*) NEW_LINGUAS="$NEW_LINGUAS $lang" ;;
         esac
       done
       LINGUAS=$NEW_LINGUAS
       AC_MSG_RESULT($LINGUAS)
     fi

     dnl Construct list of names of catalog files to be constructed.
     if test -n "$LINGUAS"; then
       for lang in $LINGUAS; do CATALOGS="$CATALOGS $lang$CATOBJEXT"; done
     fi
   fi

   dnl The reference to <locale.h> in the installed <libintl.h> file
   dnl must be resolved because we cannot expect the users of this
   dnl to define HAVE_LOCALE_H.
   if test $ac_cv_header_locale_h = yes; then
     INCLUDE_LOCALE_H="#include <locale.h>"
   else
     INCLUDE_LOCALE_H="\
/* The system does not provide the header <locale.h>.  Take care yourself.  */"
   fi
   AC_SUBST(INCLUDE_LOCALE_H)

   dnl Determine which catalog format we have (if any is needed)
   dnl For now we know about two different formats:
   dnl   Linux libc-5 and the normal X/Open format
   test -d intl || mkdir intl
   if test "$CATOBJEXT" = ".cat"; then
     AC_CHECK_HEADER(linux/version.h, msgformat=linux, msgformat=xopen)

     dnl Transform the SED scripts while copying because some dumb SEDs
     dnl cannot handle comments.
     sed -e '/^#/d' $srcdir/intl/$msgformat-msg.sed > intl/po2msg.sed
   fi
   dnl po2tbl.sed is always needed.
   sed -e '/^#.*[^\\]$/d' -e '/^#$/d' \
     $srcdir/intl/po2tbl.sed.in > intl/po2tbl.sed

   dnl In the intl/Makefile.in we have a special dependency which makes
   dnl only sense for gettext.  We comment this out for non-gettext
   dnl packages.
   if test "$PACKAGE" = "gettext"; then
     GT_NO="#NO#"
     GT_YES=
   else
     GT_NO=
     GT_YES="#YES#"
   fi
   AC_SUBST(GT_NO)
   AC_SUBST(GT_YES)

   dnl If the AC_CONFIG_AUX_DIR macro for autoconf is used we possibly
   dnl find the mkinstalldirs script in another subdir but ($top_srcdir).
   dnl Try to locate is.
   MKINSTALLDIRS=
   if test -n "$ac_aux_dir"; then
     MKINSTALLDIRS="$ac_aux_dir/mkinstalldirs"
   fi
   if test -z "$MKINSTALLDIRS"; then
     MKINSTALLDIRS="\$(top_srcdir)/mkinstalldirs"
   fi
   AC_SUBST(MKINSTALLDIRS)

   dnl *** For now the libtool support in intl/Makefile is not for real.
   l=
   AC_SUBST(l)

   dnl Generate list of files to be processed by xgettext which will
   dnl be included in po/Makefile.
   test -d po || mkdir po
   if test "x$srcdir" != "x."; then
     if test "x`echo $srcdir | sed 's@/.*@@'`" = "x"; then
       posrcprefix="$srcdir/"
     else
       posrcprefix="../$srcdir/"
     fi
   else
     posrcprefix="../"
   fi
   rm -f po/POTFILES
   sed -e "/^#/d" -e "/^\$/d" -e "s,.*,	$posrcprefix& \\\\," -e "\$s/\(.*\) \\\\/\1/" \
	< $srcdir/po/POTFILES.in > po/POTFILES
  ])


# Configure paths for GLIB
# Owen Taylor     97-11-3

dnl AM_PATH_GLIB([MINIMUM-VERSION, [ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND [, MODULES]]]])
dnl Test for GLIB, and define GLIB_CFLAGS and GLIB_LIBS, if "gmodule" or 
dnl gthread is specified in MODULES, pass to glib-config
dnl
AC_DEFUN(AM_PATH_GLIB,
[dnl 
dnl Get the cflags and libraries from the glib-config script
dnl
AC_ARG_WITH(glib-prefix,[  --with-glib-prefix=PFX   Prefix where GLIB is installed (optional)],
            glib_config_prefix="$withval", glib_config_prefix="")
AC_ARG_WITH(glib-exec-prefix,[  --with-glib-exec-prefix=PFX Exec prefix where GLIB is installed (optional)],
            glib_config_exec_prefix="$withval", glib_config_exec_prefix="")
AC_ARG_ENABLE(glibtest, [  --disable-glibtest       Do not try to compile and run a test GLIB program],
		    , enable_glibtest=yes)

  if test x$glib_config_exec_prefix != x ; then
     glib_config_args="$glib_config_args --exec-prefix=$glib_config_exec_prefix"
     if test x${GLIB_CONFIG+set} != xset ; then
        GLIB_CONFIG=$glib_config_exec_prefix/bin/glib-config
     fi
  fi
  if test x$glib_config_prefix != x ; then
     glib_config_args="$glib_config_args --prefix=$glib_config_prefix"
     if test x${GLIB_CONFIG+set} != xset ; then
        GLIB_CONFIG=$glib_config_prefix/bin/glib-config
     fi
  fi

  for module in . $4
  do
      case "$module" in
         gmodule) 
             glib_config_args="$glib_config_args gmodule"
         ;;
         gthread) 
             glib_config_args="$glib_config_args gthread"
         ;;
      esac
  done

  AC_PATH_PROG(GLIB_CONFIG, glib-config, no)
  min_glib_version=ifelse([$1], ,0.99.7,$1)
  AC_MSG_CHECKING(for GLIB - version >= $min_glib_version)
  no_glib=""
  if test "$GLIB_CONFIG" = "no" ; then
    no_glib=yes
  else
    GLIB_CFLAGS=`$GLIB_CONFIG $glib_config_args --cflags`
    GLIB_LIBS=`$GLIB_CONFIG $glib_config_args --libs`
    glib_config_major_version=`$GLIB_CONFIG $glib_config_args --version | \
           sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\1/'`
    glib_config_minor_version=`$GLIB_CONFIG $glib_config_args --version | \
           sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\2/'`
    glib_config_micro_version=`$GLIB_CONFIG $glib_config_args --version | \
           sed 's/\([[0-9]]*\).\([[0-9]]*\).\([[0-9]]*\)/\3/'`
    if test "x$enable_glibtest" = "xyes" ; then
      ac_save_CFLAGS="$CFLAGS"
      ac_save_LIBS="$LIBS"
      CFLAGS="$CFLAGS $GLIB_CFLAGS"
      LIBS="$LIBS $GLIB_LIBS"
dnl
dnl Now check if the installed GLIB is sufficiently new. (Also sanity
dnl checks the results of glib-config to some extent
dnl
      rm -f conf.glibtest
      AC_TRY_RUN([
#include <glib.h>
#include <stdio.h>
#include <stdlib.h>

int 
main ()
{
  int major, minor, micro;
  char *tmp_version;

  system ("touch conf.glibtest");

  /* HP/UX 9 (%@#!) writes to sscanf strings */
  tmp_version = g_strdup("$min_glib_version");
  if (sscanf(tmp_version, "%d.%d.%d", &major, &minor, &micro) != 3) {
     printf("%s, bad version string\n", "$min_glib_version");
     exit(1);
   }

  if ((glib_major_version != $glib_config_major_version) ||
      (glib_minor_version != $glib_config_minor_version) ||
      (glib_micro_version != $glib_config_micro_version))
    {
      printf("\n*** 'glib-config --version' returned %d.%d.%d, but GLIB (%d.%d.%d)\n", 
             $glib_config_major_version, $glib_config_minor_version, $glib_config_micro_version,
             glib_major_version, glib_minor_version, glib_micro_version);
      printf ("*** was found! If glib-config was correct, then it is best\n");
      printf ("*** to remove the old version of GLIB. You may also be able to fix the error\n");
      printf("*** by modifying your LD_LIBRARY_PATH enviroment variable, or by editing\n");
      printf("*** /etc/ld.so.conf. Make sure you have run ldconfig if that is\n");
      printf("*** required on your system.\n");
      printf("*** If glib-config was wrong, set the environment variable GLIB_CONFIG\n");
      printf("*** to point to the correct copy of glib-config, and remove the file config.cache\n");
      printf("*** before re-running configure\n");
    } 
  else if ((glib_major_version != GLIB_MAJOR_VERSION) ||
	   (glib_minor_version != GLIB_MINOR_VERSION) ||
           (glib_micro_version != GLIB_MICRO_VERSION))
    {
      printf("*** GLIB header files (version %d.%d.%d) do not match\n",
	     GLIB_MAJOR_VERSION, GLIB_MINOR_VERSION, GLIB_MICRO_VERSION);
      printf("*** library (version %d.%d.%d)\n",
	     glib_major_version, glib_minor_version, glib_micro_version);
    }
  else
    {
      if ((glib_major_version > major) ||
        ((glib_major_version == major) && (glib_minor_version > minor)) ||
        ((glib_major_version == major) && (glib_minor_version == minor) && (glib_micro_version >= micro)))
      {
        return 0;
       }
     else
      {
        printf("\n*** An old version of GLIB (%d.%d.%d) was found.\n",
               glib_major_version, glib_minor_version, glib_micro_version);
        printf("*** You need a version of GLIB newer than %d.%d.%d. The latest version of\n",
	       major, minor, micro);
        printf("*** GLIB is always available from ftp://ftp.gtk.org.\n");
        printf("***\n");
        printf("*** If you have already installed a sufficiently new version, this error\n");
        printf("*** probably means that the wrong copy of the glib-config shell script is\n");
        printf("*** being found. The easiest way to fix this is to remove the old version\n");
        printf("*** of GLIB, but you can also set the GLIB_CONFIG environment to point to the\n");
        printf("*** correct copy of glib-config. (In this case, you will have to\n");
        printf("*** modify your LD_LIBRARY_PATH enviroment variable, or edit /etc/ld.so.conf\n");
        printf("*** so that the correct libraries are found at run-time))\n");
      }
    }
  return 1;
}
],, no_glib=yes,[echo $ac_n "cross compiling; assumed OK... $ac_c"])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
     fi
  fi
  if test "x$no_glib" = x ; then
     AC_MSG_RESULT(yes)
     ifelse([$2], , :, [$2])     
  else
     AC_MSG_RESULT(no)
     if test "$GLIB_CONFIG" = "no" ; then
       echo "*** The glib-config script installed by GLIB could not be found"
       echo "*** If GLIB was installed in PREFIX, make sure PREFIX/bin is in"
       echo "*** your path, or set the GLIB_CONFIG environment variable to the"
       echo "*** full path to glib-config."
     else
       if test -f conf.glibtest ; then
        :
       else
          echo "*** Could not run GLIB test program, checking why..."
          CFLAGS="$CFLAGS $GLIB_CFLAGS"
          LIBS="$LIBS $GLIB_LIBS"
          AC_TRY_LINK([
#include <glib.h>
#include <stdio.h>
],      [ return ((glib_major_version) || (glib_minor_version) || (glib_micro_version)); ],
        [ echo "*** The test program compiled, but did not run. This usually means"
          echo "*** that the run-time linker is not finding GLIB or finding the wrong"
          echo "*** version of GLIB. If it is not finding GLIB, you'll need to set your"
          echo "*** LD_LIBRARY_PATH environment variable, or edit /etc/ld.so.conf to point"
          echo "*** to the installed location  Also, make sure you have run ldconfig if that"
          echo "*** is required on your system"
	  echo "***"
          echo "*** If you have an old version installed, it is best to remove it, although"
          echo "*** you may also be able to get things to work by modifying LD_LIBRARY_PATH"
          echo "***"
          echo "*** If you have a RedHat 5.0 system, you should remove the GTK package that"
          echo "*** came with the system with the command"
          echo "***"
          echo "***    rpm --erase --nodeps gtk gtk-devel" ],
        [ echo "*** The test program failed to compile or link. See the file config.log for the"
          echo "*** exact error that occured. This usually means GLIB was incorrectly installed"
          echo "*** or that you have moved GLIB since it was installed. In the latter case, you"
          echo "*** may want to edit the glib-config script: $GLIB_CONFIG" ])
          CFLAGS="$ac_save_CFLAGS"
          LIBS="$ac_save_LIBS"
       fi
     fi
     GLIB_CFLAGS=""
     GLIB_LIBS=""
     ifelse([$3], , :, [$3])
  fi
  AC_SUBST(GLIB_CFLAGS)
  AC_SUBST(GLIB_LIBS)
  rm -f conf.glibtest
])

dnl GNOME_VFS_CHECKS
dnl   Check for various functions needed by libvfs.
dnl   This has various effects:
dnl     Sets GNOME_VFS_LIBS to libraries required
dnl     Sets termnet  to true or false depending on whether it is required.
dnl        If yes, defines USE_TERMNET.
dnl     Sets vfs_flags to "pretty" list of vfs implementations we include.
dnl     Calls AC_SUBST(mcserv), which is either empty or "mcserv".

AC_DEFUN([GNOME_VFS_CHECKS],[
  dnl FIXME: network checks should probably be in their own macro.
  AC_CHECK_LIB(nsl, t_accept)
  AC_CHECK_LIB(socket, socket)

  have_socket=no
  AC_CHECK_FUNCS(socket, have_socket=yes)
  if test $have_socket = no; then
    # socket is not in the default libraries.  See if it's in some other.
    for lib in bsd socket inet; do
      AC_CHECK_LIB($lib, socket, [
	  LIBS="$LIBS -l$lib"
	  have_socket=yes
	  AC_DEFINE(HAVE_SOCKET)
	  break])
    done
  fi

  have_gethostbyname=no
  AC_CHECK_FUNC(gethostbyname, have_gethostbyname=yes)
  if test $have_gethostbyname = no; then
    # gethostbyname is not in the default libraries.  See if it's in some other.
    for lib in bsd socket inet; do
      AC_CHECK_LIB($lib, gethostbyname, [LIBS="$LIBS -l$lib"; have_gethostbyname=yes; break])
    done
  fi


  vfs_flags="tarfs"
  use_net_code=false
  if test $have_socket = yes; then
      AC_STRUCT_LINGER
      AC_CHECK_FUNCS(pmap_set, , [
	 AC_CHECK_LIB(rpc, pmap_set, [
	   LIBS="-lrpc $LIBS"
	  AC_DEFINE(HAVE_PMAP_SET)
	  ])])
      AC_CHECK_FUNCS(pmap_getport pmap_getmaps rresvport)
      dnl add for source routing support setsockopt
      AC_CHECK_HEADERS(rpc/pmap_clnt.h)
      vfs_flags="$vfs_flags, mcfs, ftpfs, fish"
      use_net_code=true
  fi

  dnl
  dnl The termnet support
  dnl
  termnet=false
  AC_ARG_WITH(termnet,
	  [--with-termnet             If you want a termified net support],[
	  if test x$withval = xyes; then
		  AC_DEFINE(USE_TERMNET)
		  termnet=true		
	  fi
  ])

  TERMNET=""
  AC_DEFINE(USE_VFS)
  if $use_net_code; then
     AC_DEFINE(USE_NETCODE)
  fi
  mcserv=
  if test $have_socket = yes; then
     mcserv="mcserv"
     if $termnet; then
	TERMNET="-ltermnet"
     fi
  fi
  AC_SUBST(TERMNET)
  AC_SUBST(mcserv)
])

dnl
dnl Check for struct linger
dnl
AC_DEFUN(AC_STRUCT_LINGER, [
av_struct_linger=no
AC_MSG_CHECKING(struct linger is available)
AC_TRY_RUN([
#include <sys/types.h>
#include <sys/socket.h>

struct linger li;

main ()
{
    li.l_onoff = 1;
    li.l_linger = 120;
    exit (0);
}
],[
AC_DEFINE(HAVE_STRUCT_LINGER)
av_struct_linger=yes
],[
av_struct_linger=no
],[
av_struct_linger=no
])
AC_MSG_RESULT($av_struct_linger)
])

dnl Curses detection: Munged from Midnight Commander's configure.in
dnl
dnl What it does:
dnl =============
dnl
dnl - Determine which version of curses is installed on your system
dnl   and set the -I/-L/-l compiler entries and add a few preprocessor
dnl   symbols 
dnl - Do an AC_SUBST on the CURSES_INCLUDEDIR and CURSES_LIBS so that
dnl   @CURSES_INCLUDEDIR@ and @CURSES_LIBS@ will be available in
dnl   Makefile.in's
dnl - Modify the following configure variables (these are the only
dnl   curses.m4 variables you can access from within configure.in)
dnl   CURSES_INCLUDEDIR - contains -I's and possibly -DRENAMED_CURSES if
dnl                       an ncurses.h that's been renamed to curses.h
dnl                       is found.
dnl   CURSES_LIBS       - sets -L and -l's appropriately
dnl   CFLAGS            - if --with-sco, add -D_SVID3 
dnl   has_curses        - exports result of tests to rest of configure
dnl
dnl Usage:
dnl ======
dnl 1) Add lines indicated below to acconfig.h
dnl 2) call AC_CHECK_CURSES after AC_PROG_CC in your configure.in
dnl 3) Instead of #include <curses.h> you should use the following to
dnl    properly locate ncurses or curses header file
dnl
dnl    #if defined(USE_NCURSES) && !defined(RENAMED_NCURSES)
dnl    #include <ncurses.h>
dnl    #else
dnl    #include <curses.h>
dnl    #endif
dnl
dnl 4) Make sure to add @CURSES_INCLUDEDIR@ to your preprocessor flags
dnl 5) Make sure to add @CURSES_LIBS@ to your linker flags or LIBS
dnl
dnl Notes with automake:
dnl - call AM_CONDITIONAL(HAS_CURSES, test "$has_curses" = true) from
dnl   configure.in
dnl - your Makefile.am can look something like this
dnl   -----------------------------------------------
dnl   INCLUDES= blah blah blah $(CURSES_INCLUDEDIR) 
dnl   if HAS_CURSES
dnl   CURSES_TARGETS=name_of_curses_prog
dnl   endif
dnl   bin_PROGRAMS = other_programs $(CURSES_TARGETS)
dnl   other_programs_SOURCES = blah blah blah
dnl   name_of_curses_prog_SOURCES = blah blah blah
dnl   other_programs_LDADD = blah
dnl   name_of_curses_prog_LDADD = blah $(CURSES_LIBS)
dnl   -----------------------------------------------
dnl
dnl
dnl The following lines should be added to acconfig.h:
dnl ==================================================
dnl
dnl /*=== Curses version detection defines ===*/
dnl /* Found some version of curses that we're going to use */
dnl #undef HAS_CURSES
dnl    
dnl /* Use SunOS SysV curses? */
dnl #undef USE_SUNOS_CURSES
dnl 
dnl /* Use old BSD curses - not used right now */
dnl #undef USE_BSD_CURSES
dnl 
dnl /* Use SystemV curses? */
dnl #undef USE_SYSV_CURSES
dnl 
dnl /* Use Ncurses? */
dnl #undef USE_NCURSES
dnl 
dnl /* If you Curses does not have color define this one */
dnl #undef NO_COLOR_CURSES
dnl 
dnl /* Define if you want to turn on SCO-specific code */
dnl #undef SCO_FLAVOR
dnl 
dnl /* Set to reflect version of ncurses *
dnl  *   0 = version 1.*
dnl  *   1 = version 1.9.9g
dnl  *   2 = version 4.0/4.1 */
dnl #undef NCURSES_970530
dnl
dnl /*=== End new stuff for acconfig.h ===*/
dnl 


AC_DEFUN(AC_CHECK_CURSES,[
	search_ncurses=true
	screen_manager=""
	has_curses=false

	CFLAGS=${CFLAGS--O}

	AC_SUBST(CURSES_LIBS)
	AC_SUBST(CURSES_INCLUDEDIR)

	AC_ARG_WITH(sco,
	  [  --with-sco              Use this to turn on SCO-specific code],[
	  if test x$withval = xyes; then
		AC_DEFINE(SCO_FLAVOR)
		CFLAGS="$CFLAGS -D_SVID3"
	  fi
	])

	AC_ARG_WITH(sunos-curses,
	  [  --with-sunos-curses     Used to force SunOS 4.x curses],[
	  if test x$withval = xyes; then
		AC_USE_SUNOS_CURSES
	  fi
	])

	AC_ARG_WITH(osf1-curses,
	  [  --with-osf1-curses      Used to force OSF/1 curses],[
	  if test x$withval = xyes; then
		AC_USE_OSF1_CURSES
	  fi
	])

	AC_ARG_WITH(vcurses,
	  [  --with-vcurses[=incdir] Used to force SysV curses],
	  if test x$withval != xyes; then
		CURSES_INCLUDEDIR="-I$withval"
	  fi
	  AC_USE_SYSV_CURSES
	)

	AC_ARG_WITH(ncurses,
	  [  --with-ncurses[=dir]  Compile with ncurses/locate base dir],
	  if test x$withval = xno ; then
		search_ncurses=false
	  elif test x$withval != xyes ; then
		CURSES_LIBS="$LIBS -L$withval/lib -lncurses"
		CURSES_INCLUDEDIR="-I$withval/include"
		search_ncurses=false
		screen_manager="ncurses"
		AC_DEFINE(USE_NCURSES)
		AC_DEFINE(HAS_CURSES)
		has_curses=true
	  fi
	)

	if $search_ncurses
	then
		AC_SEARCH_NCURSES()
	fi


])


AC_DEFUN(AC_USE_SUNOS_CURSES, [
	search_ncurses=false
	screen_manager="SunOS 4.x /usr/5include curses"
	AC_MSG_RESULT(Using SunOS 4.x /usr/5include curses)
	AC_DEFINE(USE_SUNOS_CURSES)
	AC_DEFINE(HAS_CURSES)
	has_curses=true
	AC_DEFINE(NO_COLOR_CURSES)
	AC_DEFINE(USE_SYSV_CURSES)
	CURSES_INCLUDEDIR="-I/usr/5include"
	CURSES_LIBS="/usr/5lib/libcurses.a /usr/5lib/libtermcap.a"
	AC_MSG_RESULT(Please note that some screen refreshs may fail)
])

AC_DEFUN(AC_USE_OSF1_CURSES, [
       AC_MSG_RESULT(Using OSF1 curses)
       search_ncurses=false
       screen_manager="OSF1 curses"
       AC_DEFINE(HAS_CURSES)
       has_curses=true
       AC_DEFINE(NO_COLOR_CURSES)
       AC_DEFINE(USE_SYSV_CURSES)
       CURSES_LIBS="-lcurses"
])

AC_DEFUN(AC_USE_SYSV_CURSES, [
	AC_MSG_RESULT(Using SysV curses)
	AC_DEFINE(HAS_CURSES)
	has_curses=true
	AC_DEFINE(USE_SYSV_CURSES)
	search_ncurses=false
	screen_manager="SysV/curses"
	CURSES_LIBS="-lcurses"
])

dnl AC_ARG_WITH(bsd-curses,
dnl [--with-bsd-curses         Used to compile with bsd curses, not very fancy],
dnl 	search_ncurses=false
dnl	screen_manager="Ultrix/cursesX"
dnl	if test $system = ULTRIX
dnl	then
dnl	    THIS_CURSES=cursesX
dnl        else
dnl	    THIS_CURSES=curses
dnl	fi
dnl
dnl	CURSES_LIBS="-l$THIS_CURSES -ltermcap"
dnl	AC_DEFINE(HAS_CURSES)
dnl	has_curses=true
dnl	AC_DEFINE(USE_BSD_CURSES)
dnl	AC_MSG_RESULT(Please note that some screen refreshs may fail)
dnl	AC_WARN(Use of the bsdcurses extension has some)
dnl	AC_WARN(display/input problems.)
dnl	AC_WARN(Reconsider using xcurses)
dnl)

	
dnl
dnl Parameters: directory filename cureses_LIBS curses_INCLUDEDIR nicename
dnl
AC_DEFUN(AC_NCURSES, [
    if $search_ncurses
    then
        if test -f $1/$2
	then
	    AC_MSG_RESULT(Found ncurses on $1/$2)
 	    CURSES_LIBS="$3"
	    CURSES_INCLUDEDIR="$4"
	    search_ncurses=false
	    screen_manager=$5
            AC_DEFINE(HAS_CURSES)
            has_curses=true
	    AC_DEFINE(USE_NCURSES)
	fi
    fi
])

AC_DEFUN(AC_SEARCH_NCURSES, [
    AC_CHECKING("location of ncurses.h file")

    AC_NCURSES(/usr/include, ncurses.h, -lncurses,, "ncurses on /usr/include")
    AC_NCURSES(/usr/include/ncurses, ncurses.h, -lncurses, -I/usr/include/ncurses, "ncurses on /usr/include/ncurses")
    AC_NCURSES(/usr/local/include, ncurses.h, -L/usr/local/lib -lncurses, -I/usr/local/include, "ncurses on /usr/local")
    AC_NCURSES(/usr/local/include/ncurses, ncurses.h, -L/usr/local/lib -L/usr/local/lib/ncurses -lncurses, -I/usr/local/include/ncurses, "ncurses on /usr/local/include/ncurses")

    AC_NCURSES(/usr/local/include/ncurses, curses.h, -L/usr/local/lib -lncurses, -I/usr/local/include/ncurses -DRENAMED_NCURSES, "renamed ncurses on /usr/local/.../ncurses")

    AC_NCURSES(/usr/include/ncurses, curses.h, -lncurses, -I/usr/include/ncurses -DRENAMED_NCURSES, "renamed ncurses on /usr/include/ncurses")

    dnl
    dnl We couldn't find ncurses, try SysV curses
    dnl
    if $search_ncurses 
    then
        AC_EGREP_HEADER(init_color, /usr/include/curses.h,
	    AC_USE_SYSV_CURSES)
	AC_EGREP_CPP(USE_NCURSES,[
#include <curses.h>
#ifdef __NCURSES_H
#undef USE_NCURSES
USE_NCURSES
#endif
],[
	CURSES_INCLUDEDIR="$CURSES_INCLUDEDIR -DRENAMED_NCURSES"
        AC_DEFINE(HAS_CURSES)
	has_curses=true
        AC_DEFINE(USE_NCURSES)
        search_ncurses=false
        screen_manager="ncurses installed as curses"
])
    fi

    dnl
    dnl Try SunOS 4.x /usr/5{lib,include} ncurses
    dnl The flags USE_SUNOS_CURSES, USE_BSD_CURSES and BUGGY_CURSES
    dnl should be replaced by a more fine grained selection routine
    dnl
    if $search_ncurses
    then
	if test -f /usr/5include/curses.h
	then
	    AC_USE_SUNOS_CURSES
        fi
    else
        # check for ncurses version, to properly ifdef mouse-fix
	AC_MSG_CHECKING(for ncurses version)
	ncurses_version=unknown
cat > conftest.$ac_ext <<EOF
[#]line __oline__ "configure"
#include "confdefs.h"
#ifdef RENAMED_NCURSES
#include <curses.h>
#else
#include <ncurses.h>
#endif
#undef VERSION
VERSION:NCURSES_VERSION
EOF
        if (eval "$ac_cpp conftest.$ac_ext") 2>&AC_FD_CC |
  egrep "VERSION:" >conftest.out 2>&1; then
changequote(,)dnl
            ncurses_version=`cat conftest.out|sed -e 's/^[^"]*"//' -e 's/".*//'`
changequote([,])dnl
	fi
	rm -rf conftest*
        AC_MSG_RESULT($ncurses_version)
	case "$ncurses_version" in
changequote(,)dnl
	4.[01])
changequote([,])dnl
            AC_DEFINE(NCURSES_970530,2)
            ;;
	1.9.9g)
            AC_DEFINE(NCURSES_970530,1)
            ;;
	1*)
            AC_DEFINE(NCURSES_970530,0)
            ;;
	esac
    fi
])






# Define a conditional.

AC_DEFUN(AM_CONDITIONAL,
[AC_SUBST($1_TRUE)
AC_SUBST($1_FALSE)
if $2; then
  $1_TRUE=
  $1_FALSE='#'
else
  $1_TRUE='#'
  $1_FALSE=
fi])

dnl
dnl GNOME_INIT_HOOK (script-if-gnome-enabled, failflag)
dnl
dnl if failflag is "fail" then GNOME_INIT_HOOK will abort if gnomeConf.sh
dnl is not found. 
dnl

AC_DEFUN([GNOME_INIT_HOOK],
[	
	AC_SUBST(GNOME_LIBS)
	AC_SUBST(GNOMEUI_LIBS)
	AC_SUBST(GNOMEGNORBA_LIBS)
	AC_SUBST(GTKXMHTML_LIBS)
	AC_SUBST(GNOME_APPLET_LIBS)
	AC_SUBST(GNOME_LIBDIR)
	AC_SUBST(GNOME_INCLUDEDIR)

	AC_ARG_WITH(gnome-includes,
	[  --with-gnome-includes   Specify location of GNOME headers],[
	CFLAGS="$CFLAGS -I$withval"
	])
	
	AC_ARG_WITH(gnome-libs,
	[  --with-gnome-libs       Specify location of GNOME libs],[
	LDFLAGS="$LDFLAGS -L$withval"
	gnome_prefix=$withval
	])

	AC_ARG_WITH(gnome,
	[  --with-gnome            Specify prefix for GNOME files],
		if test x$withval = xyes; then
	    		want_gnome=yes
	    		dnl Note that an empty true branch is not
			dnl valid sh syntax.
	    		ifelse([$1], [], :, [$1])
        	else
	    		if test "x$withval" = xno; then
	        		want_gnome=no
	    		else
	        		want_gnome=yes
	    			LDFLAGS="$LDFLAGS -L$withval/lib"
	    			CFLAGS="$CFLAGS -I$withval/include"
	    			gnome_prefix=$withval/lib
	    		fi
  		fi,
		want_gnome=yes)

	if test "x$want_gnome" = xyes; then

	    AC_PATH_PROG(GNOME_CONFIG,gnome-config,no)
	    if test "$GNOME_CONFIG" = "no"; then
	      no_gnome_config="yes"
	    else
	      AC_MSG_CHECKING(if $GNOME_CONFIG works)
	      if $GNOME_CONFIG --libs-only-l gnome >/dev/null 2>&1; then
	        AC_MSG_RESULT(yes)
	        GNOME_GNORBA_HOOK([],$2)
	        GNOME_LIBS="`$GNOME_CONFIG --libs-only-l gnome`"
	        GNOMEUI_LIBS="`$GNOME_CONFIG --libs-only-l gnomeui`"
	        GNOMEGNORBA_LIBS="`$GNOME_CONFIG --libs-only-l gnorba gnomeui`"
	        GTKXMHTML_LIBS="`$GNOME_CONFIG --libs-only-l gtkxmhtml`"
	        GNOME_APPLET_LIBS="`$GNOME_CONFIG --libs-only-l applets`"
	        GNOME_LIBDIR="`$GNOME_CONFIG --libs-only-L gnorba gnomeui`"
	        GNOME_INCLUDEDIR="`$GNOME_CONFIG --cflags gnorba gnomeui`"
                $1
	      else
	        AC_MSG_RESULT(no)
	        no_gnome_config="yes"
              fi
            fi

	    if test x$exec_prefix = xNONE; then
	        if test x$prefix = xNONE; then
		    gnome_prefix=$ac_default_prefix/lib
	        else
 		    gnome_prefix=$prefix/lib
	        fi
	    else
	        gnome_prefix=`eval echo \`echo $libdir\``
	    fi
	
	    if test "$no_gnome_config" = "yes"; then
              AC_MSG_CHECKING(for gnomeConf.sh file in $gnome_prefix)
	      if test -f $gnome_prefix/gnomeConf.sh; then
	        AC_MSG_RESULT(found)
	        echo "loading gnome configuration from" \
		     "$gnome_prefix/gnomeConf.sh"
	        . $gnome_prefix/gnomeConf.sh
	        $1
	      else
	        AC_MSG_RESULT(not found)
 	        if test x$2 = xfail; then
	          AC_MSG_ERROR(Could not find the gnomeConf.sh file that is generated by gnome-libs install)
 	        fi
	      fi
            fi
	fi
])

AC_DEFUN([GNOME_INIT],[
	GNOME_INIT_HOOK([],fail)
])

dnl
dnl GNOME_GNORBA_HOOK (script-if-gnorba-found, failflag)
dnl
dnl if failflag is "failure" it aborts if gnorba is not found.
dnl

AC_DEFUN([GNOME_GNORBA_HOOK],[
	GNOME_ORBIT_HOOK([],$2)
	AC_CACHE_CHECK([for gnorba libraries],gnome_cv_gnorba_found,[
		gnome_cv_gnorba_found=no
		if test x$gnome_cv_orbit_found = xyes; then
			GNORBA_CFLAGS="`gnome-config --cflags gnorba gnomeui`"
			GNORBA_LIBS="`gnome-config --libs gnorba gnomeui`"
			if test -n "$GNORBA_LIBS"; then
				gnome_cv_gnorba_found=yes
			fi
		fi
	])
	AM_CONDITIONAL(HAVE_GNORBA, test x$gnome_cv_gnorba_found = xyes)
	if test x$gnome_cv_orbit_found = xyes; then
		$1
		GNORBA_CFLAGS="`gnome-config --cflags gnorba gnomeui`"
		GNORBA_LIBS="`gnome-config --libs gnorba gnomeui`"
		AC_SUBST(GNORBA_CFLAGS)
		AC_SUBST(GNORBA_LIBS)
	else
	    	if test x$2 = xfailure; then
			AC_MSG_ERROR(gnorba library not installed or installation problem)
	    	fi
	fi
])

AC_DEFUN([GNOME_GNORBA_CHECK], [
	GNOME_GNORBA_HOOK([],failure)
])

dnl
dnl GNOME_ORBIT_HOOK (script-if-orbit-found, failflag)
dnl
dnl if failflag is "failure" it aborts if orbit is not found.
dnl

AC_DEFUN([GNOME_ORBIT_HOOK],[
	AC_PATH_PROG(ORBIT_CONFIG,orbit-config,no)
	AC_PATH_PROG(ORBIT_IDL,orbit-idl,no)
	AC_CACHE_CHECK([for working ORBit environment],gnome_cv_orbit_found,[
		if test x$ORBIT_CONFIG = xno -o x$ORBIT_IDL = xno; then
			gnome_cv_orbit_found=no
		else
			gnome_cv_orbit_found=yes
		fi
	])
	AM_CONDITIONAL(HAVE_ORBIT, test x$gnome_cv_orbit_found = xyes)
	if test x$gnome_cv_orbit_found = xyes; then
		$1
		ORBIT_CFLAGS=`orbit-config --cflags client server`
		ORBIT_LIBS=`orbit-config --use-service=name --libs client server`
		AC_SUBST(ORBIT_CFLAGS)
		AC_SUBST(ORBIT_LIBS)
	else
    		if test x$2 = xfailure; then
			AC_MSG_ERROR(ORBit not installed or installation problem)
    		fi
	fi
])

AC_DEFUN([GNOME_ORBIT_CHECK], [
	GNOME_ORBIT_HOOK([],failure)
])

dnl GNOME_UNDELFS_CHECKS
dnl    Check for ext2fs undel support.
dnl    Set shell variable ext2fs_undel to "yes" if we have it,
dnl    "no" otherwise.  May define USE_EXT2FSLIB for cpp.
dnl    Will set EXT2FS_UNDEL_LIBS to required libraries.

AC_DEFUN([GNOME_UNDELFS_CHECKS], [
  AC_CHECK_HEADERS(ext2fs/ext2fs.h linux/ext2_fs.h)
  ext2fs_undel=no
  EXT2FS_UNDEL_LIBS=
  if test x$ac_cv_header_ext2fs_ext2fs_h = xyes
  then
    if test x$ac_cv_header_linux_ext2_fs_h = xyes
    then
      AC_DEFINE(USE_EXT2FSLIB)
      ext2fs_undel=yes
      EXT2FS_UNDEL_LIBS="-lext2fs -lcom_err"
    fi
  fi
])

