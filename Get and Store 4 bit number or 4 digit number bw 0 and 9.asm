; This program gets a number upto 4 digits and store it in DX register

; STEPS TO READ 1 DIGIT AND STORE IT
; 1. Clear the storage register.
; 2. Use 'mov ah, 01h' and 'int 21h' to read a character
; 3. Now you have the ASCII of the entered character
; 4. Convert ASCII to it's value which is the actual number by 'sub al, '0''
;considering al has the entered character ASCII
; 5. Shift the character 4 bits left (the first and 3rd) see reason below.
; 6. Store the result in the destination register.


.model small
.stack 100h
.data
.code

    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Clear DX register to store the result
    xor dx, dx

    ; Set up for input function
    mov ah, 01h ; Function 01h reads a character from standard input, with echo

    ; Read first digit
    int 21h      ; AL will contain the ASCII value of the character
    sub al, '0'  ; Convert ASCII to its actual numerical value
    ; Since we want to store the result as a simple number digit (0-9),
    ; and each digit in AL is already in a number (0-9) form,
    ; we can directly move it after shifting it left by 4 bits
    ; (to make space for the next digit)
    shl al, 4
    mov dh, al   ; Store the result in DH

    ; Read second digit
    int 21h      
    ; Here AL will have the entered digit
    sub al, '0'  ; Convert ASCII value into actual number
    or dh, al    ; Combine the second digit with the first one in DH

    ; Read third digit
    int 21h
    ; Here AL will have the entered digit
    sub al, '0'  ; Convert ASCII value into actual number
    shl al, 4    ; Shift the number 4 bits to make room for the other digit
                 ; Debug the program for clarification
    mov dl, al   ; Store the third digit in DL

    ; Read fourth digit
    int 21h
    sub al, '0'  ; Convert ASCII value to actual number
    or dl, al    ; Combine the fourth digit with the third one in DL

    ; At this point, DX contains the 4-digit or 4-bit number

    ; Exit program
    mov ax, 4c00h
    int 21h