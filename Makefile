giza: giza.s
	gcc -no-pie giza.s -o giza

clean:
	rm -f *.o giza

test-build: giza

test-giza-1: test-build
	./giza 1

test-giza-2: test-build
	./giza 2

test-giza-5: test-build
	./giza 5

test-giza-10: test-build
	./giza 10

test-giza-21: test-build
	./giza 21

test: test-giza-1 test-giza-2 test-giza-5 test-giza-10 test-giza-21
