; Hook interrupt 65 with following services
; Take two BCD numbers
; Calc Sum
; Display Sum      

.model small
.stack 100h
.data

result dw 0
msg db "The Result is:$"

.code

mov ax, @data
mov ds, ax

mov ax, 0
mov es, ax

mov bx, 4 * 65h

mov word ptr es:[bx], offset interrupt_handler
mov word ptr es:[bx + 2], seg interrupt_handler

int 65h

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
    
    ; initialize video memory
    mov ax, 0xb800
    mov es, ax
    
    ;load the result
    mov dx, [result]
    
    ;DISPLAYING THE FIRST DIGIT
    
    ;load the result again
    mov ax, dx
    
    ;isolate the first digit
    shr ax, 12  
    
    ;display it
    mov di, 2*(0*80+22)
    call Display       
    
    ; DISPLAYING THE SECOND DIGIT
    
    ;load the result again
    mov ax, dx
    
    ;isolate the second digit
    shl ax, 4
    shr ax, 12
    
    ;display
    inc di
    call Display
    
    ; DISPLAYING THIRD DIGIT
    
    ;load the variable again
    mov ax, dx
    
    ;isolate the third digit
    shl ax, 8
    shr ax, 12
    
    ;display it
    inc di
    call Display
    
    ; DISPLAYING FOURTH DIGIT
    
    ;load the result again
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