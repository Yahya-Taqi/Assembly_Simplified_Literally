; Hook interrupt 03 with following services
; Take BCD number
; Store and display the number entered

.model small
.stack 100h
.data

.code

mov ax, @data
mov ds, ax

mov ax, 0
mov es, ax

mov bx, 4 * 03h

mov word ptr es:[bx], offset interrupt_handler
mov word ptr es:[bx + 2], seg interrupt_handler

int 03h

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
    
    
                ; DISPLAYING

    
    ; Result
    
    ; initialize video memory
    mov ax, 0xb800
    mov es, ax
    
    ; DISPLAYING FIRST DIGIT
    
    ; load the number in AX
    mov ax, dx
    
    ; isolate the first digit
    shr ax, 12
    
    ; display it
    mov di, 2*(0*80+20)
    call Display
    
    ; DISPLAYING SECOND DIGIT
    
    ; load the number in AX
    mov ax, dx
    
    ; isolate the second digit
    shl ax, 4
    shr ax, 12
    
    ; display it
    inc di
    call Display
    
    ; DISPLAYING THE THIRD DIGIT
    
    ; load the number in AX
    mov ax, dx
    
    ; isolate the third digit
    shl ax, 8
    shr ax, 12
    
    ; display it
    inc di
    call Display
    
    ; DISPLAYING THE FOURTH DIGIT
    
    ;load the number in AX
    mov ax, dx
    
    ;isolate the fourth digit
    shl ax, 12
    shr ax, 12
    
    ;display it
    inc di
    call Display
    ret
    
interrupt_handler endp


Display proc
    
    ; ensure there is only last 4 bits
    and ax, 0Fh
    
    ; check if its a number or letter
    
    cmp al, 9
    
    ;if greater
    jg its_letter
    
    ;otherwise its a number
    add al, '0' 
     
    ;proceed to display
    jmp display_it
    
its_letter:

add al, 'A' - 10

display_it:

    ;display the character
    mov es:[di], al
    inc di
    mov es:[di], 11100100b
    
    ret
 Display endp    