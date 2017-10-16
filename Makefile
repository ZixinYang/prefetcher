CFLAGS = -msse2 --std gnu99 -O0 -Wall -Wextra

GIT_HOOKS := .git/hooks/applied

SRC = main.c

EXEC = naive_transpose \
	  sse_transpose \
	  sse_prefetch_transpose \
	  avx_transpose \
	  avx_prefetch_transpose

all: $(GIT_HOOKS) $(EXEC)

run: $(EXEC)
	@for method in $(EXEC); do \
		echo exec $$method; \
		./$$method; \
	done

naive_transpose: $(SRC) naive_transpose.c
	$(CC) $(CFLAGS) -o $@ $^

sse_transpose: $(SRC) sse_transpose.c
	$(CC) $(CFLAGS) -o $@ $^

sse_prefetch_transpose: $(SRC) sse_prefetch_transpose.c
	$(CC) $(CFLAGS) -o $@ $^

avx_transpose: $(SRC) avx_transpose.c
	$(CC) $(CFLAGS) -o $@ $^

avx_prefetch_transpose: $(SRC) avx_prefetch_transpose.c
	$(CC) $(CFLAGS) -o $@ $^

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

clean:
	$(RM) $(EXEC) $(VERIFY)
