jmp main

posB1: var #1
posAntB1: var #1

IncRandB1: var #1
RandBarril: var #6
    static RandBarril + #0, #247
    static RandBarril + #1, #275
    static RandBarril + #2, #263
    static RandBarril + #3, #246
    static RandBarril + #4, #271
    static RandBarril + #5, #244

main:
    loadn r0, #0
    loadn r2, #0
    loadn r7, #0 ;um registrador inteiro só pra ser o nosso contador

    store posB1, r0
    store posAntB1, r0

    Loop:
        loadn r1, #10 ;Começa quando for um múltiplo de 10
        mod r1, r7, r1
        cmp r1, r2 
        ceq MoveB1

        inc r7

        call Delay
        
        jmp Loop

;----------------------------------------------------------------
;                      BARRIL 1
;----------------------------------------------------------------
MoveB1:
;Chama dá todos os pushes e pops que vai usar pra mover o barril1
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
    
    load r1, IncRandB1         ;r1 = índice atual (0 a 5)
    loadn r3, #RandBarril      ;r3 = endereço base da tabela
    add r3, r3, r1             ;r3 = endereço de RandBarril[r1]
    loadi r2, r3               ;r2 = RandBarril[r1] (posição aleatória)
    store posB1, r2            ;define nova posição do barril

    inc r1                     ;vai pra próxima coluna

    loadn r0, #6
    cmp r1, r0                 ;Compara se o índice já chegou no fim da tabela
    jne StoreIncB1             

    ;ZeraIndice:
    loadn r1, #0

    StoreIncB1:
        store IncRandB1, r1 ;Ele armazena o novo índice  
    
    RtsPosicaoInicialB1:
        rts

CairB1:
    load r0, posB1
    call ApagaB1

    loadn r1, #40
    add r2, r0, r1         ; r2 = próxima linha

    ;Comparação se chegou no chão 
    div r3, r2, r1         ; r3 = linha que o barril está
    loadn r1, #27
    cmp r3, r1
    jeq NochaoB1

    call DesenhaB1
    store posAntB1, r0     
    store posB1, r2     

    jmp RtsCairB1

    NochaoB1:
        loadn r0, #0
        store posB1, r0
    
    RtsCairB1:
        rts

;-----------------------------------
;     Desenha e Apaga Barril 1
;-----------------------------------
DesenhaB1: ;função 3
    push r0
    push r1

    loadn r1, #'O'
    load r0, posB1
    outchar r1, r0
    store posAntB1, r0      

    pop r1
    pop r0
    rts


ApagaB1: ;função 4
    push r0
    push r1

    load r0, posAntB1
    loadn r1, #' '
    outchar r1, r0

    pop r1
    pop r0
    rts

;--------------------------------------------
;    Delay de aproximadamente 1 segundo
;--------------------------------------------
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
