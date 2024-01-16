%define USELESS

section .text
	global _start

; Hello, I am a comment outside the function
%macro MAIN 0
	_start:
		mov rax, 85
		mov rdi, file_name
		mov rsi, 420
		syscall
		cmp rax, 0
		jl err

		push rax
		mov rax, 1
		mov rdi, [rsp]
		lea rsi, [rel text]
		mov rdx, len
		syscall

		call foo

		mov rax, 1
		mov rdi, [rsp]
		lea rsi, [rel after_big_text]
		mov rdx, len_after_big_text
		syscall

		mov rax, 3
		syscall

		pop rdi

		mov rax, 60
		mov rdi, 0
		syscall
	err:
		mov rax, 60
		mov rdi, 1
		syscall
%endmacro

%macro FOO 0
	foo:
		push rbp
		mov rbp, rsp
		push len
		lea r8, [rel text]
		push r8
		push rdi
	begin_loop:
		mov rax, 1
		mov rdi, [rbp - 24]
		lea rsi, [rel separator]
		mov rdx, len_separator
		syscall
		mov r8, [rbp - 16]
		mov r9b, [r8]
		cmp r9b, 0x0A
		je print_newline
		cmp r9b, 0x09
		je print_tab
		cmp r9b, 0x22
		je print_quote
	print_character:
		mov rax, 1
		mov rdi, [rbp - 24]
		lea rsi, [rel quote]
		mov rdx, 1
		syscall
		mov rax, 1
		mov rdi, [rbp - 24]
		mov rsi, [rbp - 16]
		mov rdx, 1
		syscall
		mov rax, 1
		mov rdi, [rbp - 24]
		lea rsi, [rel quote]
		mov rdx, 1
		syscall
		jmp end_print
	print_newline:
		mov rax, 1
		mov rdi, [rbp - 24]
		lea rsi, [rel newline_hex]
		mov rdx, newline_hex_len
		syscall
		jmp end_print
	print_tab:
		mov rax, 1
		mov rdi, [rbp - 24]
		lea rsi, [rel tab_hex]
		mov rdx, tab_hex_len
		syscall
		jmp end_print
	print_quote:
		mov rax, 1
		mov rdi, [rbp - 24]
		lea rsi, [rel quote_hex]
		mov rdx, quote_hex_len
		syscall
		jmp end_print
	end_print:
		mov r8, [rbp - 8]
		mov r9, [rbp - 16]
		dec r8
		inc r9
		mov [rbp - 8], r8
		mov [rbp - 16], r9
		cmp r8, 0
		jne begin_loop
		mov rsp, rbp
		pop rbp
		ret
%endmacro

MAIN
FOO

section .data
	file_name: db "Grace_kid.s", 0x00
	newline_hex: db "0x0A"
	newline_hex_len: equ $-newline_hex
	tab_hex: db "0x09"
	tab_hex_len: equ $-tab_hex
	quote_hex: db "0x22"
	quote_hex_len: equ $-quote_hex
	quote: db '"'
	separator: db ", "
	len_separator: equ $-separator
	after_big_text: db 0x0A, 0x09, "len equ $-text", 0x0A
	len_after_big_text: equ $-after_big_text
	text: db "", "%", "d", "e", "f", "i", "n", "e", " ", "U", "S", "E", "L", "E", "S", "S", 0x0A, 0x0A, "s", "e", "c", "t", "i", "o", "n", " ", ".", "t", "e", "x", "t", 0x0A, 0x09, "g", "l", "o", "b", "a", "l", " ", "_", "s", "t", "a", "r", "t", 0x0A, 0x0A, ";", " ", "H", "e", "l", "l", "o", ",", " ", "I", " ", "a", "m", " ", "a", " ", "c", "o", "m", "m", "e", "n", "t", " ", "o", "u", "t", "s", "i", "d", "e", " ", "t", "h", "e", " ", "f", "u", "n", "c", "t", "i", "o", "n", 0x0A, "%", "m", "a", "c", "r", "o", " ", "M", "A", "I", "N", " ", "0", 0x0A, 0x09, "_", "s", "t", "a", "r", "t", ":", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "8", "5", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "f", "i", "l", "e", "_", "n", "a", "m", "e", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "s", "i", ",", " ", "4", "2", "0", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, 0x09, "c", "m", "p", " ", "r", "a", "x", ",", " ", "0", 0x0A, 0x09, 0x09, "j", "l", " ", "e", "r", "r", 0x0A, 0x0A, 0x09, 0x09, "p", "u", "s", "h", " ", "r", "a", "x", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "s", "p", "]", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "s", "i", ",", " ", "[", "r", "e", "l", " ", "t", "e", "x", "t", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "l", "e", "n", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x0A, 0x09, 0x09, "c", "a", "l", "l", " ", "f", "o", "o", 0x0A, 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "s", "p", "]", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "s", "i", ",", " ", "[", "r", "e", "l", " ", "a", "f", "t", "e", "r", "_", "b", "i", "g", "_", "t", "e", "x", "t", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "l", "e", "n", "_", "a", "f", "t", "e", "r", "_", "b", "i", "g", "_", "t", "e", "x", "t", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "3", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x0A, 0x09, 0x09, "p", "o", "p", " ", "r", "d", "i", 0x0A, 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "6", "0", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "0", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, "e", "r", "r", ":", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "6", "0", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "1", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, "%", "e", "n", "d", "m", "a", "c", "r", "o", 0x0A, 0x0A, "%", "m", "a", "c", "r", "o", " ", "F", "O", "O", " ", "0", 0x0A, 0x09, "f", "o", "o", ":", 0x0A, 0x09, 0x09, "p", "u", "s", "h", " ", "r", "b", "p", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "b", "p", ",", " ", "r", "s", "p", 0x0A, 0x09, 0x09, "p", "u", "s", "h", " ", "l", "e", "n", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "8", ",", " ", "[", "r", "e", "l", " ", "t", "e", "x", "t", "]", 0x0A, 0x09, 0x09, "p", "u", "s", "h", " ", "r", "8", 0x0A, 0x09, 0x09, "p", "u", "s", "h", " ", "r", "d", "i", 0x0A, 0x09, "b", "e", "g", "i", "n", "_", "l", "o", "o", "p", ":", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "b", "p", " ", "-", " ", "2", "4", "]", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "s", "i", ",", " ", "[", "r", "e", "l", " ", "s", "e", "p", "a", "r", "a", "t", "o", "r", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "l", "e", "n", "_", "s", "e", "p", "a", "r", "a", "t", "o", "r", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "8", ",", " ", "[", "r", "b", "p", " ", "-", " ", "1", "6", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "9", "b", ",", " ", "[", "r", "8", "]", 0x0A, 0x09, 0x09, "c", "m", "p", " ", "r", "9", "b", ",", " ", "0", "x", "0", "A", 0x0A, 0x09, 0x09, "j", "e", " ", "p", "r", "i", "n", "t", "_", "n", "e", "w", "l", "i", "n", "e", 0x0A, 0x09, 0x09, "c", "m", "p", " ", "r", "9", "b", ",", " ", "0", "x", "0", "9", 0x0A, 0x09, 0x09, "j", "e", " ", "p", "r", "i", "n", "t", "_", "t", "a", "b", 0x0A, 0x09, 0x09, "c", "m", "p", " ", "r", "9", "b", ",", " ", "0", "x", "2", "2", 0x0A, 0x09, 0x09, "j", "e", " ", "p", "r", "i", "n", "t", "_", "q", "u", "o", "t", "e", 0x0A, 0x09, "p", "r", "i", "n", "t", "_", "c", "h", "a", "r", "a", "c", "t", "e", "r", ":", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "b", "p", " ", "-", " ", "2", "4", "]", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "s", "i", ",", " ", "[", "r", "e", "l", " ", "q", "u", "o", "t", "e", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "b", "p", " ", "-", " ", "2", "4", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "s", "i", ",", " ", "[", "r", "b", "p", " ", "-", " ", "1", "6", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "b", "p", " ", "-", " ", "2", "4", "]", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "s", "i", ",", " ", "[", "r", "e", "l", " ", "q", "u", "o", "t", "e", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, 0x09, "j", "m", "p", " ", "e", "n", "d", "_", "p", "r", "i", "n", "t", 0x0A, 0x09, "p", "r", "i", "n", "t", "_", "n", "e", "w", "l", "i", "n", "e", ":", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "b", "p", " ", "-", " ", "2", "4", "]", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "s", "i", ",", " ", "[", "r", "e", "l", " ", "n", "e", "w", "l", "i", "n", "e", "_", "h", "e", "x", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "n", "e", "w", "l", "i", "n", "e", "_", "h", "e", "x", "_", "l", "e", "n", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, 0x09, "j", "m", "p", " ", "e", "n", "d", "_", "p", "r", "i", "n", "t", 0x0A, 0x09, "p", "r", "i", "n", "t", "_", "t", "a", "b", ":", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "b", "p", " ", "-", " ", "2", "4", "]", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "s", "i", ",", " ", "[", "r", "e", "l", " ", "t", "a", "b", "_", "h", "e", "x", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "t", "a", "b", "_", "h", "e", "x", "_", "l", "e", "n", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, 0x09, "j", "m", "p", " ", "e", "n", "d", "_", "p", "r", "i", "n", "t", 0x0A, 0x09, "p", "r", "i", "n", "t", "_", "q", "u", "o", "t", "e", ":", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "a", "x", ",", " ", "1", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "i", ",", " ", "[", "r", "b", "p", " ", "-", " ", "2", "4", "]", 0x0A, 0x09, 0x09, "l", "e", "a", " ", "r", "s", "i", ",", " ", "[", "r", "e", "l", " ", "q", "u", "o", "t", "e", "_", "h", "e", "x", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "d", "x", ",", " ", "q", "u", "o", "t", "e", "_", "h", "e", "x", "_", "l", "e", "n", 0x0A, 0x09, 0x09, "s", "y", "s", "c", "a", "l", "l", 0x0A, 0x09, 0x09, "j", "m", "p", " ", "e", "n", "d", "_", "p", "r", "i", "n", "t", 0x0A, 0x09, "e", "n", "d", "_", "p", "r", "i", "n", "t", ":", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "8", ",", " ", "[", "r", "b", "p", " ", "-", " ", "8", "]", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "9", ",", " ", "[", "r", "b", "p", " ", "-", " ", "1", "6", "]", 0x0A, 0x09, 0x09, "d", "e", "c", " ", "r", "8", 0x0A, 0x09, 0x09, "i", "n", "c", " ", "r", "9", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "[", "r", "b", "p", " ", "-", " ", "8", "]", ",", " ", "r", "8", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "[", "r", "b", "p", " ", "-", " ", "1", "6", "]", ",", " ", "r", "9", 0x0A, 0x09, 0x09, "c", "m", "p", " ", "r", "8", ",", " ", "0", 0x0A, 0x09, 0x09, "j", "n", "e", " ", "b", "e", "g", "i", "n", "_", "l", "o", "o", "p", 0x0A, 0x09, 0x09, "m", "o", "v", " ", "r", "s", "p", ",", " ", "r", "b", "p", 0x0A, 0x09, 0x09, "p", "o", "p", " ", "r", "b", "p", 0x0A, 0x09, 0x09, "r", "e", "t", 0x0A, "%", "e", "n", "d", "m", "a", "c", "r", "o", 0x0A, 0x0A, "M", "A", "I", "N", 0x0A, "F", "O", "O", 0x0A, 0x0A, "s", "e", "c", "t", "i", "o", "n", " ", ".", "d", "a", "t", "a", 0x0A, 0x09, "f", "i", "l", "e", "_", "n", "a", "m", "e", ":", " ", "d", "b", " ", 0x22, "G", "r", "a", "c", "e", "_", "k", "i", "d", ".", "s", 0x22, ",", " ", "0", "x", "0", "0", 0x0A, 0x09, "n", "e", "w", "l", "i", "n", "e", "_", "h", "e", "x", ":", " ", "d", "b", " ", 0x22, "0", "x", "0", "A", 0x22, 0x0A, 0x09, "n", "e", "w", "l", "i", "n", "e", "_", "h", "e", "x", "_", "l", "e", "n", ":", " ", "e", "q", "u", " ", "$", "-", "n", "e", "w", "l", "i", "n", "e", "_", "h", "e", "x", 0x0A, 0x09, "t", "a", "b", "_", "h", "e", "x", ":", " ", "d", "b", " ", 0x22, "0", "x", "0", "9", 0x22, 0x0A, 0x09, "t", "a", "b", "_", "h", "e", "x", "_", "l", "e", "n", ":", " ", "e", "q", "u", " ", "$", "-", "t", "a", "b", "_", "h", "e", "x", 0x0A, 0x09, "q", "u", "o", "t", "e", "_", "h", "e", "x", ":", " ", "d", "b", " ", 0x22, "0", "x", "2", "2", 0x22, 0x0A, 0x09, "q", "u", "o", "t", "e", "_", "h", "e", "x", "_", "l", "e", "n", ":", " ", "e", "q", "u", " ", "$", "-", "q", "u", "o", "t", "e", "_", "h", "e", "x", 0x0A, 0x09, "q", "u", "o", "t", "e", ":", " ", "d", "b", " ", "'", 0x22, "'", 0x0A, 0x09, "s", "e", "p", "a", "r", "a", "t", "o", "r", ":", " ", "d", "b", " ", 0x22, ",", " ", 0x22, 0x0A, 0x09, "l", "e", "n", "_", "s", "e", "p", "a", "r", "a", "t", "o", "r", ":", " ", "e", "q", "u", " ", "$", "-", "s", "e", "p", "a", "r", "a", "t", "o", "r", 0x0A, 0x09, "a", "f", "t", "e", "r", "_", "b", "i", "g", "_", "t", "e", "x", "t", ":", " ", "d", "b", " ", "0", "x", "0", "A", ",", " ", "0", "x", "0", "9", ",", " ", 0x22, "l", "e", "n", " ", "e", "q", "u", " ", "$", "-", "t", "e", "x", "t", 0x22, ",", " ", "0", "x", "0", "A", 0x0A, 0x09, "l", "e", "n", "_", "a", "f", "t", "e", "r", "_", "b", "i", "g", "_", "t", "e", "x", "t", ":", " ", "e", "q", "u", " ", "$", "-", "a", "f", "t", "e", "r", "_", "b", "i", "g", "_", "t", "e", "x", "t", 0x0A, 0x09, "t", "e", "x", "t", ":", " ", "d", "b", " ", 0x22, 0x22
	len equ $-text
