IDEAL
MODEL small
STACK 100h
DATASEG

; piece sprite format: t - transparent, b - border, a - inside

Spawn db "tttttttttttttttt"
	  db "ttttttbbbbtttttt"
	  db "tttttbaaaabttttt"
	  db "tttttbaaaabttttt"
	  db "ttttttbaabtttttt"
	  db "ttttttbaabtttttt"
	  db "ttttttbaabtttttt"
	  db "ttttttbaabtttttt"
	  db "ttttttbaabtttttt"
	  db "ttttttbaabtttttt"
	  db "ttttttbaabtttttt"
	  db "tttbbbbbbbbbbttt"
	  db "ttbaaaaaaaaaabtt"
	  db "ttbbbbbbbbbbbbtt"
	  db "tttttttttttttttt"

Srook db "tttttttttttttttt"
	  db "ttttbbtbbtbbtttt"
	  db "tttbaabaabaabttt"
	  db "tttbaabaabaabttt"
	  db "tttbaaaaaaaabttt"
	  db "ttttbbaaaabbtttt"
	  db "tttttbaaaabttttt"
	  db "tttttbaaaabttttt"
	  db "tttttbaaaabttttt"
	  db "tttttbaaaabttttt"
	  db "tttttbaaaabttttt"
	  db "tttbbbbbbbbbbttt"
	  db "ttbaaaaaaaaaabtt"
	  db "ttbbbbbbbbbbbbtt"
	  db "tttttttttttttttt"

Sknight db "tttttttttttttttt"
		db "tttttttbbbtttttt"
		db "ttttttbaaabttttt"
		db "tttttbaaaaabtttt"
		db "tttttbaaaaaabttt"
		db "tttttbaaaaaabttt"
		db "tttttbaabbbbbttt"
		db "tttttbaabttttttt"
		db "tttttbaaabtttttt"
		db "tttttbaaabtttttt"
		db "tttttbaaaabttttt"
		db "tttttbaaaabttttt"
		db "tttbbbbbbbbbbttt"
		db "ttbaaaaaaaaaabtt"
		db "ttbbbbbbbbbbbbtt"
		db "tttttttttttttttt"

Sbishop db "tttttttttttttttt"
		db "tttttttbbttttttt"
		db "ttttttbaabtttttt"
		db "tttttbaaaabttttt"
		db "ttttbaaaababtttt"
		db "ttttbaaabaabtttt"
		db "ttttbbaaaabbtttt"
		db "tttttbaaaabttttt"
		db "tttttbaaaabttttt"
		db "tttttbaaaabttttt"
		db "tttttbaaaabttttt"
		db "tttbbbbbbbbbbttt"
		db "ttbaaaaaaaaaabtt"
		db "ttbbbbbbbbbbbbtt"
		db "tttttttttttttttt"
		
Squeen db "tttttttttttttttt"
	   db "tttttttttttttttt"
	   db "tttttttbbttttttt"
	   db "ttbttttbbttttbtt"
	   db "tbabttbaabttbabt"
	   db "tbabttbaabttbabt"
	   db "tbaabtbaabtbaabt"
	   db "ttbabtbaabtbabtt"
	   db "ttbaabbaabbaabtt"
	   db "tttbaabaabaabttt"
	   db "tttbaabaabaabttt"
	   db "ttttbabaababtttt"
	   db "tttbbbbbbbbbbttt"
	   db "ttbaaaaaaaaaabtt"
	   db "ttbbbbbbbbbbbbtt"
	   db "tttttttttttttttt"
	   
Sking db "tttttttttttttttt"
	  db "tttttttbbttttttt"
	  db "ttttttbbbbtttttt"
	  db "tttttttbbttttttt"
	  db "ttttbbtbbtbbtttt"
	  db "tttbaabbbbaabttt"
	  db "tttbaaaaaaaabttt"
	  db "tttbaaaaaaaabttt"
	  db "tttbaaaaaaaabttt"
	  db "ttttbaaaaaabtttt"
	  db "ttttbaaaaaabtttt"
	  db "tttttbaaaabttttt"
	  db "tttbbbbbbbbbbttt"
	  db "ttbaaaaaaaaaabtt"
	  db "ttbbbbbbbbbbbbtt"
	  db "tttttttttttttttt"

	   
		
sprites dw 8 dup(offset Spawn), 2 dup(offset Srook), 2 dup(offset Sknight), 2 dup(offset Sbishop), offset Squeen, offset Sking

;piece pos format: 1  2 (3 4 5) (6 7 8)
;            	     /     |       | 
;                 eaten   file    row
;             

Wpawns db 000001b, 001001b, 010001b, 011001b, 100001b, 101001b, 110001b, 111001b
Wrooks db 000000b, 111000b
Wknights db 001000b, 110000b
Wbishops db 010000b, 101000b
Wqueen db 011000b
Wking db 100000b

Bpawns db 000110b, 001110b, 010110b, 011110b, 100110b, 101110b, 110110b, 1110110b
Brooks db 000111b, 111111b
Bknights db 001111b, 110111b
Bbishops db 010111b, 101111b
Bqueen db 011111b
Bking db 100111b

Xp dw 0000h
Yp dw 0000h
color db 00h


CODESEG

proc putPixel ; put a pixel of color [color] at ([Xp], [Yp])
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


proc displayBoard ; displays the chess board (without the pieces)
	push ax
	push bx
	push cx
	push dx
	
	mov ax, 96
	mov bx, 36
	displayBoardTileLoop: ; loops through each tile
			mov [Xp], ax
			mov [Yp], bx
			mov cx, ax
			add cx, bx
			sub cx, 132
			and cx, 10000b ;checks if its a black or white tile	
			mov cx, 0
			mov dx, 0
			jz whiteTile
				mov [color], 16h ; it's black
				jmp displayBoardPaintLoop
			whiteTile:
				mov [color], 0Fh ; it's white
			
			displayBoardPaintLoop: ;loops through each pixel
					call putPixel
				inc cx
				inc [Xp]
				cmp cx, 16
				jb displayBoardPaintLoop
			mov cx, 0
			mov [Xp], ax
			inc dx
			inc [Yp]
			cmp dx, 16
			jb displayBoardPaintLoop
		add ax, 16
		cmp ax, 224
		jb displayBoardTileLoop
	mov ax, 96
	add bx, 16
	cmp bx, 164
	jb displayBoardTileLoop
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp displayBoard

proc background ; paint the background pattern
	push ax
	push bx
	push cx
	push dx
	
	mov [Xp], 0
	mov [Yp], 0
	backgroundLoop:
			mov ax, [Yp]
			shr ax, 2
			add ax, [Xp]
			and ax, 1b
			jz green
				mov [color], 06h
				jmp backgroundCon
			green:
				mov [color], 02h
			backgroundCon:
			call putPixel
			inc [Yp]
			call putPixel
			inc [Yp]
			call putPixel
			inc [Yp]
			call putPixel
			sub [Yp], 3
		inc [Xp]
		cmp [Xp], 320
		jb backgroundLoop
	mov [Xp], 0
	add [Yp], 4
	cmp [Yp], 200
	jb backgroundLoop
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp background



start:
	mov ax, @data
	mov ds, ax
	
	mov ax, 13h
	int 10h ; go to graphic mode
	
	call background
	call displayBoard

exit:
	mov ah, 00h
	int 16h
	
	
	mov ah, 0
	mov al, 2
	int 10h ; back to text mode
	mov ax, 4c00h
	int 21h;
END start