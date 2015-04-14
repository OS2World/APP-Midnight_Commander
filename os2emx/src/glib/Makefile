LOBJ = gstrfuncs.o gutils.o gmessages.o gmem.o 

TLIB = ../../lib/glib.a

AR  = ar
AF  = rvs

all: $(TLIB)

$(TLIB) : $(LOBJ)
	$(AR) $(AF) $(TLIB) $(LOBJ)

gstrfuncs.o: gstrfuncs.c
	gcc -c -DOS2EMX -D__ST_MT_ERRNO__ -DHAVE_STRERROR -I../.. gstrfuncs.c

gutils.o: gutils.c
	gcc -c -DOS2EMX -D__ST_MT_ERRNO__ -DHAVE_STRERROR -I../.. gutils.c

gmessages.o: gmessages.c
	gcc -c -DOS2EMX -D__ST_MT_ERRNO__ -DHAVE_STRERROR -I../.. gmessages.c

gmem.o: gmem.c
	gcc -c -DOS2EMX -D__ST_MT_ERRNO__ -DHAVE_STRERROR -I../.. gmem.c



clean:
	rm -f *.o
	rm $(TLIB)