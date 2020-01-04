.data 

prompt: .asciiz "Enter string: "
newl: .asciiz "\n" 
output: .asciiz "result: "
prompt2: .asciiz "Enter the charcter: "
prompt3: .asciiz "enter the integer: "
str1: .space 20 
char1: .space 2
num1:  .space 4  

	.text 
	
main:
	
	la $s2,str1
	move $t2,$s2
	la $a0,prompt  
	li $v0,4
	syscall 
    
	move $a0,$t2
	li $a1,20
	li $v0,8 
	syscall
	
	la $a0,prompt2
	li $v0,4 
	syscall
	li $v0,12
	syscall
	move $a2,$v0
	la $a0,newl
	li $v0,4
	syscall
	
	la $a0,prompt3 
	li $v0,4
	syscall
	li $v0,5        
    syscall        
    move $a3,$v0
	move $t4,$zero
	move $v1,$zero
	la $a1,str1
loo:lb $t1,($a1)
    beq $t1,$zero,print
	beq $a2,$t1,count
	bne $t4,$zero,check
	addi $a1,$a1,1
	beq $t4,$zero,loo
count:
	addi $a1,$a1,1
	addi $t4,$t4,1
	j loo
check:
	bge $t4,$a3,tcount
	addi $a1,$a1,1
	move $t4,$zero
	j loo
tcount:
    
	addi $v1,$v1,1
	addi $a1,$a1,1
	move $t4,$zero
	j loo

print:
	la $s3,output
	move $a0,$s3
	li $v0,4
	syscall
	move $a0,$v1
	li $v0,1
	syscall
	
	j exit
	
	
	

	


exit: 
	li $v0,10
	syscall