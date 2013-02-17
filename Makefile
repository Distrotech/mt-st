CFLAGS=  -Wall -O2
SBINDIR= /usr/sbin
BINDIR=  /usr/bin
USRBINDIR= /usr/bin
MANDIR= /usr/share/man

MTDIR=$(BINDIR)

all:	mt stinit

mt:	mt.c
	$(CC) $(CFLAGS) -o mt mt.c

stinit:	stinit.c
	$(CC) $(CFLAGS) -o stinit stinit.c

install: mt stinit
	install -d $(DESTDIR)$(MTDIR) $(DESTDIR)$(MANDIR)/man1 $(DESTDIR)$(MANDIR)/man8
	install -s mt $(DESTDIR)$(MTDIR)
	install -c -m 444 mt.1 $(DESTDIR)$(MANDIR)/man1
	(if [ -f $(DESTDIR)$(MANDIR)/man1/mt.1.gz ] ; then \
	  rm -f $(DESTDIR)$(MANDIR)/man1/mt.1.gz; gzip $(DESTDIR)$(MANDIR)/man1/mt.1; fi)
	install -s stinit $(DESTDIR)$(SBINDIR)
	install -c -m 444 stinit.8 $(DESTDIR)$(MANDIR)/man8
	(if [ -f $(DESTDIR)$(MANDIR)/man8/stinit.8.gz ] ; then \
	  rm -f $(DESTDIR)$(MANDIR)/man8/stinit.8.gz; gzip $(DESTDIR)$(MANDIR)/man8/stinit.8; fi)

dist:	clean
	(mydir=`basename \`pwd\``;\
	cd .. && tar cvvf - $$mydir | gzip -9 > $${mydir}.tar.gz)

clean:
	rm -f *~ \#*\# *.o mt stinit
