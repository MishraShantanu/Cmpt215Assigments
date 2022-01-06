.data 

# Asks user to enter two strigs and then compare the common character in both strings. 
# Retuns the number of common found in both the string. 

prompt: .asciiz "Enter string"
newl: .asciiz "\n" 
output: .asciiz "the number of charcter that are found in both strings\n"

str1: .space 20 
str2: .space 20 

	.text 
	
main:
	
	la $s2,str1
	move $t2,$s2
	jal getstr
	
	
	la $s3,str2
	move $t2,$s3
	jal getstr
	
	la $s5, newl
	
	li $t1, -1

cmploop: 

	lb $t2,($s2)
    
c_loop:
	lb $t3,($s3)
	beq $t2, $zero, print_sth
	beq $t3, $zero, cmploop_cont
	beq $t2,$t3,cmpeq1
c_loop_cont:
	addi $s3,$s3,1
	j c_loop
	
cmploop_cont:
    la $s3, str2
	addi $s2,$s2,1
	j cmploop

print_sth:
	la $a0,output
	li $v0,4
	syscall 
	
	move $a0,$t1
	li $v0,1
	syscall
	
	j exit

cmpeq1:
    add $t1,$t1,1 
    j cmploop_cont 

getstr:
	la $a0,prompt
	li $v0,4
	syscall
    
	move $a0,$t2
	li $a1,20
	li $v0,8 
	syscall
	
	jr $ra

exit: 
	li $v0,10
	syscall
