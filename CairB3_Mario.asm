jmp main
;barril
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

FlagCaindo: var #5

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

FlagColuna: var #6 ;inicializa no zero == flag desligada

posMario: var #1
posAntMario: var #1

;Codigo principal
main:
	loadn r1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #1536  			; cor branca!
	call ImprimeTela

	loadn r2, #0 ;inicializa o contador com 0 

	Loopmenu:
		inchar r4
		loadn r1, #13 ;tecla enter
		
		inc r2 ;faz a soma aleatória para dar o rand

		cmp r4, r1
		jne Loopmenu

		loadn r5, #5
		mod r3, r2, r5

		loadn r0, #IncRandBarril
		storei r0, r3

    Restart:
        call Inicializacao

        call ApagaTela
        loadn R1, #tela1Linha0	; Endereco onde comeca a primeira linha do cenario!!
        loadn R2, #1536  			; cor branca!
        call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
        
        loadn R1, #tela2Linha0	; Endereco onde comeca a primeira linha do cenario!!
        loadn R2, #2048  ;COR DA Onda
        call ImprimeTela2   		;  Rotina de Impresao de Cenario na Tela Inteira
        
        loadn r0, #1119
        store posMario, r0 ;mario começa na linha 27, coluna 39
        call DesenhaMario

        loadn r0, #0	
        loadn r2, #0	

        Loop:

            call MoveMario

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

            inc r0 	;contador++
            
            jmp Loop
	
    fim:
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

    loadn r0, #FlagCaindo
    loadn r2, #5
    loadn r1, #0
    store posAntMario, r1
    loadn r3, #0
    LoopFlagCaindo0:
        storei r0, r1

        inc r0
        inc r3

        cmp r3, r2
        jne LoopFlagCaindo0
        
    loadn r3, #0
    loadn r0, #FlagColuna
    loadn r2, #6
    LoopFlagColuna0:
        storei r0, r1

        inc r0
        inc r3

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

	call MoveMario_RecalculaPos		;Recalcula Posicao do Mario

    ;Só apaga e Redesenha se (pos != posAnt)
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

    inchar r1 ; lê o teclado

    loadn r2, #'a'
    cmp r1, r2
    jeq MoveMario_RecalculaPos_A

    loadn r2, #'d'
    cmp r1, r2
    jeq MoveMario_RecalculaPos_D

    loadn r2, #'w'
    cmp r1, r2
    jeq MoveMario_RecalculaPos_W

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
        mod r1, r0, r1      ;coluna atual
        cmp r1, r2
        jeq RtsMoveMario_RecalculaPos  

        ;Verifica se tem chão
        mov r6, r0
        loadn r2, #40
        dec r6              ;vai para a esquerda
        add r6, r6, r2      ;vai para linha de baixo
        div r1, r6, r2      ;linha
        mod r4, r6, r2      ;coluna

        ; calcula endereço: tela1 + linha*41 + coluna
        loadn r3, #41
        mul r1, r1, r3      ; deslocamento da linha (linha * 41)
        loadn r3, #tela1Linha0
        add r3, r3, r1      ; endereço da linha
        add r3, r3, r4      ; endereço final do caractere
        loadi r6, r3        ;lê caractere do chão

        loadn r5, #'='
        cmp r6, r5
        jne RtsMoveMario_RecalculaPos  ; se não for chão, não anda

        dec r0              ; anda para a esquerda
        jmp StoreposMario

    ;Move para direita
    MoveMario_RecalculaPos_D:
        ;Verifica se está na parede
        loadn r1, #40
        loadn r2, #0
        mod r1, r0, r1      ;coluna atual
        cmp r1, r2
        jeq RtsMoveMario_RecalculaPos  

        ;Verifica se tem chão
        mov r6, r0
        loadn r2, #40
        inc r6              ;vai para a direita
        add r6, r6, r2      ;vai para linha de baixo
        div r1, r6, r2      ;linha
        mod r4, r6, r2      ;coluna

        ; calcula endereço: tela1 + linha*41 + coluna
        loadn r3, #41
        mul r1, r1, r3      ; deslocamento da linha (linha * 41)
        loadn r3, #tela1Linha0
        add r3, r3, r1      ; endereço da linha
        add r3, r3, r4      ; endereço final do caractere
        loadi r6, r3        ;lê caractere do chão

        loadn r5, #'='
        cmp r6, r5
        jne RtsMoveMario_RecalculaPos  ; se não for chão, não anda

        inc r0              ; anda para a direita
        jmp StoreposMario


    ;Move para cima
    MoveMario_RecalculaPos_W:
        loadn r2, #40

        ; calcula o endereço do caractere no mapa da escada
        loadn r1, #tela3Linha0
        add r4, r0, r1    ; tela3Linha0 + pos
        div r5, r0, r2    ; pos / 40 (quantidade de \0 anteriores)
        add r4, r4, r5    ; soma ajuste da linha

        loadi r6, r4      ; pega o caractere do mapa da escada

        loadn r5, #'n'
        cmp r6, r5
        jne RtsMoveMario_RecalculaPos

        sub r0, r0, r2 ; sobe 1 linha
        jmp StoreposMario

;--------------------------------------------
;                 Venceu
;--------------------------------------------
Venceu:
    push r0
    push r1
    push r2
    push r3

    call ApagaTela

    loadn r1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #1536  			; cor branca!
	call ImprimeTela

	loadn r2, #0 ;inicializa o contador com 0 

    loadn r0, #'s'
    loadn r3, #'n'

    LoopVenceu:
        inchar r1
        inc r2
        
        cmp r1, r3
        jeq fim

        cmp r1, r0
        jeq Sim

        jmp LoopVenceu

    Sim:
		loadn r5, #5
		mod r3, r2, r5

		loadn r0, #IncRandBarril
		storei r0, r3

        pop r3
        pop r2
        pop r1
        pop r0

        pop r0

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

    store posAntMario, R0

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

	; --> r2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
	loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add r2, r1, r0	; R2 = Tela1Linha0 + posAnt
	loadn r4, #40
	div r3, r0, r4	; R3 = posAnt/40
	add r2, r2, r3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi r5, r2	; R5 = Char (Tela(posAnt))

    outchar r5, r0         ; Escreve esse caractere na posição da tela

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

    load r0, parametroBarril
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
        add r4, r4, r1             ;r4 = endereço de RandBarril[r1]
        loadi r2, r4               ;r2 = RandBarril[r1] (posição aleatória)
        
        loadn r4, #posBarril
        add r4, r4, r0             ;generalizei para achar qual barril que vai cair
        storei r4, r2              ;guarda a posBarril[r0] no endereço posBarril[r0] 

        loadn r4, #FlagCaindo
        add r4, r4, r0             ;endereço da FlagCaindo[parametroBarril]
        loadn r0, #1
        storei r4, r0              ;FlagCaindo[parametroBarril] == 1
        
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
    loadn r1, #29
    cmp r4, r1
    jeq Nochao

    call DesenhaBarril
    storei r3, r0 ;posbarril[r4] == r0 já na próxima linha

    loadn r0, #posAntBarril
    load r1, parametroBarril
    add r0, r1, r0 ;posAntBarril[r1]
    
    storei r0, r2 ;posAntBarril[r1]

    ;Vejo se colidiu com o mário
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

    load r1, parametroBarril        ;para saber qual barril vai cair
    loadn r0, #IncRandBarril        ;Endereço do Vetor dos Incrementos
    add r0, r0, r1                  ;r0 == Endereço IncRandBarril[parametroBarril]
    loadi r2, r0                    ;r2 == valor do IncRandBarril[parametroBarril]

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

        call LigarFlag

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

    loadn r2, #5 ;como os índices são ciclicos, antes de 0 é 5

    jmp DesligaFlag

    SubIncRandBarril:
        dec r2

    DesligaFlag:
        loadn r1, #FlagColuna
        add r1, r1, r2 ;Endereço FlagColuna[r2]

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

    loadn r1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #1536  			; cor branca!
	call ImprimeTela

	loadn r2, #0 ;inicializa o contador com 0 

    loadn r0, #'s'
    loadn r3, #'n'

    LoopMorreu:
        inchar r1
        inc r2
        
        cmp r1, r3
        jeq fim

        cmp r1, r0
        jeq SimM

        jmp LoopMorreu

    SimM:
		loadn r5, #5
		mod r3, r2, r5

		loadn r0, #IncRandBarril
		storei r0, r3

        pop r3
        pop r2
        pop r1
        pop r0

        pop r0

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

    loadn r0, #posAntBarril
    add r0, r0, r1
    storei r0, r2
    
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
    loadi r2, r0           ; r2 = pos anterior do barril (posição da tela 0~1199)

	; --> R0 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
	loadn R1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add r0, R1, r2	; R2 = Tela1Linha0 + posAnt
	loadn R4, #40
	div R3, r2, R4	; R3 = posAnt/40
	add r0, r0, R3	; R2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi R5, r0	; R5 = Char (Tela(posAnt))


    outchar r5, r2         ; Escreve esse caractere na posição da tela

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
				
;--------------------------------------------
;             Imprime String 
;--------------------------------------------
ImprimeStr:	 
    ;r0 = Posicao da tela que o primeiro caractere da mensagem será impresso 
    ;r1 = endereco onde comeca a mensagem
    ;r2 = cor da mensagem

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
				
;--------------------------------------------
;             Imprime String 2
;--------------------------------------------
ImprimeStr2: 
    ;r0 = Posicao da tela que o primeiro caractere da mensagem será impresso  
    ;r1 = endereco onde comeca a mensagem
    ;r2 = cor da mensagem. 
	
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
tela4Linha20 : string "                 /  \                   "
tela4Linha21 : string "                /____\                  "
tela4Linha22 : string "                \    /                  "
tela4Linha23 : string "                 \__/                   "
tela4Linha24 : string "                                        "
tela4Linha25 : string "                                        "
tela4Linha26 : string "                                        "
tela4Linha27 : string "                                        "
tela4Linha28 : string "                                        "
tela4Linha29 : string "                                        "
