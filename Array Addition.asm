.model small
.stack
.data
; Size of word is 2bytes = 16bits
arr dw 1h,54h,55h,76h,8h
arr1 dw 5h,2h,6h,7h,10h
arr2 dw 5 dup(0)
.code          
mov ax,@data
mov ds,ax

mov si,0
mov di,8
mov cx,5  

l1:
mov ax,ds:[arr+si]    ; Loading elements
mov dx,ds:[arr1+di]   ; from arrays
add ax,dx
mov ds:[arr2+si],ax
add si, 2 ; To access the next element increment by 2 since each
          ; content stored is 2 bytes
sub di, 2 ; Same logic here
loop l1

.exit