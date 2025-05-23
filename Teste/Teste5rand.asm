jmp main

;Mensagens
Msn0: string "Pressione ENTER para jogar"

;Variaveis
posBarril: var #5
    static posBarril + #0, #0 ;inicializa no 0
    static posBarril + #1, #0 ;inicializa no 0
    static posBarril + #2, #0 ;inicializa no 0
    static posBarril + #3, #0 ;inicializa no 0
    static posBarril + #4, #0 ;inicializa no 0

posAntBarril: var #5
    static posAntBarril + #0, #0 ;inicializa no 0
    static posAntBarril + #1, #0 ;inicializa no 0
    static posAntBarril + #2, #0 ;inicializa no 0
    static posAntBarril + #3, #0 ;inicializa no 0
    static posAntBarril + #4, #0 ;inicializa no 0

parametroBarril: var #1 ;Para saber qual Barril está caindo

IncRandBarril: var #5
    static IncRandBarril + #0, #0 ;inicializa no 0
    static IncRandBarril + #1, #0 ;inicializa no 0
    static IncRandBarril + #2, #0 ;inicializa no 0
    static IncRandBarril + #3, #0 ;inicializa no 0
    static IncRandBarril + #4, #0 ;inicializa no 0

RandBarril: var #6
    static RandBarril + #0, #247
    static RandBarril + #1, #275
    static RandBarril + #2, #263
    static RandBarril + #3, #246
    static RandBarril + #4, #271
    static RandBarril + #5, #244

FlagColuna: var #6
    static FlagColuna + #0, #0
    static FlagColuna + #1, #0
    static FlagColuna + #2, #0
    static FlagColuna + #3, #0
    static FlagColuna + #4, #0
    static FlagColuna + #5, #0

main:
    call Menu

    loadn r2, #0
    loadn r0, #0

    Loopmain:

        loadn r7, #0 ;r7 vai ser meio que um parâmetro
        store parametroBarril, r7
        loadn r1, #2 ;Começa quando for um múltiplo de 5
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveBarril

        loadn r7, #1 ;r7 vai ser meio que um parâmetro
        store parametroBarril, r7
        loadn r1, #3 ;Começa quando for um múltiplo de 5
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveBarril
        
        loadn r7, #2 ;r7 vai ser meio que um parâmetro
        store parametroBarril, r7
        loadn r1, #4 ;Começa quando for um múltiplo de 5
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveBarril
        
        loadn r7, #3 ;r7 vai ser meio que um parâmetro
        store parametroBarril, r7
        loadn r1, #5 ;Começa quando for um múltiplo de 5
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveBarril

        loadn r7, #4 ;r7 vai ser meio que um parâmetro
        store parametroBarril, r7
        loadn r1, #6 ;Começa quando for um múltiplo de 5
        mod r1, r0, r1
        cmp r1, r2 
        ceq MoveBarril

        call Delay

        inc r0
        
        jmp Loopmain

    fim:
        halt

;-------------------------------------------
;                  MENU
;-------------------------------------------
Menu:
    loadn r0, #247 ;onde inicia a frase
    loadn r1, #Msn0
	loadn r2, #0 ;se quiser add cor 0 é nada
    call ImprimeSTR

    LoopMenu:
        inchar r4
        loadn r1, #13 ;tecla enter
        
        inc r2 ;faz a soma aleatória para dar o rand

        cmp r4, r1
        jne LoopMenu

        loadn r5, #6
        mod r3, r2, r5

        loadn r0, #IncRandBarril
        storei r0, r3   

    rts

;-------------------------------------------
;             MoveBarril
;-------------------------------------------
MoveBarril:
    call PosicaoInicialBarril
    call CairBarril

    rts

PosicaoInicialBarril:
    push r0
    push r1
    push r2
    push r3
    push r4

    load r0, parametroBarril
    loadn r4, #0
    cmp r0, r4
    jeq FlagCaindo

    FlagCaindo:
        loadn r3, #posBarril       ;r3 = endereço base da tabela
        add r3, r3, r0             ;r3 = endereço de RandBarril[r0]
        loadi r2, r3               ;r2 = posBarril[r0] 
        
        loadn r4, #0
        cmp r2, r4                 ;Cmp se posBarril == 0, se sim, ele tem que cair
        jeq VaiCair

        jmp RtsPosicaoInicialBarril

    VaiCair:
        ;r2 == 0 => posBarril 

        call AcharIncRandBarril 
        
        load r0, parametroBarril
        loadn r3, #IncRandBarril
        add r3, r3, r0
        loadi r1, r3
        
        loadn r4, #RandBarril      ;r4 = endereço base da tabela
        add r4, r4, r1             ;r4 = endereço de RandBarril[r1]
        loadi r2, r4               ;r2 = RandBarril[r1] (posição aleatória)
        
        loadn r4, #posBarril
        add r4, r4, r0             ;generalizei para achar qual barril que vai cair
        storei r4, r2              ;guarda a posBarril[r0] no endereço posBarril[r0] 

        call LigarFlag
        
        inc r1

        loadn r0, #6
        cmp r1, r0                 ;Compara se o índice já chegou no fim da tabela
        jne StoreIncBarril

        ;ZeraIndice:
        loadn r1, #0

        StoreIncBarril:
            storei r3, r1 ;Ele armazena o novo índice no r3 -> endereço IncRandBarril[parêmetro]

        RtsPosicaoInicialBarril:
            pop r4
            pop r3
            pop r2
            pop r1
            pop r0
            rts             

CairBarril:
    push r0
    push r1
    push r2
    push r3
    push r4

    loadn r0, #0
    loadn r3, #posBarril
    load r4, parametroBarril
    add r3, r3, r4 ;posBarril[r4] bonitinho, apontado já
    loadi r2, r3 ;r2 == posBarrilatual

    call ApagaBarril

    loadn r1, #40
    add r0, r1, r2 ;Barril desce uma linha

    ;Comparação se chegou no chão
    div r4, r0, r1
    loadn r1, #27
    cmp r4, r1
    jeq Nochao

    call DesenhaBarril
    storei r3, r0 ;posbarril[r4] == r0 já na próxima linha

    loadn r0, #posAntBarril
    load r1, parametroBarril
    add r0, r1, r0 ;posAntBarril[r1]
    
    storei r0, r2 ;posAntBarril[r1]

    
    jmp RtsCairBarril

    Nochao:
        loadn r0, #0
        storei r3, r0

        call ZerarFlag

    RtsCairBarril:
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

AcharIncRandBarril:
    push r0
    push r1
    push r2
    push r3
    push r4

    load r1, parametroBarril ;para saber qual barril vai cair
    loadn r0, #IncRandBarril ;Endereço do Vetor dos Incrementos
    add r0, r0, r1 ;r0 == Endereço IncRandBarril[r1]
    loadi r2, r0 ; Valor do IncRandBarril[r1]

    LoopFlags: ;Até achar a flag livre
        loadn r1, #FlagColuna
        add r1, r1, r2 ;endereço da FlagColuna[r2]
        loadi r3, r1 ;valor da flag (0 ou 1)

        loadn r4, #0
        cmp r3, r4
        jeq RtsAcharIncRandBarril ;se a flag está desligada, rts

        inc r2 ;incremento o índice do barril

        ;vê se precisa zerar o índice
        loadn r1, #6
        cmp r1, r2
        jne LoopFlags

        ;zera o índice
        loadn r2, #0
        jmp LoopFlags

    RtsAcharIncRandBarril:
        storei r0, r2 ;r0 tem o endereço do IncRandBarril[parametroBarril]

        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

LigarFlag:
    push r0
    push r1
    push r2

    loadn r0, #IncRandBarril
    load r1, parametroBarril
    add r0, r0, r1
    loadi r2, r0 ;valor do incremento do IncRandBarril[parametroBarril]

    loadn r1, #FlagColuna
    add r1, r1, r2 ;Endereço FlagColuna[r2]

    loadn r0, #1
    storei r1, r0 ;Flag Ligada!

    pop r2
    pop r1
    pop r0
    rts

ZerarFlag:
    push r0
    push r1
    push r2
    push r3
    
    loadn r0, #IncRandBarril
    load r1, parametroBarril
    add r0, r0, r1
    loadi r2, r0 ;valor do incremento do IncRandBarril[parametroBarril]

    ;como IncRandBarril sempre aponta já para a próxima coluna
    ;confere primeiro, se é zero, caso não seja: r2--
    loadn r3, #0
    cmp r2, r3
    jne SubIncRandBarril

    loadn r2 #5 ;como os índices são ciclicos, antes de 0 é 5

    jmp DesligaFlag

    SubIncRandBarril:
        dec r2

    DesligaFlag:
        loadn r1, #FlagColuna
        add r1, r1, r2 ;Endereço FlagColuna[r2]

        loadn r0, #0
        storei r1, r0 ;Flag Ligada!

        pop r3
        pop r2
        pop r1
        pop r0
        rts
;-------------------------------------------
;           Desenha e Apaga B1
;-------------------------------------------
DesenhaBarril:
    push r0
    push r1
    push r2
    push r3

    loadn r0, #posBarril
    load r1, parametroBarril
    add r0, r1, r0 ;posBarril[r1]
    loadi r2, r0 ;tem a posBarril[r1]

    loadn r3, #'O'
    outchar r3, r2
    
    pop r3
    pop r2
    pop r1
    pop r0
    rts

ApagaBarril:
    push r0
    push r1
    push r2

    loadn r0, #posAntBarril
    load r1, parametroBarril
    add r0, r1, r0 ;posAntBarril[r1]
    loadi r2, r0 ;tem a posAntBarril[r1]

    loadn r1, #' '
    outchar r1, r2

    pop r2
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
        loadn r0, #2500

    DelayVolta1:
        dec r0
        jnz DelayVolta1
        dec r1
        jnz DelayVolta2

        pop r1
        pop r0
        rts

;-------------------------------------------
;             Imprime String
;-------------------------------------------
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
