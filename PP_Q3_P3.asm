; Hook interrupt 65 with following services
; Take two BCD numbers
; Calc Sum
; Display Sum      

.model small
.stack 100h
.data

result dw 0
msg db "The Sum is stored in AX.$"

.code

mov ax, @data
mov ds, ax

mov ax, 0
mov es, ax

mov bx, 4 * 02h

mov word ptr es:[bx], offset interrupt_handler
mov word ptr es:[bx + 2], seg interrupt_handler

int 02h

mov ax, 4ch
int 21h

interrupt_handler proc
    
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
    
            ; FOR SECOND DIGIT
    
    ; Read first digit
    mov ah, 01h
    int 21h
    
    sub al, '0'
    shl al, 4
    
    mov ch, al
    
    ; Read second digit
    mov ah, 01h
    int 21h
    
    sub al, '0'
    
    or ch, al
    
    ; Read third digit
    mov ah, 01h
    int 21h
    
    sub al, '0'
    shl al, 4
    
    mov cl, al
    
    ; Read fourth digit
    mov ah, 01h
    int 21h
    
    sub al, '0'
    
    or cl, al
    
                ; ADDING
                
    add dx, cx
    mov [result], dx
    
                ; DISPLAYING
    ; Message            
    mov dx, offset msg
    mov ah, 09h           
    int 21h
    
    ; Result
    mov ax, [result]
    
    ret
    
interrupt_handler endp


