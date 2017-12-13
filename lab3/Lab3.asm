# Bingxue Ouyang
# bouyang@ucsc.edu
# Lab3
# section 02F
# this program converts a decimal user input into binary output
.data
welcome: .asciiz "\nWelcome to Decimal-to-Binary Convertor.\n"
prompt: .asciiz "Input Number: "
output: .asciiz "\nOutput Number: "

.text
main:
    # print welcome message
    la $a0, welcome
    li $v0, 4
    syscall
    # print prompt message
    la $a0, prompt
    li $v0, 4
    syscall
    # print program argument
    move $s0, $a1
    lw $s0, ($s0)
    la $a0, ($s0)
    li $v0, 4
    syscall
    # print output message
    la $a0, output
    li $v0, 4
    syscall
    
    # masks
    li $t2, 1
    # move mask to 31
    sll $t2, $t2, 31
    # loop counter start at 32 bits
    addi $t3, $0, 32
    
    # set s1 to 0
    li $s1, 0

readInt:
    lb $t1, ($s0) # t1 = bit in argument
    beq $t1, 45, ne# if bit equals to "-"
    beq $t1, $0, negORpos # stop when null
    addi $t1, $t1, -48  # convert char to int
    mul $s1, $s1, 10   # sum *= 10
    add $s1, $s1, $t1  # sum += $t1
    addi $s0, $s0, 1  # i++
    j readInt
    
ne:
    # set a flag $s4
    li $s4, 1
    # ignore this bit and go back to readInt
    addi $s0, $s0, 1
    j readInt

negORpos:
    # do 2's complement
    beq $s4, 1, twosc
    
loop:
    # $t4 = input AND mask
    and $t4, $s1, $t2
    # print 0 if $t4 is 0
    beq $t4, $0, print
    # else $t4 = 1
    add $t4, $0, $0
    # $t4 = 1
    addi $t4, $0, 1
    
print:
    # moves bit into $a0, the output
    move $a0, $t4
    li $v0, 1
    syscall
    # shift 1 to right
    srl $t2, $t2, 1
    # counter --
    addi $t3, $t3, -1
    # loop if counter does not equal to zero
    bne $t3, $0, loop
    beq $t3, $0, exit

twosc:
    # flip bits
    not $s1, $s1
    # add one
    addi $s1, $s1, 1
    j loop
    
exit:
    addi $v0, $0, 10
    syscall
