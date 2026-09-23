all: bin/client_static

bin/client_static: obj/main.o lib/libmyutils.a
	mkdir -p bin
	gcc obj/main.o -Llib -lmyutils -o bin/client_static

lib/libmyutils.a: obj/mystrfunctions.o obj/myfilefunctions.o
	mkdir -p lib
	ar rcs lib/libmyutils.a obj/mystrfunctions.o obj/myfilefunctions.o

obj/mystrfunctions.o: src/mystrfunctions.c include/mystrfunctions.h
	mkdir -p obj
	gcc -c -Iinclude src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c include/myfilefunctions.h
	mkdir -p obj
	gcc -c -Iinclude src/myfilefunctions.c -o obj/myfilefunctions.o

obj/main.o: src/main.c include/mystrfunctions.h include/myfilefunctions.h
	mkdir -p obj
	gcc -c -Iinclude src/main.c -o obj/main.o

clean:
	rm -rf obj/*.o lib/*.a bin/client_static

.PHONY: all clean