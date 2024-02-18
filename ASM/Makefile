ASMC = nasm
ASMFLAGS = -felf64
LINKER = ld

all: Colleen Grace Sully

Colleen: Colleen.o
	$(LINKER) $^ -o $@

Grace: Grace.o
	$(LINKER) $^ -o $@

Sully: Sully.o
	$(LINKER) $^ -o $@

clean:
	rm -f Colleen.o Grace.o Sully.o

fclean: clean
	rm -f Colleen Grace Sully

%.o: %.s
	$(ASMC) $(ASMFLAGS) $^ -o $@


re:	fclean all

.PHONY: all clean fclean re
