jmp inicio
; Variáveis
Msn0: string "Pressione ENTER para jogar"

posB1: var #1
posAntB1: var #1

IncRandBarril: var #1
RandBarril: var #6
    static RandBarril + #0, #247
    static RandBarril + #1, #275
    static RandBarril + #2, #263
    static RandBarril + #3, #246
    static RandBarril + #4, #271
    static RandBarril + #5, #244

inicio:
	loadn r0, #247 ;onde inicia a frase
    loadn r1, #Msn0
	loadn r2, #0 ;se quiser add cor 0 é nada
    call ImprimeSTR
    
Loopinicio:
    inchar r4
    loadn r1, #13 ;tecla enter
    
    inc r2 ;faz a soma aleatória para dar o rand

    cmp r4, r1
    jne Loopinicio

    loadn r5, #6
    mod r3, r2, r5

    store IncRandBarril, r3
    
    jmp main

; Início do programa
main:
    loadn r2, #0
    store posB1, r0
    store posAntB1, r0

Loop:
    loadn r1, #10 ;Começa quando for um múltiplo de 10
	mod r1, r0, r1
	cmp r1, r2 
	ceq MoveB1
    
    inc r0 	; c++
	jmp Loop
fim:
    halt

;--------Barril 1 ------------
MoveB1:
	push r0
	push r1
	push r2
	push r3

	call PosicaoInicialB1
	call CairB1

	pop r3
	pop r2
	pop r1
	pop r0
	rts

; Escolhe posição aleatória para o barril com base na tabela
PosicaoInicialB1:
    push r0
    push r1
    push r2
    push r3

    load r1, IncRandBarril         ;r1 = índice atual (0 a 5)

    
    loadn r3, #RandBarril          ;r3 = endereço base da tabela
    add r3, r3, r1                 ;r3 = endereço de RandBarril[r1]
    loadi r2, r3                   ;r2 = RandBarril[r1] (posição aleatória)
    store posB1, r2                ;define nova posição do barril

    inc r1 ;vai pra próxima coluna
    
    loadn r0, #6
    cmp r1, r0
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
CairB1:
    push r0
    push r1
    push r2
    push r3

    load r0, posB1
    call DesenhaB1

LoopCairB1:
    loadn r1, #40
    add r2, r0, r1         ; r2 = próxima linha

;Comparação se chegou no chão 
    div r3, r2, r1         ; r3 = linha que o barril está
    loadn r1, #27
    cmp r3, r1
    jeq FimCairB1

    call ApagaTelaB1
    store posAntB1, r0
    store posB1, r2
    
    call DesenhaB1
    
    call Delay

    mov r0, r2
    jmp LoopCairB1

FimCairB1:
    call ApagaTelaB1

    pop r3
    pop r2
    pop r1
    pop r0
    rts

; Desenha o barril na tela
DesenhaB1:
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
ApagaTelaB1:
    push r0
    push r1

    load r0, posAntB1
    loadn r1, #' '
    outchar r1, r0

    pop r1
    pop r0
    rts

; Delay de aproximadamente 1 segundo
Delay:
    push r0
    push r1

    loadn r1, #15

DelayVolta2:
    loadn r0, #3000

DelayVolta1:
    dec r0
    jnz DelayVolta1
    dec r1
    jnz DelayVolta2

    pop r1
    pop r0
    rts

ImprimeSTR:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	loadn r3, #'\0'		; Caractere de parada

ImprimeSTRLoop:
	loadi r4, r1			; Carrega caractere da string
	cmp r4, r3
	jeq ImprimeSTRSai

	outchar r4, r0			; Imprime caractere puro (sem cor)
	inc r0					; Próxima posição na tela
	inc r1					; Próximo caractere
	jmp ImprimeSTRLoop

ImprimeSTRSai:
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
