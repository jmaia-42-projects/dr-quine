#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

/*
	I am a comment outside a function
*/
void foo(char *code, int i, int fd)
{
	int j = 0;
	for (; code[j] != 0x79; j++)
		dprintf(fd, "%c", code[j]);
	j++;
	dprintf(fd, "%c", i - 1 + '0');
	for (; code[j] != 0x7A; j++)
		dprintf(fd, "%c", code[j]);
	j++;
	for (int i = 0; code[i]; i++)
	{
		if (code[i] == 0x0A)
			dprintf(fd, "%cn", 0x5C);
		else if (code[i] == 0x09)
			dprintf(fd, "%ct", 0x5C);
		else if (code[i] == 0x22)
			dprintf(fd, "%c%c", 0x5C, 0x22);
		else
			dprintf(fd, "%c", code[i]);
	}
	for (; code[j]; j++)
		dprintf(fd, "%c", code[j]);
}

int	main(void)
{
	/*
		I am a comment inside a function
	*/
	int i = 5;
	char filename[] = "Sully_X.c";
	filename[6] = i - 1 + '0';

	int fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);
	if (fd == -1)
		return 1;
	char *code = "#include <stdio.h>\n#include <unistd.h>\n#include <fcntl.h>\n#include <stdlib.h>\n\n/*\n\tI am a comment outside a function\n*/\nvoid foo(char *code, int i, int fd)\n{\n\tint j = 0;\n\tfor (; code[j] != 0x79; j++)\n\t\tdprintf(fd, \"%c\", code[j]);\n\tj++;\n\tdprintf(fd, \"%c\", i - 1 + '0');\n\tfor (; code[j] != 0x7A; j++)\n\t\tdprintf(fd, \"%c\", code[j]);\n\tj++;\n\tfor (int i = 0; code[i]; i++)\n\t{\n\t\tif (code[i] == 0x0A)\n\t\t\tdprintf(fd, \"%cn\", 0x5C);\n\t\telse if (code[i] == 0x09)\n\t\t\tdprintf(fd, \"%ct\", 0x5C);\n\t\telse if (code[i] == 0x22)\n\t\t\tdprintf(fd, \"%c%c\", 0x5C, 0x22);\n\t\telse\n\t\t\tdprintf(fd, \"%c\", code[i]);\n\t}\n\tfor (; code[j]; j++)\n\t\tdprintf(fd, \"%c\", code[j]);\n}\n\nint\tmain(void)\n{\n\t/*\n\t\tI am a comment inside a function\n\t*/\n\tint i = y;\n\tchar filename[] = \"Sully_X.c\";\n\tfilename[6] = i - 1 + '0';\n\n\tint fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0644);\n\tif (fd == -1)\n\t\treturn 1;\n\tchar *code = \"z\";\n\tfoo(code, i, fd);\n\tclose(fd);\n\tif (i != 0)\n\t{\n\t\tchar execute[] = \"cc -o Sully_x -Wall -Wextra -Werror Sully_x.c\";\n\t\texecute[12] = i - 1 + '0';\n\t\texecute[42] = i - 1 + '0';\n\t\tsystem(execute);\n\t\tchar executable_name[] = \"./Sully_x\";\n\t\texecutable_name[8] = i - 1 + '0';\n\t\tsystem(executable_name);\n\t}\n}\n";
	foo(code, i, fd);
	close(fd);
	if (i != 0)
	{
		char execute[] = "cc -o Sully_x -Wall -Wextra -Werror Sully_x.c";
		execute[12] = i - 1 + '0';
		execute[42] = i - 1 + '0';
		system(execute);
		char executable_name[] = "./Sully_x";
		executable_name[8] = i - 1 + '0';
		system(executable_name);
	}
}
