#include <stdio.h>
#include <unistd.h>

/*
	I am a comment outside a function
*/
void foo(char *code)
{
	int j = 0;
	for (; code[j] != 0x7A; j++)
		putchar(code[j]);
	j++;
	for (int i = 0; code[i]; i++)
	{
		if (code[i] == 0x0A)
			printf("%cn", 0x5C);
		else if (code[i] == 0x09)
			printf("%ct", 0x5C);
		else if (code[i] == 0x22)
			printf("%c%c", 0x5C, 0x22);
		else
			printf("%c", code[i]);
	}
	for (; code[j]; j++)
		putchar(code[j]);
}

int	main(void)
{
	/*
		I am a comment inside a function
	*/
	char *code = "#include <stdio.h>\n#include <unistd.h>\n\n/*\n\tI am a comment outside a function\n*/\nvoid foo(char *code)\n{\n\tint j = 0;\n\tfor (; code[j] != 0x7A; j++)\n\t\tputchar(code[j]);\n\tj++;\n\tfor (int i = 0; code[i]; i++)\n\t{\n\t\tif (code[i] == 0x0A)\n\t\t\tprintf(\"%cn\", 0x5C);\n\t\telse if (code[i] == 0x09)\n\t\t\tprintf(\"%ct\", 0x5C);\n\t\telse if (code[i] == 0x22)\n\t\t\tprintf(\"%c%c\", 0x5C, 0x22);\n\t\telse\n\t\t\tprintf(\"%c\", code[i]);\n\t}\n\tfor (; code[j]; j++)\n\t\tputchar(code[j]);\n}\n\nint\tmain(void)\n{\n\t/*\n\t\tI am a comment inside a function\n\t*/\n\tchar *code = \"z\";\n\tfoo(code);\n}\n";
	foo(code);
}
