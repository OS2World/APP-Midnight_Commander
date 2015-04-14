
include ../../Make.common

# Defined (compiler)

DEFINED = -DLIBDIR=\""$(libdir)/"\"

# Include Directories

INCLUDES = -I../.. -I.. -I. 

CC= gcc
CF= -c $(INCLUDES) $(DEFINED) -O3
CXF = -s $(INCLUDES) $(DEFINED) -O3

CRYPTLIB = ../../lib/ufc.a
PWD=../../lib/pwd.o

OBJS= getopt.o getpass.o


all: $(PWD) mcpasswd.exe


$(PWD): mcpwd.c mcpwd.h
	$(CC) $(CF) -o $@ $<

mcpasswd.exe: mcpasswd.c $(PWD) getopt.o getpass.o
	$(CC) $(CXF) -o $@ $< $(OBJS) $(PWD) $(CRYPTLIB)

getopt.o: getopt.c
	$(CC) $(CF) -o $@ $<

getpass.o: getpass.c
	$(CC) $(CF) -o $@ $<

clean:
	rm -f *.o *.exe $(PWD)