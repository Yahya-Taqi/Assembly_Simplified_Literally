.model small
.stack 100h

.data
    message db "Interrupt 0x65 Hooked!$"

.code
    mov ax, @data
    mov ds, ax

    ; Set the new interrupt vector for 0x65
    mov ax, 0               ; Segment address of the interrupt vector table
    mov es, ax
    mov bx, 4 * 65h         ; Calculate vector address for interrupt 0x65
    mov word ptr es:[bx], offset my_interrupt_handler ; Set offset of handler
    mov word ptr es:[bx + 2], seg my_interrupt_handler ; Set segment of handler

    ; Trigger interrupt 0x65
    int 65h

    ; Exit program
    mov ax, 4C00h
    int 21h

; Custom interrupt handler
my_interrupt_handler proc

    mov dx, offset message  ; Point DX to the message
    mov ah, 09h             ; Function 9: Write string to standard output
    int 21h                 ; Call DOS interrupt
    ret                    ; Return from interrupt
my_interrupt_handler endp
