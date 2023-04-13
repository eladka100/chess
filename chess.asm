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

Bpawns db 000110b, 001110b, 010110b, 011110b, 100110b, 101110b, 110110b, 111110b
Brooks db 000111b, 111111b
Bknights db 001111b, 110111b
Bbishops db 010111b, 101111b
Bqueen db 011111b
Bking db 100111b

;promotions: 0 - pawn, 1 - rook, 2 - knight, 3 - bishop, 4 - queen


Wpromotions db 8 dup(00h)
Bpromotions db 8 dup (00h)
promotionSprites dw offset Spawn, offset Srook, offset Sknight, offset Sbishop, offset Squeen

WmovedTwice db 8 dup (00h)
BmovedTwice db 8 dup (00h)

Xp dw 0000h
Yp dw 0000h
color db 00h


;piece numbers: 0-7 - pawn, 8-9 - rook, A-B - knight, C-D - bishop, E - queen, F - king
;piece format: 1 2 3 4 (5 6 7 8)
;            	    /      |       
;               color  piece num
;  
piece db 00h
targetTile db 00h
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

	mov bh, 0
	mov bl, [piece]
	and bl, 0Fh
	cmp bl, 8 ; checks if it's a pawn
	jae dontMindPromotion
		mov al, [piece]
		and al, 10h
		shr al, 1
		add bl, al
		add bx, offset Wpromotions ; go to the correct pawn to view its promotion
		mov ax, [bx]
		shl ax, 1
		add si, ax
		mov si, [si] ; go to the correct sprite
	dontMindPromotion:
	
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

proc showGame
	call displayBoard
	mov [piece], 0
	showGameLoop:
		call paintPiece
		inc [piece]
		cmp [piece], 20h
		jb showGameLoop
	ret
endp showGame

proc emptyTile ; activates the zero flag if [tile] doesn't contain piece of ah color
	push ax
	push bx
	push cx
	push dx
	
	mov al, ah
	shl al, 4
	mov ah, 0
	mov bx, offset Wpawns
	add bx, ax
	mov cx, 0
	emptyTileLoop: ; loop through every piece of the color
		mov cl, [bx]
		cmp cl, [tile]
		je isntEmpty ; if the piece is on [tile] then the tile isnt empty
	inc bx
	inc ch
	cmp ch, 8
	jb emptyTileLoop
	
	mov ax, 0
	jmp emptyTileEnd
	isntEmpty:
		mov ax, 1
	emptyTileEnd:
	and ax, 1
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp emptyTile

proc LegalMovePawn
	push ax
	push bx
	push cx
	push dx
	
	cmp ch, dh
	jne notForward
		; the move is forward
		xor ah, 1
		call emptyTile 
		jnz isntLegalPawnHelp ; pawns can't eat forward
		xor ah, 1
		shl ah, 1
		add dl, ah
		dec dl ; white pawns walk upward and black pawns walk downward 
		cmp cx, dx
		je isLegalPawnHelp ; the move is one step toward the other side
		; the move is more than 1 step foward
		add dl, ah
		dec dl
		cmp cx, dx
		jne isntLegalPawnHelp ; the move is more than 2 steps forward
		add [tile], ah
		dec [tile]
		shr ah, 1
		call emptyTile
		jnz isntLegalPawn ; allay piece is in the way
		xor ah, 1
		call emptyTile
		jnz isntLegalPawn ; enemy piece is in the way
		xor ah, 1
		jz whitePawn 
			cmp cl, 6
			jne isntLegalPawn ; pawns can only move twice from starting position
			jmp isLegalPawn
		whitePawn:
			cmp cl, 1
			jne isntLegalPawn ; pawns can only move twice from starting position
			jmp isLegalPawn
	
	
	isLegalPawnHelp:
		jmp isLegalPawn
	isntLegalPawnHelp:
		jmp isntLegalPawn
	
		notForward:
			shl ah, 1
			add dl, ah
			dec dl
			cmp cl, dl
			jne isntLegalPawn ; the move isnt to the next row
			sub dh, ch
			cmp dh, 0
			jl PawnToLeft
				cmp dh, 1
				jne isntLegalPawn ; the move isnt to the file right from the pawn
				jmp legalMovePawnCon				
			PawnToLeft:
				cmp dh, -1
				jne isntLegalPawn ; the move isnt to the file left from the pawn
				jmp legalMovePawnCon
			
			legalMovePawnCon:
			shr ah, 1
			xor ah, 1
			call emptyTile
			jnz isLegalPawn ; pawns can move one squere diagonaly if there's an enemy there
			; now check for en passant
			mov bx, offset WmovedTwice
			shl ah, 3
			add bl, ah
			add bl, ch
			add bl, dh
			mov al, [bx]
			cmp al, 1
			jne isntLegalPawn ; the correct pawn didnt move twice before
			shr ah, 3
			xor ah, 1
			neg ah
			add ah, 4
			cmp cl, ah
			jne isntLegalPawn ; not near the en passant pawn
			je isLegalPawn ; it is en passant
		
	isntLegalPawn:
		mov ax, 1
		jmp legalMovePawnEnd
	isLegalPawn:
		mov ax, 0
	legalMovePawnEnd:
	and ax, 1
	pop dx
	pop cx
	pop bx
	pop bx
	ret
endp LegalMovePawn

proc LegalMoveRook
	push ax
	push bx
	push cx
	push dx
	
	cmp cl, dl
	je rookHorizontal
		; the move isnt horizonatl
		cmp ch, dh
		jne isntLegalRook ; the move is not straight
		; the move is vertical
		cmp cl, dl
		jb rookUp
			; the move is down
			mov bl, 1
			mov bh, cl
			sub bh, dl
			jmp legalMoveRookCon
		rookUp:
			; the move is up
			mov bl, -1
			mov bh, dl
			sub bh, cl
			jmp legalMoveRookCon
	rookHorizontal:
		cmp ch, dh
		jb rookRight
			; the move is left
			mov bl, 8
			mov bh, ch
			sub bh, dh
			jmp legalMoveRookCon
		rookRight:
			; the move is right
			mov bl, -8
			mov bh, dh
			sub bh, ch
			jmp legalMoveRookCon
			
	legalMoveRookCon:
	; now adding bl to [tile] move tile towards the piece's position 
	; and bh is the number of times it needed to be added so that [tile] is the piece's tile
	rookLoop:
		add [tile], bl
		dec bh
		cmp bh, 0
		je isLegalRook ; the loop ended in success because tile reached thh piece
		mov ah, 0
		call emptyTile
		jnz isntLegalRook ; something white is in the way
		mov ah, 1
		call emptyTile
		jnz isntLegalRook ; something black is in the way
		jmp rookLoop
	
	isntLegalRook:
		mov ax, 1
		jmp legalMoveRookEnd
	isLegalRook:
		mov ax, 0
	legalMoveRookEnd:
	and ax, 1
	pop dx
	pop cx
	pop bx
	pop bx
	ret
endp LegalMoveRook

proc LegalMoveKnight
	push ax
	push bx
	push cx
	push dx
	
	; basically check the distance from the piece to the target tile using pythagoras's theorem
	sub cl, dl
	sub ch, dh
	mov al, cl
	imul cl
	mov bx, ax
	mov al, ch
	imul ch
	add bx, ax
	cmp bx, 5
	je isLegalKnight
	
	isntLegalKnight:
		mov ax, 1
		jmp legalMoveKnightEnd
	isLegalKnight:
		mov ax, 0
	legalMoveKnightEnd:
	and ax, 1
	pop dx
	pop cx
	pop bx
	pop bx
	ret
endp LegalMoveKnight

proc LegalMoveBishop
	push ax
	push bx
	push cx
	push dx
	
	sub cl, dl
	sub ch, dh
	mov ah, 0
	mov al, cl
	idiv ch
	cmp ax, 1
	je bishopUp
		; the move isnt the / diagonal
		cmp ax, 00FFh
		jne isntLegalBishop ; the move is not a diagonal
		; the move is the \ diagonal
		cmp cl, 0
		jl bishopDownRight
			; the move is up left
			mov bl, 7
			mov bh, cl
			jmp legalMoveBishopCon
		bishopDownRight:
			; the move is down right
			mov bl, -7
			mov bh, cl
			neg bh
			jmp legalMoveBishopCon
	bishopUp:
		; the move is the / diagonal
		cmp cl, 0
		jl bishopUpRight
			; the move is down left
			mov bl, 9
			mov bh, cl
			jmp legalMoveBishopCon
		bishopUpRight:
			; the move is up right
			mov bl, -9
			mov bh, cl
			neg bh
			jmp legalMoveBishopCon
			
	legalMoveBishopCon:
	; now adding bl to [tile] move tile towards the piece's position 
	; and bh is the number of times it needed to be added so that [tile] is the piece's tile
	bishopLoop:
		add [tile], bl
		dec bh
		cmp bh, 0
		je isLegalBishop ; the loop ended in success because tile reached thh piece
		mov ah, 0
		call emptyTile
		jnz isntLegalBishop ; something white is in the way
		mov ah, 1
		call emptyTile
		jnz isntLegalBishop ; something black is in the way
		jmp bishopLoop
	
	isntLegalBishop:
		mov ax, 1
		jmp legalMoveBishopEnd
	isLegalBishop:
		mov ax, 0
	legalMoveBishopEnd:
	and ax, 1
	pop dx
	pop cx
	pop bx
	pop bx
	ret
endp LegalMoveBishop

proc LegalMoveQueen
	push ax
	push bx
	push cx
	push dx
	
	mov al, [tile]
	push ax
	call LegalMoveBishop
	jz isLegalQueen ; the queen moves diagonally
	pop ax
	mov [tile], al
	call isLegalRook
	jz isLegalQueen ; the queen moves in straight lines
	
	isntLegalQueen:
		mov ax, 1
		jmp legalMoveQueenEnd
	isLegalQueen:
		mov ax, 0
	legalMoveQueenEnd:
	and ax, 1
	pop dx
	pop cx
	pop bx
	pop bx
	ret
endp LegalMoveQueen

proc LegalMoveKing
	push ax
	push bx
	push cx
	push dx
	
	sub cl, dl
	sub ch, dh
	cmp cl, 1
	jg isntLegalKing ; the move is too down
	cmp cl, -1
	jl isntLegalKing ; th move is too up
	cmp ch, 1
	jg isntLegalKing ; the move is too left
	cmp ch, -1
	jl isntLegalKing ; th move is too right
	jmp isLegalKing
	
	isntLegalKing:
		mov ax, 1
		jmp legalMoveKingEnd
	isLegalKing:
		mov ax, 0
	legalMoveKingEnd:
	and ax, 1
	pop dx
	pop cx
	pop bx
	pop bx
	ret
endp LegalMoveKing

proc legalMove ; activates the zero flag if the move of [piece] to [tile] is legal
	push ax
	push bx
	push cx
	push dx
	mov al, [targetTile]
	mov [tile], al
	
	mov ah, 0
	mov al, [piece]
	mov bx, offset Wpawns
	add bx, ax 
	mov ah, al
	and al, 0Fh
	shr ah, 6
	; al is the piece and ah is the color of the piece
	
	mov dl, [bx]
	and dl, 40h
	jnz legalMoveHelp ; if the piece is eaten then the move isn't legal
	
	mov cl, [bx]
	mov ch, [bx]
	shr ch, 3
	and cl, 7
	; ch is file of piece and cl is row of [piece]
	mov dl, [tile]
	mov dh, [tile]
	shr dh, 3
	and dl, 7
	; dh is file of piece and dl is row of [tile]
	
	call emptyTile
	legalMoveHelp:
	jnz isntLegal ; if [tile] has a piece of the same color then the move is ilegal
	
	cmp al, 08h
	jae notPawn
		; the piece is a pawn or a promoted pawn
		mov bx, 0
		mov bl, ah
		shl bl, 3
		add bl, al
		add bx, offset Wpromotions
		mov bl, [bx]
		cmp bl, 1
		je isRook
		cmp bl, 2
		je isKnight
		cmp bl, 3
		je isBishop
		cmp bl, 4
		je isQueen
		; the piece is an unpromoted pawn
		call LegalMovePawn
		jz isLegal
		jnz isntLegal
	
	notPawn:
	cmp al, 0Ah
	jae notRook
	isRook:
		call LegalMoveRook
		jz isLegal
		jnz isntLegal
	notRook:
	cmp al, 0Ch
	jae notKnight
	isKnight:
		call LegalMoveKnight
		jz isLegal
		jnz isntLegal
	notKnight:
	cmp al, 0Eh
	jae notBishop
	isBishop:
		call LegalMoveBishop
		jz isLegal
		jnz isntLegal
	notBishop:
	cmp al, 0Fh
	je isKing
	isQueen: 
		call LegalMoveQueen
		jz isLegal
		jnz isntLegal
	isKing:
		call LegalMoveKing
		jz isLegal
		jnz isntLegal
	
	
	
	isntLegal:
		mov ax, 1
		jmp legalMoveEnd
	isLegal:
		mov ax, 0
	legalMoveEnd:
	and ax, 1
	pop dx
	pop cx
	pop bx
	pop ax
	ret
	
endp legalMove

start:
	mov ax, @data
	mov ds, ax
	
	mov ax, 13h
	int 10h ; go to graphic mode
	
	
	mov [Wknights], 010010b
	call showGame
	
	mov [piece], 10
	mov [targetTile], 011100b
	call legalMove
	jnz exit
	mov [Xp], 10
	mov [Yp], 10
	mov [color], 03h
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