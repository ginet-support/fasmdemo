; flat assembler 1.72 windows
; AUTHOR Noam Kloos

include 'win64axp.inc' ; also win64wxp messed up output (wide character)

;macro CRLF {13,10} ; NO EVAL
define CRLF 13,10

struct text
tex1	TCHAR	'Amiga Rulez'
tex2	TCHAR	'!'
tex3	TCHAR	CRLF
tex4	TCHAR	"The 80's were the times ",'"digital"',' watches were cool.',CRLF
ends

.code
  start:
; make your choice here
	mov [varlen],textlen-amiga
	lea rax,[message+amiga]
	mov [pointer],rax
	mov rax,[varlen]
	mov [tlen],rax
; make use of pointers

	display "main",CRLF
	invoke	AllocConsole
	; check argument types of writeconsole
	invoke	WriteConsole, \
	<invoke GetStdHandle,STD_OUTPUT_HANDLE>,[pointer],[tlen],dummy,0
	; use [pointer] instead of pointer
	invoke	Sleep,10000
;	 invoke ClearScreen
;	 invoke sleep,5000
	invoke	ExitProcess,0
.end start

.data

display "data",CRLF

message TCHAR 'Amiga Rulez!',CRLF,"The 80's were the times ", \
	   '"digital"',' watches were cool.',CRLF
label textlen at $ - message

dreams TCHAR 'Surely you must have dreams?',CRLF
label dreamlen at $ - dreams
; label textlen at $+8 - message ; shows all but in wrong order

blocklen = textlen + dreamlen
;need to create buffer and copy two arrays into it

dummy rd 1
amiga = 14
varlen dq amiga
textt = message
tlen dq ?
pointer dq ?

label pointerl at message ; how do i do this in code segment?

; need to understand memory management

texi text
label structlen at $ - texi ; this works fine

