# Generated automatically from Makefile.in by configure.
srcdir = .

SHELL   = sh
rootdir = $(srcdir)/..
include ../os2emx/Make.common



CFLAGS   = $(XCFLAGS)
CPPFLAGS = $(XCPPFLAGS) -DREGEX_MALLOC
LDFLAGS  = $(XLDFLAGS) -s -Zbin-files -Zmt
DEFS     = $(XDEFS)
LIBS     = $(XLIBS)  $(XLIB) -lrpc -lsocket -ltermcap -lmc_emx -lmmap -lglib
OURLIBS  = -lvfs-mc -lmcslang -ledit -L$(builddir)/intl -lintl
INSTALL  = /usr/bin/install -c

INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA = ${INSTALL} -m 644

SRCS =	dir.c util.c main.c screen.c dialog.c keyxdef.c menu.c\
	file.c win.c color.c help.c find.c profile.c user.c view.c \
	ext.c setup.c dlg.c option.c info.c \
	tree.c widget.c mad.c xcurses.c xslint.c \
	wtools.c  subshell.c terms.c boxes.c chown.c achown.c \
	hotlist.c layout.c fsusage.c mountlist.c regex.c \
	complete.c slint.c command.c cmd.c panelize.c \
	listmode.c utilunix.c background.c rxvt.c popt.c \
	text.c key.c mouse.c learn.c chmod.c chattrib.c drive.c hetnet.c \
        filegui.c filenot.c findme.c

HDRS =	color.h file.h mouse.h user.h dialog.h find.h main.h \
	util.h dir.h global.h menu.h panel.h win.h mem.h \
	help.h profile.h dlg.h option.h tree.h info.h \
	widget.h chmod.h cons.saver.h mad.h wtools.h chown.h  \
	subshell.h view.h setup.h key.h ext.h boxes.h \
	hotlist.h layout.h fsusage.h mountlist.h regex.h complete.h \
	myslang.h command.h cmd.h tty.h fs.h panelize.h achown.h \
	learn.h listmode.h features.inc background.h \
	x.h popt.h textconf.h i18n.h chattrib.h drive.h hetnet.h \
        filegui.h findme.h

OBJS =	dir.o util.o screen.o dialog.o keyxdef.o menu.o\
	file.o win.o color.o help.o find.o profile.o user.o view.o \
	ext.o  setup.o dlg.o option.o \
	tree.o widget.o mad.o wtools.o info.o \
	terms.o boxes.o \
	hotlist.o layout.o fsusage.o mountlist.o \
	regex.o complete.o slint.o command.o \
	cmd.o main.o panelize.o listmode.o utilunix.o \
        background.o popt.o text.o key.o mouse.o learn.o chmod.o \
	chattrib.o drive.o hetnet.o \
        filegui.o filenot.o findme.o
# 

#
# Distribution variables
#

DISTFILES = \
	$(HDRS) $(SRCS) Makefile.in TODO ChangeLog OChangeLog man2hlp.c \
	gindex.pl xmkdir cons.saver.c ncurses.patch mc.hlp depend.awk \
	fixhlp.c mfmt.c

# Should be: mc $(srcdir)/mc.hlp but it's remaking it always

all: mc$(EXESFX) mcmfmt$(EXESFX) Makefile

#Makefile: $(srcdir)/Makefile.in $(builddir)/config.status
#	cd $(builddir) && CONFIG_FILES=$@ CONFIG_HEADERS= $(SHELL) ./config.status
.c.o:
	$(CC) -c $(CPPFLAGS) $(DEFS) $(CFLAGS) $<

cons.saver$(EXESFX): cons.saver.o
	$(CC) -s cons.saver.o -o cons.saver$(EXESFX)

check:
	@echo no tests are supplied.

mc$(EXESFX): $(OBJS) ../vfs/$(LIBPREFIX)vfs-mc.a ../slang/$(LIBPREFIX)mcslang.a ../edit/$(LIBPREFIX)edit.a ../os2emx/lib/$(LIBPREFIX)mc_emx.a
	$(CC) $(LDFLAGS) -o $@ $(OBJS) -L../os2emx/lib -L../vfs -L../slang -L../edit $(OURLIBS) $(LIBS) 


mcmfmt$(EXESFX): mfmt.o
	$(CC) $(LDFLAGS) mfmt.o -o $@ 

libvfs-mc.a:
	cd ../vfs; $(MAKE) libvfs-mc.a
	-$(RMF) libvfs-mc.a
	$(LN_S) ../vfs/libvfs-mc.a .

libmcslang.a:
	cd ../slang; $(MAKE) libmcslang.a
	-$(RMF) libmcslang.a
	$(LN_S) ../slang/libmcslang.a .

libedit.a:
	cd ../edit; $(MAKE) libedit.a
	-$(RMF) libedit.a
	$(LN_S) ../edit/libedit.a .

cross:
	$(MAKE) CC=gcc-linux CPP="gcc-linux -E" \
	CPPFLAGS="$(CPPFLAGS) -I/usr/local/lib/gcc-lib/i386-linux-linux/include/ncurses "

$(srcdir)/mc.hlp: $(docdir)/mc.1.in $(mclibdir)/xnc.hlp $(srcdir)/gindex.pl
	$(MAKE) man2hlp
	./man2hlp 58 $(docdir)/mc.1.in | cat - $(mclibdir)/xnc.hlp | \
	perl $(srcdir)/gindex.pl > $(srcdir)/mc.hlp

mc.html: $(docdir)/mc.1.in man2hlp
	./man2hlp 0 $(docdir)/mc.1.in > body.html
	cat index.html body.html > mc.html
	$(RM) index.html body.html

TAGS: $(SRCS)
	etags $(SRCS)

clean:
	$(RMF) mc cons.saver man2hlp fixhlp *.o core a.out mc.html mcmfmt
	$(RMF) *.exe

realclean: clean
	$(RMF) .depend
	$(RMF) TAGS
	$(RMF) *~

distclean:
	-$(RMF) $(srcdir)/*~ $(srcdir)/mc $(srcdir)/cons.saver
	-$(RMF) $(srcdir)/mfmt
	-$(RMF) $(srcdir)/man2hlp $(srcdir)/fixhlp $(srcdir)/*.o $(srcdir)/core
	-$(RMF) $(srcdir)/a.out $(srcdir)/mc.html
	-$(RMF) $(srcdir)/libvfs-mc.a $(srcdir)/libmcslang.a $(srcdir)/libedit.a
	-if test $(srcdir) = .; then $(MAKE) realclean; fi
	-$(RMF) $(srcdir)/Makefile

install: mc mcmfmt install.saver
	$(INSTALL_PROGRAM) mc     $(DESTDIR)$(bindir)/$(binprefix)mc
	$(INSTALL_PROGRAM) mcmfmt $(DESTDIR)$(bindir)/$(binprefix)mcmfmt
	$(SEDCMD2) < $(srcdir)/mc.hlp > $(DESTDIR)$(libdir)/$(libprefix)mc.hlp 

install.saver: cons.saver
	$(INSTALL_PROGRAM) -m 4755 cons.saver $(DESTDIR)$(suppbindir)/cons.saver

uninstall:
	$(RMF) $(bindir)/$(binprefix)mc
	$(RMF) $(bindir)/$(binprefix)mcmfmt
	$(RMF) $(bindir)/$(binprefix)cons.saver
	$(RMF) $(libdir)/$(libprefix)mc.hlp

distcopy: $(srcdir)/mc.hlp
	$(CP) $(DISTFILES) ../../mc-$(VERSION)/src

depend dep: mcdep

fastdeploc: fastdepslang fastdepvfs

# ***Dependencies***Do not edit***
ifeq (.depend,$(wildcard .depend)) 
include .depend 
endif
# ***End of dependencies***
