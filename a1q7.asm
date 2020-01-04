	.data #declaring data

prompt:	.asciiz "Enter ten integers \n" 
output: .asciiz  " the i'th integer in the array: "
newl:	.asciiz "\n"
	.align 2
array:	.space 40

	.text #code starting

main:	li $v0,4
	la $a0,prompt #printing the string 
	syscall

	la $s0, array
	li $s1,10

loop:   li $v0,5
	syscall
	sw $v0,0($s0)
	addi $s0,$s0,4
	addi $s1,$s1,-1
	bnez $s1,loop
	
	addi $s0,$s0,-4
	li $s1,10

input:	li $v0,4
	la $a0,output
	syscall
    li $v0,5	
	syscall
	move $s5,$v0
    sltiu $s4,$s5,11
	beqz $s4,exit 
	
prnt:	
    la $s0,array
	addi $s5,$s5,-1
	sll  $s5,$s5,2
	add $s0,$s0,$s5
	li $v0,1
	lw $a0,($s0)
	syscall
	li $v0,4
	la $a0,newl
	syscall
	b input
	
exit: 
	li $v0,10	# syscall code 10: exit program
	syscall	
	