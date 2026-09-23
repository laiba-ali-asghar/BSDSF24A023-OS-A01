all: bin/client

bin/client: obj/mystrfunctions.o obj/myfilefunctions.o obj/main.o
	mkdir -p bin
	gcc obj/mystrfunctions.o obj/myfilefunctions.o obj/main.o -o bin/client

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
	rm -rf obj/*.o bin/client

.PHONY: all clean
