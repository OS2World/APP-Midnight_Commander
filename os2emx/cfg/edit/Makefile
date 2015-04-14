# Generated automatically from Makefile.in by configure.
srcdir = ../gtkedit

rootdir = $(srcdir)/..
include ../os2emx/Make.common

CFLAGS = $(XCFLAGS)
CPPFLAGS = $(XCPPFLAGS) -I$(srcdir)
LDFLAGS = $(XLDFLAGS) 
DEFS = $(XDEFS)
LIBS =  $(XLIBS)  -lpam -ldl $(XLIB)
INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644
AR = ar


#
# Distribution variables
#

EDITSRC = $(srcdir)/edit.c $(srcdir)/editcmd.c \
          $(srcdir)/editwidget.c \
          edit_key_translator.c $(srcdir)/editdraw.c \
	  $(srcdir)/edit.h $(srcdir)/editmenu.c \
          $(srcdir)/editcmddef.h $(srcdir)/wordproc.c \
          $(srcdir)/syntax.c $(srcdir)/editoptions.c

EDITOBJS = edit.o editcmd.o editwidget.o editdraw.o editmenu.o wordproc.o \
	  syntax.o editoptions.o

DIST = 	Makefile.in $(EDITSRC)

all: $(LIBPREFIX)edit.a 

edit.o: $(srcdir)/edit.c
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) -DMIDNIGHT $(srcdir)/edit.c

editcmd.o: $(srcdir)/editcmd.c
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) -DMIDNIGHT $(srcdir)/editcmd.c

editwidget.o: $(srcdir)/editwidget.c
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) -DMIDNIGHT $(srcdir)/editwidget.c

editdraw.o: $(srcdir)/editdraw.c
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) -DMIDNIGHT $(srcdir)/editdraw.c

editmenu.o: $(srcdir)/editmenu.c
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) -DMIDNIGHT $(srcdir)/editmenu.c

wordproc.o: $(srcdir)/wordproc.c
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) -DMIDNIGHT $(srcdir)/wordproc.c

syntax.o: $(srcdir)/syntax.c
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) -DMIDNIGHT $(srcdir)/syntax.c

editoptions.o: $(srcdir)/editoptions.c
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) -DMIDNIGHT $(srcdir)/editoptions.c


check:
	@echo no tests are supplied.

checklinks:
	@if test -f $(rootdir)/edit/edit.c; then echo ok; \
	else $(MAKE) sourcelinks; fi

sourcelinks:
	-cd $(rootdir)/edit ; $(LN_S) ../gtkedit/*.[ch] . >/dev/null 2>&1 ; true

cleansourcelinks:
	-if test -f $(rootdir)/edit/edit.c; then \
	    cd $(rootdir)/edit; find . -lname '*.[ch]' | xargs $(RM); \
	fi

$(LIBPREFIX)edit.a: checklinks
	$(MAKE) mx
	touch mx

mx: $(EDITOBJS)
	$(RMF) $(LIBPREFIX)edit.a
	$(AR) cr $(LIBPREFIX)edit.a $(EDITOBJS)
	-$(RANLIB) $(LIBPREFIX)edit.a

mcedit:
	-$(RMF) $(DESTDIR)$(bindir)/$(binprefix)mcedit
	$(LN_S) mc $(DESTDIR)$(bindir)/$(binprefix)mcedit

showlibdep:
	@echo 'OBJS="$(EDITOBJS)"'

cross:
	$(MAKE) CC=gcc-linux CPP="gcc-linux -E" \
	CPPFLAGS="$(CPPFLAGS) -I/usr/local/lib/gcc-lib/i386-linux-linux/include/ncurses "

TAGS: $(EDITSRC)
	etags $(EDITSRC)

clean:
	$(RMF) *.o core a.out edit.a mx

realclean: clean
	$(RMF) .depend
	$(RMF) TAGS
	$(RMF) *~

distclean: cleansourcelinks
	-$(RMF) $(srcdir)/*~ $(srcdir)/*.o $(srcdir)/a.out
	-$(RMF) $(srcdir)/core $(srcdir)/libedit.a
	-if test $(srcdir) = .; then $(MAKE) realclean; fi
	-$(RMF) $(srcdir)/Makefile

install: mcedit

uninstall:
	-$(RMF) $(DESTDIR)$(bindir)/$(binprefix)mcedit

distcopy:
	$(CP) $(DIST) ../../mc-$(VERSION)/edit

depend dep: mcdep

fastdeploc:

# ***Dependencies***Do not edit***
ifeq (.depend,$(wildcard .depend)) 
include .depend 
endif
# ***End of dependencies***
