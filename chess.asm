IDEAL
MOODEL small
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

CODESEG





start:
	mov ax, @data
	mov ds, ax
	
	
	

exit:
	mov ax, 4c00h
	int 21h;
END start