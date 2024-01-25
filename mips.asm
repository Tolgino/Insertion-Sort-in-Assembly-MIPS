#####################################################################
#                                                                   #
# Name:         Tolga Sumer                                                    #
# KUSIS ID:           64534                                              #
#####################################################################

# This file serves as a template for creating 
# your MIPS assembly code for assignment 2

.eqv MAX_LEN_BYTES 400

#====================================================================
# Variable definitions
#====================================================================

.data

arg_err_msg:       .asciiz   "Argument error"
input_msg:         .asciiz   "Input integers"
input_data:        .space    MAX_LEN_BYTES     #Define length of input list
#  You can define other data as per your need. 
next_line:         .asciiz "\n"
array:  .space      400
output_msg1:	   .asciiz   "Sorted List: \n"
output_msg2:       .asciiz   "Sorted list without duplicates: \n"
output_msg3:       .asciiz   "List sum: \n"
end_msg:           .asciiz   "Program finished"
nextline:	   .asciiz   "\n"
spc:		   .asciiz   " "

#==================================================================== 
# Program start
#====================================================================

.text
.globl main

main:
   #
   # Main program entry
   #
   #
   # Main body
   # 
   
   li $v0, 5 # set v0 to 5 in order to prepare it for integer input from the user
   syscall # wait for the user input
   move $t0, $v0 # take the user input stored in v0 and move it to t0 which is count
   lw $t1,array       # Point t1 to array 

   # Check for command line arguments count and validity
   

   # Check for first argument to be n
   

Data_Input:
   # Get integers from user as per value of n
   
   ##################  YOUR CODE  ####################   

   li $v0, 4
   la $a0, input_msg # print the next line
   syscall
   
   li $v0, 4
   la $a0, next_line # print the next line
   syscall
   
  
Loop:
	li $v0, 5 # set v0 to 5 in order to prepare it for integer input from the user
	syscall # wait for the user input
	
        sw $v0, array($t1)  # Move the integer into the array
        addi $t1,$t1,4      # Add count 4
        add $t2,$t2,1           # add 1 to $t2
        bne $t2, $t0,Loop	#if counter is not equal to number of inputs iterate the loop


# Insertion sort begins here
sort_data:

   ##################  YOUR CODE  ####################
     
   beq $t2, $t0, Continue	#reinitialize array offset for looping
   
   lw $t5, input_data($t1)	#$t5=a[$t1]=a[i]
   lw $t6, input_data($t2)	#$t6=a[$t2]=a[i+1]
   
   addi $t3, $t3, 1	#$t3= $t3+1
   
   slt $t7, $t5, $t6	# if ($t5<$t6) $t7 = 1 else $t7 = 0
   beq $t7, $s0, Swap	#if ($t7 == $s0) go to Swap #s0=0
   
   addi $t1, $t1, 4	#$t1= $t1 + 4
   addi $t2, $t2, 4	#$t2= $t2 + 4
   
   j sort_data
   
  Continue:
  
    move $t1, $zero	#for a[i]
    move $t2, $zero
    addi $t2, $t2, 4	#for a[i+1]
    move $t0, $zero
    addi $s0, $s0, 1	#condition check
    
  Swap:
  
   sw $t5, input_data($t2)	#a[i+1] = $t5
   sw $t6, input_data($t1)	#a[i] = $t6
   
   addi $t1, $t1, 4	#$t1= $t1 + 4
   addi $t2, $t2, 4	#$t2= $t2 + 4
   
   j sort_data
   

remove_duplicates:
   
   ##################  YOUR CODE  ####################

# Print sorted list with and without duplicates



print_w_dup:

   ##################  YOUR CODE  ####################
   
   
   	li $v0, 4
   	la $a0, output_msg1  # print  "Sorted List: " 
	syscall
	
	li $v0, 4
        la $a0, nextline # print next line
        syscall
   
   DupLoop:
	
	li $v0, 1 # print the number
	lw $a0, 0($a1) 
	syscall
	
	li $v0, 4
	la $a0, spc #print space	
	syscall
	
	addi $s0, $s0, 1 # increment counter
	addi $a1, $a1, 4 # move the array address to the next
	bne $s0, $v0, DupLoop #if counter is not equal to number of inputs iterate the loop
    	
    	la $a0, nextline # move to next line
	li $v0, 4
	syscall
	
print_wo_dup:

   ##################  YOUR CODE  ####################
   
   
   	li $v0, 4
   	la $a0, output_msg2 # print  "Sorted List: " 
   	
	syscall
	li $v0, 4
        la $a0, nextline # print next line
        syscall
        
        WoDupLoop:
        
	li $v0, 1 # print the number
	lw $a0, 0($a1) 
	syscall
	
	li $v0, 4
	la $a0, spc #print space 
	syscall
	
	addi $s0, $s0, 1 # increment the counter 
	addi $a1, $a1, 4 # move the array address to the next
	bne $s0, $v0, WoDupLoop #if counter is not equal to number of inputs iterate the loop
    	
    	la $a0, nextline # move to next line
	li $v0, 4
	syscall
	

        

# Perform reduction
   
   ##################  YOUR CODE  ####################
   
   li $v0, 4
   la $a0, output_msg3 # print  "List sum: " 
   syscall
   
   li $v0, 4
   la $a0, nextline # print the next line
   syscall
   
   Sum:
   lw $t2, array($a2)	#$t2 = a[i]
   addi $s1, $s1, 1	#i=i+1
   addi $a1, $a1, 4	#move to the next slot on the array, a[i+1]
   add $s2, $s2, $t2	#$s2 = $s2 + $t2
   j Sum

# Print sum
  li  $v0, 1
  addi $a0, $t3, 0      # $t3 contains the sum  
  syscall

   j Exit 
   
Arg_Err:
   # Error message when no input arguments specified
   # or when argument format is not valid
   la $a0, arg_err_msg
   li $v0, 4
   syscall
   j Exit

Exit:   
   # Jump to this label at the end of the program
   li $v0, 10
   syscall
