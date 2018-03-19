.data
.align 0
  # String para interacao com o usuario
  str_incicial: .asciiz "Digite um número : "


.text
# MARS nao deixa colocar ALign 2 pois é padrao ja
  # Exibindo a frase para o usuario digitar um numero
  li $v0, 4
  la $a0, str_incicial
  syscall

  # Lendo o que o usuario digitou
  li $v0, 5 # Read_int
  syscall
  move $t2, $v0 # Copia para t2 para nao perder o valor


# Rotulo para fazer a logica fatorial
FATORIAL:

  slt $v0, $t2, 1 # Verifica se n eh menor que 1
  beq $v0, $t2, FINALIZAR
  # f(x) = f(x) * f(x-1) ... f(1)
  # diminui e soma ao registrador que contem f(x)
  # acumula,
  # volta para fatorial
  j FATORIAL



# Rotulo para finalizar o programa
FINALIZAR:
  # Funcao para parar de ler a memoria - EXIT
  li $v0, 10 # 10 = exit
  syscall
