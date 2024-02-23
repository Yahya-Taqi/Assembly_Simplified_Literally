; Initialize Data Segment
; Initialize Extra Segment with 0
; Calculate interrupt vector address by multiplying the interrupt
;number with 4
; Set offset and seg of interrupt handeler proc
; Trigger the interrupt
; Do not for get to write the interrupt handler proc

.model small
.stack 100h
.data

msg db "HAha nope$"

.code

mov ax, @data
mov ds, ax

mov ax, 0
mov es, ax
; Setting interrupt 0h or 0x00
mov bx, 4 * 0x00

mov word ptr es:[bx], offset interrupt_handler
mov word ptr es:[bx + 2], seg interrupt_handler

int 0x00 

mov ax, 4Ch
int 21h

interrupt_handler proc
    mov dx, offset msg
    mov ah, 09h
    int 21h
    ret
interrupt_handler endp