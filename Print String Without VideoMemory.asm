.model small
.stack 100h
.data

message db "Hello World$"

.code

mov dx, offset message
mov ah, 09h
int 21h

mov ax, 4ch
int 21h