CC = gcc
CFLAGS = -Wall -Wextra -Iinclude
PREFIX = /usr/local

all: bin/client_dynamic

bin/client_dynamic: obj/main_dynamic.o lib/libmyutils.so
	mkdir -p bin
	gcc obj/main_dynamic.o -Llib -lmyutils -o bin/client_dynamic

lib/libmyutils.so: obj/mystrfunctions_pic.o obj/myfilefunctions_pic.o
	mkdir -p lib
	gcc -shared obj/mystrfunctions_pic.o obj/myfilefunctions_pic.o -o lib/libmyutils.so

obj/mystrfunctions_pic.o: src/mystrfunctions.c include/mystrfunctions.h
	mkdir -p obj
	gcc -c -fPIC -Iinclude src/mystrfunctions.c -o obj/mystrfunctions_pic.o

obj/myfilefunctions_pic.o: src/myfilefunctions.c include/myfilefunctions.h
	mkdir -p obj
	gcc -c -fPIC -Iinclude src/myfilefunctions.c -o obj/myfilefunctions_pic.o

obj/main_dynamic.o: src/main.c include/mystrfunctions.h include/myfilefunctions.h
	mkdir -p obj
	gcc -c -Iinclude src/main.c -o obj/main_dynamic.o

install: bin/client_dynamic
	mkdir -p $(PREFIX)/bin
	mkdir -p $(PREFIX)/share/man/man3
	mkdir -p $(PREFIX)/lib
	cp bin/client_dynamic $(PREFIX)/bin/client
	cp lib/libmyutils.so $(PREFIX)/lib/
	cp man/man3/*.3 $(PREFIX)/share/man/man3/
	ldconfig

clean:
	rm -rf obj/*.o lib/*.so bin/client_dynamic

.PHONY: all install clean