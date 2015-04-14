@SET MC_LIBDIR=c:/usr/lib/mc
@SET TERMCAP=%MC_LIBDIR%/termcap
@start /min /c xterm -tn xterm -fn 10x20 -bg black -fg yellow2 -display 192.168.10.10:0 -e @%MC_LIBDIR%\bin\mc  %1 %2 %3 %4 %5 %6 %7 %8 %9