.MODEL SMALL
.DATA
    MSG DB "My Name is Yahya$"
    LENGTH_MSG DB "The length of the given string is $"
    
    result dw 0

.CODE
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Call subroutine to calculate length
    CALL Length
    mov [result], cx     

    ; Set cursor position to row 20, column 50
    MOV DH, 20
    MOV DL, 50
    MOV BH, 0
    MOV AH, 02h
    INT 10h

    ; Display length message
    MOV AH, 09h
    MOV DX, OFFSET LENGTH_MSG
    INT 21h

    ; Displaying the variable containing result
    
    ; Load the content
    mov ax, [result]
    
    ; isolate the first digit
    shr ax, 12
    
    ;display it
    call ConvertAndDisplay
    
    ; load the content again
    mov ax, [result]
    
    ; isolate the second digit
    shl ax, 4
    shr ax, 12
    
    ; display it
    call ConvertAndDisplay
    
    ; load the content again
    mov ax, [result]
    
    ;isolate the third digit
    shl ax, 8
    shr ax, 12
    
    ;display it
    call ConvertAndDisplay
    
    ;load the content again
    mov ax, [result]
    
    ;isolate the 4th digit
    shl ax, 12
    shr ax, 12
    
    ;display it
    call ConvertAndDisplay
    
    mov ax, 4ch 
    INT 21h

; Subroutine to calculate length of the string
Length PROC
    MOV SI, 0          ; String index
    MOV CX, 0          ; Length counter

CALC_LENGTH_LOOP:
    MOV AL, [MSG + SI] ; Load character
    CMP AL, '$'        ; Check end of string
    JE CALC_LENGTH_DONE
    CMP AL, ' '        ; Check space
    JE SKIP
    INC CX             ; Increment length
SKIP:
    INC SI             ; Move to next character
    JMP CALC_LENGTH_LOOP

CALC_LENGTH_DONE:

    RET
Length ENDP

; Subroutine to convert number to ASCII and display
ConvertAndDisplay PROC
    CMP AL, 9
    JG IsLetter
    ADD AL, '0'        ; Convert to ASCII number
    JMP Display
IsLetter:
    ADD AL, 'A' - 10        ; Convert to ASCII letter (A-F)
Display:
    MOV DL, AL
    MOV AH, 02h ; Interrupt to write a character to output screen
    INT 21h
    RET
ConvertAndDisplay ENDP