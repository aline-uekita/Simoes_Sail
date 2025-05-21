;mario : 
;	- Move 3 Objetos com Delays diferentes
;	- Nao apaga o cenario
;	- Le teclado para movimentar a mario
;	- Declara Tabela de nr. Randoicos
;	- Le Tabela de nr. Randomico para movimentar o Alien
;	- Se Tiro ou Alien passar por cima, nao apaga a mario
;	- Nao fica piscando, pois so' redezenha se pos != posAnt
;   - Senario Colorido!!!!!
;	- Loop principal segue estrutura abaixo:


;	Loop:
;		if (mod(c/10)==0
;			{	
;				Recalculamario (posmario = Teclado...)
;				If (posmario != posAntmario)
;				{ 	Apagamario: Print Tela(posAntmario + posAntmario/40) , posAntmario
;				 	Desenhamario  (posAntmario = posmario)
;				}
;			}
;		if (mod(c/5)==0
;			{	
;				RecalculaAlien (posAlien = Rand...)
;				If (posAlien != posAntAlien)
;				{ 	ApagaAlien: Print Tela(posAntAlien + posAntAlien/40) , posAntAlien
;				 	DesenhaAlien  (posAntAlien = posAlien)
;				}
;			}
;		if (mod(c/2)==0
;			{	
;				RecalculaTiro (posTiro = posTiro + IncTiro...)
;				If (posTiro != posAntTiro)
;				{ 	ApagaTiro: Print Tela(posAntTiro + posAntTiro/40) , posAntTiro
;				 	DesenhaTiro  (posAntTiro = posTiro)
;				}
;			}
;		
;		Delay
;		c++
;		goto Loop


jmp main
;barril
posB1: var #1
posAntB1: var #1
IncRandBarril: var #1

posB2: var #1
posAntB2: var #1
IncRandBarril2: var #1



RandBarril: var #6
    static RandBarril + #0, #247
    static RandBarril + #1, #275
    static RandBarril + #2, #263
    static RandBarril + #3, #246
    static RandBarril + #4, #271
    static RandBarril + #5, #244

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Msn0: string "V O C E   V E N C E U !!!"
Msn1: string "Quer jogar novamente? <s/n>"

Letra: var #1		; Contem a letra que foi digitada

posmario: var #1			; Contem a posicao atual da mario
posAntmario: var #1		; Contem a posicao anterior da mario

posAlien: var #1		; Contem a posicao atual do Alien
posAntAlien: var #1		; Contem a posicao anterior do Alien

posTiro: var #1			; Contem a posicao atual do Tiro
posAntTiro: var #1		; Contem a posicao anterior do Tiro
FlagTiro: var #1		; Flag para ver se Atirou ou nao (Barra de Espaco!!)

IncRand: var #1			; Incremento para circular na Tabela de nr. Randomicos
Rand : var #30			; Tabela de nr. Randomicos entre 0 - 7
	static Rand + #0, #0
	static Rand + #1, #3
	static Rand + #2, #7
	static Rand + #3, #1
	static Rand + #4, #6
	static Rand + #5, #2
	static Rand + #6, #7
	static Rand + #7, #2
	static Rand + #8, #0
	static Rand + #9, #5
	static Rand + #10, #7
	static Rand + #11, #2
	static Rand + #12, #0
	static Rand + #13, #2
	static Rand + #14, #7
	static Rand + #15, #5
	static Rand + #16, #5
	static Rand + #17, #6
	static Rand + #18, #7
	static Rand + #19, #2
	static Rand + #20, #0
	static Rand + #20, #7
	static Rand + #21, #1
	static Rand + #22, #5
	static Rand + #23, #6
	static Rand + #24, #6
	static Rand + #25, #7
	static Rand + #26, #0
	static Rand + #27, #3
	static Rand + #28, #1
	static Rand + #29, #1







;Codigo principal
main:
	call ApagaTela
	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #1536  			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2048  ;COR DA Onda
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
    
	loadn R1, #tela3Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #2048; COR DA ESCADA
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	loadn R1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #256   			; cor branca!
	call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira

	Loadn R0, #1120			
	store posmario, R0		; Zera Posicao Atual da mario
	store posAntmario, R0	; Zera Posicao Anterior da mario
	
	store FlagTiro, R0		; Zera o Flag para marcar que ainda nao Atirou!
	store posTiro, R0		; Zera Posicao Atual do Tiro
	store posAntTiro, R0	; Zera Posicao Anterior do Tiro
	
	Loadn R0, #120
	store posAlien, R0		; Zera Posicao Atual do Alien
	store posAntAlien, R0	; Zera Posicao Anterior do Alien
	
	Loadn R0, #0			; Contador para os Mods	= 0
	loadn R2, #0			; Para verificar se (mod(c/10)==0

	loadn r0, #98
    store posB1, r0
    store posAntB1, r0
    
    loadn r1, #0
    store IncRandBarril, r1

	loadn r0, #98
    store posB2, r0
    store posAntB2, r0
    
    loadn r1, #1
    store IncRandBarril2, r1


	Loop:
	
		loadn R1, #10
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/10)==0
		ceq Movemario	; Chama Rotina de movimentacao da mario
	
		loadn R1, #30
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/30)==0
		ceq MoveAlien	; Chama Rotina de movimentacao do Alien
	
		loadn R1, #2
		mod R1, R0, R1
		cmp R1, R2		; if (mod(c/2)==0
		ceq MoveTiro	; Chama Rotina de movimentacao do Tiro
	
		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2
		ceq MoveBarril

		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2
		ceq MoveBarril2
    

		call Delay
		inc R0 	;c++
		jmp Loop
	
;Funcoes

fim:
    halt

;--------------------------
MoveBarril: ;Para ficar mais organizado
	push r0
	push r1
	push r2
	push r3

	call PosicaoInicialBarril
	call CairBarril

	pop r3
	pop r2
	pop r1
	pop r0
	rts

; Escolhe posição aleatória para o barril com base na tabela
PosicaoInicialBarril:
	push r0
	push r1
	push r2
	push r3

	load r1, IncRandBarril

;Começa o "switch-case"
	loadn r0, #0
	cmp r1, r0
	jeq Escolhe0
	
    loadn r0, #1
	cmp r1, r0
	jeq Escolhe1
	
    loadn r0, #2
	cmp r1, r0
	jeq Escolhe2
	
    loadn r0, #3
	cmp r1, r0
	jeq Escolhe3
	
    loadn r0, #4
	cmp r1, r0
	jeq Escolhe4
	
    loadn r0, #5
	cmp r1, r0
	jeq Escolhe5

Escolhe0:
	loadn r3, #247
	jmp Continua

Escolhe1:
	loadn r3, #275
	jmp Continua

Escolhe2:
	loadn r3, #263
	jmp Continua

Escolhe3:
	loadn r3, #246
	jmp Continua

Escolhe4:
	loadn r3, #271
	jmp Continua

Escolhe5:
	loadn r3, #244
	jmp Continua

Continua:
	store posB1, r3

	inc r1
	loadn r2, #6
	cmp r1, r2
	jeq ZeraIndice

ArmazenaIndice:
	store IncRandBarril, r1
	pop r3
	pop r2
	pop r1
	pop r0
	rts

ZeraIndice:
	loadn r1, #0
	jmp ArmazenaIndice

; Faz o barril cair até o chão
CairBarril:
    push r0
    push r1
    push r2
    push r3

    load r0, posB1
    call DesenhaBarril

LoopCair:
    loadn r1, #40
    add r2, r0, r1         ; r2 = próxima linha

;Comparação se chegou no chão 
    div r3, r2, r1         ; r3 = linha que o barril está
    loadn r1, #27
    cmp r3, r1
    jeq FimCair

    call ApagaBarril
    store posAntB1, r0
    store posB1, r2
    
    call DesenhaBarril
    
    call Delay1

    mov r0, r2
    jmp LoopCair

FimCair:
    call ApagaBarril

    pop r3
    pop r2
    pop r1
    pop r0
    rts

; Desenha o barril na tela
DesenhaBarril:
    push r0
    push r1

    loadn r1, #'O'
    load r0, posB1
    outchar r1, r0
    store posAntB1, r0

    pop r1
    pop r0
    rts

; Apaga o barril da posição anterior
ApagaBarril:
    push R0
	push R1
	push R2
	push R3
	push R4
	push R5

	load R0, posAntB1	; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))
	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts

;----------------------------------------------------------------------------------------------------------------------------
;
;														BARRIL 2
;
;

MoveBarril2: ;Para ficar mais organizado
	push r0
	push r1
	push r2
	push r3

	call PosicaoInicialBarril2
	call CairBarril

	pop r3
	pop r2
	pop r1
	pop r0
	rts

; Escolhe posição aleatória para o barril com base na tabela
PosicaoInicialBarril2:
	push r0
	push r1
	push r2
	push r3

	load r1, IncRandBarril2

;Começa o "switch-case"
	loadn r0, #0
	cmp r1, r0
	jeq Escolhe1
	
    loadn r0, #1
	cmp r1, r0
	jeq Escolhe1
	
    loadn r0, #2
	cmp r1, r0
	jeq Escolhe2
	
    loadn r0, #3
	cmp r1, r0
	jeq Escolhe3
	
    loadn r0, #4
	cmp r1, r0
	jeq Escolhe4
	
    loadn r0, #5
	cmp r1, r0
	jeq Escolhe5

Escolhe0:
	loadn r3, #247
	jmp Continua

Escolhe1:
	loadn r3, #275
	jmp Continua

Escolhe2:
	loadn r3, #263
	jmp Continua

Escolhe3:
	loadn r3, #246
	jmp Continua

Escolhe4:
	loadn r3, #271
	jmp Continua

Escolhe5:
	loadn r3, #244
	jmp Continua

Continua:
	store posB2, r3

	inc r1
	loadn r2, #6
	cmp r1, r2
	jeq ZeraIndice2

ArmazenaIndice2:
	store IncRandBarril2, r1
	pop r3
	pop r2
	pop r1
	pop r0
	rts

ZeraIndice2:
	loadn r1, #0
	jmp ArmazenaIndice2

; Faz o barril cair até o chão
CairBarril:
    push r0
    push r1
    push r2
    push r3

    load r0, posB2
    call DesenhaBarril2

LoopCair:
    loadn r1, #40
    add r2, r0, r1         ; r2 = próxima linha

;Comparação se chegou no chão 
    div r3, r2, r1         ; r3 = linha que o barril está
    loadn r1, #27
    cmp r3, r1
    jeq FimCair

    call ApagaBarril2
    store posAntB2, r0
    store posB2, r2
    
    call DesenhaBarril2
    
    call Delay1

    mov r0, r2
    jmp LoopCair

FimCair2:
    call ApagaBarril2

    pop r3
    pop r2
    pop r1
    pop r0
    rts

; Desenha o barril na tela
DesenhaBarril2:
    push r0
    push r1

    loadn r1, #'L'
    load r0, posB2
    outchar r1, r0
    store posAntB2, r0

    pop r1
    pop r0
    rts

; Apaga o barril da posição anterior
ApagaBarril2:
    push R0
	push R1
	push R2
	push R3
	push R4
	push R5

	load R0, posAntB2	; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))
	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts


;--------------------------------------------------------------------------------------------------------------------------
; Delay de aproximadamente 1 segundo
Delay1:
    push r0
    push r1

    loadn r1, #15

DelayVolta3:
    loadn r0, #3000

DelayVolta2:
    dec r0
    JNZ DelayVolta2
    dec r1
    JNZ DelayVolta3

    pop r1
    pop r0
    rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Movemario:
	push r0
	push r1
	
	call Movemario_RecalculaPos		; Recalcula Posicao da mario

; So' Apaga e Redesenha se (pos != posAnt)
;	If (posmario != posAntmario)	{	
	load r0, posmario
	load r1, posAntmario
	cmp r0, r1
	jeq Movemario_Skip
		call Movemario_Apaga
		call Movemario_Desenha		;}
  Movemario_Skip:
	
	pop r1
	pop r0
	rts

;--------------------------------
	
Movemario_Apaga:		; Apaga a mario preservando o Cenario!
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5

	load R0, posAntmario	; R0 = posAnt
	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))
	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts
;----------------------------------	
	
Movemario_RecalculaPos:		; Recalcula posicao da mario em funcao das Teclas pressionadas
	push R0
	push R1
	push R2
	push R3

	load R0, posmario
	
	inchar R1				; Le Teclado para controlar a mario
	loadn R2, #'a'
	cmp R1, R2
	jeq Movemario_RecalculaPos_A
	
	loadn R2, #'d'
	cmp R1, R2
	jeq Movemario_RecalculaPos_D
		
	loadn R2, #'w'
	cmp R1, R2
	jeq Movemario_RecalculaPos_W
		
	loadn R2, #'s'
	cmp R1, R2
	jeq Movemario_RecalculaPos_S
	
	loadn R2, #' '
	cmp R1, R2
	jeq Movemario_RecalculaPos_Tiro
	
  Movemario_RecalculaPos_Fim:	; Se nao for nenhuma tecla valida, vai embora
	store posmario, R0
	pop R3
	pop R2
	pop R1
	pop R0
	rts

  Movemario_RecalculaPos_A:	; Move mario para Esquerda
	loadn R1, #40
	loadn R2, #0
	mod R1, R0, R1		; Testa condicoes de Contorno 
	cmp R1, R2
	jeq Movemario_RecalculaPos_Fim
	dec R0	; pos = pos -1
	jmp Movemario_RecalculaPos_Fim
		
  Movemario_RecalculaPos_D:	; Move mario para Direita	
	loadn R1, #40
	loadn R2, #39
	mod R1, R0, R1		; Testa condicoes de Contorno 
	cmp R1, R2
	jeq Movemario_RecalculaPos_Fim
	inc R0	; pos = pos + 1
	jmp Movemario_RecalculaPos_Fim
	
  Movemario_RecalculaPos_W:	; Move mario para Cima
	loadn R1, #40
	cmp R0, R1		; Testa condicoes de Contorno 
	jle Movemario_RecalculaPos_Fim
	sub R0, R0, R1	; pos = pos - 40
	jmp Movemario_RecalculaPos_Fim

  Movemario_RecalculaPos_S:	; Move mario para Baixo
	loadn R1, #1159
	cmp R0, R1		; Testa condicoes de Contorno 
	jgr Movemario_RecalculaPos_Fim
	loadn R1, #40
	add R0, R0, R1	; pos = pos + 40
	jmp Movemario_RecalculaPos_Fim	
	
  Movemario_RecalculaPos_Tiro:	
	loadn R1, #1			; Se Atirou:
	store FlagTiro, R1		; FlagTiro = 1
	store posTiro, R0		; posTiro = posmario
	jmp Movemario_RecalculaPos_Fim	
;----------------------------------
Movemario_Desenha:	; Desenha caractere da mario
	push R0
	push R1
	
	Loadn R1, #':'	; desenho mario
	load R0, posmario
	outchar R1, R0
	store posAntmario, R0	; Atualiza Posicao Anterior da mario = Posicao Atual
	
	pop R1
	pop R0
	rts

;----------------------------------
;----------------------------------
;----------------------------------

MoveAlien:
	push r0
	push r1
	
	call MoveAlien_RecalculaPos
	
; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posAlien
	load r1, posAntAlien
	cmp r0, r1
	jeq MoveAlien_Skip
		call MoveAlien_Apaga
		call MoveAlien_Desenha		;}
  MoveAlien_Skip:
	
	pop r1
	pop r0
	rts
		
; ----------------------------
		
MoveAlien_Apaga:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5

	load R0, posAntAlien	; R0 == posAnt
	load R1, posAntmario		; R1 = posAnt
	cmp r0, r1
	jne MoveAlien_Apaga_Skip
		loadn r5, #':'		; Se o Tiro passa sobre a mario, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien_Apaga_Fim

  MoveAlien_Apaga_Skip:	
  
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))
  
  MoveAlien_Apaga_Fim:	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts
;----------------------------------	
; sorteia nr. randomico entre 0 - 7
;					switch rand
;						case 0 : posNova = posAnt -41
;						case 1 : posNova = posAnt -40
;						case 2 : posNova = posAnt -39
;						case 3 : posNova = posAnt -1
;						case 4 : posNova = posAnt +1
;						case 5 : posNova = posAnt +39
;						case 6 : posNova = posAnt +40
;						case 7 : posNova = posAnt +41
	
MoveAlien_RecalculaPos:
	push R0
	push R1
	push R2
	push R3

	load R0, posAlien

; sorteia nr. randomico entre 0 - 7
	loadn R2, #Rand 	; declara ponteiro para tabela rand na memoria!
	load R1, IncRand	; Pega Incremento da tabela Rand
	add r2, r2, r1		; Soma Incremento ao inicio da tabela Rand
						; R2 = Rand + IncRand
	loadi R3, R2 		; busca nr. randomico da memoria em R3
						; R3 = Rand(IncRand)				
	inc r1				; Incremento ++
	loadn r2, #30
	cmp r1, r2			; Compara com o Final da Tabela e re-estarta em 0
	jne MoveAlien_RecalculaPos_Skip
		loadn r1, #0		; re-estarta a Tabela Rand em 0
  MoveAlien_RecalculaPos_Skip:
	store IncRand, r1	; Salva incremento ++

; Switch Rand (r3)
 ; Case 0 : posAlien = posAlien -41
	loadn r2, #0
	cmp r3, r2	; Se Rand = 0
	jne MoveAlien_RecalculaPos_Case1
	loadn r1, #41
	sub r0, r0, r1
	jmp MoveAlien_RecalculaPos_FimSwitch	; Break do Switch

 ; Case 1 : posAlien = posAlien -40
   MoveAlien_RecalculaPos_Case1:
	loadn r2, #1
	cmp r3, r2	; Se Rand = 1
	jne MoveAlien_RecalculaPos_Case2
	loadn r1, #40
	sub r0, r0, r1
	jmp MoveAlien_RecalculaPos_FimSwitch	; Break do Switch

 ; Case 2 : posAlien = posAlien - 39
   MoveAlien_RecalculaPos_Case2:
	loadn r2, #2	; Se Rand = 2
	cmp r3, r2
	jne MoveAlien_RecalculaPos_Case3
	loadn r1, #39
	sub r0, r0, r1
	jmp MoveAlien_RecalculaPos_FimSwitch	; Break do Switch

 ; Case 3 : posAlien = posAlien - 1
   MoveAlien_RecalculaPos_Case3:
	loadn r2, #3	; Se Rand = 3
	cmp r3, r2
	jne MoveAlien_RecalculaPos_Case4
	loadn r1, #1
	sub r0, r0, r1
	jmp MoveAlien_RecalculaPos_FimSwitch	; Break do Switch

 ; Case 4 : posAlien = posAlien + 1	
   MoveAlien_RecalculaPos_Case4:
	loadn r2, #4	; Se Rand = 4
	cmp r3, r2
	jne MoveAlien_RecalculaPos_Case5
	loadn r1, #1
	add r0, r0, r1
	jmp MoveAlien_RecalculaPos_FimSwitch	; Break do Switch

 ; Case 5 : posAlien = posAlien + 39
   MoveAlien_RecalculaPos_Case5:
	loadn r2, #5	; Se Rand = 5
	cmp r3, r2
	jne MoveAlien_RecalculaPos_Case6
	loadn r1, #39
	add r0, r0, r1
	jmp MoveAlien_RecalculaPos_FimSwitch	; Break do Switch

 ; Case 6 : posAlien = posAlien + 40
   MoveAlien_RecalculaPos_Case6:
	loadn r2, #6	; Se Rand = 6
	cmp r3, r2
	jne MoveAlien_RecalculaPos_Case7
	loadn r1, #40
	add r0, r0, r1
	jmp MoveAlien_RecalculaPos_FimSwitch	; Break do Switch	

 ; Case 7 : posAlien = posAlien + 41
   MoveAlien_RecalculaPos_Case7:
	loadn r2, #7	; Se Rand = 7
	cmp r3, r2
	jne MoveAlien_RecalculaPos_FimSwitch
	loadn r1, #41
	add r0, r0, r1
	;jmp MoveAlien_RecalculaPos_FimSwitch	; Break do Switch	

 ; Fim Switch:
  MoveAlien_RecalculaPos_FimSwitch:	
	store posAlien, R0	; Grava a posicao alterada na memoria
	pop R3
	pop R2
	pop R1
	pop R0
	rts


;----------------------------------
MoveAlien_Desenha:
	push R0
	push R1
	
	Loadn R1, #'Q'	; Alien é atecla Q
	load R0, posAlien
	outchar R1, R0
	store posAntAlien, R0
	
	pop R1
	pop R0
	rts

;----------------------------------
;----------------------------------
;--------------------------
Movi_Prego:
	push R0
	push R1
	push r7

	des_obj:
	outchar r0, r1
	rts

	delay:
		push r7
		loadn r7, #640

	delay_loop:
		dec r7
		jnz delay_loop

	pop r7
		rts
	
:
	outchar r2, r1
	rts

	recalc_pos:
    push r7
	inc r1
    loadn r7, #1200
    cmp r1, r7
    jne recalc_pos_sai
    loadn r1, #10

    recalc_pos_sai:
        pop r7
        rts



;---------------------------------------------------------
MoveTiro:
	push r0
	push r1
	
	call MoveTiro_RecalculaPos

; So' Apaga e Redezenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posTiro
	load r1, posAntTiro
	cmp r0, r1
	jeq MoveTiro_Skip
		call MoveTiro_Apaga
		call MoveTiro_Desenha		;}
  MoveTiro_Skip:
	
	pop r1
	pop r0
	rts

;-----------------------------
	
MoveTiro_Apaga:
	push R0
	push R1
	push R2
	push R3
	push R4
	push R5

	; Compara Se (posAntTiro == posAntmario)
	load R0, posAntTiro	; R0 = posAnt
	load R1, posAntmario	; R1 = posAnt
	cmp r0, r1
	jne MoveTiro_Apaga_Skip1
		loadn r5, #':'		; Se o Tiro passa sobre a mario, apaga com um X, senao apaga com o cenario 
		jmp MoveTiro_Apaga_Fim
		
  MoveTiro_Apaga_Skip1:	
	; --> R2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add R2, R1, r0	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, R0, R4	; R3 = posAnt/40
	add R2, R2, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, R2	; R5 = Char (Tela(posAnt))

  MoveTiro_Apaga_Fim:	
	outchar R5, R0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop R5
	pop R4
	pop R3
	pop R2
	pop R1
	pop R0
	rts
;----------------------------------	
	
	
; if TiroFlag = 1
;	posTiro++
;	
	
MoveTiro_RecalculaPos:
	push R0
	push R1
	push R2
	
	load R1, FlagTiro	; Se Atirou, movimenta o tiro!
	loadn R2, #1
	cmp R1, R2			; If FlagTiro == 1  Movimenta o Tiro
	jne MoveTiro_RecalculaPos_Fim2	; Se nao vai embora!
	
	load R0, posTiro	; TEsta se o Tiro Pegou no Alien
	load R1, posAlien
	cmp R0, R1			; IF posTiro == posAlien  BOOM!!
	jeq MoveTiro_RecalculaPos_Boom
	
	loadn R1, #40		; Testa condicoes de Contorno 
	loadn R2, #39
	mod R1, R0, R1		
	cmp R1, R2			; Se tiro chegou na ultima linha
	jne MoveTiro_RecalculaPos_Fim
	call MoveTiro_Apaga
	loadn R0, #0
	store FlagTiro, R0	; Zera FlagTiro
	store posTiro, R0	; Zera e iguala posTiro e posAntTiro
	store posAntTiro, R0
	jmp MoveTiro_RecalculaPos_Fim2	
	
  MoveTiro_RecalculaPos_Fim:
	inc R0
	store posTiro, R0
  MoveTiro_RecalculaPos_Fim2:	
	pop R2
	pop R1
	pop R0
	rts

  MoveTiro_RecalculaPos_Boom:	
	; Limpa a Tela !!
  	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn R2, #0  			; cor branca!
	call ImprimeTela   		;  Rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Venceu !!!
	loadn r0, #526
	loadn r1, #Msn0
	loadn r2, #0
	call ImprimeStr
	
	;imprime quer jogar novamente
	loadn r0, #605
	loadn r1, #Msn1
	loadn r2, #0
	call ImprimeStr

	MoveTiro_RecalculaPos_Boom_Loop:	
	call DigLetra
	loadn r0, #'n'
	load r1, Letra
	cmp r0, r1				; tecla == 'n' ?
	jeq MoveTiro_RecalculaPos_Boom_FimJogo	; tecla e' 'n'
	
	loadn r0, #'s'
	cmp r0, r1				; tecla == 's' ?
	jne MoveTiro_RecalculaPos_Boom_Loop	; tecla nao e' 's'
	
	
	
	; Se quiser jogar novamente...
	call ApagaTela
	
	pop r2
	pop r1
	pop r0

	pop r0	; Da um Pop a mais para acertar o ponteiro da pilha, pois nao vai dar o RTS !!
	jmp main

 MoveTiro_RecalculaPos_Boom_FimJogo:
	call ApagaTela
	halt

;----------------------------------
MoveTiro_Desenha:
	push R0
	push R1
	
	Loadn R1, #'P'	; Tiro
	load R0, posTiro
	outchar R1, R0
	store posAntTiro, R0
	
	pop R1
	pop R0
	rts

;----------------------------------

;********************************************************
;                       DELAY
;********************************************************		


Delay:
						;Utiliza Push e Pop para nao afetar os Ristradores do programa principal
	Push R0
	Push R1
	
	Loadn R1, #50  ; a
   Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	Loadn R0, #30	; b
   Delay_volta: 
	Dec R0					; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	JNZ Delay_volta	
	Dec R1
	JNZ Delay_volta2
	
	Pop R1
	Pop R0
	
	RTS							;return

;-------------------------------


;********************************************************
;                       IMPRIME TELA
;********************************************************	

ImprimeTela: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r4 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	
   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	pop r5	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------

;---------------------------	
;********************************************************
;                   IMPRIME STRING
;********************************************************
	
ImprimeStr:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr_Sai
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;------------------------	
	

;-------------------------------


;********************************************************
;                       IMPRIME TELA2
;********************************************************	

ImprimeTela2: 	;  Rotina de Impresao de Cenario na Tela Inteira
		;  r1 = endereco onde comeca a primeira linha do Cenario
		;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina

	loadn R0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn R3, #40  	; Incremento da posicao da tela!
	loadn R4, #41  	; incremento do ponteiro das linhas da tela
	loadn R5, #1200 ; Limite da tela!
	loadn R6, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	
   ImprimeTela2_Loop:
		call ImprimeStr2
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = R0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela2_Loop	; Enquanto r0 < 1200

	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------

;---------------------------	
;********************************************************
;                   IMPRIME STRING2
;********************************************************
	
ImprimeStr2:	;  Rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera' impresso;  r1 = endereco onde comeca a mensagem; r2 = cor da mensagem.   Obs: a mensagem sera' impressa ate' encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina
	
	
	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr2_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr2_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr2_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
   		storei r6, r4
   ImprimeStr2_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6
		jmp ImprimeStr2_Loop
	
   ImprimeStr2_Sai:	
	pop r6	; Resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	

;------------------------		
;********************************************************
;                   DIGITE UMA LETRA
;********************************************************

DigLetra:	; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push r0
	push r1
	loadn r1, #255	; Se nao digitar nada vem 255

   DigLetra_Loop:
		inchar r0			; Le o teclado, se nada for digitado = 255
		cmp r0, r1			;compara r0 com 255
		jeq DigLetra_Loop	; Fica lendo ate' que digite uma tecla valida

	store Letra, r0			; Salva a tecla na variavel global "Letra"

	pop r1
	pop r0
	rts



;----------------
	
;********************************************************
;                       APAGA TELA
;********************************************************
ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
		dec r0
		outchar r1, r0
		jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts	
	
;------------------------	
; Declara uma tela vazia para ser preenchida em tempo de execussao:

tela0Linha0  : string "                                        "
tela0Linha1  : string "                                        "
tela0Linha2  : string "                                        "
tela0Linha3  : string "                                        "
tela0Linha4  : string "                                        "
tela0Linha5  : string "                                        "
tela0Linha6  : string "                                        "
tela0Linha7  : string "                                        "
tela0Linha8  : string "                                        "
tela0Linha9  : string "                                        "
tela0Linha10 : string "                                        "
tela0Linha11 : string "                                        "
tela0Linha12 : string "                                        "
tela0Linha13 : string "                                        "
tela0Linha14 : string "                                        "
tela0Linha15 : string "                                        "
tela0Linha16 : string "                                        "
tela0Linha17 : string "                                        "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "	

; Declara e preenche tela linha por linha (40 caracteres):
tela1Linha0  : string "                                        "
tela1Linha1  : string "                                        "
tela1Linha2  : string "                                        "
tela1Linha3  : string "                                        "
tela1Linha4  : string "          ================              "
tela1Linha5  : string "                                        "
tela1Linha6  : string "                                        "
tela1Linha7  : string "========================================"
tela1Linha8  : string "                                        "
tela1Linha9  : string "                                        "
tela1Linha10 : string "                                        "
tela1Linha11 : string "========================================"
tela1Linha12 : string "                                        "
tela1Linha13 : string "                                        "
tela1Linha14 : string "                                        "
tela1Linha15 : string "========================================"
tela1Linha16 : string "                                        "
tela1Linha17 : string "                                        "
tela1Linha18 : string "========================================"
tela1Linha19 : string "                                        "
tela1Linha20 : string "                                        "
tela1Linha21 : string "                                        "
tela1Linha22 : string "========================================"
tela1Linha23 : string "                                        "
tela1Linha24 : string "                                        "
tela1Linha25 : string "========================================"
tela1Linha26 : string "                                        "
tela1Linha27 : string "                                        "
tela1Linha28 : string "========================================"
tela1Linha29 : string "                                        "



; Declara e preenche tela linha por linha (40 caracteres):
tela2Linha0  : string "                                        "
tela2Linha1  : string "                                        "
tela2Linha2  : string "                                        "
tela2Linha3  : string "                                        "
tela2Linha4  : string "                                        "
tela2Linha5  : string "                  - -                   "
tela2Linha6  : string "                  - -                   "
tela2Linha7  : string "                                        "
tela2Linha8  : string "      - -                               "
tela2Linha9  : string "      - -                               "
tela2Linha10 : string "      - -                               "
tela2Linha11 : string "                                        "
tela2Linha12 : string "                                  - -   "
tela2Linha13 : string "                                  - -   "
tela2Linha14 : string "                                  - -   "
tela2Linha15 : string "                                        "
tela2Linha16 : string "                      - -               "
tela2Linha17 : string "                      - -               "
tela2Linha18 : string "                                        "
tela2Linha19 : string "     - -                                "
tela2Linha20 : string "     - -                                "
tela2Linha21 : string "     - -                                "
tela2Linha22 : string "                                        "
tela2Linha23 : string "                              - -       "
tela2Linha24 : string "                              - -       "
tela2Linha25 : string "                                        "
tela2Linha26 : string "   - -                                  "
tela2Linha27 : string "   - -                                  "
tela2Linha28 : string "                                        "
tela2Linha29 : string "                                        "


; Declara e preenche tela linha por linha (40 caracteres):
tela3Linha0  : string "                                        "
tela3Linha1  : string "                                        "
tela3Linha2  : string "                                        "
tela3Linha3  : string "                                        "
tela3Linha4  : string "                                        "
tela3Linha5  : string "                                        "
tela3Linha6  : string "                                        "
tela3Linha7  : string "                                        "
tela3Linha8  : string "                                        "
tela3Linha9  : string "                                        "
tela3Linha10 : string "                                        "
tela3Linha11 : string "                                        "
tela3Linha12 : string "                                        "
tela3Linha13 : string "                                        "
tela3Linha14 : string "                                        "
tela3Linha15 : string "                                        "
tela3Linha16 : string "                                        "
tela3Linha17 : string "                                        "
tela3Linha18 : string "                                        "
tela3Linha19 : string "                                        "
tela3Linha20 : string "                                        "
tela3Linha21 : string "                                        "
tela3Linha22 : string "                                        "
tela3Linha23 : string "                                        "
tela3Linha24 : string "                                        "
tela3Linha25 : string "                                        "
tela3Linha26 : string "                                        "
tela3Linha27 : string "                                        "
tela3Linha28 : string "                                        "
tela3Linha29 : string "                                        "



tela4Linha0  : string "                                        "
tela4Linha1  : string "                                        "
tela4Linha2  : string "                                        "
tela4Linha3  : string "                                        "
tela4Linha4  : string "                                        "
tela4Linha5  : string "                                        "
tela4Linha6  : string "                                        "
tela4Linha7  : string "                                        "
tela4Linha8  : string "                                        "
tela4Linha9  : string "                                        "
tela4Linha10 : string "                                        "
tela4Linha11 : string "                                        "
tela4Linha12 : string "                                        "
tela4Linha13 : string "                                        "
tela4Linha14 : string "                                        "
tela4Linha15 : string "                                        "
tela4Linha16 : string "                                        "
tela4Linha17 : string "                                        "
tela4Linha18 : string "                                        "
tela4Linha19 : string "                                        "
tela4Linha20 : string "                                        "
tela4Linha21 : string "                                        "
tela4Linha22 : string "                                        "
tela4Linha23 : string "                                        "
tela4Linha24 : string "                                        "
tela4Linha25 : string "                                        "
tela4Linha26 : string "                                        "
tela4Linha27 : string "                                        "
tela4Linha28 : string "                                        "
tela4Linha29 : string "                                        "

