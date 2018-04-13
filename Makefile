BINNAME = zjs
OUT = $(BINNAME)
CC = gcc
SRCDIR = ./src
CFLAGS = -g -Wall -std=c99
LFLAGS = -lSDL2 -lm -ll
IFLAGS = ./include

all:
	flex zoomjoystrong.lex
	bison -d zoomjoystrong.y
	mv *.h -t include; mv *.c -t src
	$(CC) $(CFLAGS) $(SRCDIR)/* -I $(IFLAGS) -o $(OUT) $(LFLAGS)
