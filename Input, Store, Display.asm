; This program includes:
                        ; Getting and storing input
                        ; Getting two numbers, adding and storing to variable
                        ; Conversion for storing and displaying data
                        ; Displaying variable to Video Memory

; Description:
; This program takes two 4 digit numbers in b/w 0 - 9 (specifically desinged
; for BCD input but other digits works too) and add them, store them in
; a variable and then display the result to the video memory


.model small
.stack 100h
.data 

result dw 0  ; Assuming you want to store a single word


.code

; initialize data segment
mov ax, @data
mov ds, ax

; Clear destination register
xor dx, dx

; Read the digit
mov ah, 01h
int 21h
; Now al has the ASCII, convert it
sub al, '0'
; shift the digit
shl al, 4
; store it
mov dh, al

; Read the second digit
mov ah, 01h
int 21h 

; Convert ASCII
sub al, '0'

; Combine the result
or dh, al

; Read the third digit
mov ah, 01h
int 21h

; Convert ASCII
sub al, '0'

; shift the digit
shl al, 4

; Combine the result
mov dl, al

; Read the fourth digit
mov ah, 01h
int 21h

; convert the ASCII 
sub al, '0'

; Combine the result
or dl, al
         
         ; FOR SECOND NUMBER
       
; Clear destination register
xor cx, cx

; Read the digit
mov ah, 01h
int 21h
; Now al has the ASCII, convert it
sub al, '0'
; shift the digit
shl al, 4
; store it
mov ch, al

; Read the second digit
mov ah, 01h
int 21h 

; Convert ASCII
sub al, '0'

; Combine the result
or ch, al

; Read the third digit
mov ah, 01h
int 21h

; Convert ASCII
sub al, '0'

; shift the digit
shl al, 4

; Combine the result
mov cl, al

; Read the fourth digit
mov ah, 01h
int 21h

; convert the ASCII 
sub al, '0'

; Combine the result
or cl, al

            ; ADDING THE NUMBERS
           
add dx, cx

; Store the final result in the variable
mov [result], dx

            ; DISPLAY
            
mov ax,[result] ; loading the variable
 mov ax, 0B800h
    mov es, ax
    xor di, 2000 ; Start writing at the center of the screen

    ; First digit
    mov ax, dx
    shr ax, 12 ; Isolate the first digit
    call DisplayHexDigit

    ; Second digit
    mov ax, dx
    shl ax, 4 ; Remove the first digit
    shr ax, 12 ; Isolate the second digit
    call DisplayHexDigit

    ; Third digit
    mov ax, dx
    shl ax, 8 ; Remove the first two digits
    shr ax, 12 ; Isolate the third digit
    call DisplayHexDigit

    ; Fourth digit
    mov ax, dx
    shl ax, 12 ; Remove the first three digits
    shr ax, 12 ; Isolate the fourth digit
    call DisplayHexDigit


    ; Terminate program
    mov ax, 4C00h
    int 21h  
    
    DisplayHexDigit proc
    ; Convert 4-bit value in AX to ASCII
    and ax, 0Fh ; Ensure it's only the last 4 bits
    cmp ax, 9
    jg .letter
    add al, '0' ; Convert 0-9 to '0'-'9'
    jmp .done
.letter:
    add al, 'A' - 10 ; Convert 10-15 to 'A'-'F'
.done:
    ; Display the character
    mov es:[di], al ; Write the ASCII character
    inc di
    mov es:[di], 07h ; Attribute byte (light grey on black)
    inc di
    ret
    
    DisplayHexDigit endp