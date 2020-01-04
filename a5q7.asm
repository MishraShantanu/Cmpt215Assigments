
        .data
prompt: .asciiz "Enter the string: "
result: .asciiz "converted string in Pig Latin: "
space:  .ascii " "
aystr:  .asciiz "ay "
char:   .byte 1
buffer: .byte 200


        .text
        .globl main
main:	
	la $a0, prompt 
        li $v0, 4
        syscall
	lb $t3, space
	       
	la $t0, char
        la $t1, buffer

        la $a0, buffer
        li $a1, 200
        li $v0, 8
        syscall

    	lb $t2, ($t1)           
        addi $t1, $t1, 1

loop:
        lb $t4, ($t1)           
	addi $t1, $t1, 1
        beqz $t4, exit         
        beq $t3, $t4, loop_continue   
        move $a0, $t4           
        li $v0, 11
        syscall

        j loop

loop_continue:
        move $a0, $t2
        li $v0, 11
        syscall

        la $a0, aystr
        li $v0, 4
        syscall

        lb $t2, ($t1)   
        addi $t1, $t1, 1    
	j loop
exit:

        move $a0, $t2
        li $v0, 11
        syscall

        la $a0, aystr
        li $v0, 4
        syscall

        li $v0, 10
        syscall       


