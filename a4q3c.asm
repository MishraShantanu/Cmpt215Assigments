	  .data
prompt1:  .asciiz "enter the value for k:  "
output:	  .asciiz "Approximate value of pie==> "
newl:	  .asciiz "\n"

	.text

main:   li $v0, 4
	la $a0, prompt1
	syscall

	li $v0,5
	syscall   #GETTING THE VALUE OF K 
	move $s1,$v0
	move $s4,$s1
	
	
	addi $t0,$zero,2
	mtc1 $t0,$f12
	cvt.d.w $f12,$f12 #CONVERTING AND STORING THE VALUE OF 2 IN FLOAT 
	
	addi $t0,$zero,1
	mtc1 $t0,$f0
	cvt.d.w $f0,$f0
	mov.d $f6,$f0  
	
	addi $t0,$zero,3
	mtc1 $t0,$f2
	cvt.d.w $f2,$f2
	

	sqrt.d $f2, $f2
	
	div.d $f2,$f0,$f2 #GETTING VALUE OF T(0) IN F2

loop:   beq $s1,$zero,done #COMPUTE T(K)
	mul.d $f0,$f0,$f12		
	addi $s1,$s1,-1
	j loop   
	
done:	
	li $s3,0 #COUNTER INITILATION FOR LOOP2
loop2:	beq $s3,$s4,exit # LOOP FOR CAL T(K)
	mul.d $f4,$f2,$f2 #f4 holds the ti^2
	add.d $f4,$f6,$f4 #f4 holds ti^2+1
	sqrt.d $f4,$f4 #sqroot(ti^2+1)
	add.d $f4,$f4,$f6 #f4 = sqroot(ti^2+1)+1
	div.d $f2,$f2,$f4 #f1 = f2/f4 
	
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
	
      

      

