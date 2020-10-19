include Irvine32.inc

cls PROTO C
checkLogin PROTO C username:DWORD, password: DWORD
checkRanking PROTO C
addRanking PROTO C user:DWORD, correctCount : DWORD, totalQuest : DWORD, level : DWORD
getRemainder PROTO C, remain : DWORD

mWrite MACRO text
LOCAL string
.data
string BYTE text, 0
.code
push edx
mov  edx, OFFSET string
call WriteString
pop edx
ENDM

mWriteLn MACRO text
mWrite text
call crlf
ENDM

mWriteChar MACRO char
push eax
mov al, char
call WriteChar
pop eax
ENDM


validation MACRO maxOpt
.code
pushad
XOR EAX, EAX
.REPEAT
call ReadInt
mov selectedOpt, eax
mov ebx, maxOpt
.IF selectedOpt < 1 || selectedOpt > ebx
mWrite "Invalid Option! Please select 1 to "
mov eax, ebx
call writeDec
mWrite " : "
.ENDIF
.UNTIL selectedOpt > 0 && selectedOpt <= ebx
mov  selectedOpt, eax
popad
ENDM

.DATA
MAX = 100
userenter BYTE MAX + 1 DUP(? )
userenter2 BYTE MAX + 1 DUP(? )
stringIn BYTE MAX + 1 DUP(? )
username BYTE "user", 0
password BYTE "password", 0

correct1 BYTE  "     _    _  ____  _      ____  _____  __  _  ____", 0AH, 0DH, 0
correct2 BYTE  "    / \  / \/  _/ / \    /   _\/  _  \/  \/ |/   _/", 0AH, 0DH, 0
correct3 BYTE  "    | |  | ||  \  | |    |  /  | / \ || |\/|||  \  ", 0AH, 0DH, 0
correct4 BYTE  "    | |/\| ||  /_ | |__/\|  \__| \ / || |  |||  /_ ", 0AH, 0DH, 0
correct5 BYTE  "    \_/  \_/\____\\_____/\____/\ ___ /\_|  \|\____\",0AH,0DH,0

selectedOpt DWORD ?

promptBad BYTE "Invalid input, please enter again: ", 0


secondDecimal		DWORD ?
ynOption			DWORD ?
menuSelected		DWORD ?
levelSelected		DWORD ?
range				DWORD ?
ranNum				DWORD ?
ranNum1				DWORD ?
ranNum2				DWORD ?
correctAnswer		DWORD ?
userAnswer			DWORD ?
remainder			DWORD ?
MAX_NO_QUEST		DWORD 3
currentQuest		DWORD 1
result				DWORD ?
countCorrect		DWORD ?
remain				DWORD ?
tmpDwordToByte		DWORD ?
valid				DWORD ? ;check login validation from c function, 1 is valid
bufsize = ($ - stringIn)

printArithmetic MACRO menuSelected
.code
INVOKE cls
.IF menuSelected == 1
mWriteLn " ----------"
mWriteLn "| Addition |"
mWriteLn " ----------"
.ELSEIF menuSelected == 2
mWriteLn " -------------"
mWriteLn "| Subtraction |"
mWriteLn " -------------"
.ELSEIF menuSelected == 3
mWriteLn " ----------------"
mWriteLn "| Multiplication |"
mWriteLn " ----------------"
.ELSE
mWriteLn " ----------"
mWriteLn "| Division |"
mWriteLn " ----------"
.ENDIF
call crlf
ENDM

tmp2 BYTE ?
resultStr1 BYTE ?
resultStr2 DWORD ?

.CODE

MATH_QUIZ PROC C
mov valid, 1
login :
	invoke cls
	mov eax, black + (white * 16)
	call SetTextColor
	invoke cls
	mWriteLn " MATH QUIZ"
	mWriteLn "  -------"
	mWriteLn " | Login |"
	mWriteLn "  -------"
	.IF valid == 0
		mov eax, lightRed + (white * 16)
		call SetTextColor
		mWriteln " Wrong username or wrong password!"
	.ENDIF
	mov eax, black + (white * 16)
	call SetTextColor
	call crlf

	mWrite " Username : "
	mov  edx, OFFSET userenter
	mov  ecx, MAX
	call ReadString
	mWrite " Password : "
	mov eax, white + (white * 16)
	call SetTextColor
	mov  edx, OFFSET userenter2
	mov  ecx, MAX
	call ReadString

	pushad
	mov eax, OFFSET userenter
	mov ebx, OFFSET userenter2
	invoke checkLogin, eax, ebx
	mov valid, eax
	popad
	cmp valid, 1
	je validUser
	jne login

validUser :
	call crlf
	mov edx, OFFSET userenter
	call writestring

	mov eax, black + (white * 16)
	call SetTextColor
	call crlf
	mov eax, magenta + (white * 16)
	call SetTextColor
	mov edx, OFFSET correct1
	call WRITESTRING
	mov edx, OFFSET correct2
	call WRITESTRING
	mov eax, red + (white * 16)
	call SetTextColor
	mov edx, OFFSET correct3
	call WRITESTRING
	mov edx, OFFSET correct4
	call WRITESTRING
	mov eax, lightred + (white * 16)
	call SetTextColor
	mov edx, OFFSET correct5
	call WRITESTRING

	call crlf
	mov eax, black + (white * 16)
	call SetTextColor
	call Waitmsg
	jmp menu

menu :	
	INVOKE cls
	mov eax,black+(white*16)
	call SetTextColor
	mWriteLn " ======"
	mWriteLn "| Menu |"
	mWriteLn " ======"
	mov eax,red+(white*16)
	call SetTextColor
	mWriteLn "(1) Addition"
	mWriteLn "(2) Subtraction"
	mWriteLn "(3) Multiplication"
	mWriteLn "(4) Division"
	mWriteLn "(5) Top Ranking"
	mWriteLn "(6) EXIT PROGRAM"
	call crlf
	mov eax,green+(white*16)
	call SetTextColor
	mWrite "Select 1 to 6 to proceed: "

	validation 6

	mov eax, selectedOpt
	mov menuSelected, eax

	CMP menuSelected, 5
	JE  ranking
	CMP menuSelected, 6
	JE  endProgram

level :
	mov eax,black+(white*16)
	call SetTextColor
	printArithmetic menuSelected
	mov eax,blue+(white*16)
	call SetTextColor
	mWriteLn "Level"
	mWriteLn "====="
	mov eax,cyan+(white*16)
	call SetTextColor
	mWriteLn "(1) Beginner"
	mWriteLn "(2) Intermediate"
	mWriteLn "(3) Advanced"
	mWriteLn "(4) Back"
	mWriteLn "(5) EXIT PROGRAM"
	call crlf
	mov eax,green+(white*16)
	call SetTextColor
	mWrite "Select 1 to 5 to proceed: "

	validation 5
	mov eax, selectedOpt
	mov levelSelected, eax

goodLevelInput:
	.IF levelSelected == 1
		mov range, 100
	.ELSEIF levelSelected == 2
		mov range, 1000
	.ELSE
		mov range, 10000
	.ENDIF
	CMP levelSelected, 4
		JE  menu
		CMP levelSelected, 5
		JE  endProgram

generateQuestion:
	mov eax,black+(white*16)
	call SetTextColor
	printArithmetic menuSelected
	.IF menuSelected == 4
		mWriteLn "** Format 10/3 = 3R1 **"
		call crlf
	.ENDIF
	mov ecx, MAX_NO_QUEST ; loop for 3 questions
	mov currentQuest, 1 ; reset value
	mov countCorrect, 0

	mov eax,Black+(white*16)
	call SetTextColor

.WHILE currentQuest <= ecx
	call Randomize ; reseed randomize number
	generateRandomNo1 :
	mov  eax, range
	call RandomRange
	cmp eax, 0
	JE  generateRandomNo1
	mov  ranNum1, eax

	mov eax,Black+(white*16)
	call SetTextColor

	generateRandomNo2 :
	mov  eax, range
	call RandomRange
	cmp eax, 0
	JE  generateRandomNo2
	mov  ranNum2, eax

	printQuestion:
		mov eax, currentQuest
		call writeDec
		mWrite ".) "
		mov eax, ranNum1
		add correctAnswer, eax
		call writeDec
		.IF menuSelected == 1
		mWriteChar '+'
		.ELSEIF menuSelected == 2
		mWriteChar '-'
		.ELSEIF menuSelected == 3
		mWriteChar 'x'
		.ELSE
		mWriteChar '/'
		.ENDIF

		mov  eax, ranNum2
		call writeDec
		mov  al, '='
		call WriteChar
		mov  al, ' '
		call WriteChar
		CDQ
		mov eax, ranNum1
		mov ebx, ranNum2
		.IF menuSelected == 1
		add eax, ebx
		.ELSEIF menuSelected == 2
		sub eax, ebx
		.ELSEIF menuSelected == 3
		mul ebx
		.ELSE
			div ebx
			MOV remainder, edx
		.ENDIF

		mov correctAnswer, eax


		read : ;if division read string
		.IF menuSelected != 4
			call ReadInt

		.ELSE 
			mov  edx, OFFSET stringIn
			push ecx
			mov  ecx, MAX
			call ReadString
			pop ecx
			push ecx
			mov   ecx, bufsize
			call  ParseDecimal32
			mov   tmpDwordToByte, EAX
			pop ecx
		.ENDIF
		jno  goodInput

		mov  edx, OFFSET promptBad
		call WriteString
		jmp  read; go input again

	goodInput :
		mov  userAnswer, eax; store good value
		mov  eax, correctAnswer
		mov ebx, userAnswer
	
		.IF ebx == eax || tmpDwordToByte == eax
			mov eax, red + (white * 16)
			call SetTextColor
			.IF menuselected == 4 && remainder != 0
				pushad
				INVOKE getRemainder, edx
				MOV remain, eax ;value from c function
				popad
				mov eax, remainder
				.IF eax != remain
					JMP  wrong
				.ENDIF
			.ENDIF
			mWrite "    Correct!"
			inc countCorrect
		.ELSE
			wrong:
			mov eax,red+(white*16)
			call SetTextColor

			mWrite "    Wrong! Correct answer : "
			mov eax, correctAnswer
			.IF menuSelected == 2
				cmp eax, 0
				jl printInt
				jmp printDec
				printInt: 
					call writeInt ; substraction print negative sign
			.ELSE; 
				printDec:
					call writeDec
			.ENDIF

			.IF menuSelected == 4
				mov al, 'R'
				call writeChar
				mov eax, remainder
				call WriteDec
			.ENDIF
		.ENDIF

	call crlf
	call crlf
	inc currentQuest
.ENDW

	mov eax,lightRed+(white*16)
	call SetTextColor

	mWrite "    Correct "

	mov eax, countCorrect 
	call writeDec
	mWrite " out "
	mov eax, MAX_NO_QUEST
	call writeDec
	
	mov eax,black+(white*16)
	call SetTextColor

	mWrite '. ' 
	mov edx, OFFSET userenter
	call writeString
	mWrite ", your mark is "
	;calculate mark
	mov eax, countCorrect
    mov ebx, MAX_NO_QUEST
    xor edx, edx           
    div ebx   
	.IF eax ==1
		call writeDec
	.ENDIF
	xor ecx, ecx ;display decimal point
	mov ecx, 4
	.WHILE ecx!=0
		dec ecx
		imul eax, edx, 10 
		xor edx, edx 
		div ebx
		.IF ecx == 0
			mov secondDecimal, eax
			imul eax, edx, 10
			xor edx, edx
			div ebx
			.IF secondDecimal >= 5; round off the decimal
				add secondDecimal, 1
				mov eax, secondDecimal
			.ENDIF
		.ENDIF
		call WriteDec

		.IF ecx == 2
			mWriteChar '.'
		.ENDIF
	.ENDW
	mWriteln "%"
	pushad
	mov eax, OFFSET userenter
	INVOKE addRanking, eax, countCorrect, MAX_NO_QUEST,levelSelected
	popad
	restart :
		call crlf
		mWriteln "Restart?"
		mWriteln "1. Yes"
		mWriteln "2. No"
		call crlf
		mov eax,green+(white*16)
		call SetTextColor
		mWrite "Select 1 or 2 to proceed: "

		validation 2
		mov eax, selectedOpt
		mov ynOption, eax

		cmp ynOption, 1
		je goodLevelInput
		jmp menu;
ranking:
	call cls
	mov eax,black+(white*16)
	call SetTextColor
	mwriteln " ---------"
	mwriteln "| Ranking |"
	mwriteln " ---------"
	mov eax,red+(white*16)
	call SetTextColor
	INVOKE checkRanking
	call crlf
	mov eax,black+(white*16)
	call SetTextColor
	call waitMsg
	jmp menu


endProgram:
	call crlf
	mov eax,black+(white*16)
	call SetTextColor
	mWriteln "Sure to quit?"
	mWriteln "1. Yes"
	mWriteln "2. Back to menu"
	mWriteln "3. Back to login"
	call crlf
	mov eax,green+(white*16)
	call SetTextColor
	mWrite "Select 1 or 3 to proceed: "
	validation 3
	mov eax, selectedOpt
	mov ynOption, eax
	cmp ynOption, 2
	je menu
	cmp ynOption, 3
	je login
	mov eax,black+(white*16)
	call SetTextColor
	call crlf
	mWrite "Thanks for play! Bye " 
	mov edx, OFFSET userenter
	call writeString
	mWriteChar'.'
	call crlf

EXIT
MATH_QUIZ ENDP
END