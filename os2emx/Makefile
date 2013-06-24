
include ./Make.common

codedirs= vfs slang edit src 
unixdirs= intl $(codedirs)

executables = ../src/mc.exe ../src/mcmfmt.exe ../vfs/mcserv.exe ./src/pwd/mcpasswd.exe
distrname = mc-$(VERSION).zip

all: 
	@cd ./src; \
	${MAKE} all || exit 1;
	@cd ./src/pwd; \
	${MAKE} all || exit 1;
	@cd ./src/glib; \
	${MAKE} all || exit 1;
	@for dir in ${unixdirs} ; do \
		cd ../$$dir; \
		${MAKE} all || exit 1; \
		cd ../os2emx ;\
	done

clean: 
	@cd ./src; \
	${MAKE} clean || exit 1; 
	@cd ./src/pwd; \
	${MAKE} clean || exit 1; 
	@cd ./src/glib; \
	${MAKE} clean || exit 1; 
	@for dir in ${unixdirs} ; do \
		cd ../$$dir; \
		${MAKE} clean || exit 1; \
		cd ../os2emx ;\
	done

config:
	@for dir in ${unixdirs} ; do \
		cp ./cfg/$$dir/Makefile ../$$dir; \
	done

getbin: 
	@for x in ${executables} ; do \
		cp $$x ./bin; \
	done

install: 
	@for x in ${executables} ; do \
		echo cp $$x $(suppbindir); \
		cp $$x $(suppbindir) ; \
	done
	cp ./bin/mc.cmd $(bindir)
	cp ./bin/mcx.cmd $(bindir)
	cp ./dll/mmap.dll $(exec_prefix)/dll
	cp ./dll/mmap.dll $(suppbindir)
	cp ./doc/* $(libdir)/doc
	cp ./bin/mc.cmd $(libdir)/doc
	cp ./bin/mcx.cmd $(libdir)/doc


distr:
	@cd $(libdir); cd ..; zip -r $(distrname) mc
	mv $(libdir)/../$(distrname) ./
	zip mc454bin $(distrname) README.OS2 INSTALL.OS2
	rm $(distrname)
