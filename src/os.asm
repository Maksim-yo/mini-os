org 0x7000
mov ax, 4
mov bx, 1
add bx, ax
mov al, bl

; print the number
mov ah, 0x0e
add al, 48
int 0x10
hlt

times 510-($-$$) db 0
dw 0xaa55