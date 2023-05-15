#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

/*
	I am a comment outside a function
*/

#define USELESS Hello I am useless

#define foo(code, fd) {int j = 0; for (; code[j] != 0x7A; j++) dprintf(fd, "%c", code[j]); j++; for (int i = 0; code[i]; i++) { if (code[i] == 0x0A) dprintf(fd, "%cn", 0x5C); else if (code[i] == 0x09) dprintf(fd, "%ct", 0x5C); else if (code[i] == 0x22) dprintf(fd, "%c%c", 0x5C, 0x22); else dprintf(fd, "%c", code[i]); } for (; code[j]; j++) dprintf(fd, "%c", code[j]); }

#define FT(x)int main(){int fd = open("Grace_kid.c", O_CREAT | O_WRONLY | O_TRUNC, 0644); if (fd == -1) return (-1); char *code = "#include <stdio.h>\n#include <unistd.h>\n#include <fcntl.h>\n\n/*\n\tI am a comment outside a function\n*/\n\n#define USELESS Hello I am useless\n\n#define foo(code, fd) {int j = 0; for (; code[j] != 0x7A; j++) dprintf(fd, \"%c\", code[j]); j++; for (int i = 0; code[i]; i++) { if (code[i] == 0x0A) dprintf(fd, \"%cn\", 0x5C); else if (code[i] == 0x09) dprintf(fd, \"%ct\", 0x5C); else if (code[i] == 0x22) dprintf(fd, \"%c%c\", 0x5C, 0x22); else dprintf(fd, \"%c\", code[i]); } for (; code[j]; j++) dprintf(fd, \"%c\", code[j]); }\n\n#define FT(x)int main(){int fd = open(\"Grace_kid.c\", O_CREAT | O_WRONLY | O_TRUNC, 0644); if (fd == -1) return (-1); char *code = \"z\"; foo(code, fd); close(fd);}\n\nFT(\"pouet\");\n"; foo(code, fd); close(fd);}

FT("pouet");
