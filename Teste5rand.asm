jmp inicio
; Variáveis
Msn0: string "Pressione ENTER para jogar"

posB1: var #1
posAntB1: var #1

posB2: var #1
posAntB2: var #1

posB3: var #1
posAntB3: var #1

IncRandB3: var #1
IncRandB2: var #1
IncRandB1: var #1
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

        loadn r5, #5
        mod r3, r2, r5

        store IncRandB1, r3
        
        jmp main

; Início do programa
main:
    loadn r2, #0
    loadn r1, #0
    loadn r0, #0
    store posB1, r0
    store posAntB1, r0
    store posB2, r0
    store posAntB2, r0

    Loopmain:

        loadn r1, #5 ;Começa quando for um múltiplo de 5
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveB1
        
        loadn r1, #10 ;Começa quando for um múltiplo de 10
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveB2

        loadn r1, #15
        mod r1, r0, r1
        cmp r1, r2
        ceq MoveB3
        
        call Delay

        inc r0
        
        jmp Loopmain
    
    fim:
        halt

;-----------------------------
;         BARRIL 1 
;-----------------------------
MoveB1:
    push r0
    push r1
    push r2
    push r3

    call CmpIncB1B2
    call CmpIncB1B3
    call PosicaoInicialB1
    call CairB1

    pop r3
    pop r2
    pop r1
    pop r0
    rts

CmpIncB1B2:
    loadn r0, #0               ;confere se ele está caindo ou vai cair
    load r2, posB1
    cmp r0, r2
    jne RtsCmpIncB1B2          ;se ele está caindo, já dá rts na função
    
    load r4, posB2             ;confere se B2 vai cair ou não
    cmp r0, r4
    jne IncRandB2atual1     ;se é != 0, ele está caíndo, então o IncRandB1 que a gente analisa é outro

    load r4, IncRandB2         ;já é a nova posição que o B1 vai cair
    load r1, IncRandB1   
    cmp r4, r1                 ;compara se eles vão cair no mesmo lugar
    jne RtsCmpIncB1B2          ;se não, dá rts na função

    loadn r0, #5
    cmp r0, r4                 ;confere se vai cair na última coluna
    jne Add12                   ;se não, pode só somar 1 no IncRandB2

    loadn r1, #0
    store IncRandB1, r1        ;zera o IncRandB2
    jmp RtsCmpIncB1B2

    Add12:
        inc r1
        store IncRandB1, r1    ;se ele ia cair na coluna 0, ele vai cair na 1
        jmp RtsCmpIncB1B2

    IncRandB2atual1:
        load r4, IncRandB2         ;está apontando para a próxima coluna já
        loadn r0, #0
        cmp r0, r4                 ;eu vejo se a próxima coluna é o 0 (zerou 5 + 1 = 0)
        jne Sub12                   ;se não é, pode r4-- para saber qual coluna ele está

        loadn r4, #5               ;se zerou, ele estava no fim da tabela
        load r1, IncRandB1         
        cmp r4, r1                 ;compara se ambos vão estar no fim da tabela
        jne RtsCmpIncB1B2          ;se não, rts

        loadn r4, #0               ;zera o índice se eles iriam cair na última coluna (5 + 1 = 0)
        store IncRandB1, r4
        jmp RtsCmpIncB1B2
        
        Sub12:
            dec r4                     ;r4--
            load r1, IncRandB1         
            cmp r1, r4                 ;compara se são iguais
            jne RtsCmpIncB1B2

            loadn r4, #5               ;para saber se eles estão no fim da tabela para zerar
            cmp r1, r4                 
            jne SomaIncRandB12

            ;Zera o IncRandB1
            loadn r1, #0
            store IncRandB1, r1
            jmp RtsCmpIncB1B2
        
        SomaIncRandB12:
            inc r1
            store IncRandB1, r1

        RtsCmpIncB1B2:
            rts

CmpIncB1B3:
    loadn r0, #0               ;confere se ele está caindo ou vai cair
    load r2, posB1
    cmp r0, r2
    jne RtsCmpIncB1B3          ;se ele está caindo, já dá rts na função
    
    load r4, posB3             ;confere se B3 vai cair ou não
    cmp r0, r4
    jne IncRandB3atual1     ;se é != 0, ele está caíndo, então o IncRandB1 que a gente analisa é outro

    load r4, IncRandB3         ;já é a nova posição que o B1 vai cair
    load r1, IncRandB1   
    cmp r4, r1                 ;compara se eles vão cair no mesmo lugar
    jne RtsCmpIncB1B3          ;se não, dá rts na função

    loadn r0, #5
    cmp r0, r4                 ;confere se vai cair na última coluna
    jne Add13                   ;se não, pode só somar 1 no IncRandB2

    loadn r1, #0
    store IncRandB1, r1        ;zera o IncRandB2
    jmp RtsCmpIncB1B3

    Add13:
        inc r1
        store IncRandB1, r1    ;se ele ia cair na coluna 0, ele vai cair na 1
        jmp RtsCmpIncB1B3

    IncRandB3atual1:
        load r4, IncRandB3         ;está apontando para a próxima coluna já
        loadn r0, #0
        cmp r0, r4                 ;eu vejo se a próxima coluna é o 0 (zerou 5 + 1 = 0)
        jne Sub13                   ;se não é, pode r4-- para saber qual coluna ele está

        loadn r4, #5               ;se zerou, ele estava no fim da tabela
        load r1, IncRandB1         
        cmp r4, r1                 ;compara se ambos vão estar no fim da tabela
        jne RtsCmpIncB1B3          ;se não, rts

        loadn r4, #0               ;zera o índice se eles iriam cair na última coluna (5 + 1 = 0)
        store IncRandB1, r4
        jmp RtsCmpIncB1B3
        
        Sub13:
            dec r4                     ;r4--
            load r1, IncRandB1         
            cmp r1, r4                 ;compara se são iguais
            jne RtsCmpIncB1B3

            loadn r4, #5               ;para saber se eles estão no fim da tabela para zerar
            cmp r1, r4                 
            jne SomaIncRandB13

            ;Zera o IncRandB1
            loadn r1, #0
            store IncRandB1, r1
            jmp RtsCmpIncB1B3
        
        SomaIncRandB13:
            inc r1
            store IncRandB1, r1

        RtsCmpIncB1B3:
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

;-----------------------------
;         BARRIL 2
;-----------------------------
MoveB2:
    push r0
    push r1
    push r2
    push r3
    push r4

    call CmpIncB2B1 ;Ele compara os índices de B2 e B1, se iguais, ele recalcula o 2
    call CmpIncB2B3
    call PosicaoInicialB2
    call CairB2

    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

CmpIncB2B1:
    loadn r0, #0               ;confere se ele está caindo ou vai cair
    load r2, posB2
    cmp r0, r2
    jne RtsCmpIncB2B1          ;se ele está caindo, já dá rts na função
    
    load r4, posB1             ;confere se B1 vai cair ou não
    cmp r0, r4
    jne IncRandB1atual2     ;se é != 0, ele está caíndo, então o IncRandB1 que a gente analisa é outro

    load r4, IncRandB1         ;já é a nova posição que o B1 vai cair
    load r1, IncRandB2   
    cmp r4, r1                 ;compara se eles vão cair no mesmo lugar
    jne RtsCmpIncB2B1          ;se não, dá rts na função

    loadn r0, #5
    cmp r0, r4                 ;confere se vai cair na última coluna
    jne Add21                   ;se não, pode só somar 1 no IncRandB2

    loadn r1, #0
    store IncRandB2, r1        ;zera o IncRandB2
    jmp RtsCmpIncB2B1

    Add21:
        inc r1
        store IncRandB2, r1    ;se ele ia cair na coluna 0, ele vai cair na 1
        jmp RtsCmpIncB2B1

    IncRandB1atual2:
        load r4, IncRandB1         ;está apontando para a próxima coluna já
        loadn r0, #0
        cmp r0, r4                 ;eu vejo se a próxima coluna é o 0 (zerou 5 + 1 = 0)
        jne Sub21                   ;se não é, pode r4-- para saber qual coluna ele está

        loadn r4, #5               ;se zerou, ele estava no fim da tabela
        load r1, IncRandB2         
        cmp r4, r1                 ;compara se ambos vão estar no fim da tabela
        jne RtsCmpIncB2B1          ;se não, rts

        loadn r4, #0               ;zera o índice se eles iriam cair na última coluna (5 + 1 = 0)
        store IncRandB2, r4
        jmp RtsCmpIncB2B1
        
        Sub21:
            dec r4                     ;r4--
            load r1, IncRandB2         
            cmp r1, r4                 ;compara se são iguais
            jne RtsCmpIncB2B1

            loadn r4, #5               ;para saber se eles estão no fim da tabela para zerar
            cmp r1, r4                 
            jne SomaIncRandB21

            ;Zera o IncRandB2
            loadn r1, #0
            store IncRandB2, r1
            jmp RtsCmpIncB2B1
        
        SomaIncRandB21:
            inc r1
            store IncRandB2, r1

        RtsCmpIncB2B1:
            rts

CmpIncB2B3:
    loadn r0, #0               ;confere se ele está caindo ou vai cair
    load r2, posB2
    cmp r0, r2
    jne RtsCmpIncB2B3          ;se ele está caindo, já dá rts na função
    
    load r4, posB3             ;confere se B3 vai cair ou não
    cmp r0, r4
    jne IncRandB3atual2     ;se é != 0, ele está caíndo, então o IncRandB1 que a gente analisa é outro

    load r4, IncRandB3         ;já é a nova posição que o B3 vai cair
    load r1, IncRandB2   
    cmp r4, r1                 ;compara se eles vão cair no mesmo lugar
    jne RtsCmpIncB2B3          ;se não, dá rts na função

    loadn r0, #5
    cmp r0, r4                 ;confere se vai cair na última coluna
    jne Add23                   ;se não, pode só somar 1 no IncRandB2

    loadn r1, #0
    store IncRandB2, r1        ;zera o IncRandB2
    jmp RtsCmpIncB2B3

    Add23:
        inc r1
        store IncRandB2, r1    ;se ele ia cair na coluna 0, ele vai cair na 1
        jmp RtsCmpIncB2B1

    IncRandB3atual2:
        load r4, IncRandB3         ;está apontando para a próxima coluna já
        loadn r0, #0
        cmp r0, r4                 ;eu vejo se a próxima coluna é o 0 (zerou 5 + 1 = 0)
        jne Sub23                   ;se não é, pode r4-- para saber qual coluna ele está

        loadn r4, #5               ;se zerou, ele estava no fim da tabela
        load r1, IncRandB2         
        cmp r4, r1                 ;compara se ambos vão estar no fim da tabela
        jne RtsCmpIncB2B3          ;se não, rts

        loadn r4, #0               ;zera o índice se eles iriam cair na última coluna (5 + 1 = 0)
        store IncRandB2, r4
        jmp RtsCmpIncB2B3
        
        Sub23:
            dec r4                     ;r4--
            load r1, IncRandB2         
            cmp r1, r4                 ;compara se são iguais
            jne RtsCmpIncB2B3

            loadn r4, #5               ;para saber se eles estão no fim da tabela para zerar
            cmp r1, r4                 
            jne SomaIncRandB23

            ;Zera o IncRandB2
            loadn r1, #0
            store IncRandB2, r1
            jmp RtsCmpIncB2B3
        
        SomaIncRandB23:
            inc r1
            store IncRandB2, r1

        RtsCmpIncB2B3:
            rts

PosicaoInicialB2:
    loadn r0, #0              ;confere se ele está caíndo
    load r2, posB2
    cmp r0, r2
    jne RtsPosicaoInicialB2
    
    load r1, IncRandB2         ;índice que vai pegar na table
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
        store IncRandB2, r1    ;Ele armazena o novo índice  
    
    RtsPosicaoInicialB2:
        rts

CairB2:
    load r0, posB2
    call ApagaB2       ;se Desenha antes, posAntB2 = posB2, então apaga o desenha que ele fez, logo aparece nada na tela

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

;-----------------------------------
;     Desenha e Apaga Barril 2
;-----------------------------------
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

;-----------------------------
;         BARRIL 3 
;-----------------------------
MoveB3:
    push r0
    push r1
    push r2
    push r3

    call CmpIncB3B1
    call CmpIncB3B2
    call PosicaoInicialB3
    call CairB3

    pop r3
    pop r2
    pop r1
    pop r0
    rts

CmpIncB3B1:
    loadn r0, #0               ;confere se ele está caindo ou vai cair
    load r2, posB2
    cmp r0, r2
    jne RtsCmpIncB3B1          ;se ele está caindo, já dá rts na função
    
    load r4, posB1             ;confere se B1 vai cair ou não
    cmp r0, r4
    jne IncRandB1atual3     ;se é != 0, ele está caíndo, então o IncRandB1 que a gente analisa é outro

    load r4, IncRandB1         ;já é a nova posição que o B1 vai cair
    load r1, IncRandB3   
    cmp r4, r1                 ;compara se eles vão cair no mesmo lugar
    jne RtsCmpIncB3B1          ;se não, dá rts na função

    loadn r0, #5
    cmp r0, r4                 ;confere se vai cair na última coluna
    jne Add31                   ;se não, pode só somar 1 no IncRandB3

    loadn r1, #0
    store IncRandB3, r1        ;zera o IncRandB3
    jmp RtsCmpIncB3B1

    Add31:
        inc r1
        store IncRandB3, r1    ;se ele ia cair na coluna 0, ele vai cair na 1
        jmp RtsCmpIncB3B1

    IncRandB1atual3:
        load r4, IncRandB1         ;está apontando para a próxima coluna já
        loadn r0, #0
        cmp r0, r4                 ;eu vejo se a próxima coluna é o 0 (zerou 5 + 1 = 0)
        jne Sub31                   ;se não é, pode r4-- para saber qual coluna ele está

        loadn r4, #5               ;se zerou, ele estava no fim da tabela
        load r1, IncRandB3         
        cmp r4, r1                 ;compara se ambos vão estar no fim da tabela
        jne RtsCmpIncB3B1          ;se não, rts

        loadn r4, #0               ;zera o índice se eles iriam cair na última coluna (5 + 1 = 0)
        store IncRandB3, r4
        jmp RtsCmpIncB3B1
        
        Sub31:
            dec r4                     ;r4--
            load r1, IncRandB3         
            cmp r1, r4                 ;compara se são iguais
            jne RtsCmpIncB3B1

            loadn r4, #5               ;para saber se eles estão no fim da tabela para zerar
            cmp r1, r4                 
            jne SomaIncRandB31

            ;Zera o IncRandB3
            loadn r1, #0
            store IncRandB3, r1
            jmp RtsCmpIncB3B1
        
        SomaIncRandB31:
            inc r1
            store IncRandB3, r1

        RtsCmpIncB3B1:
            rts

CmpIncB3B2:
    loadn r0, #0               ;confere se ele está caindo ou vai cair
    load r2, posB3
    cmp r0, r2
    jne RtsCmpIncB3B2          ;se ele está caindo, já dá rts na função
    
    load r4, posB2             ;confere se B2 vai cair ou não
    cmp r0, r4
    jne IncRandB2atual3        ;se é != 0, ele está caíndo, então o IncRandB1 que a gente analisa é outro

    load r4, IncRandB2         ;já é a nova posição que o B2 vai cair
    load r1, IncRandB3   
    cmp r4, r1                 ;compara se eles vão cair no mesmo lugar
    jne RtsCmpIncB3B2          ;se não, dá rts na função

    loadn r0, #5
    cmp r0, r4                 ;confere se vai cair na última coluna
    jne Add32                  ;se não, pode só somar 1 no IncRandB3

    loadn r1, #0
    store IncRandB3, r1        ;zera o IncRandB3
    jmp RtsCmpIncB3B2

    Add32:
        inc r1
        store IncRandB3, r1    ;se ele ia cair na coluna 0, ele vai cair na 1
        jmp RtsCmpIncB3B2

    IncRandB2atual3:
        load r4, IncRandB3         ;está apontando para a próxima coluna já
        loadn r0, #0
        cmp r0, r4                 ;eu vejo se a próxima coluna é o 0 (zerou 5 + 1 = 0)
        jne Sub32                   ;se não é, pode r4-- para saber qual coluna ele está

        loadn r4, #5               ;se zerou, ele estava no fim da tabela
        load r1, IncRandB3         
        cmp r4, r1                 ;compara se ambos vão estar no fim da tabela
        jne RtsCmpIncB3B2          ;se não, rts

        loadn r4, #0               ;zera o índice se eles iriam cair na última coluna (5 + 1 = 0)
        store IncRandB3, r4
        jmp RtsCmpIncB3B2
        
        Sub32:
            dec r4                     ;r4--
            load r1, IncRandB3         
            cmp r1, r4                 ;compara se são iguais
            jne RtsCmpIncB3B2

            loadn r4, #5               ;para saber se eles estão no fim da tabela para zerar
            cmp r1, r4                 
            jne SomaIncRandB32

            ;Zera o IncRandB3
            loadn r1, #0
            store IncRandB3, r1
            jmp RtsCmpIncB3B2
        
        SomaIncRandB32:
            inc r1
            store IncRandB3, r1

        RtsCmpIncB3B2:
            rts

PosicaoInicialB3:
    loadn r0, #0
    load r2, posB3
    cmp r0, r2
    jne RtsPosicaoInicialB3
    
    load r1, IncRandB3         ;r1 = índice atual (0 a 5)
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
        store IncRandB3, r1 ;Ele armazena o novo índice  
    
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

;-----------------------------------
;     Desenha e Apaga Barril 3
;-----------------------------------
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

;--------------------------------------------
;    Delay de aproximadamente 1 segundo
;--------------------------------------------
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
