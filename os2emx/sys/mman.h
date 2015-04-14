/*

Memory Mapped Files Emulation Layer v1.00
(c) 1998 Maurilio Longo - md2520@mclink.it

*/


#ifndef caddr_t
#  define     caddr_t        char *
#endif
#ifndef off_t
#  define     off_t          long
#endif
#ifndef size_t
#  define     size_t         unsigned long
#endif


#define	HAVE_MSYNC	1
#define	PROT_READ	0x0001
#define	PROT_WRITE	0x0002
#define	PROT_EXEC	0x0004
#define	PROT_NONE	0x0000
#define	MAP_SHARED	0x1
#define	MAP_PRIVATE	0x2
#define	MAP_FIXED	0x10
#define	MCL_CURRENT	0x1
#define	MCL_FUTURE 	0x2
#define	MS_ASYNC	0x1
#define	MS_INVALIDATE	0x2
#define	MS_MUNMAP	0x10


int	getpagesize(void);
int	mprotect(caddr_t pAddr, int cbLen, int fProtection);
int	mlockall(int fFlags);
caddr_t	mmap(caddr_t pAddr, size_t cbLen, int fProtection, int fFlags, int hFile, off_t cbOffset);
int	msync(caddr_t pAddr, int cbLen, int fFlags);
int	munlockall(void);
int	munmap(caddr_t pAddr, int cbLen);
int     merror(void);


