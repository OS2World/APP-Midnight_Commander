#
# Makefile mc_emx
#

include ../Make.common

# Defined (compiler)

DEFINED = -DLIBDIR=\""$(libdir)/"\"

# Include Directories

INCLUDES = -I../.. -I.. -I. 

# RC Include Directories

RCINCLUDES = -i .. -i . 

# Standard Library Directories

STDL = 

# Library Object Directory

LODIR = ./#

# List Of Library Object Files

LOBJ = \
$(LODIR)attrib.o $(LODIR)cons_os2.o \
$(LODIR)drive.o $(LODIR)fcntlbts.o $(LODIR)rename.o \
$(LODIR)key_os2.o $(LODIR)keytoc.o $(LODIR)mystatfs.o $(LODIR)mysystem.o \
$(LODIR)stdlog.o $(LODIR)util.o $(LODIR)util2.o $(LODIR)mouse.o 

# Target Librarry

TLIB = ../lib/mc_emx.a

# Object Directory

ODIR =  #

# List Of Object Files

OBJ = \


# Linked Libraries

LIBR = 

# Library Files

DLIB = 

# Target Def File

TDEF = 

# Target Rc File

TRC = 

# Target Res File

TRES = 

# Target Exe File

TEXE = 

# Tools

AR  = ar
AF  = rvs
CR  = rc
CRF = -r $(RCINCLUDES)
CC  = gcc
CF  = -c $(INCLUDES) $(DEFINED) -O3 
CXF = -s $(STDL)

# Target

all: $(TLIB) 

$(TLIB) : $(LOBJ)
	$(AR) $(AF) $(TLIB) $(LOBJ)

# Library Object Rules

$(LODIR)attrib.o : ./attrib.c \
                   ../config.h
	$(CC) $(CF) -o $@ $<


$(LODIR)cons_os2.o : ./cons_os2.c \
                     ../config.h
	$(CC) $(CF) -o $@ $<

$(LODIR)drive.o : ./drive.c \
                  ../config.h
	$(CC) $(CF) -o $@ $<

$(LODIR)fcntlbts.o : ./fcntlbts.c
	$(CC) $(CF) -o $@ $<


$(LODIR)rename.o : ./rename.c
	$(CC) $(CF) -o $@ $<

$(LODIR)key_os2.o : ./key_os2.c \
                    ../config.h
	$(CC) $(CF) -o $@ $<

$(LODIR)keytoc.o : ./keytoc.c \
                    ../config.h
	$(CC) $(CF) -o $@ $<

$(LODIR)mystatfs.o : ./mystatfs.c \
                     ../config.h
	$(CC) $(CF) -o $@ $<

$(LODIR)mysystem.o : ./mysystem.c \
                     ../config.h
	$(CC) $(CF) -o $@ $<

$(LODIR)stdlog.o : ./stdlog.c
	$(CC) $(CF) -o $@ $<

$(LODIR)util.o : ./util.c
	$(CC) $(CF) -o $@ $<

$(LODIR)util2.o : ./util2.c
	$(CC) $(CF) -o $@ $<

$(LODIR)mouse.o : ./mouse.c
	$(CC) $(CF) -o $@ $<


clean:
	rm -f *.o core a.out ../lib/mc_emx.a 
