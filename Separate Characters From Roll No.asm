.model small
.data
RNO db "L1F22BSCS0645$", '$'
alpha db 13 dup(?), '$'  ; Array for alphabets, ending with '$'
decimal db 13 dup(?), '$'  ; Array for decimals, ending with '$'

alphaIndex db 0  ; Index for next alphabet storage location
decimalIndex db 0  ; Index for next decimal storage location

.code
main PROC
    mov ax, @data
    mov ds, ax

    xor si, si  ; Source index for RNO

process_string:
    cmp si, 13  ; Process 13 characters
    jge end_processing

    mov al, [RNO + si]  ; Get the character

    cmp al, '9'
    jg its_letter

    ; Decimal processing
    mov bl, [decimalIndex]  ; Load current index for decimal array
    mov [decimal + bx], al  ; Store the character
    inc [decimalIndex]      ; Increment index
    jmp next_char

its_letter:
    ; Alphabet processing
    mov bl, [alphaIndex]  ; Load current index for alphabet array
    mov [alpha + bx], al  ; Store the character
    inc [alphaIndex]      ; Increment index

next_char:
    inc si  ; Move to the next character
    jmp process_string

end_processing:
    ; Program termination or next steps
    mov ax, 4C00h
    int 21h

main ENDP

