	  .data
prompt1:  .asciiz "enter the value for k:  "
output:	  .asciiz "Approximate value of pie==> "
newl:	  .asciiz "\n"

	.text

main:   li $v0, 4
	la $a0, prompt1  #PRINTING PROMPT 1
	syscall

	li $v0,5
	syscall #GETTING THE VALUE OF K 
	move $s1,$v0
	move $s4,$s1
	
	
	addi $t0,$zero,2
	mtc1 $t0,$f12    #CONVERTING AND STORING THE VALUE OF 2 IN FLOAT 
	cvt.d.w $f12,$f12
	
	addi $t0,$zero,1
	mtc1 $t0,$f0
	cvt.d.w $f0,$f0 #CONVERTING AND STORING THE VALUE OF 1 IN FLOAT IN F0 FOR MULT. TO GET 2^K IN LOOP
	mov.d $f6,$f0	  #MOVE F0 VALUE TO F3 FOR ADDING ONE IN THE EQUATION IN LOOP2
	
	
	addi $t0,$zero,3  #CONVERTING AND STORING THE VALUE OF 3 IN FLOAT IN F1
	mtc1 $t0,$f2
	cvt.d.w $f2,$f2
	

	sqrt.d $f2, $f2
	
	div.d $f2,$f0,$f2   #GETTING THE VALUE OF T(0) IN F1


loop:   beq $s1,$zero,done  #LOOP TO COMPUTE 2^K
	mul.d $f0,$f0,$f12		
	addi $s1,$s1,-1
	j loop   
	
done:	
	li $s3,0  #COUNTER FOR LOOP2

loop2:	beq $s3,$s4,exit  #LOOP FOR CALCULATING T(K)
	mul.d $f4,$f2,$f2 #f4 holds the ti^2
	add.d $f4,$f6,$f4 #f4 holds ti^2+1
	sqrt.d $f4,$f4 #sqroot(ti^2+1)
	sub.d $f4,$f4,$f6 #f4 = sqroot(ti^2+1)-1
	div.d $f2,$f4,$f2 #f1 = f4/f1 
	
	addi $s3,$s3,1
	mov.d $f12,$f2
	
	j loop2

exit:	
	li $v0,4
	la $a0,newl
	syscall
	li $v0,4
	la $a0,output
	syscall

	addi $t0,$zero,6
	mtc1 $t0,$f8
	cvt.d.w $f8,$f8
        
	mul.d $f12,$f8,$f0  #F12 = 6*2^K
	mul.d $f12,$f12,$f2 #F12 = (6*2^K)*T(K)	
	
	li $v0,3
	syscall

	
	

        li $v0,10
	syscall 
	
      

      

