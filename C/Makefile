CC = clang
CFLAGS = -Wall -Wextra -Werror

all: Colleen Grace Sully

Colleen: Colleen.o
	$(CC) $(CFLAGS) $^ -o $@

Grace: Grace.o
	$(CC) $(CFLAGS) $^ -o $@

Sully: Sully.o
	$(CC) $(CFLAGS) $^ -o $@

clean:
	rm -f Colleen.o Grace.o Sully.o

fclean: clean
	rm -f Colleen Grace Sully

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


re:	fclean all

.PHONY: all clean fclean re
