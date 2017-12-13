# Bingxue Ouyang
# bouyang@ucsc.edu
# Lab5
# section 02F
# a program that use key to encode and decode text
.data
key: .asciiz "The given key is: "
text: .asciiz "\nThe given text is: "
en: .asciiz "\nThe encrypted text is: "
de: .asciiz "\nThe decrypted text is: "
blank: .asciiz "\n"
enString: .space 100
deString: .space 100

.text
main:
	# assign value
	lw $s6, 0($a1) # key = argv[0] = s6 = t6
	move $t6, $s6
	lw $s7, 4($a1) # text = argv[1] = s7 = t7
	move $t7, $s7
	li $t9, 0 # key.length
	li $t8, 0 # i for enString
	sb $t8, enString # load 0 to enString
	
	# print key message
	la $a0, key
	li $v0, 4
	syscall
	# print key: argv[0]
	move $a0, $s6
	li $v0, 4
	syscall
	# print text message
	la $a0, text
	li $v0, 4
	syscall
	# print text: argv[1] = address + 4 bytes
	move $a0, $s7
	li $v0, 4
	syscall
	# print en message:
	la $a0, en
	li $v0, 4
	syscall

# key.length = t9
keyLength:
	lb $t5, ($t6) # char t5 = key[i]
	beq $t5, $0, encode # branch when null
	addi $t6, $t6, 1 # i++
	add $t9, $t9, 1 # key.length++
	b keyLength

encode:
	lb $t0, ($t7) # char t0 = text[counter]
	beq $t0, $0, reset # exit when null
	move $t6, $s6 # reset
	
	remu $t2, $t8, $t9 # t2 = counter%key.length
	add $t6, $t6, $t2 # key[t2]
	lb $t1, ($t6) # char t1 = key[counter%key.length]
	
	add $t3, $t0, $t1 # char t3 = text + key
	remu $t3, $t3, 128 # char t3 = encodeChar[counter]
	beq $t3, $0, exit
	
	move $a0, $t3
	li $v0, 11
	syscall
	
	# making encoded string enString
	mul $t8, $t8, 4
	sb $t3, enString($t8)
	add $t8, $t8, 4
	sb $0, enString($t8) # setting enString[i+1] null
	sub $t8, $t8, 4
	div $t8, $t8, 4
	
	addi $t8, $t8, 1 # i++
	addi $t7, $t7, 1 # counter++
	b encode
	
reset:
	# print de message
	la $a0, de
	li $v0, 4
	syscall
	li $t8, 0
	li $t3, 0
	li $t2, 0
	li $t1, 0
	li $s4, 0 # de counter
	
decode:
	lb $t3, enString($t8) # char t3 = enString[i]
	beq $t3, $0, exit
	move $t6, $s6 # read key
	
	remu $t2, $s4, $t9 # t2 = counter*key.length
	add $t6, $t6, $t2 # key[t2]
	lb $t1, ($t6) # char t1 = key[counter*key.length
	
	sub $t4, $t3, $t1 # char t4 = text - key
	remu $t4, $t4, 128 # char t4 = decodeChar[counter]
	
	move $a0, $t4
	li $v0, 11
	syscall
	
	addi $t8, $t8, 4 # i++
	addi $s4, $s4, 1 # counter+=
	b decode

exit:
	li $v0, 10
	syscall
