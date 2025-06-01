jmp main
;barril
posBarril: var #10
    static posBarril + #0, #0 ;inicializa no 0
    static posBarril + #1, #0 ;inicializa no 0
    static posBarril + #2, #0 ;inicializa no 0
    static posBarril + #3, #0 ;inicializa no 0
    static posBarril + #4, #0 ;inicializa no 0
    static posBarril + #5, #0 ;inicializa no 0
    static posBarril + #6, #0 ;inicializa no 0
    static posBarril + #7, #0 ;inicializa no 0
    static posBarril + #8, #0 ;inicializa no 0
    static posBarril + #9, #0 ;inicializa no 0

posAntBarril: var #10
    static posAntBarril + #0, #0 ;inicializa no 0
    static posAntBarril + #1, #0 ;inicializa no 0
    static posAntBarril + #2, #0 ;inicializa no 0
    static posAntBarril + #3, #0 ;inicializa no 0
    static posAntBarril + #4, #0 ;inicializa no 0
    static posAntBarril + #5, #0 ;inicializa no 0
    static posAntBarril + #6, #0 ;inicializa no 0
    static posAntBarril + #7, #0 ;inicializa no 0
    static posAntBarril + #8, #0 ;inicializa no 0
    static posAntBarril + #9, #0 ;inicializa no 0

FlagCaindo: var #10

parametroBarril: var #1 ;Para saber qual Barril está caindo

IncRandBarril: var #10
    static IncRandBarril + #0, #0 ;inicializa no 0
    static IncRandBarril + #1, #0 ;inicializa no 0
    static IncRandBarril + #2, #0 ;inicializa no 0
    static IncRandBarril + #3, #0 ;inicializa no 0
    static IncRandBarril + #4, #0 ;inicializa no 0
    static IncRandBarril + #5, #0 ;inicializa no 0
    static IncRandBarril + #6, #0 ;inicializa no 0
    static IncRandBarril + #7, #0 ;inicializa no 0
    static IncRandBarril + #8, #0 ;inicializa no 0
    static IncRandBarril + #9, #0 ;inicializa no 0

RandBarril: var #40
    static RandBarril + #0, #267
    static RandBarril + #1, #245
    static RandBarril + #2, #253
    static RandBarril + #3, #273
    static RandBarril + #4, #251
    static RandBarril + #5, #264
    static RandBarril + #6, #269
    static RandBarril + #7, #277
    static RandBarril + #8, #248
    static RandBarril + #9, #241
    static RandBarril + #10, #246
    static RandBarril + #11, #258
    static RandBarril + #12, #274
    static RandBarril + #13, #255
    static RandBarril + #14, #259
    static RandBarril + #15, #244
    static RandBarril + #16, #262
    static RandBarril + #17, #249
    static RandBarril + #18, #260
    static RandBarril + #19, #243
    static RandBarril + #20, #272
    static RandBarril + #21, #275
    static RandBarril + #22, #278
    static RandBarril + #23, #266
    static RandBarril + #24, #256
    static RandBarril + #25, #261
    static RandBarril + #26, #257
    static RandBarril + #27, #268
    static RandBarril + #28, #279
    static RandBarril + #29, #270
    static RandBarril + #30, #250
    static RandBarril + #31, #247
    static RandBarril + #32, #263
    static RandBarril + #33, #242
    static RandBarril + #34, #276
    static RandBarril + #35, #252
    static RandBarril + #36, #265
    static RandBarril + #37, #254
    static RandBarril + #38, #240
    static RandBarril + #39, #271

FlagColuna: var #40 ;inicializa no zero == flag desligada

posMario: var #1
posAntMario: var #1

;Codigo principal
main:
	loadn r1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #30720  			; cor branca!
	call ImprimeTela

	loadn r2, #0 ;inicializa o contador com 0 

	Loopmenu:
		inchar r4
		loadn r1, #13 ;tecla enter
		
		inc r2 ;faz a soma aleatória para dar o rand

		cmp r4, r1
		jne Loopmenu

		loadn r5, #6
		mod r3, r2, r5

		loadn r0, #IncRandBarril
		storei r0, r3

    Restart:
        call Inicializacao

        call ApagaTela
        loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
        loadn R2, #25600  			; cor branca!
        call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
        
        loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
        loadn R2, #10240  ;COR DA Onda
        call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
        
        loadn r0, #1119
        store posMario, r0 ;mario começa na linha 27, coluna 39
        call DesenhaMario

        loadn r0, #0	
        loadn r2, #0	

        Loop:
            loadn r1, #2
            mod r1, r0, r1
            cmp r1, r2
            ceq MoveMario

            loadn r7, #0 ;r7 vai ser meio que um parâmetro
            store parametroBarril, r7
            loadn r1, #2 ;Começa quando for um múltiplo de 2
            mod r1, r0, r1
            cmp r1, r2 
            ceq MoveBarril

            loadn r7, #1 ;r7 vai ser meio que um parâmetro
            store parametroBarril, r7
            loadn r1, #3 ;Começa quando for um múltiplo de 3
            mod r1, r0, r1
            cmp r1, r2 
            ceq MoveBarril
            
            loadn r7, #2 ;r7 vai ser meio que um parâmetro
            store parametroBarril, r7
            loadn r1, #4 ;Começa quando for um múltiplo de 4
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
            loadn r1, #6 ;Começa quando for um múltiplo de 6
            mod r1, r0, r1
            cmp r1, r2 
            ceq MoveBarril

            loadn r7, #5 ;r7 vai ser meio que um parâmetro
            store parametroBarril, r7
            loadn r1, #2 ;Começa quando for um múltiplo de 2
            mod r1, r0, r1
            cmp r1, r2 
            ceq MoveBarril

            loadn r7, #6 ;r7 vai ser meio que um parâmetro
            store parametroBarril, r7
            loadn r1, #3 ;Começa quando for um múltiplo de 3
            mod r1, r0, r1
            cmp r1, r2 
            ceq MoveBarril
            
            loadn r7, #7 ;r7 vai ser meio que um parâmetro
            store parametroBarril, r7
            loadn r1, #4 ;Começa quando for um múltiplo de 4
            mod r1, r0, r1
            cmp r1, r2 
            ceq MoveBarril
            
            loadn r7, #8 ;r7 vai ser meio que um parâmetro
            store parametroBarril, r7
            loadn r1, #5 ;Começa quando for um múltiplo de 5
            mod r1, r0, r1
            cmp r1, r2 
            ceq MoveBarril

            loadn r7, #9 ;r7 vai ser meio que um parâmetro
            store parametroBarril, r7
            loadn r1, #6 ;Começa quando for um múltiplo de 6
            mod r1, r0, r1
            cmp r1, r2 
            ceq MoveBarril

            call Delay

            inc r0 	;contador++
            
            jmp Loop
	
    fim:
        call ApagaTela
        
        halt

;--------------------------------------------
;               Inicialização
;--------------------------------------------
Inicializacao:
    ;Zera as flags
    push r0
    push r1
    push r2
    push r3

    loadn r0, #FlagCaindo ;sempre é endereço, não flag
    loadn r2, #10 ;número de flags (como são de 0 - 4, se o r3 == 5, passou do número de flags existentes)
    loadn r1, #0 ;vai ser o 0 que zera as flags
    store posAntMario, r1
    loadn r3, #0 ;contador para não passar o número de flags -> qual flag que é
    LoopFlagCaindo0:
        storei r0, r1 ;endereço da flag recebe 0

        inc r0 ;vai para o próximo endereço da flag
        inc r3 ;vai para a próxima flag 

        cmp r3, r2
        jne LoopFlagCaindo0
        
    loadn r3, #0 ;contador para não passar o número de flags -> qual flag que é
    loadn r0, #FlagColuna
    loadn r2, #40 ;número de flags (como são de 0 - 5, se o r3 == 6, passou do número de flags existentes)
    LoopFlagColuna0:
        storei r0, r1 ;endereço da flag recebe 0

        inc r0 ;vai para o próximo endereço da flag
        inc r3 ;vai para a próxima flag 

        cmp r3, r2
        jne LoopFlagColuna0

    pop r3
    pop r2
    pop r1
    pop r0
    rts

;--------------------------------------------
;               MoveMario
;--------------------------------------------	
MoveMario:
    push r0
    push r1
    push r2

    load r0, posAntMario
    loadn r2, #135 ;linha 3 coluna 15
    cmp r0, r2
    ceq Venceu

    call Suicidou

	call MoveMario_RecalculaPos		;Recalcula Posicao do Mario

    ;Só apaga e Redesenha se (pos != posAnt) não precisava, mas deixa minimamente mais rápido
	load r0, posMario
	load r1, posAntMario
	cmp r0, r1
	jeq RtsMoveMario
	
	;Se Próxima instrucao do mario for o chao ou parede, nao move
	call ApagaMario
	call DesenhaMario	

    RtsMoveMario:
	
        pop r2
        pop r1
        pop r0
        rts

MoveMario_RecalculaPos:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6

    load r0, posMario

    inchar r1 ;lê o teclado

    loadn r2, #'a'
    cmp r1, r2
    jeq MoveMario_RecalculaPos_A

    loadn r2, #'d'
    cmp r1, r2
    jeq MoveMario_RecalculaPos_D

    loadn r2, #'w'
    cmp r1, r2
    jeq MoveMario_RecalculaPos_W

    loadn r2, #'s'
    cmp r1, r2
    jeq MoveMario_RecalculaPos_S

    StoreposMario:
        store posMario, r0

    RtsMoveMario_RecalculaPos:
        pop r6
        pop r5
        pop r4
        pop r3
        pop r2
        pop r1
        pop r0
        rts

    ;Move para a esquerda
    MoveMario_RecalculaPos_A:
        ;Verifica se está na parede
        loadn r1, #40
        loadn r2, #0
        mod r1, r0, r1      ;coluna posMario atual
        cmp r1, r2          ;Se ele já tiver na coluna 0, não tem mais o que andar
        jeq RtsMoveMario_RecalculaPos  

        ;Verifica se tem chão: 
            mov r6, r0          ;r0 é fixo para mexer na posMario 
            loadn r2, #40
            dec r6              ;vai para a esquerda
            add r6, r6, r2      ;vai para linha de baixo
            div r1, r6, r2      ;linha posMario + 40
            mod r4, r6, r2      ;coluna posMario + 40

            ;calcula endereço: tela1 + linha*41(40 + '\0') + coluna
            loadn r3, #41
            mul r1, r1, r3      ;deslocamento da linha (linha * 41)
            
            loadn r3, #tela1Linha0
            add r3, r3, r1      ;endereço da linha
            add r3, r3, r4      ;endereço final do caractere (soma coluna)
            loadi r6, r3        ;vê o que tem lá

            loadn r5, #'='
            cmp r6, r5
            jne RtsMoveMario_RecalculaPos  ;se não for chão, rts

        dec r0              ;se tiver chão anda para esquerda
        jmp StoreposMario

    ;Move para direita
    MoveMario_RecalculaPos_D:
        ;Verifica se está na parede
        loadn r1, #40
        loadn r2, #0
        mod r1, r0, r1      ;coluna posMario atual
        loadn r1, #39       ;se ele está na coluna 39, não tem mais o que andar
        cmp r1, r2
        jeq RtsMoveMario_RecalculaPos  

        ;Verifica se tem chão
            mov r6, r0          ;r0 == posMario, reservado
            loadn r2, #40
            inc r6              ;vai para a direita
            add r6, r6, r2      ;vai para linha de baixo
            div r1, r6, r2      ;linha posMario + 1 + 40
            mod r4, r6, r2      ;coluna posMario + 1 + 40

            ;calcula endereço: tela1 + linha*41(40 + '\0') + coluna
            loadn r3, #41
            mul r1, r1, r3      ;deslocamento da linha (linha * 41)
            loadn r3, #tela1Linha0
            add r3, r3, r1      ;endereço da linha
            add r3, r3, r4      ;endereço final do caractere

            loadi r6, r3        ;vê o que tem no endereço

            loadn r5, #'='
            cmp r6, r5
            jne RtsMoveMario_RecalculaPos  ;se não for chão, não anda

        inc r0              ;anda para a direita
        jmp StoreposMario


    ;Move para cima
    MoveMario_RecalculaPos_W:
        ;calcula o endereço do caractere no mapa da escada
            loadn r2, #40
            loadn r1, #tela3Linha0
            add r4, r0, r1    ;endereço da tela3Linha0 + posMario
            div r5, r0, r2    ;pos / 40 (quantidade de '\0' anteriores)
            add r4, r4, r5    ;endereço da tela3Linha0 + posMario + '\0'
            loadi r6, r4      ;vê o que tem no mapa

            loadn r5, #'n'
            cmp r6, r5
            jne RtsMoveMario_RecalculaPos ;se não tiver o 'n' -> pode ser qualquer caractere, mas tem que atualizar a tela3

        sub r0, r0, r2 ;sobe 1 linha
    
        jmp StoreposMario

    MoveMario_RecalculaPos_S:
        loadn r2, #40
        mov   r6, r0         ;r0 é fixo para a posMario
        add   r6, r6, r2     ;desce uma linha
        div   r1, r6, r2     ;linha posMario + 40 
        mod   r4, r6, r2     ;coluna posMario + 40

        ;Calcula o endereço da posição na tela3 (mapa de escadas)
            loadn r3, #41         ;40 + \0
            mul r1, r1, r3        ;deslocamento da linha (linha * 41)
            
            loadn r3, #tela3Linha0
            add r3, r3, r1        ;endereço da tela3 + linha (linha * 41)
            add r3, r3, r4        ;endereço da tela3 + linha (linha * 41) + coluna

            loadi r6, r3            ;vê o que tem nesse endereço

            loadn r5, #'n'
            cmp   r6, r5
            jne   RtsMoveMario_RecalculaPos ;se não for 'n', rts

    ;Desce para a próxima linha
    add   r0, r0, r2
    
    ;como ele está nadando contra a correnteza, é mais lento
    call Delay
    call Delay
    call Delay

    jmp   StoreposMario

;--------------------------------------------
;                 Venceu
;--------------------------------------------
Venceu:
    push r0
    push r1
    push r2
    push r3

    call ApagaTela          ;Apago o cenário do jogo

    loadn r1, #tela5Linha0	;Imprimo a tela do vencedor
	loadn r2, #30720 		;cor roxa
	call ImprimeTela

	loadn r2, #0 ;inicializa o contador com 0 

    loadn r0, #'s'
    loadn r3, #'n'

    LoopVenceu:
        inchar r1 ;lê o teclado
        inc r2 ;contador++ 
        
        cmp r1, r3 ;compara se a pessoa digitou 'n'
        jeq fim

        cmp r1, r0  ;compara se a pessoa digitou 's'
        jeq Sim

        jmp LoopVenceu ;se ela não digitou nada ou digitou algo 'não permitido', volta para o loop

    Sim:
        ;gera o randômico sempre para o barril 0 -> mais rápido
		loadn r5, #6 ;tamanho da tabela de randômicos
		mod r3, r2, r5 ;deixo o valor entre 0 e 5

		loadn r0, #IncRandBarril ;endereço do índice do barril[0]
		storei r0, r3 ;guardo o valor aleatório entre 0 e 5, no índice do barril 0

        pop r3
        pop r2
        pop r1
        pop r0

        pop r0 ;desempilha tudo, não vai ter o rts, vai direto no main

        jmp Restart

;--------------------------------------------
;                 Suicidou
;--------------------------------------------
Suicidou:
    push r0
    push r1
    push r2
    push r3
    push r4

    load r0, posAntMario
    loadn r1, #0 ;contador
    loadn r2, #40 ;limite do contador
    loadn r3, #posAntBarril ;endereço da posAntBarril[0]
    LoopConfere:
        add r3, r3, r1 ;endereço do posAntBarril[contador] (podia fazer só o inc r3 também)
        loadi r4, r3   ;para ver qual a posAntBarril[contador]

        cmp r4, r0 ;compara posAntBarril x posAntMario
        jeq Suicidio

        inc r1

        cmp r1, r2 ;vê se já checou todos os barris
        jne LoopConfere 

    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

    Suicidio:
        call ApagaTela

        loadn r1, #tela4Linha0	    ;endereco onde comeca a primeira linha do cenario
        loadn r2, #30720  			;cor roxa
        call ImprimeTela

        loadn r2, #0 ;inicializa o contador com 0 

        loadn r0, #'s'
        loadn r3, #'n'

        LoopSuicidio:
            inchar r1 ;lê o que a pessoa escreveu
        
            inc r2    ;contador++
        
            cmp r1, r3 ;se ele digitou 'n'
            jeq fim

            cmp r1, r0 ;se ele digitou 's'
            jeq SimS

            jmp LoopSuicidio ;se ele não digitou/digitou outra coisa

        SimS:
            ;gera o randômico sempre para o barril 0 -> mais rápido
            loadn r5, #41 ;tamanho da tabela de randômicos
            mod r3, r2, r5 ;deixo o valor entre 0 e 5

            loadn r0, #IncRandBarril ;endereço do índice do barril[0]
            storei r0, r3 ;guardo o valor aleatório entre 0 e 5, no índice do barril 0

            pop r3
            pop r2
            pop r1
            pop r0

            pop r0 ;desempilha tudo, não vai ter o rts, vai direto no main

            jmp Restart

;--------------------------------------------
;            Desenha e Apaga Mario 
;--------------------------------------------
DesenhaMario:
    push r0
    push r1

    load r0, posMario
    loadn r1, ':'
    outchar r1, r0

    store posAntMario, R0 ;Se o mario anda, a posAntMario é atualizada quando é desenhado

    pop r1
    pop r0
    rts

ApagaMario:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5

    load r0, posAntMario

	loadn r1, #tela0Linha0	;Endereço do cenário tela1 + tela2
	add r2, r1, r0	;r2 = endereço tela0Linha0 + posAntMario

	loadn r4, #40
	div r3, r0, r4	;r3 = linha posAntMario
	add r2, r2, r3	;r2 = endereço tela0Linha0 + posAntMario + posAnt/40
	
	loadi r5, r2	;vê o que tinha no cenário

    outchar r5, r0         ;desenha o que tinha antes -> sem o Mario

    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts

;-------------------------------------------
;                 MoveBarril
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

    load r0, parametroBarril   ;vê qual barril que está caindo [0 a 4]
    loadn r3, #FlagCaindo      ;r3 = endereço da FlagCaindo[0]
    add r3, r3, r0             ;r3 = endereço da FlagCaindo[parametroBarril]
    loadi r2, r3               ;r2 = valor da FlagCaindo[parametroBarril] 
        
    loadn r4, #0
    cmp r2, r4                 ;Cmp se FlagBarril == 0, se sim, ele tem que cair
    jeq VaiCair

    jmp RtsPosicaoInicialBarril

    VaiCair:

        call AcharIncRandBarril 
        
        load r0, parametroBarril
        loadn r3, #IncRandBarril
        add r3, r3, r0
        loadi r1, r3               ;r1 = IncRandBarril[parametroBarril]
        
        loadn r4, #RandBarril      ;r4 = endereço base da tabela
        add r4, r4, r1             ;r4 = endereço de RandBarril[IncRandBarril[parametroBarril]]
        loadi r2, r4               ;r2 = RandBarril[IncRandBarril[parametroBarril]] (posição inicial)
        
        loadn r4, #posBarril
        add r4, r4, r0             ;r4 = endereço posBarril[parametroBarril]
        storei r4, r2              ;guarda a posição inicial no endereço posBarril[parametroBarril] 

        loadn r4, #FlagCaindo
        add r4, r4, r0             ;endereço da FlagCaindo[parametroBarril]
        loadn r0, #1
        storei r4, r0              ;FlagCaindo[parametroBarril] == 1 porque o Barril já começou a cair
        
        inc r1  ;aumenta o índice IncRandBarril[parametroBarril] (ex: 0 para 1)

        loadn r0, #40
        cmp r1, r0                 ;Compara se o índice já chegou no fim da tabela
        jne StoreIncBarril

        ;ZeraIndice:
        loadn r1, #0

        StoreIncBarril:
            storei r3, r1 ;Ele armazena o novo índice no r3 -> endereço IncRandBarril[parametroBarril]

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
    add r3, r3, r4 ;r3 == ENDEREÇO posBarril [parametroBarril] -> não vou mexer mais no r3!! 
    loadi r2, r3 ;r2 == posBarril[parametroBarril]

    ;tem que apagar primeiro, pois eu atualizo a posAntBarril no desenhaBarril, ou seja, ele ia desenhar e apagar logo em seguida
    call ApagaBarril

    loadn r1, #40
    add r0, r2, r1 ;Barril desce uma linha

    ;Comparação se chegou no chão:
        div r4, r0, r1
        loadn r1, #29
        cmp r4, r1
        jeq Nochao

    call DesenhaBarril
    storei r3, r0 ;posbarril[parametroBarril] == r0 já na próxima linha

    ;Vejo se colidiu com o mário:
        load r0, posAntMario
        cmp r0, r2
        ceq Morreu
    
    jmp RtsCairBarril

    Nochao:
        loadn r0, #0
        load r1, parametroBarril
        loadn r3, #FlagCaindo      ;r3 = endereço da FlagCaindo[0]
        add r3, r3, r1             ;r3 = endereço da FlagCaindo[parametroBarril]
        storei r3, r0              ;zera a FlagCaindo[parametroBarril]

        call ZerarFlag             ;zera a FlagColuna

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

    load r1, parametroBarril        ;para saber qual barril vai cair
    loadn r0, #IncRandBarril        ;Endereço do vetor dos índices
    add r0, r0, r1                  ;r0 == Endereço IncRandBarril[parametroBarril]
    loadi r2, r0                    ;r2 == IncRandBarril[parametroBarril]

    LoopFlags: ;Até achar a flag livre
        loadn r1, #FlagColuna
        add r1, r1, r2 ;endereço da FlagColuna[r2]
        loadi r3, r1 ;valor da flag (0 ou 1)

        loadn r4, #0
        cmp r3, r4
        jeq RtsAcharIncRandBarril ;se a flag está desligada, rts

        inc r2 ;incrementa o índice do barril

        ;vê se precisa zerar o índice:
            loadn r1, #40
            cmp r1, r2
            jne LoopFlags

        ;zera o índice:
            loadn r2, #0
            jmp LoopFlags

    RtsAcharIncRandBarril:
        storei r0, r2 ;r0 tem o endereço do IncRandBarril[parametroBarril]

        call LigarFlag ;Assim que eu acho qual coluna ele vai cair, pode ligar a FlagColuna

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
    loadi r2, r0 ;valor do índice(0 a 5) do IncRandBarril[parametroBarril]

    loadn r1, #FlagColuna
    add r1, r1, r2 ;Endereço FlagColuna[IncRandBarril[parametroBarril]]

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
    loadi r2, r0 ;valor do índice do IncRandBarril[parametroBarril]

    ;como IncRandBarril sempre aponta já para a próxima coluna
    ;confere primeiro, se é zero, caso não seja: r2--
    loadn r3, #0
    cmp r2, r3
    jne SubIncRandBarril

    loadn r2, #41 ;como os índices são ciclicos, antes de 0 é 5

    jmp DesligaFlag

    SubIncRandBarril:
        dec r2

    DesligaFlag:
        loadn r1, #FlagColuna
        add r1, r1, r2 ;endereço FlagColuna[IncRandBarril[parametroBarril]]

        loadn r0, #0
        storei r1, r0 ;Flag Desligada!

        pop r3
        pop r2
        pop r1
        pop r0
        rts

;--------------------------------------------
;                 Morreu
;--------------------------------------------
Morreu:
    push r0
    push r1
    push r2
    push r3

    call ApagaTela

    loadn r1, #tela4Linha0	    ;endereco onde comeca a primeira linha do cenario
	loadn r2, #30720  			;cor roxa
	call ImprimeTela

	loadn r2, #0 ;inicializa o contador com 0 

    loadn r0, #'s'
    loadn r3, #'n'

    LoopMorreu:
        inchar r1 ;lê o que a pessoa escreveu
    
        inc r2    ;contador++
    
        cmp r1, r3 ;se ele digitou 'n'
        jeq fim

        cmp r1, r0 ;se ele digitou 's'
        jeq SimM

        jmp LoopMorreu ;se ele não digitou/digitou outra coisa

    SimM:
        ;gera o randômico sempre para o barril 0 -> mais rápido
		loadn r5, #6 ;tamanho da tabela de randômicos
		mod r3, r2, r5 ;deixo o valor entre 0 e 5

		loadn r0, #IncRandBarril ;endereço do índice do barril[0]
		storei r0, r3 ;guardo o valor aleatório entre 0 e 5, no índice do barril 0

        pop r3
        pop r2
        pop r1
        pop r0

        pop r0 ;desempilha tudo, não vai ter o rts, vai direto no main

        jmp Restart

;-------------------------------------------
;          Desenha e Apaga Barril
;-------------------------------------------
DesenhaBarril:
    push r0
    push r1
    push r2
    push r3

    loadn r0, #posBarril
    load r1, parametroBarril
    add r0, r1, r0 ;r0 = endereço do posBarril[parametroBarril]
    loadi r2, r0 ;r2 = valor do posBarril[parametroBarril]

    loadn r3, #'O'
    outchar r3, r2

    ;Atualiza o posAntBarril
    loadn r0, #posAntBarril
    add r0, r0, r1  ;endereço posAntBarril[parametroBarril]
    storei r0, r2   ;guardo o valor do posBarril[parametroBarril] no endereço do posAntBarril[parametroBarril]
    
    pop r3
    pop r2
    pop r1
    pop r0
    rts

ApagaBarril:
    push r0
    push r1
    push r2
    push r3
    push r4
    push r5

    loadn r0, #posAntBarril
    load r1, parametroBarril
    add r0, r1, r0
    loadi r2, r0            ;r2 = posAntBarril[parametroBarril]

	loadn r1, #tela0Linha0	;endereço do cenário (tela1 + tela2)
	add r0, r1, r2	        ;r2 = tela0Linha0 + posAntBarril
	loadn r4, #40
	div r3, r2, r4	        ;r3 = linha do posAntBarril
	add r0, r0, r3	        ;r0 = endereço tela0Linha0 + posAntBarril + linha do posAntBarril
	
	loadi r5, r0	        ;vê o que tinha nesse endereço


    outchar r5, r2         ;redesenha o que tinha antes -> sem o barril

    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    pop r0
    rts
;--------------------------------------------
;                 Delay 
;--------------------------------------------		
Delay:
    push r0
    push r1

    loadn r1, #15

    DelayVolta2:
        loadn r0, #1000

    DelayVolta1:
        dec r0
        jnz DelayVolta1
        dec r1
        jnz DelayVolta2

        pop r1
        pop r0
        rts

;--------------------------------------------
;             Imprime Tela
;--------------------------------------------
ImprimeTela:
	;r1 = endereco onde comeca a primeira linha do Cenario
	;r2 = cor do Cenario para ser impresso

	push r0	
	push r1	
	push r2	
	push r3	
	push r4
	push r5

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

	pop r5	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;--------------------------------------------
;             Imprime String 
;--------------------------------------------
ImprimeStr:	 
    ;r0 = Posicao da tela que o primeiro caractere da mensagem será impresso 
    ;r1 = endereco onde comeca a mensagem
    ;r2 = cor da mensagem

	push r0	
	push r1	
	push r2	
	push r3	
	push r4
	
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
	pop r4	
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;--------------------------------------------
;               Imprime Tela 2
;--------------------------------------------
ImprimeTela2:
	;r1 = endereco onde comeca a primeira linha do Cenario
	;r2 = cor do Cenario para ser impresso

	push r0	
	push r1	
	push r2	
	push r3	
	push r4
	push r5	
	push r6	

	loadn r0, #0  	        ;posicao inicial tem que ser o comeco da tela
	loadn r3, #40  	        ;incremento da posicao da tela
	loadn r4, #41  	        ;incremento do ponteiro das linhas da tela
	loadn r5, #1200         ;limite da tela
	loadn r6, #tela0Linha0	;endereco onde comeca a primeira linha do cenario
	
   ImprimeTela2_Loop:
		call ImprimeStr2
		add r0, r0, r3  	;incrementa posicao para a segunda linha na tela (r0 = r0 + 40)
		add r1, r1, r4  	;incrementa o ponteiro para o comeco da proxima linha na memoria (40 + '/0') (r1 = r1 + 41)
		add r6, r6, r4  	;incrementa o ponteiro para o comeco da proxima linha na memoria (40 + '/0') (r1 = r1 + 41)
		cmp r0, r5			;compara r0 com 1200
		jne ImprimeTela2_Loop	

	pop r6	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;--------------------------------------------
;             Imprime String 2
;--------------------------------------------
ImprimeStr2: 
    ;r0 = Posicao da tela que o primeiro caractere da mensagem será impresso  
    ;r1 = endereco onde comeca a mensagem
    ;r2 = cor da mensagem. 
	
    push r0	
	push r1	
	push r2	
	push r3	
	push r4
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
;--------------------------------------------
;                 Apaga Tela
;--------------------------------------------
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
	
;--------------------------------------------
;                   TELAS
;--------------------------------------------
;Endereço das telas desenhadas (STR2 - 1+2)
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

;Tela 01: Chão
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

;Tela 02: Escadas
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


;Tela 03: o meio da escada para subir
tela3Linha0  : string "                                        "
tela3Linha1  : string "                                        "
tela3Linha2  : string "                                        "
tela3Linha3  : string "                                        "
tela3Linha4  : string "                   n                    "
tela3Linha5  : string "                   n                    "
tela3Linha6  : string "                   n                    "
tela3Linha7  : string "       n                                "
tela3Linha8  : string "       n                                "
tela3Linha9  : string "       n                                "
tela3Linha10 : string "       n                                "
tela3Linha11 : string "                                   n    "
tela3Linha12 : string "                                   n    "
tela3Linha13 : string "                                   n    "
tela3Linha14 : string "                                   n    "
tela3Linha15 : string "                       n                "
tela3Linha16 : string "                       n                "
tela3Linha17 : string "                       n                "
tela3Linha18 : string "      n                                 "
tela3Linha19 : string "      n                                 "
tela3Linha20 : string "      n                                 "
tela3Linha21 : string "      n                                 "
tela3Linha22 : string "                               n        "
tela3Linha23 : string "                               n        "
tela3Linha24 : string "                               n        "
tela3Linha25 : string "    n                                   "
tela3Linha26 : string "    n                                   "
tela3Linha27 : string "    n                                   "
tela3Linha28 : string "                                        "
tela3Linha29 : string "                                        "

;Tela menu:
tela4Linha0  : string "                                        "
tela4Linha1  : string "                                        "
tela4Linha2  : string "    PRESSIONE ENTER PARA INICIAR        "
tela4Linha3  : string "    E RECUPERAR O BARCO DO SIMOES       "
tela4Linha4  : string "                                        "
tela4Linha5  : string "                                        "
tela4Linha6  : string "                                        "
tela4Linha7  : string "               BBBBBBBB                 "
tela4Linha8  : string "              BBBBBBBBBB                "
tela4Linha9  : string "           BBBBBBBBBBBBBBBB             "
tela4Linha10 : string "          BBBBBBBBBBBBBBBBBB            "
tela4Linha11 : string "          BBBB   SIMOES   BBB           "
tela4Linha12 : string "          BBBBBBBBBBBBBBBBBB            "
tela4Linha13 : string "           BBBBBBBBBBBBBBBB             "
tela4Linha14 : string "              BBBBBBBBBB                "
tela4Linha15 : string "                                        "
tela4Linha16 : string "                                        "
tela4Linha17 : string "                                        "
tela4Linha18 : string "                                        "
tela4Linha19 : string "                  __                    "
tela4Linha20 : string "                 y  l                   "
tela4Linha21 : string "                y____l                  "
tela4Linha22 : string "                l    y                  "
tela4Linha23 : string "                 l__y                   "
tela4Linha24 : string "                                        "
tela4Linha25 : string "                                        "
tela4Linha26 : string "                                        "
tela4Linha27 : string "                                        "
tela4Linha28 : string "                                        "
tela4Linha29 : string "                                        "

;Tela Venceu:
tela5Linha0  : string "                                        "
tela5Linha1  : string "                                        "
tela5Linha2  : string "                                        "
tela5Linha3  : string "                                        "
tela5Linha4  : string "                                        "
tela5Linha5  : string "                                        "
tela5Linha6  : string "               VOCE VENCEU              "
tela5Linha7  : string "                                        "
tela5Linha8  : string "        AGORA ESTA PRONTO PARA O        "
tela5Linha9  : string "              ATAQUE ZUMBI              "
tela5Linha10 : string "           _____                        "
tela5Linha11 : string "          |     l                       "
tela5Linha12 : string "          |      l                      "
tela5Linha13 : string "          |      y        O     __      "
tela5Linha14 : string "          |_____y        y|l   y  l     "
tela5Linha15 : string "          |             y | l | SS |    "
tela5Linha16 : string "          |               |   | SS |    "
tela5Linha17 : string "          |              y l   l__y     "
tela5Linha18 : string "  ________|_____________y___l_________  "
tela5Linha19 : string "  l                                   y "
tela5Linha20 : string "   l            SIMOES               y  "
tela5Linha21 : string "    l                               y   "
tela5Linha22 : string "     l_____________________________y    "
tela5Linha23 : string "                                        "
tela5Linha24 : string "                                        "
tela5Linha25 : string "        QUER JOGAR DE NOVO? <s/n>       "
tela5Linha26 : string "                                        "
tela5Linha27 : string "                                        "
tela5Linha28 : string "                                        "
tela5Linha29 : string "                                        "