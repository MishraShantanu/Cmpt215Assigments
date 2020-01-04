	.data	# declare initialized variables in memory/data segment
# Three different strings (note \n newline characters)
# NAME	TYPE	VALUE
prompt:	.asciiz "Enter list of numbers (each must be on separate line) terminated by 0\n"
outputp:	.asciiz "The sum of positive  is "
outputn:	.asciiz "The sum of negative  is "
newl:	.asciiz "\n"

	.text	# write your code here in text segment
	
# s0 : sum of integers
	
	
# main label is required, and is jumped to by qtspim
# print instruction to user, initialize registers
main: 	li $v0,4	# 4: print string syscall
	la $a0,prompt	# load address of string to print into a0
	syscall			# tell the operating system to DEW it, and don't come back till it's done!

	move $s0,$zero	# move copies the value on the right, into the left
	move $s1,$zero				# s0 = $zero
					# initialize s0 to 0
	#li $s0,0		# functionally the same as above

# loop repeatedly, getting user input, adding it to our sum, until user enters 0 or invalid input
loop:	li $v0, 5	# 5: read integer from user
	syscall			# puts inputted integer into v0
	
	# user has hit enter key (input is in v0)
	bgtz $v0,addd
	bltz $v0,nad
	beqz $v0, prnt
addd: 
	add $s0,$s0,$v0
    nop	
	b loop# s0 = s0 + v0
nad:
    add $s1,$s1,$v0	
	nop                 # add what we had before, with new input (sum it)
	b loop		# branch if not equal to zero
						# branch to loop if v0 != 0
	
	# loop is over (user entered 0), finish program

    
prnt:
	li $v0,4	# syscall code 4: print string
	la $a0,outputp	# load address of string to print into a0
	syscall		# DEW IT
	
	li $v0,1	# syscall code 1: print integer
	move $a0,$s0	# put integer value to print into a0 
					# a0 = s0 (copies value from right into left)
	syscall		# print out integer in a0
	
	li $v0,4	# print out a newline
	la $a0,newl
	syscall
	li $v0,4	# syscall code 4: print string
	la $a0,outputn	# load address of string to print into a0
	syscall		# DEW IT
	
	li $v0,1	# syscall code 1: print integer
	move $a0,$s1	# put integer value to print into a0 
					# a0 = s0 (copies value from right into left)
	syscall		# print out integer in a0
	
	li $v0,4	# print out a newline
	la $a0,newl
	syscall
	
	li $v0,10	# syscall code 10: exit program
	syscall		# ciao
