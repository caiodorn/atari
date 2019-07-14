	PROCESSOR 6502

	SEG code
	ORG $F000	; define the code origin $F000

Start:
	SEI			; disable interrupts -- always do this by default
	CLD			; disable the BCD decimal math mode
	LDX #$FF	; loads X register with $FF
	TXS 		; transfer X register to s(S register) stack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Zero Page region ($00 to $FF)
; Meaning the entire TIA register space and also RAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	LDA #0		; A = 0
	LDX #$FF	; X = #$FF

MemLoop:
	STA $0,X	; store zero at address $0 + X
	DEX			; x--
	BNE MemLoop ; loop until x==0 (z-flag set)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	ORG $FFFC
	.word Start	; reset vector at $FFFC
	.word Start ; interrupt vector at $FFFE (unused in VCS)
	
