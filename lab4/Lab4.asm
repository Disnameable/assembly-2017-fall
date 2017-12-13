# Bingxue Ouyang
# bouyang@ucsc.edu
# 02F
# Lab4
# this program is using Sieve of Eratosthenes method
# by making a stack with a user defined size
# and marking multiples as 0 and skip them while printing

.data
prompt: .asciiz "Please enter a number: "
comma: .asciiz ","
error: .asciiz "Error: User input is less than 2."

.text
main:
	# print prompt message
	la, $a0, prompt
	li, $v0, 4
	syscall
	# user input
	li, $v0, 5
	syscall
	move $t0, $v0
	# error if user input is less than 2
	blt $t0, 2, errormessage
	# assign marker
	li $s1, -1
	li $s2, 0
	# assign value
	li $t1, 2 # counter starts from 2 because 1's multiples are useless
	li $s5, 2 # prepare to print 2
	la $s0, ($sp) # s0 = beginning address of stack pointer

makeStack:
	sw $s1, ($sp) # load all -1s to sp (-1 = prime, 0 = not prime)
	add $t1, $t1, 1 # counter ++
	add $sp, $sp, -4 # push
	ble $t1, $t0, makeStack # loop while(counter<=userinput)

counterReset:
	li $t1, 1 # counter reset, counter starts from 2
	
counterAdder:
	add $t1, $t1, 1 # counter ++
	mul $t2, $t1, $t1 # t2 = t1^2
	blt $t0, $t2, reset # if(userinput < multiple) go to reset
	mul $t4, $t1, 4 # t4 = counter * 4 bytes = current bytes
	sub $t3, $s0, $t4 # t3 = s0 - current bytes = current address
	add $t3, $t3, 8 # t3 = t3 + 8 bytes = t3 + 2 counter
	lw $t4, ($t3) # t4 = number in t3 address
	beqz $t4, counterAdder # skip multiples that were marked

markMultiples:
	mul $t4, $t2, 4 # t4 = counter multiple * 4 bytes = multiple bytes
	sub $t3, $s0, $t4 # t3 = s0 - multiple bytes = multiple address
	add $t3, $t3, 8 # t3 = t3 + 8 bytes = t3 + 2 counter
	sw $s2, ($t3) # mark 0 for t3
	add $t2, $t2, $t1 # t2 += t1 (multiples of t1)
	blt $t0, $t2, counterAdder # if(userinput < multiple) go to next counter
	b markMultiples # loop to next multiple of t1
	
reset:
	# print 2
	move $a0, $s5
	li $v0, 1
	syscall
	# reset counter, counter begins at 3 while printing
	li $t1, 2
	
checkMark:
	# skip address marked as 0:
	add $t1, $t1, 1
	blt $t0, $t1, exit # for(t1=1, t1<t0, t1++)
	mul $t4, $t1, 4 # t4 = counter * 4 bytes = current bytes
	sub $t3, $s0, $t4 # t3 = s0 - current bytes = current address
	add $t3, $t3, 8 # t3 = t3 + 2
	lw $t4, ($t3) # t4 = content in t3 address
	beqz $t4, checkMark # if t4 is 0 (not prime), go to next counter

print:
	# convert address of t3 into content of t3
	sub $t5, $s0, $t3 # t5 = stack pointer address - current address = current bytes
	div $t5, $t5, 4 # t5/4bytes = counter
	add $t5, $t5, 2 # t5 + add 2 counter = prime
	# print comma
	la $a0, comma
	li $v0, 4
	syscall
	# print prime
	move $a0, $t5
	li $v0, 1
	syscall
	
	b checkMark

exit:
	li $v0, 10
	syscall

errormessage:
	la, $a0, error
	li, $v0, 4
	syscall
	b exit
