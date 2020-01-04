	  .data
prompt1:  .asciiz "enter the value for k:  "
output:	  .asciiz "Approximate value of pie==> "
newl:	  .asciiz "\n"

	.text

main:   li $v0, 4
	la $a0, prompt1  #PRINTING PROMPT 1
	syscall

	li $v0,5
	syscall      
	move $s1,$v0  #GETTING THE VALUE OF K 
	move $s4,$s1
	
	
	addi $t0,$zero,2
	mtc1 $t0,$f12     
	cvt.s.w $f12,$f12 #CONVERTING AND STORING THE VALUE OF 2 IN FLOAT 
	
	addi $t0,$zero,1
	mtc1 $t0,$f0
	cvt.s.w $f0,$f0		#CONVERTING AND STORING THE VALUE OF 1 IN FLOAT IN F0 FOR MULT. TO GET 2^K IN LOOP
	mov.s $f3,$f0           #MOVE F0 VALUE TO F3 FOR ADDING ONE IN THE EQUATION IN LOOP2
	
	addi $t0,$zero,3	#CONVERTING AND STORING THE VALUE OF 3 IN FLOAT IN F1
	mtc1 $t0,$f1		
	cvt.s.w $f1,$f1		
	

	sqrt.s $f1, $f1         
	
	div.s $f1,$f0,$f1       #GETTING THE VALUE OF T(0) IN F1

loop:   beq $s1,$zero,done	#LOOP TO COMPUTE 2^K
	mul.s $f0,$f0,$f12		
	addi $s1,$s1,-1
	j loop   
	
done:	
	         
        li $s3,0


loop2:	beq $s3,$s4,exit  #LOOP FOR CALCULATING T(K)
	mul.s $f4,$f1,$f1 #f4 holds the ti^2
	add.s $f4,$f3,$f4 #f4 holds ti^2+1
	sqrt.s $f4,$f4 #sqroot(ti^2+1)
	sub.s $f4,$f4,$f3 #f4 = sqroot(ti^2+1)-1
	div.s $f1,$f4,$f1 #f1 = f4/f1 
	
	addi $s3,$s3,1
	
	
	j loop2

exit:	
	li $v0,4
	la $a0,newl
	syscall
	li $v0,4
	la $a0,output
	syscall

	addi $t0,$zero,6 
	mtc1 $t0,$f2
	cvt.s.w $f2,$f2
        
	mul.s $f12,$f2,$f0  #F12 = 6*2^K
	mul.s $f12,$f12,$f1 #F12 = (6*2^K)*T(K)
	
	li $v0,2
	syscall

	

        li $v0,10
	syscall 
	
      

      

