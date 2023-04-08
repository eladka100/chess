IDEAL
MODEL small
STACK 100h
DATASEG

;piece pos format: (1 2) (3 4 5) (6 7 8)
;            		/       |       | 
;           pawn promotion file    row
;

Wpawns db 000001b, 001001b, 010001b, 011001b, 100001b, 101001b, 110001b, 111001b
Wrooks db 000000b, 111000b
Wknites db 001000b, 110000b
Wbishops db 010000b, 101000b
Wqueen db 011000b
Wking db 100000b

Bpawns db 000110b, 001110b, 010110b, 011110b, 100110b, 101110b, 110110b, 1110110b
Brooks db 000111b, 111111b
Bknites db 001111b, 110111b
Bbishops db 010111b, 101111b
Bqueen db 011111b
Bking db 100111b

Xp dw 0000h
Yp dw 0000h
color db 00h

CODESEG

proc putPixel
	push ax
	push bx
	push cx
	push dx
	
	mov bh, 0h
	mov cx, [Xp]
	mov dx, [Yp]
	mov al, [color]
	mov ah, 0ch
	int 10h
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp putPixel





start:
	mov ax, @data
	mov ds, ax
	
	mov ax, 13h
	int 10h ; go to graphic mode
	
	mov [Xp], 160
	mov [Yp], 100
	mov [color], 28h
	
	call putPixel

exit:
	mov ah, 00h
	int 16h
	
	
	mov ah, 0
	mov al, 2
	int 10h ; back to text mode
	mov ax, 4c00h
	int 21h;
END start