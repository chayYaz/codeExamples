
#Ch yaz, Hanna s
.data
	matA:
	.asciiz 
	enter: "\n "
	size: "Enter desired size (i.e. 2 2 for 2x2):\n"
	MA: "Enter values for matrix A:\n"
	MB: "Enter values for matrix B\n"
	res: "Result:\n"
	error: "Cannot multiply\n"
.text
	la	$a0,size
	li	$v0,4
	syscall
	la 	$s6,matA
	li 	$v0,5
	syscall
	add	 $t0,$s6, $zero
	addi	 $s0,$v0,0
	li	 $v0 5
	syscall
	addi	 $s1 $v0 0
	la	$a0,size
	li	$v0,4
	syscall
	li	 $v0 5
	syscall
	addi	 $s2,$v0,0
	li	 $v0 5
	syscall
	addi	 $s3,$v0,0
	bne	 $s1 $s2 end
#------Matrix Multiplication algorithm:------------
#(int i = 0; i < array height; i++) {
    #for (int j = 0; j < array width; j++) {
       # prompt and read array value
        #row index = i
       # column index = j
       # memory[array base address + 4 * (array width * row index + column index)] = array value
   # }
#}
	la 	$a0,MA
	li	 $v0,4
	syscall
	addi 	$a2 $zero 0
	forOut:
#a2==i
		beq 	$a2,$s0,MatB
		addi 	$a3,$zero,0
	forIn:
      #a3==j
      		beq 	$a3 $s1 endInside
	# memory[array base address + 4 * (array width * row index + column index)] = array value
	#mult $s1 $a2 # (array width * row index
	#mflo $t0
	#dex + column index
	# sll $t0 $t0 2#*4
	#base mamory+place
    		 li 	$v0 5
		syscall
		sw	 $v0 0($t0)
		addi	 $a3 $a3 1
		addi	 $t0 $t0 4
		j 	forIn
	endInside:
		addi 	$a2,$a2,1
		j	 forOut

#------Change----
MatB:	la 	$a0,MB	#Print "enter for B"
		li 	$v0,4
		syscall
		addi 	$s5,$t0,0
		addi 	$a2,$zero,0
	forOut2:
#a2==i
		beq 	$a2,$s2,endForOut
    		addi 	$a3,$zero,0
	forIn2:
 #a3==j
		beq	 $a3 $s3 endInside2
	# memory[array base address + 4 * (array width * row index + column index)] = array value
	# (array width * row index
	#dex + column index
	# sll $t0 $t0 2#*4
	#base mamory+place
		li	 $v0,5
		syscall
     		sw 	$v0 0($t0)
      		addi 	$a3 $a3 1
      		addi 	$t0, $t0 4
		j 	forIn2
			endInside2:
				addi 	$a2 $a2 1
				j	 forOut2
	endForOut:
		addi	 $a2,$zero,0
		la 	 $a0,res
		li	$v0,4
		syscall
	for1:
		beq	 $a2, $s0 endFor1
		addi $a3,$zero,0
		for2:
			beq 	$a3,$s3,endFor2#j<k
			addi 	$t3 $zero 0
			addi	 $t6,$zero,0
			for3:
				beq 	$t3 $s2 endFor3
	  			#memory[array base address + 4 * (array width * row index + column index)] = array value
				mult  	$a2,$s1#w*row
				mflo	 $t4
				add 	$t4, $t4,$t3#+columb
				sll  	$t4,$t4,2#*4
				add 	$t4,$t4,$s6#+base
				lw 	$t4,0($t4)
	   	 		#a[i][r]
	   	 		#b[r][j]
				mult 	$t3,$s3
				mflo 	$t5
				add 	$t5, $t5,$a3#+columb
				sll 	$t5,$t5 2	#negative
				add 	$t5,$t5,$s5
				lw 	$t5,0($t5)
	 			mult	$t4,$t5
	 			mflo	$a1	
	 			add 	$t6,$t6,$a1 #sum+=t4*t5
				addi 	$t3 $t3 1
				j	for3
		   endFor3:
	   			addi 	$a0,$t6,0	#Cout<<sum<<" ";
				li 	$v0,1
				syscall
	   			li 	$a0,' '
				li 	$v0,11
				syscall
				addi 	$a3,$a3,1#j++
				j	 for2
	endFor2:		
		addi	 $a2,$a2,1
		addi 	$a0, $0, 0xA #ascii code for Line feed (\n)
        		addi	 $v0, $0, 11 #syscall 11 prints the lower 8 bits of $a0 as an ascii character.
        		syscall
		j for1
endFor1:
	li 	$v0,10
	syscall
end:
	la	$a0,error
	li	$v0,4
	syscall
	li 	$v0,10
	syscall	