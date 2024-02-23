; Hook interrupt 01h with following services
; Take BCD number
; Store in dx  

.model small
.stack 100h
.data

msg db "Enter 4 Digit BCD number: $"

.code

mov ax, @data
mov ds, ax

mov ax, 0
mov es, ax

mov bx, 4 * 01h

mov word ptr es:[bx], offset interrupt_handler
mov word ptr es:[bx + 2], seg interrupt_handler

int 01h

mov ax, 4ch
int 21h

interrupt_handler proc
    
    ; Display message
    
    mov dx, offset msg
    mov ah, 09h
    int 21h
    
    
    ; Read first digit
    mov ah, 01h
    int 21h
    
    sub al, '0'
    shl al, 4
    
    mov dh, al
    
    ; Read second digit
    mov ah, 01h
    int 21h
    
    sub al, '0'
    
    or dh, al
    
    ; Read third digit
    mov ah, 01h
    int 21h
    
    sub al, '0'
    shl al, 4
    
    mov dl, al
    
    ; Read fourth digit
    mov ah, 01h
    int 21h
    
    sub al, '0'
    
    or dl, al
interrupt_handler endp