jmp inicio
; Variáveis
Msn0: string "Pressione ENTER para jogar"

posB1: var #1
posAntB1: var #1

posB2: var #1
posAntB2: var #1

posB3: var #1
posAntB3: var #1

posB4: var #1
posAntB4: var #1

IncRandBarril: var #1
RandBarril: var #6
    static RandBarril + #0, #247
    static RandBarril + #1, #275
    static RandBarril + #2, #263
    static RandBarril + #3, #250
    static RandBarril + #4, #271
    static RandBarril + #5, #244

inicio:
	loadn r0, #247             ;onde inicia a frase
    loadn r1, #Msn0
	loadn r2, #0               ;se quiser add cor 0 é nada
    call ImprimeSTR
    
    Loopinicio:
        inchar r4
        loadn r1, #13          ;tecla enter
        
        inc r2                 ;faz a soma aleatória para dar o rand

        cmp r4, r1
        jne Loopinicio

        loadn r5, #6
        mod r3, r2, r5
        store IncRandBarril, r3    ;dá o valor aleatório para B1

        jmp main

; Início do programa
main:
    loadn r2, #0
    loadn r1, #0
    loadn r0, #0
    store posB1, r0
    store posB2, r0
    store posB3, r0
    store posB4, r0

    Loopmain:
        loadn r1, #2 ;Começa quando for um múltiplo de 2
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveB1
        
        loadn r1, #3 ;Começa quando for um múltiplo de 3
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveB2

        loadn r1, #4 ;Começa quando for um múltiplo de 4
        mod r1, r0, r1
        cmp r1, r2
        ceq MoveB3
        
        loadn r1, #3 ;Começa quando for um múltiplo de 5
        mod r1, r0, r1
        cmp r1, r2
        ceq MoveB4

        call Delay

        inc r0
        
        jmp Loopmain
    
    fim:
        halt

;-------------------------------------------
;                BARRIL 1 
;-------------------------------------------
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

PosicaoInicialB1:
    loadn r0, #0
    load r2, posB1
    cmp r0, r2
    jne RtsPosicaoInicialB1
    
    load r1, IncRandBarril         ;r1 = índice atual (0 a 5)
    loadn r3, #RandBarril          ;r3 = endereço base da tabela
    add r3, r3, r1                 ;r3 = endereço de RandBarril[r1]
    loadi r2, r3                   ;r2 = RandBarril[r1] (posição aleatória)
    store posB1, r2                ;define nova posição do barril

    inc r1                         ;vai pra próxima coluna

    loadn r0, #6
    cmp r1, r0                     ;Compara se o índice já chegou no fim da tabela
    jne StoreIncB1             

    ;ZeraIndice:
    loadn r1, #0

    StoreIncB1:
        store IncRandBarril, r1         ;Ele armazena o novo índice  
    
    RtsPosicaoInicialB1:
        rts

CwairB1:
    load r0, posB1
    call ApagaB1           ;se Desenha antes, posAntB1 = posB1, então apaga o desenha que ele fez, logo aparece nada na tela


    loadn r1, #40
    add r2, r0, r1         ; r2 = próxima linha

    ;Comparação se chegou no chão 
    div r3, r2, r1         ; r3 = linha que o barril está
    loadn r1, #27
    cmp r3, r1
    jeq NochaoB1           ;se r2 == r3 == 27, ele está no chão, não precisa cair

    call DesenhaB1
    store posAntB1, r0     
    store posB1, r2     

    jmp RtsCairB1

    NochaoB1:
        ;eu fiz isso como um "flag" para saber se ele ainda está caíndo ou não
        loadn r0, #0       ;poderia ser outro número, mas teria que iniciar ele lá no main, eu iniciei com 0
        store posB1, r0
    
    RtsCairB1:
        rts

;-------------------------------------------
;       Desenha e Apaga o Barril 1
;-------------------------------------------
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


ApagaB1: 
    push r0
    push r1

    load r0, posAntB1
    loadn r1, #' '
    outchar r1, r0

    pop r1
    pop r0
    rts

;-------------------------------------------
;                BARRIL 2 
;-------------------------------------------
MoveB2:
    push r0
    push r1
    push r2
    push r3
    push r4

    call PosicaoInicialB2
    call CairB2

    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

PosicaoInicialB2:
    loadn r0, #0              ;confere se ele está caíndo
    load r2, posB2
    cmp r0, r2
    jne RtsPosicaoInicialB2
    
    load r1, IncRandBarril     ;índice que vai pegar na tabela
    loadn r3, #RandBarril      ;r3 = endereço base da tabela
    add r3, r3, r1             ;r3 = endereço de RandBarril[r1]
    loadi r2, r3               ;r2 = RandBarril[r1] (posição aleatória)
    store posB2, r2            ;define nova posição do barril

    inc r1                     ;vai pra próxima coluna

    loadn r0, #6
    cmp r1, r0                 ;Compara se o índice já chegou no fim da tabela
    jne StoreIncB2             ;se não chegou, pode já dar store novo índice

    ;ZeraIndice:
    loadn r1, #0

    StoreIncB2:
        store IncRandBarril, r1    ;Ele armazena o novo índice  
    
    RtsPosicaoInicialB2:
        rts

CairB2:
    load r0, posB2
    call ApagaB2           ;se Desenha antes, posAntB2 = posB2, então apaga o desenha que ele fez, logo aparece nada na tela

    loadn r1, #40
    add r2, r0, r1         ;r2 = próxima linha

    ;Comparação se chegou no chão 
    div r3, r2, r1         ;r3 = linha que o barril está
    loadn r1, #27
    cmp r3, r1
    jeq NochaoB2           ;se r2 == r3 == 27, ele está no chão, não precisa cair

    call DesenhaB2
    store posAntB2, r0     
    store posB2, r2     

    jmp RtsCairB2

    NochaoB2:
        ;eu fiz isso como um "flag" para saber se ele ainda está caíndo ou não
        loadn r0, #0        ;poderia ser outro número, mas teria que iniciar ele lá no main, eu iniciei com 0
        store posB2, r0
    
    RtsCairB2:
        rts

;-------------------------------------------
;       Desenha e Apaga o Barril 2
;-------------------------------------------
DesenhaB2: 
    push r0
    push r1

    loadn r1, #'Y'
    load r0, posB2
    outchar r1, r0
    store posAntB2, r0      

    pop r1
    pop r0
    rts


ApagaB2: 
    push r0
    push r1

    load r0, posAntB2
    loadn r1, #' '
    outchar r1, r0

    pop r1
    pop r0
    rts

;-------------------------------------------
;                BARRIL 3
;-------------------------------------------
MoveB3:
    push r0
    push r1
    push r2
    push r3

    call PosicaoInicialB3
    call CairB3

    pop r3
    pop r2
    pop r1
    pop r0
    rts

PosicaoInicialB3:
    loadn r0, #0
    load r2, posB3
    cmp r0, r2
    jne RtsPosicaoInicialB3
    
    load r1, IncRandBarril     ;r1 = índice atual (0 a 5)
    loadn r3, #RandBarril      ;r3 = endereço base da tabela
    add r3, r3, r1             ;r3 = endereço de RandBarril[r1]
    loadi r2, r3               ;r2 = RandBarril[r1] (posição aleatória)
    store posB3, r2            ;define nova posição do barril

    inc r1                     ;vai pra próxima coluna

    loadn r0, #6
    cmp r1, r0                 ;Compara se o índice já chegou no fim da tabela
    jne StoreIncB3             

    ;ZeraIndice:
    loadn r1, #0

    StoreIncB3:
        store IncRandBarril, r1 ;Ele armazena o novo índice  
    
    RtsPosicaoInicialB3:
        rts

CairB3:
    load r0, posB3
    call ApagaB3

    loadn r1, #40
    add r2, r0, r1         ; r2 = próxima linha

    ;Comparação se chegou no chão 
    div r3, r2, r1         ; r3 = linha que o barril está
    loadn r1, #27
    cmp r3, r1
    jeq NochaoB3

    call DesenhaB3
    store posAntB3, r0     
    store posB3, r2     

    jmp RtsCairB3

    NochaoB3:
        loadn r0, #0
        store posB3, r0
    
    RtsCairB3:
        rts

;-------------------------------------------
;       Desenha e Apaga o Barril 3
;-------------------------------------------
DesenhaB3: 
    push r0
    push r1

    loadn r1, #'F'
    load r0, posB3
    outchar r1, r0
    store posAntB3, r0      

    pop r1
    pop r0
    rts


ApagaB3: 
    push r0
    push r1

    load r0, posAntB3
    loadn r1, #' '
    outchar r1, r0

    pop r1
    pop r0
    rts

;-------------------------------------------
;                BARRIL 4 
;-------------------------------------------
MoveB4:
    push r0
    push r1
    push r2
    push r3

    call PosicaoInicialB4
    call CairB4

    pop r3
    pop r2
    pop r1
    pop r0
    rts

PosicaoInicialB4:
    loadn r0, #0               ;verifica se b4 está caindo
    load r2, posB4
    cmp r0, r2
    jne RtsPosicaoInicialB4
    
    load r1, IncRandBarril     ;r1 = índice atual (0 a 5)
    loadn r3, #RandBarril      ;r3 = endereço base da tabela
    add r3, r3, r1             ;r3 = endereço de RandBarril[r1]
    loadi r2, r3               ;r2 = RandBarril[r1] (posição aleatória)
    store posB4, r2            ;define nova posição do barril

    inc r1                     ;vai pra próxima coluna

    loadn r0, #6
    cmp r1, r0                 ;Compara se o índice já chegou no fim da tabela
    jne StoreIncB4             

    ;ZeraIndice:
    loadn r1, #0

    StoreIncB4:
        store IncRandBarril, r1    ;Ele armazena o novo índice  
    
    RtsPosicaoInicialB4:
        rts

CairB4:
    load r0, posB4
    call ApagaB4          ;se Desenha antes, posAntB2 = posB2, então apaga o desenha que ele fez, logo aparece nada na tela


    loadn r1, #40
    add r2, r0, r1         ;r2 = próxima linha

    ;Comparação se chegou no chão 
    div r3, r2, r1         ;r3 = linha que o barril está
    loadn r1, #27
    cmp r3, r1
    jeq NochaoB4           ;se r2 == r3 == 27, ele está no chão, não precisa cair

    call DesenhaB4
    store posAntB4, r0     
    store posB4, r2     

    jmp RtsCairB4

    NochaoB4:
        loadn r0, #0
        store posB4, r0
    
    RtsCairB4:
        rts

;-------------------------------------------
;       Desenha e Apaga o Barril 4
;-------------------------------------------
DesenhaB4: 
    push r0
    push r1

    loadn r1, #'Z'
    load r0, posB4
    outchar r1, r0
    store posAntB4, r0      

    pop r1
    pop r0
    rts


ApagaB4: 
    push r0
    push r1

    load r0, posAntB4
    loadn r1, #' '
    outchar r1, r0

    pop r1
    pop r0
    rts

Delay:
    push r0
    push r1

    loadn r1, #15

    DelayVolta2:
        loadn r0, #1500

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