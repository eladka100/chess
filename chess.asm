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

	   
		
sprites dw 8 dup(offset promotionSprites), 2 dup(offset Srook), 2 dup(offset Sknight), 2 dup(offset Sbishop), offset Squeen, offset Sking

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

;promotions: 0 - pawn, 1 - rook, 2 - knight, 3 - bishop, 4 - queen


Wpromotions db 8 dup(00h)
Bpromotions db 8 dup (00h)
promotionSprites dw offset Spawn, offset Srook, offset Sknight, offset Sbishop, offset Squeen

Xp dw 0000h
Yp dw 0000h
color db 00h


;piece numbers: 0-7 - pawn, 8-9 - rook, A-B - knight, C-D - bishop, E - queen, F - king
;piece format: 1 2 3 4 (5 6 7 8)
;            	    /      |       
;               color  piece num
;  
piece db 00h
tile db 00h


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
				mov [color], 00h ; it's black
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

proc paintPiece
	push ax
	push bx
	push cx
	push dx
	push si
	
	mov ah, 0
	mov al, [piece]
	and al, 0Fh ; only look at the piece itself and not the color
	shl al, 1
	add ax, offset sprites
	mov si, ax
	mov si, [si] ; go to the start of the correct sprite
	
	mov bh, 0
	mov bl, [piece]
	add bx, offset Wpawns
	mov al, [bx]
	
	push ax
	and al, 40h
	pop ax
	jnz paintPieceHelp; the piece is eaten and so it won't be painted
	
	mov [tile], al

	
	
	
	mov ah, 0
	mov al, [tile]
	shr ax, 3 ; only look at the file
	shl ax, 4 ; multiply by 16 because the tile size is 16 px
	add ax, 96 ; add the offset of the board
	mov [Xp], ax ; this is the X coordinate of the left corner of the piece
	mov cx, ax ; save the X coordinate
	
	mov ah, 0
	mov al, [tile]
	and ax, 7 ; look at the row
	shl ax, 4 ; multiply by 16 because the tile size is 16 px
	neg ax ; the rows are in bottom to top but the coordinates are from top to bottom
	add ax, 148 ; add the offset of the board
	mov [Yp], ax ; this is the Y coordinate of the left corner of the piece
	
	
	mov ax, 0
	paintPieceLoop:
			mov dl, [si]
			cmp dl, 't'
			je paintPieceCon ; if pixel should be transparent then don't do anything
			
			cmp dl, 'b'
			jne insidePiece ; if it's a pixel in the border of the piece
				mov [color], 16h
				call putPixel
				jmp paintPieceCon
	
	paintPieceHelp:
	jmp paintPieceEnd
	
	
			insidePiece: ; if it's a pixel in the inside of the piece
				mov bl, [piece]
				and bl, 10h ; check if the piece is white or black
				jz whitePiece
					mov [color], 00h
					call putPixel
					jmp paintPieceCon
				whitePiece:
					mov [color], 0Fh
					call putPixel
					jmp paintPieceCon
			
			paintPieceCon:
			inc si
			inc [Xp]
			inc al
			cmp al, 16
			jb paintPieceLoop
		mov [Xp], cx
		mov al, 0
		inc [Yp]
		inc ah
		cmp ah, 16
		jb paintPieceLoop
					
	
	paintPieceEnd:
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp paintPiece

start:
	mov ax, @data
	mov ds, ax
	
	mov ax, 13h
	int 10h ; go to graphic mode
	
	call background
	call displayBoard
	
	mov [piece], 0Eh
	call paintPiece
	
	

exit:
	mov ah, 00h
	int 16h
	
	
	mov ah, 0
	mov al, 2
	int 10h ; back to text mode
	mov ax, 4c00h
	int 21h;
END start