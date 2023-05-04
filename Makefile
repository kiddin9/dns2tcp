CC = gcc
CFLAGS = -std=c99 -Wall -Wextra -O3
LIBS = -lm
SRCS = dns2tcp.c
OBJS = $(SRCS:.c=.o)
MAIN = dns2tcp
DESTDIR = /usr/local/bin

EVCFLAGS = -O3 -fno-strict-aliasing
EVSRCFILE = libev/ev.c
EVOBJFILE = ev.o

.PHONY: all install clean

all: $(MAIN)

install: $(MAIN)
	mkdir -p $(DESTDIR)
	install -m 0755 $(MAIN) $(DESTDIR)

clean:
	$(RM) *.o $(MAIN)

$(MAIN): $(EVOBJFILE) $(OBJS)
	$(CC) $(CFLAGS) -s -o $(MAIN) $(OBJS) $(EVOBJFILE) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

$(EVOBJFILE): $(EVSRCFILE)
	$(CC) $(EVCFLAGS) -c $(EVSRCFILE) -o $(EVOBJFILE)
