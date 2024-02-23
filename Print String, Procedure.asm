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

             ; storing a sequence of characters
             ; in 'string' label with and a character
             ; of our choice (0 recommended) to let 
             ; know that here is where the string ends
string db "Yahya$"


.code
    
    ; initializing data segment to get
    ; the 'string' from the data segment
    mov ax, @data
    mov ds, ax
              
              
    ; getting the address (where the string
    ; is present) in the data segment
    mov bx, offset string
    
    call PrintString       
              
    ; Terminate program
    mov ax, 4C00h
    int 21h
    
    PrintString proc
        
        ;initializing Video Memory
        mov ax, 0xb800
        mov es, ax
        
        ; initializing source index iterator
        mov si, 0
        
        ; initializing destination index iterator
        ; this can point to anywhere on the Video Memory
        mov di, 2 * (24 * 80 + 75)
   DISPLAY:     
        ; storing the character (the first character content under
        ; address bx + si into the AL register)
        ; Using AL since we used DB which means each character is of
        ; 1 Byte
        
        mov al, [bx + si]       
        
        ; Checking if the character is null 
        ; if yes then end the program
        ; if not then continue
        cmp al, '$'
        je DONE          
        
        ; Printing the character to the Video Memory
        mov es:[di], al
        inc di
        mov es:[di], 11100100b
        
        ; incrementing to print to the next location of  video memory
        inc di
        
        ; Incrementing by 1 byte to get the next character that
        ; is the next byte in the string
        inc si
        
        jmp DISPLAY
        
        DONE:
        ret
        
PrintString endp