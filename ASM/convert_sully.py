#!/bin/python3
import sys

print(end='\ttext: db ""')
with open('Sully.s') as file:
    data = file.read()
    data = data[11:]
    data += '\ttext: db ""'
    for c in data:
        if c == '\n':
            print(end=', 0x0A')
        elif c == '\t':
            print(end=', 0x09')
        elif c == '"':
            print(end=', 0x22')
        else:
            print(', "' + str(c) + '"', end='')

print("")
print("\tlen equ $-text")
