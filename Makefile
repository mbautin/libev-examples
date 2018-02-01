CC_OPTS = -Wall -Werror -ggdb3 -I./include -I/home/mbautin/code/libev -L/home/mbautin/code/libev/.libs -fPIC

all: obj/array-heap.o bin/unix-echo-server bin/unix-echo-client bin/udp-echo-server

clean:
	rm -f *.o bin/*

bin/array-test: src/array-test.c obj/array-heap.o
	$(CC) $(CC_OPTS) -o $@ $< obj/array-heap.o

obj/array-heap.o: src/array-heap.c include/array-heap.h
	$(CC) $(CC_OPTS) -o $@ -c $<

bin/udp-echo-server: src/udp-echo-server.c
	$(CC) $(CC_OPTS) -o $@ $<

bin/unix-echo-server: src/unix-echo-server.c obj/array-heap.o
	$(CC) $(CC_OPTS) -o $@ $< obj/array-heap.o -l:libev.a -lm

bin/unix-echo-client: src/unix-echo-client.c
	$(CC) $(CC_OPTS) -o $@ $< -l:libev.a -lm
