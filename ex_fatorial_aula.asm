    .data
    .align 0

strdig: .asciiz "Digite o numero para fatorial"
strfat: .asciiz "O fatorial de"
streh: .asciiz " eh " # Tem que fazer a string separada
strquebra: .asciiz "./n"

    .text
    .globl main
    .align 2

main:
    li $v0, 4
    la $a0, strdig
    syscall

    li $v0, 5
    syscall

    move $a0, $v0 # $a0 para usar de argumento na funcao

    jal fatorial  # coloca sempre no $ra, nao precisa fazer manualmente, ja tem fixo o valor 31
                  # jal alguma_coisa --> $ra = PC e PC = alguma_coisa
    move $t0, $a0 # Salvando o fatorial de n
    move $t1, $a0 # Salvando n
                  # Salvando os dois pois quer exibir no print, sem perder tais dados


    #print
    # valor da memoria
    li $v0, 4 # pintar string
    la $a0, strfat #load adress pois nao ta em nenhum registrador, ta na memoria
    syscall

    #valor registrador
    li $v0, 1 # printar inteiro
    move $a0, $t1 # move copia de um registrador para outro, por isso nao usa la, pois nao da para pegar o adress
    syscall

    #valor da memoria
    li $v0, 4 # pintar string
    la $a0, streh #load adress pois nao ta em nenhum registrador, ta na memoria
    syscall

    #valor do registrador
    li $v0, 1 # printar inteiro
    move $a0, $t0 # move copia de um registrador para outro, por isso nao usa la, pois nao da para pegar o adress
    syscall

    #valor da memoria
    li $v0, 4 # pintar string
    la $a0, strquebra #load adress pois nao ta em nenhum registrador, ta na memoria
    syscall

    # Finalizando o programa
    li $v0, 10
    syscall



fatorial:
    # Fazendo a insercao na pilha
    addi $sp, $sp, -8 #-8 pois quer decrementar 2 int de 4 bytes

    sw $ra, 4($sp) # Primeiro item 4 byte para armazenar na pilha
    sw $a0, 0($sp) # Segundo item 4 byte para armazenar na pilha
    
    #Acabou de salvar na pilha
    li $v0, 1 # Por convencao usa o valor de v0 para retorno
    li $t0, 1 # aux para ser usado em ble

loop: ble $a0, $t0, endloop # Desvie se for menor ou igual a 1
      mul $v0, $v0, $a0
      addi $a0, $a0, -1

      j loop

endloop:
    #Fazendo a leitura da pilha
    lw $a0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 8  # addi para somar com inteiro
                      # Se fosse com outro registrador, usar so add

    #Retorna o que ta em $v0 - convencao de uso de registradores

    jr $ra
