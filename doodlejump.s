#####################################################################
#
#
# Student: Wei Tao, Student Number: 1003996367
#
#
#
 
 # CSC258H5S Fall 2020 Assembly Final Project
 # University of Toronto, St. George
  
 # Bitmap Display Configuration:
 # - Unit width in pixels: 8
 # - Unit height in pixels: 8
 # - Display width in pixels: 256
 # - Display height in pixels: 256
 # - Base Address for Display: 0x10008000 ($gp)
 # Which milestone is reached in this submission?
 # - Milestone 1
 # - Milestone 2
 # - Milestone 3
 # - Milestone 4
 # - Milestone 5
 # Any additional information that the TA needs to know:
 # - The first feature I implemented in Milestone 4 is (b), after game is over, there will be 
 #   a 'byE' appears on the sreen, and press 's' will restart the game.
 # - The second feature I implemented in Milestone 4 is (d), dynamic increase in speed and number
 #   of lethal creatures, the slowest speed is when no platform is jumped, and then every two platforms
 #   are jumped, the speed is increased a little, the maximum speed is reached when 9 platforms are jumped.
 #   Also the smallest number of lethal creature is one when less than 3 platforms are jumped. It increases 
 #   one when two platforms are jumped, and the maximum number of lethal creatures is three when five platforms
 #   are jumped.
 # - The first feature I implemented in Milestone 5 is (a), the jump rate in my project is according to 
 #   gravity. So Doodler character will slow down as he is close to his maximum jump height, and then speed up
 #   as he is falling down.
 # - The second feature I implemented in Milestone 5 is (f), when Doodler character touches the platforms, there will 
 #   be a first sound effect for it. When Doodler character is jumping up, there will be a second sound effect for it. When game is over,
 #   there will be a third sound effect for it. And there is also the background music when playing the game. The tone gets higher 
 #   when Doodler jumps higher. Until jumped 9 platforms, the background music becomes regular.
 # - The third feature I implemented in Milestone 5 is (i), there will be lethal creatures in the game when Doodler is jumping.
 #   When Doodler touches the lethal creatures, the game will be over. And also the number of lethal creatures will increase 
 #   when more platforms are jumped. Maximum number of lethal creatures are three. 
#####################################################################

.data
      	displayAddress: .word   0x10008000
      	maximumLevelAddress: .word 0x10008500
      	stopAddress: .word 0x10008F80
      	lenOfList: .word 34
      	listOfLeftBoundary:   .word 0x10007F04, 0x10007F84, 0x10008004, 0x10008084, 0x10008104, 0x10008184, 0x10008204, 0x10008284, 0x10008304, 0x10008384, 0x10008404, 0x10008484, 0x10008504, 0x10008584, 0x10008604, 0x10008684, 0x10008704, 0x10008784, 0x10008804, 0x10008884, 0x10008904, 0x10008984, 0x10008A04, 0x10008A84, 0x10008B04, 0x10008B84, 0x10008C04, 0x10008C84, 0x10008D04, 0x10008D84, 0x10008E04, 0x10008E84, 0x10008F04, 0x10008F84
	listOfRightBoundary:    .word 0x10007F80, 0x10008000, 0x10008080, 0x10008100, 0x10008180, 0x10008200, 0x10008280, 0x10008300, 0x10008380, 0x10008400, 0x10008480, 0x10008500, 0x10008580, 0x10008600, 0x10008680, 0x10008700, 0x10008780, 0x10008800, 0x10008880, 0x10008900, 0x10008980, 0x10008A00, 0x10008A80, 0x10008B00, 0x10008B80, 0x10008C00, 0x10008C80, 0x10008D00, 0x10008D80, 0x10008E00, 0x10008E80, 0x10008F00, 0x10008F80, 0x10009000
	arrayOfPlatform: .space 12
	arrayOfBye: .word 0x100086AC, 0x100086CC, 0x100086D0, 0x100086D4, 0x1000872C, 0x1000874C, 0x100087AC, 0x100087B0, 0x100087B4, 0x100087BC, 0x100087C4, 0x100087CC, 0x100087D0, 0x100087D4, 0x1000882C, 0x10008834, 0x1000883C, 0x10008844, 0x1000884C, 0x100088AC, 0x100088B0, 0x100088B4, 0x100088BC, 0x100088C0, 0x100088C4, 0x100088CC, 0x100088D0, 0x100088DD, 0x100088D4, 0x10008944, 0x100089BC, 0x100089C0, 0x100089C4, 0x10008C08, 0x10008C0C, 0x10008C10, 0x10008C88, 0x10008D08, 0x10008D0C, 0x10008D10, 0x10008D90, 0x10008E08, 0x10008E0C, 0x10008E10, 0x10008D18, 0x10008D1C, 0x10008D20, 0x10008C28, 0x10008C2C, 0x10008C30, 0x10008CA8, 0x10008D28, 0x10008D2C, 0x10008D30, 0x10008DB0, 0x10008E28, 0x10008E2C, 0x10008E30, 0x10008C38, 0x10008C3C, 0x10008C40, 0x10008CBC, 0x10008D3C, 0x10008DBC, 0x10008E3C, 0x10008C4C, 0x10008CC8, 0x10008CD0, 0x10008D48, 0x10008D4C, 0x10008D50, 0x10008D28, 0x10008DC8, 0x10008DD0, 0x10008E48, 0x10008E50, 0x10008C58, 0x10008C5C, 0x10008C60, 0x10008CD8, 0x10008CE0, 0x10008D58, 0x10008D5C, 0x10008D60, 0x10008DD8, 0x10008DDC, 0x10008E58, 0x10008E60, 0x10008C68, 0x10008C6C, 0x10008C70, 0x10008CEC, 0x10008D6C, 0x10008DEC, 0x10008E6C
	lenOfArrayOfBye: .word 95
	arrayOfStart: .word 0x10008C08, 0x10008C0C, 0x10008C10, 0x10008C88, 0x10008D08, 0x10008D0C, 0x10008D10, 0x10008D90, 0x10008E08, 0x10008E0C, 0x10008E10, 0x10008D18, 0x10008D1C, 0x10008D20, 0x10008C28, 0x10008C2C, 0x10008C30, 0x10008CA8, 0x10008D28, 0x10008D2C, 0x10008D30, 0x10008DB0, 0x10008E28, 0x10008E2C, 0x10008E30, 0x10008C38, 0x10008C3C, 0x10008C40, 0x10008CBC, 0x10008D3C, 0x10008DBC, 0x10008E3C, 0x10008C4C, 0x10008CC8, 0x10008CD0, 0x10008D48, 0x10008D4C, 0x10008D50, 0x10008D28, 0x10008DC8, 0x10008DD0, 0x10008E48, 0x10008E50, 0x10008C58, 0x10008C5C, 0x10008C60, 0x10008CD8, 0x10008CE0, 0x10008D58, 0x10008D5C, 0x10008D60, 0x10008DD8, 0x10008DDC, 0x10008E58, 0x10008E60, 0x10008C68, 0x10008C6C, 0x10008C70, 0x10008CEC, 0x10008D6C, 0x10008DEC, 0x10008E6C                                                                                
	lenOfArrayOfStart: .word 62
	numberOfPlatformJumped: .word 0
	arrayOfFirstLethal: .space 4
	arrayOfSecondLethal: .space 4
	arrayOfThirdLethal: .space 4
	
.text

      	lw $t0, displayAddress		# $t0 stores the base address
      	li $s1, 0x0000ff		# $s1 stores the blue colour
      	li $s2, 0xff0000		# $s2 stores the red colour
      	li $s3, 0x00ff00		# $s3 stores the green colour
      	li $s6, 0x000000		# $s6 stores the black colour
      	#sw $s2, 0($t0) 		# paint the first (top-left) unit red.
      	#sw $s3, 4($t0) 		# paint the second unit on the first row green
      	#sw $s1, 128($t0) 		# paint the first unit on the second row blue


Start: 
	lw $t0, displayAddress		# $t0 stores the base address
	li $s1, 0x0000ff		# $s1 stores the blue colour
      	li $s2, 0xff0000		# $s2 stores the red colour
      	li $s3, 0x00ff00		# $s3 stores the green colour
	lw $t2, 0xffff0004
	add $s4, $zero, $zero		# clean the register that used to store the shifting value
	lw $t7, numberOfPlatformJumped($zero)
	addi $t7, $zero, 0		# refresh the number of platform jumped
	sw $t7, numberOfPlatformJumped($zero)
	beq $t2, 0x73, main
	add $t4, $zero, $zero		# initialize t4 0, to be loop index
	li $s6, 0x000000		# $s6 stores the black colour
	loop_erase: beq $t4, 4096, end_erase		# check loop
	j inner_loop_at_start
	keep_outerloop_at_strat:
	addi $t4, $t4, 4		# update loop index
	addi $t0, $t0, 4		# update address
	j loop_erase
	
	inner_loop_at_start:
	lw $t7, lenOfArrayOfStart($zero)
	addi $t8, $zero, 4
	mult $t7, $t8
	mflo $t7
	add $t5, $zero, $zero		# pointer of arraylist
	keepPaintStart: lw $t6, arrayOfStart($t5)
	beq $t0, $t6, paintStart
	j finishPaintBlack_at_strat
	paintStart: sw $s3, 0($t0)	# paint the letters green 
	j keep_outerloop_at_strat
	finishPaintBlack_at_strat:
	addi $t5, $t5, 4		# update pointer of arraylist
	bne $t5, $t7, keepPaintStart
	sw $s6, 0($t0)			# load black color one pixel to fill the whole screen
	j keep_outerloop_at_strat
	
	end_erase:
	j Start
	
Bye_sound_effect:    li $v0, 31			# sound effect
	li $a0, 45
	li $a1, 700
	li $a2, 56
	li $a3, 127
	syscall	
	j Bye
Bye: 
	lw $t0, displayAddress		# $t0 stores the base address
	li $s1, 0x0000ff		# $s1 stores the blue colour
      	li $s2, 0xff0000		# $s2 stores the red colour
      	li $s3, 0x00ff00		# $s3 stores the green colour
	lw $t2, 0xffff0004
	add $s4, $zero, $zero		# clean the register that used to store the shifting value
	lw $t7, numberOfPlatformJumped($zero)
	addi $t7, $zero, 0		# refresh the number of platform jumped
	sw $t7, numberOfPlatformJumped($zero)
	beq $t2, 0x73, main
	add $t4, $zero, $zero		# initialize t4 0, to be loop index
	li $s6, 0x000000		# $s6 stores the black colour
	loop_letter: beq $t4, 4096, end_paint		# check loop
	j inner_loop
	keep_outerloop:
	addi $t4, $t4, 4		# update loop index
	addi $t0, $t0, 4		# update address
	j loop_letter
	
	inner_loop:
	lw $t7, lenOfArrayOfBye($zero)
	addi $t8, $zero, 4
	mult $t7, $t8
	mflo $t7
	add $t5, $zero, $zero		# pointer of arraylist
	keepPaintLetter: lw $t6, arrayOfBye($t5)
	beq $t0, $t6, paintLetter
	j finishPaintBlack
	paintLetter: sw $s3, 0($t0)	# paint the letters green 
	j keep_outerloop
	finishPaintBlack:
	addi $t5, $t5, 4		# update pointer of arraylist
	bne $t5, $t7, keepPaintLetter
	sw $s6, 0($t0)			# load black color one pixel to fill the whole screen
	j keep_outerloop
	
	end_paint:
	j Bye
	
	
main: 	lw $t0, displayAddress		# $t0 stores the base address
	add $t4, $zero, $zero		# initialize t4 0, to be loop index
	addi $t5, $zero, 4096		# initialize t5 4096, to fill the screen
	add $t6, $zero, $zero		# initialize t6 0
	addi $t7, $zero, 10		# initialize t7 10, to make the platform length 10
	
SCREEN:  beq $t4, $t5, initializePlatform		# check loop
	sw $s1, 0($t0)			# load blue color one pixel to fill the whole screen
	addi $t4, $t4, 4		# update loop index
	addi $t0, $t0, 4		# update address
	j SCREEN
initializePlatform: 
	addi $t1, $zero, 1152		# at row 9 to generate a platform
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 23			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	add $t2, $zero, $zero		# point to the first location of arrayOfPlatform
	sw $a0, arrayOfPlatform($t2)	# store the address of first platform
	jal func_initialPLATFORM
	
	addi $t1, $zero, 2560		# at row 20 to generate a platform
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 23			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	addi $t2, $t2, 4		# point to the second location of arrayOfPlatform
	sw $a0, arrayOfPlatform($t2)	# store the address of second platform
	jal func_initialPLATFORM
	
	addi $t1, $zero, 3968		# at row 31 to generate a platform
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 23			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	addi $t2, $t2, 4			# point to the third location of arrayOfPlatform
	sw $a0, arrayOfPlatform($t2)	# store the address of third platform
	jal func_initialPLATFORM
	add $v1, $zero, $t0
	
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 30			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	lw $t0, displayAddress		# $t0 stores the base address
	add $t6, $a0, $t0
	sw $t6, arrayOfFirstLethal($zero)	# store random address of first lethal
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 30			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	add $t6, $a0, $t0
	sw $t6, arrayOfSecondLethal($zero)	# store random address of second lethal
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 30			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	add $t6, $a0, $t0
	sw $t6, arrayOfThirdLethal($zero)	# store random address of third lethal
	
	
START_BOUNCE_UP:
	addi $t4, $zero, 1		# initialize t4 1, to be loop index
	BOUNCE_UP: beq $t4, 22, START_BOUNCE_DOWN # if the doodler gets to the maximum level, then starts to bounce down
	
	
	add $s4, $s4, $zero	# determine shift in bouncing up
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	lw $s5, 0xffff0000
	bne $s5, 1, skip_shift1		# check is there any keyboard pressed
	lw $t2, 0xffff0004
	bne $t2, 0x6a, jumpout_left1	# check if j is pressed to shift left
	jal shift_left
	jumpout_left1:
	bne $t2, 0x6b, jumpout_right1	# check if k is pressed to shift right
	jal shift_right
	jumpout_right1:
	skip_shift1:
	lw $s4, 0($sp)
	addi $sp, $sp, 4
	addi $t5, $zero, 0		# it is 0 if no jumping up from middle
	jal func_doodler		# call function of doodler
	
	li $v0, 31			# sound effect
	li $a0, 50
	li $a1, 250
	li $a2, 118
	li $a3, 120
	syscall
	addi $t4, $t4, 1		# update loop index
	j BOUNCE_UP
	
START_BOUNCE_DOWN:
	addi $t4, $zero, 20		# initialize t4 20, to be loop index
	BOUNCE_DOWN: beq $t4, -1, Bye_sound_effect # if the doodler touched the illegal area, then exit, if not, keep bounce down
	
	add $t6, $zero, $zero
	slti $t6, $t4, 10		# check if the last edge of doodler has passed the second platform
	addi $t7, $zero, 1
	beq $t7, $t6, BOUNCE_DOWN_FROM_MIDDLE	# if last edge of doodler has passed second platform, then operate another bounce down, if not, keep going
	addi $t1, $t1, 128		# load to the level that below first pixel of the current doodle, (the address of first pixel of doodle plus 128)
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, platform_sound_effect_2	# compare if colour in $t1 is red (if the next level is platform), if not, keep bounce down, if yes, bounce up
	addi $t1, $t1, -8		# load to the level that below second pixel of the current doodle, (the address of first pixel of doodle plus 128, and minus 8)
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, platform_sound_effect_2	# compare if colour in $t1 is red (if the next level is platform), if not, keep bounce down, if yes, bounce up
	add $s4, $s4, $zero	# determine shift in bouncing down
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	lw $s5, 0xffff0000
	bne $s5, 1, skip_shift2		# check is there any keyboard pressed
	lw $t2, 0xffff0004
	bne $t2, 0x6a, jumpout_left2	# check if j is pressed to shift left
	jal shift_left
	jumpout_left2:
	bne $t2, 0x6b, jumpout_right2	# check if k is pressed to shift right
	jal shift_right
	jumpout_right2:
	skip_shift2:
	lw $s4, 0($sp)
	addi $sp, $sp, 4
	addi $t5, $zero, 0		# it is 0 if no jumping up from middle
	jal func_doodler		# call function of doodler
	addi $t4, $t4, -1		# update loop index
	j BOUNCE_DOWN
	
BOUNCE_DOWN_FROM_MIDDLE: 
	addi $t1, $t1, 128		# load to the level that below the current doodle, (the address of first pixel of doodle plus 128)
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, platform_sound_effect_1	# compare if colour in $t1 is red (if the next level is platform), if not, keep bounce down, if yes, bounce up
	addi $t1, $t1, -8		# load to the level that below second pixel of the current doodle, (the address of first pixel of doodle plus 128, and minus 8)
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, platform_sound_effect_1	# compare if colour in $t1 is red (if the next level is platform), if not, keep bounce down, if yes, bounce up
	
	add $s4, $s4, $zero	# determine shift in bouncing down from middle
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	lw $s5, 0xffff0000
	bne $s5, 1, skip_shift3		# check is there any keyboard pressed
	lw $t2, 0xffff0004
	bne $t2, 0x6a, jumpout_left3	# check if j is pressed to shift left
	jal shift_left
	jumpout_left3:
	bne $t2, 0x6b, jumpout_right3	# check if k is pressed to shift right
	jal shift_right
	jumpout_right3:
	skip_shift3:
	lw $s4, 0($sp)
	addi $sp, $sp, 4
	addi $t5, $zero, 0		# it is 0 if no jumping up from middle
	jal func_doodler		# call function of doodler
	addi $t4, $t4, -1		# update loop index
	j BOUNCE_DOWN
	
BOUNCE_UP_FROM_MIDDLE:
	lw $t7, numberOfPlatformJumped($zero)
	addi $t7, $t7, 1
	sw $t7, numberOfPlatformJumped($zero)
	addi $t4, $zero, 13		# initialize t4 13, to be loop index
	BOUNCE_MIDDLE: beq $t4, 33, START_BOUNCE_DOWN	# if the doodler gets to the maximum level, then start bounce down from maximum level
	
	add $s4, $s4, $zero	# determine shift in bouncing up from middle
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	lw $s5, 0xffff0000
	bne $s5, 1, skip_shift4		# check is there any keyboard pressed
	lw $t2, 0xffff0004
	bne $t2, 0x6a, jumpout_left4	# check if j is pressed to shift left
	jal shift_left
	jumpout_left4:
	bne $t2, 0x6b, jumpout_right4	# check if k is pressed to shift right
	jal shift_right
	jumpout_right4:
	skip_shift4:
	lw $s4, 0($sp)
	addi $sp, $sp, 4
	addi $t5, $zero, 1		# it is 1 if jumping up from middle
	jal func_doodler		# call function of doodler
	li $v0, 31			# sound effect
	li $a0, 50
	li $a1, 250
	li $a2, 118
	li $a3, 120
	syscall
	addi $t4, $t4, 1		# update loop index
	beq $t4, 23, update_platform_firstRound
	beq $t4, 24, update_platform_afterFirstRound
	beq $t4, 25, update_platform_afterFirstRound
	beq $t4, 26, update_platform_afterFirstRound
	beq $t4, 27, update_platform_afterFirstRound
	beq $t4, 28, update_platform_afterFirstRound
	beq $t4, 29, update_platform_afterFirstRound
	beq $t4, 30, update_platform_afterFirstRound
	beq $t4, 31, update_platform_afterFirstRound
	beq $t4, 32, update_platform_afterFirstRound
	beq $t4, 33, update_platform_afterFirstRound
	finishingUpdatingPlatform:
	j BOUNCE_MIDDLE

	
Exit:
      	li $v0, 10 			# terminate the program gracefully
      	syscall
      	
      	
func_initialPLATFORM:  		# function used to generate platform 
	add $a0, $a0, $t1		# input the line from $t1 to generate the platform
	add $t6, $zero, $zero		# initialize t6 0
	BUILD_LOOP: beq $t6, 10, RETURN 		# check loop
	lw $t0, displayAddress		# $t0 stores the base address
	add $t0, $t0, $a0		# add the random number (multiple of 4) to the base address as the first pixel of the platform
	sw $s2, 0($t0)			# store red color to the $t0 address
	addi $a0, $a0, 4		# update the address for next pixel of platform
	addi $t6, $t6, 1		# update loop index
	j BUILD_LOOP
	RETURN: jr $ra
	
func_doodler:
	j draw_lethal
	finishDrawingLethal:
	lw $t9, numberOfPlatformJumped($zero)
	addi $t8, $zero, 2
	slt $t9, $t8, $t9
	bne $t9, 1 not_draw_second_lethal
	j draw_lethal2
	finishDrawingLethal2:
	
	lw $t9, numberOfPlatformJumped($zero)
	addi $t8, $zero, 5
	slt $t9, $t8, $t9
	bne $t9, 1 not_draw_second_lethal
	j draw_lethal3
	finishDrawingLethal3:
	not_draw_second_lethal:
	
	addi $t6, $zero, -128		# initialize -128 in $t6
	mult $t6, $t4			# multiply -128 and a multiplier in $t4, to decide how many rows to bounce up
	mflo $s0
	add $t1, $zero, $zero		# initialize a new register
	add $t1, $v1, $s0		# store the address into a new register by adding $t0 and a multiple of -128
	add $t1, $t1, $s4		# updat the address of shifting
	
	beq $s4, $zero, keepGoing	# if no j or k is pressed, then keep going
	blez $s4, checkLeftBoundary	# if shift left ($s4 is -4), then check the left boundary
	j checkRightBoundary		# otherwise, check the right boundary
	checkLeftBoundary: 
	la $s6, listOfLeftBoundary
	la $s7, lenOfList
	lw $s5, 0($s7)
	leftBoundary: lw $s0, 0($s6)	# loop
	beq $s0, $t1, addition		# check if the address of first pixel is in the list of left boundary, if yes, add 4
	addi $s5, $s5, -1
	addi $s6, $s6, 4
	bne $s5, $zero, leftBoundary	# check loop condition
	j keepGoing
	addition: addi $t1, $t1, 4
	add $s4, $s4, 4			# restore $s4 (shift value) 
	j keepGoing
	checkRightBoundary:
	la $s6, listOfRightBoundary
	la $s7, lenOfList
	lw $s5, 0($s7)
	rightBoundary: lw $s0, 0($s6)	# loop
	beq $s0, $t1, subtraction	# check if the address of first pixel is in the list of right boundary, if yes, abtract 4
	addi $s5, $s5, -1
	addi $s6, $s6, 4
	bne $s5, $zero, rightBoundary	# check loop condition
	j keepGoing
	subtraction: addi $t1, $t1, -4
	add $s4, $s4, -4		# restore $s4 (shift value) 
	
	keepGoing:
	add $t9, $zero, $zero
	lw $t7, maximumLevelAddress
	slt $t9, $t1, $t7		# check if the doodle gets to the maximum level
	beq $t9, 1, NO_BOUNCE		# if yes, then keep the doodler at the maximum level
	
	
	addi $sp, $sp, -4	# paint doodler normally
	sw $t1, 0($sp)			# store the address of first pixel in the first stack
	lw $t2, 0($t1)
	beq $t2, $s6, Bye_sound_effect			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump1		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump1: addi $t1, $t1, -8	# update the second pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of second pixel in the second stack
	lw $t2, 0($t1)
	beq $t2, $s6, Bye_sound_effect			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump2		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump2: addi $t1, $t1, -120	# update the third pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of third pixel in the third stack
	lw $t2, 0($t1)
	beq $t2, $s6, Bye_sound_effect			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump3		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump3: addi $t1, $t1, -4	# update the fourth pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of fourth pixel in the fourth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump4		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump4: addi $t1, $t1, -4	# update the fifth pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of fifth pixel in the fifth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump5		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump5: addi $t1, $t1, -124	# update the sixth pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of sixth pixel in the sixth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump6		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump6:
	
	
	
	
	lw $t7, numberOfPlatformJumped($zero)
	add $t8, $zero, 0
	slti $t8, $t7, 1		# if doodler has jumped 1 platform
	beq $t8, 1, sleep65
	slti $t8, $t7, 3		# if doodler has jumped 2 or 3 platform
	beq $t8, 1, sleep45
	slti $t8, $t7, 5		# if doodler has jumped 4 or 5 platform
	beq $t8, 1, sleep35
	slti $t8, $t7, 7		# if doodler has jumped 6 or 7 platform
	beq $t8, 1, sleep25
	slti $t8, $t7, 9		# if doodler has jumped 8 or 9 platform
	beq $t8, 1, sleep15

	beq $t5, 1, sleep_above_middle_sleep5
	beq $t4, 0, speed1_sleep5
	beq $t4, 1, speed1_sleep5
	beq $t4, 2, speed1_sleep5
	beq $t4, 3, speed1_sleep5
	beq $t4, 4, speed1_sleep5
	beq $t4, 5, speed2_sleep5
	beq $t4, 6, speed2_sleep5
	beq $t4, 7, speed2_sleep5
	beq $t4, 8, speed2_sleep5
	beq $t4, 9, speed2_sleep5
	beq $t4, 10, speed3_sleep5
	beq $t4, 11, speed3_sleep5
	beq $t4, 12, speed3_sleep5
	beq $t4, 13, speed4_sleep5
	beq $t4, 14, speed4_sleep5
	beq $t4, 15, speed4_sleep5
	beq $t4, 16, speed5_sleep5
	beq $t4, 16, speed5_sleep5
	beq $t4, 16, speed5_sleep5
	beq $t4, 16, speed6_sleep5
	beq $t4, 17, speed6_sleep5
	beq $t4, 18, speed7_sleep5
	beq $t4, 19, speed7_sleep5
	beq $t4, 20, speed8_sleep5
	beq $t4, 21, speed8_sleep5
	
	
	
	
	NO_BOUNCE:		# paint doodler when it gets to the maximum level
	addi $t6, $zero, -128		# initialize -128 in $t6
	addi $t7, $zero, 21		# initialize the maximum level the doodler could bounce to 
	mult $t6, $t7			# multiply -128 and constant 21, to keep doodler at maximum level
	mflo $s0			# put multiplication in $s0
	add $t1, $zero, $zero		# initialize a new register
	add $t1, $v1, $s0		# store the address into a new register by adding $t0 and a multiple of -128
	add $t1, $t1, $s4
	
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of first pixel in the first stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump12		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump12: addi $t1, $t1, -8	# update the second pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of second pixel in the second stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump22		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump22: addi $t1, $t1, -120	# update the third pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of third pixel in the third stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump32		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump32: addi $t1, $t1, -4	# update the fourth pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of fourth pixel in the fourth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump42		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump42: addi $t1, $t1, -4	# update the fifth pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of fifth pixel in the fifth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump52		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump52: addi $t1, $t1, -124	# update the sixth pixel of doodler
	addi $sp, $sp, -4
	sw $t1, 0($sp)			# store the address of sixth pixel in the sixth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s6, Bye_sound_effect
	beq $t2, $s2, jump62		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s3, 0($t1)			# store green color to the $t1 address
	jump62:
	
	lw $t7, numberOfPlatformJumped($zero)
	add $t8, $zero, 0
	slti $t8, $t7, 1		# if doodler has jumped 0 platform
	beq $t8, 1, sleep65
	slti $t8, $t7, 3		# if doodler has jumped 1 0r 2 platforms
	beq $t8, 1, sleep45
	slti $t8, $t7, 5		# if doodler has jumped 3 or 4 platforms
	beq $t8, 1, sleep35	
	slti $t8, $t7, 7		# if doodler has jumped 5 or 6 platforms
	beq $t8, 1, sleep25
	slti $t8, $t7, 9		# if doodler has jumped 7 or 8 platforms
	beq $t8, 1, sleep15

	# if doodler has jumped more than 9 platforms
	beq $t5, 1, sleep_above_middle_sleep5
	beq $t4, 0, speed1_sleep5
	beq $t4, 1, speed1_sleep5
	beq $t4, 2, speed1_sleep5
	beq $t4, 3, speed1_sleep5
	beq $t4, 4, speed1_sleep5
	beq $t4, 5, speed2_sleep5
	beq $t4, 6, speed2_sleep5
	beq $t4, 7, speed2_sleep5
	beq $t4, 8, speed2_sleep5
	beq $t4, 9, speed2_sleep5
	beq $t4, 10, speed3_sleep5
	beq $t4, 11, speed3_sleep5
	beq $t4, 12, speed3_sleep5
	beq $t4, 13, speed4_sleep5
	beq $t4, 14, speed4_sleep5
	beq $t4, 15, speed4_sleep5
	beq $t4, 16, speed5_sleep5
	beq $t4, 16, speed5_sleep5
	beq $t4, 16, speed5_sleep5
	beq $t4, 16, speed6_sleep5
	beq $t4, 17, speed6_sleep5
	beq $t4, 18, speed7_sleep5
	beq $t4, 19, speed7_sleep5
	beq $t4, 20, speed8_sleep5
	beq $t4, 21, speed8_sleep5
	sleep_above_middle_sleep5:
	beq $t4, 13, speed1_sleep5
	beq $t4, 14, speed1_sleep5
	beq $t4, 15, speed1_sleep5
	beq $t4, 16, speed1_sleep5
	beq $t4, 17, speed1_sleep5
	beq $t4, 18, speed2_sleep5
	beq $t4, 19, speed2_sleep5
	beq $t4, 20, speed2_sleep5
	beq $t4, 21, speed3_sleep5
	beq $t4, 22, speed3_sleep5
	beq $t4, 23, speed3_sleep5
	beq $t4, 24, speed4_sleep5
	beq $t4, 25, speed4_sleep5
	beq $t4, 26, speed5_sleep5
	beq $t4, 27, speed5_sleep5
	beq $t4, 28, speed5_sleep5
	beq $t4, 29, speed6_sleep5
	beq $t4, 30, speed6_sleep5
	beq $t4, 31, speed6_sleep5
	beq $t4, 32, speed7_sleep5
	speed8_sleep5:
	li $v0, 32			# sleep operation 5 to see the doodler
	li $a0, 165
	syscall
	j ERASE	
	speed7_sleep5:
	li $v0, 32			# sleep operation 5 to see the doodler
	li $a0, 125
	syscall
	j ERASE	
	speed6_sleep5:
	li $v0, 32			# sleep operation 5 to see the doodler
	li $a0, 95
	syscall
	li $v0, 31			# sound effect
	li $a0, 59
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed5_sleep5:
	li $v0, 32			# sleep operation 5 to see the doodler
	li $a0, 75
	syscall
	j ERASE	
	speed4_sleep5:
	li $v0, 32			# sleep operation 5 to see the doodler
	li $a0, 55
	syscall
	li $v0, 31			# sound effect
	li $a0, 75
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed3_sleep5:
	li $v0, 32			# sleep operation 5 to see the doodler
	li $a0, 35
	syscall
	j ERASE	
	speed2_sleep5:
	li $v0, 32			# sleep operation 5 to see the doodler
	li $a0, 15
	syscall
	j ERASE	
	speed1_sleep5:
	li $v0, 32			# sleep operation to 5 see the doodler
	li $a0, 5
	syscall
	j ERASE

	
	ERASE:			# erase doodle
	lw $t1, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump_back6	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t1)			# change back the colour of sixth pixel from green to blue
	jump_back6: addi $sp, $sp, 4
	lw $t1, 0($sp)			# load the address of fifth pixel from fifth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump_back5	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t1)			# change back the colour of fifth pixel from green to blue
	jump_back5: addi $sp, $sp, 4
	lw $t1, 0($sp)			# load the address of fourth pixel from fourth stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump_back4	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t1)			# change back the colour of fourth pixel from green to blue
	jump_back4: addi $sp, $sp, 4
	lw $t1, 0($sp)			# load the address of third pixel from third stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump_back3	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t1)			# change back the colour of third pixel from green to blue
	jump_back3: addi $sp, $sp, 4
	lw $t1, 0($sp)			# load the address of second pixel from second stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump_back2	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t1)			# change back the colour of second pixel from green to blue
	jump_back2: addi $sp, $sp, 4
	lw $t1, 0($sp)			# load the address of first pixel from first stack
	lw $t2, 0($t1)			# load the colour value from $t1 to $t2
	beq $t2, $s2, jump_back1	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t1)			# change back the colour of first pixel from green to blue
	jump_back1: addi $sp, $sp, 4
	
	j erase_lethal
	finishErasingLethal:
	lw $t9, numberOfPlatformJumped($zero)
	addi $t8, $zero, 2
	slt $t9, $t8, $t9
	bne $t9, 1 not_erase_second_lethal
	j erase_lethal2
	finishErasingLethal2:
	lw $t9, numberOfPlatformJumped($zero)
	addi $t8, $zero, 5
	slt $t9, $t8, $t9
	bne $t9, 1 not_erase_second_lethal
	j erase_lethal3
	finishErasingLethal3:
	not_erase_second_lethal:
	
	jr $ra
	
shift_left:
	lw $s4, 0($sp)
	addi $sp, $sp, 4
	addi $s4, $s4, -4
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	jr $ra
	
shift_right:
	lw $s4, 0($sp)
	addi $sp, $sp, 4
	addi $s4, $s4, 4
	addi $sp, $sp, -4
	sw $s4, 0($sp)
	jr $ra

erase_platform:
	add $t9, $zero, $zero		# initialize t6 0
	ERASE_LOOP: beq $t9, 10, finish_erase 		# check loop
	lw $t0, displayAddress		# $t0 stores the base address
	add $t0, $t0, $t8		# add the address of platform to the base address as the first pixel of the platform
	sw $s1, 0($t0)			# store blue color to the $t0 address
	addi $t8, $t8, 4		# update the address for next pixel of platform
	addi $t9, $t9, 1		# update loop index
	j ERASE_LOOP
	finish_erase:
	jr $ra
func_PLATFORM:  		# function used to generate platform 
	# we have made $a0 bofere into this function 	# added in update)_platform # input the line from $t1 to generate the platform
	add $t6, $zero, $zero		# initialize t6 0
	BUILD_PLATFORM_LOOP: beq $t6, 10, RETURN_func 		# check loop
	lw $t0, displayAddress		# $t0 stores the base address
	add $t0, $t0, $a0		# add the random number (multiple of 4) to the base address as the first pixel of the platform
	sw $s2, 0($t0)			# store red color to the $t0 address
	addi $a0, $a0, 4		# update the address for next pixel of platform
	addi $t6, $t6, 1		# update loop index
	j BUILD_PLATFORM_LOOP
	RETURN_func: jr $ra
	
update_platform_firstRound:	
	# first round of erase platform and redraw platform
	## erase
	add $t7, $zero, $zero
	lw $t8, arrayOfPlatform($t7)
	addi $t9, $zero, 1152
	add $t8, $t8, $t9		# the address of the first pixel of platform
	jal erase_platform
	
	addi $t7, $t7, 4
	lw $t8, arrayOfPlatform($t7)
	addi $t9, $zero, 2560
	add $t8, $t8, $t9		# the address of the second pixel of platform
	jal erase_platform
	
	addi $t7, $t7, 4
	lw $t8, arrayOfPlatform($t7)
	addi $t9, $zero, 3968
	add $t8, $t8, $t9		# the address of the third pixel of platform
	jal erase_platform
	## redraw
	add $t7, $zero, $zero
	lw $t8, arrayOfPlatform($t7)
	add $a0, $zero, $t8
	addi $a0, $a0, 1280
	jal func_PLATFORM
	
	addi $t7, $t7, 4
	lw $t8, arrayOfPlatform($t7)
	add $a0, $zero, $t8
	addi $a0, $a0, 2688
	jal func_PLATFORM
	
	li $v0, 32			# sleep operation to see the doodler
	li $a0, 5
	syscall
	## update sequence of platform's array
	add $t7, $zero, $zero
	addi $t7, $t7, 4
	lw $t8, arrayOfPlatform($t7)	# store the old second platform's address to $t1
	addi $t7, $t7, 4		# point to the last location of arrayOfPlatform
	sw $t8, arrayOfPlatform($t7) 	# store the old second platform's address to the last location of arrayOfPlatform
	
	addi $t7, $t7, -8
	lw $t8, arrayOfPlatform($t7)	# store the old first platform's address to $t1
	addi $t7, $t7, 4		# point to the seoncd location of arrayOfPlatform
	sw $t8, arrayOfPlatform($t7) 	# store the old first platform's address to the second location of arrayOfPlatform
	
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 23			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2
	addi $t7, $t7, -4		# point to the first location of arrayOfPlatform
	sw $a0, arrayOfPlatform($t7) 	# store the new first platform's address to the first location of arrayOfPlatform
	
	j finishingUpdatingPlatform
	
	# second to eleventh round of erase platform and redraw platform
update_platform_afterFirstRound:
	addi $a1, $zero, 25
	sub $a1, $t4, $a1		# level of new first platform
			
	addi $a2, $zero, 14	
	sub $a2, $t4, $a2		# level of new second platform
	
	addi $a3, $zero, 3
	sub $a3, $t4, $a3		# level of new third platform
				
	## erase
	add $t7, $zero, $zero
	lw $t8, arrayOfPlatform($t7)
	addi $t9, $zero, 128
	mult $t9, $a1			# update the level of the platform
	mflo $t9
	add $t8, $t8, $t9		# the address of the first pixel of platform
	jal erase_platform

	addi $t7, $t7, 4
	lw $t8, arrayOfPlatform($t7)
	addi $t9, $zero, 128
	mult $t9, $a2			# update the level of the platform
	mflo $t9
	add $t8, $t8, $t9		# the address of the second pixel of platform
	jal erase_platform
	
	addi $t7, $t7, 4
	lw $t8, arrayOfPlatform($t7)
	addi $t9, $zero, 128
	mult $t9, $a3			# update the level of the platform
	mflo $t9
	add $t8, $t8, $t9		# the address of the second pixel of platform
	jal erase_platform
	
	## redraw platform at next level
	addi $a1, $zero, 24
	sub $a1, $t4, $a1		# level of new first platform
			
	addi $a2, $zero, 13	
	sub $a2, $t4, $a2		# level of new second platform
	
	addi $a3, $zero, 2
	sub $a3, $t4, $a3		# level of new third platform
	
	addi $a0, $zero, 128
	mult $a0, $a1
	mflo $a0
	add $t7, $zero, $zero
	lw $t8, arrayOfPlatform($t7)
	add $a0, $a0, $t8
	jal func_PLATFORM
	
	addi $a0, $zero, 128
	mult $a0, $a2
	mflo $a0
	addi $t7, $t7, 4
	lw $t8, arrayOfPlatform($t7)
	add $a0, $a0, $t8
	jal func_PLATFORM
	
	addi $a0, $zero, 128
	mult $a0, $a3
	mflo $a0
	addi $t7, $t7, 4
	lw $t8, arrayOfPlatform($t7)
	add $a0, $a0, $t8
	jal func_PLATFORM
	li $v0, 32			# sleep operation to see the doodler
	li $a0, 5
	syscall
	
	j finishingUpdatingPlatform
	
sleep15:
	beq $t5, 1, sleep_above_middle_sleep15
	beq $t4, 0, speed1_sleep15
	beq $t4, 1, speed1_sleep15
	beq $t4, 2, speed1_sleep15
	beq $t4, 3, speed1_sleep15
	beq $t4, 4, speed1_sleep15
	beq $t4, 5, speed2_sleep15
	beq $t4, 6, speed2_sleep15
	beq $t4, 7, speed2_sleep15
	beq $t4, 8, speed2_sleep15
	beq $t4, 9, speed2_sleep15
	beq $t4, 10, speed3_sleep15
	beq $t4, 11, speed3_sleep15
	beq $t4, 12, speed3_sleep15
	beq $t4, 13, speed4_sleep15
	beq $t4, 14, speed4_sleep15
	beq $t4, 15, speed4_sleep15
	beq $t4, 16, speed5_sleep15
	beq $t4, 16, speed5_sleep15
	beq $t4, 16, speed5_sleep15
	beq $t4, 16, speed6_sleep15
	beq $t4, 17, speed6_sleep15
	beq $t4, 18, speed7_sleep15
	beq $t4, 19, speed7_sleep15
	beq $t4, 20, speed8_sleep15
	beq $t4, 21, speed8_sleep15
	sleep_above_middle_sleep15:
	beq $t4, 13, speed1_sleep15
	beq $t4, 14, speed1_sleep15
	beq $t4, 15, speed1_sleep15
	beq $t4, 16, speed1_sleep15
	beq $t4, 17, speed1_sleep15
	beq $t4, 18, speed2_sleep15
	beq $t4, 19, speed2_sleep15
	beq $t4, 20, speed2_sleep15
	beq $t4, 21, speed3_sleep15
	beq $t4, 22, speed3_sleep15
	beq $t4, 23, speed3_sleep15
	beq $t4, 24, speed4_sleep15
	beq $t4, 25, speed4_sleep15
	beq $t4, 26, speed5_sleep15
	beq $t4, 27, speed5_sleep15
	beq $t4, 28, speed5_sleep15
	beq $t4, 29, speed6_sleep15
	beq $t4, 30, speed6_sleep15
	beq $t4, 31, speed6_sleep15
	beq $t4, 32, speed7_sleep15
	speed8_sleep15:
	li $v0, 32			# sleep operation 15 to see the doodler
	li $a0, 185
	syscall
	j ERASE	
	speed7_sleep15:
	li $v0, 32			# sleep operation 15 to see the doodler
	li $a0, 165
	syscall
	li $v0, 31			# sound effect
	li $a0, 74
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed6_sleep15:
	li $v0, 32			# sleep operation 15 to see the doodler
	li $a0, 115
	syscall
	j ERASE	
	speed5_sleep15:
	li $v0, 32			# sleep operation 15 to see the doodler
	li $a0, 85
	syscall
	j ERASE	
	speed4_sleep15:
	li $v0, 32			# sleep operation 15 to see the doodler
	li $a0, 55
	syscall
	j ERASE	
	speed3_sleep15:
	li $v0, 32			# sleep operation 15 to see the doodler
	li $a0, 35
	syscall
	li $v0, 31			# sound effect
	li $a0, 71
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed2_sleep15:
	li $v0, 32			# sleep operation 15 to see the doodler
	li $a0, 25
	syscall
	j ERASE	
	speed1_sleep15:
	li $v0, 32			# sleep operation 15 to see the doodler
	li $a0, 15
	syscall
	j ERASE
sleep25:
	beq $t5, 1, sleep_above_middle_sleep25
	beq $t4, 0, speed1_sleep25
	beq $t4, 1, speed1_sleep25
	beq $t4, 2, speed1_sleep25
	beq $t4, 3, speed1_sleep25
	beq $t4, 4, speed1_sleep25
	beq $t4, 5, speed2_sleep25
	beq $t4, 6, speed2_sleep25
	beq $t4, 7, speed2_sleep25
	beq $t4, 8, speed2_sleep25
	beq $t4, 9, speed2_sleep25
	beq $t4, 10, speed3_sleep25
	beq $t4, 11, speed3_sleep25
	beq $t4, 12, speed3_sleep25
	beq $t4, 13, speed4_sleep25
	beq $t4, 14, speed4_sleep25
	beq $t4, 15, speed4_sleep25
	beq $t4, 16, speed5_sleep25
	beq $t4, 16, speed5_sleep25
	beq $t4, 16, speed5_sleep25
	beq $t4, 16, speed6_sleep25
	beq $t4, 17, speed6_sleep25
	beq $t4, 18, speed7_sleep25
	beq $t4, 19, speed7_sleep25
	beq $t4, 20, speed8_sleep25
	beq $t4, 21, speed8_sleep25
	sleep_above_middle_sleep25:
	beq $t4, 13, speed1_sleep25
	beq $t4, 14, speed1_sleep25
	beq $t4, 15, speed1_sleep25
	beq $t4, 16, speed1_sleep25
	beq $t4, 17, speed1_sleep25
	beq $t4, 18, speed2_sleep25
	beq $t4, 19, speed2_sleep25
	beq $t4, 20, speed2_sleep25
	beq $t4, 21, speed3_sleep25
	beq $t4, 22, speed3_sleep25
	beq $t4, 23, speed3_sleep25
	beq $t4, 24, speed4_sleep25
	beq $t4, 25, speed4_sleep25
	beq $t4, 26, speed5_sleep25
	beq $t4, 27, speed5_sleep25
	beq $t4, 28, speed5_sleep25
	beq $t4, 29, speed6_sleep25
	beq $t4, 30, speed6_sleep25
	beq $t4, 31, speed6_sleep25
	beq $t4, 32, speed7_sleep25
	speed8_sleep25:
	li $v0, 32			# sleep operation 25 to see the doodler
	li $a0, 205
	syscall
	j ERASE	
	speed7_sleep25:
	li $v0, 32			# sleep operation 25 to see the doodler
	li $a0, 185
	syscall
	j ERASE	
	speed6_sleep25:
	li $v0, 32			# sleep operation 25 to see the doodler
	li $a0, 125
	syscall
	li $v0, 31			# sound effect
	li $a0, 70
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed5_sleep25:
	li $v0, 32			# sleep operation 25 to see the doodler
	li $a0, 95
	syscall
	j ERASE	
	speed4_sleep25:
	li $v0, 32			# sleep operation 25 to see the doodler
	li $a0, 65
	syscall
	j ERASE	
	speed3_sleep25:
	li $v0, 32			# sleep operation 25 to see the doodler
	li $a0, 45
	syscall
	li $v0, 31			# sound effect
	li $a0, 68
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed2_sleep25:
	li $v0, 32			# sleep operation 25 to see the doodler
	li $a0, 35
	syscall
	j ERASE	
	speed1_sleep25:
	li $v0, 32			# sleep operation 25 see the doodler
	li $a0, 25
	syscall
	j ERASE
sleep35:
	beq $t5, 1, sleep_above_middle_sleep35
	beq $t4, 0, speed1_sleep35
	beq $t4, 1, speed1_sleep35
	beq $t4, 2, speed1_sleep35
	beq $t4, 3, speed1_sleep35
	beq $t4, 4, speed1_sleep35
	beq $t4, 5, speed2_sleep35
	beq $t4, 6, speed2_sleep35
	beq $t4, 7, speed2_sleep35
	beq $t4, 8, speed2_sleep35
	beq $t4, 9, speed2_sleep35
	beq $t4, 10, speed3_sleep35
	beq $t4, 11, speed3_sleep35
	beq $t4, 12, speed3_sleep35
	beq $t4, 13, speed4_sleep35
	beq $t4, 14, speed4_sleep35
	beq $t4, 15, speed4_sleep35
	beq $t4, 16, speed5_sleep35
	beq $t4, 16, speed5_sleep35
	beq $t4, 16, speed5_sleep35
	beq $t4, 16, speed6_sleep35
	beq $t4, 17, speed6_sleep35
	beq $t4, 18, speed7_sleep35
	beq $t4, 19, speed7_sleep35
	beq $t4, 20, speed8_sleep35
	beq $t4, 21, speed8_sleep35
	sleep_above_middle_sleep35:
	beq $t4, 13, speed1_sleep35
	beq $t4, 14, speed1_sleep35
	beq $t4, 15, speed1_sleep35
	beq $t4, 16, speed1_sleep35
	beq $t4, 17, speed1_sleep35
	beq $t4, 18, speed2_sleep35
	beq $t4, 19, speed2_sleep35
	beq $t4, 20, speed2_sleep35
	beq $t4, 21, speed3_sleep35
	beq $t4, 22, speed3_sleep35
	beq $t4, 23, speed3_sleep35
	beq $t4, 24, speed4_sleep35
	beq $t4, 25, speed4_sleep35
	beq $t4, 26, speed5_sleep35
	beq $t4, 27, speed5_sleep35
	beq $t4, 28, speed5_sleep35
	beq $t4, 29, speed6_sleep35
	beq $t4, 30, speed6_sleep35
	beq $t4, 31, speed6_sleep35
	beq $t4, 32, speed7_sleep35
	speed8_sleep35:
	li $v0, 32			# sleep operation 35 to see the doodler
	li $a0, 245
	syscall
	j ERASE	
	speed7_sleep35:
	li $v0, 32			# sleep operation 35 to see the doodler
	li $a0, 205
	syscall
	li $v0, 31			# sound effect
	li $a0, 67
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed6_sleep35:
	li $v0, 32			# sleep operation 35 to see the doodler
	li $a0, 145
	syscall
	j ERASE	
	speed5_sleep35:
	li $v0, 32			# sleep operation 35 to see the doodler
	li $a0, 105
	syscall
	j ERASE	
	speed4_sleep35:
	li $v0, 32			# sleep operation 35 to see the doodler
	li $a0, 75
	syscall
	li $v0, 31			# sound effect
	li $a0, 57
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed3_sleep35:
	li $v0, 32			# sleep operation 35 to see the doodler
	li $a0, 55
	syscall
	j ERASE	
	speed2_sleep35:
	li $v0, 32			# sleep operation 35 to see the doodler
	li $a0, 45
	syscall
	li $v0, 31			# sound effect
	li $a0, 64
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed1_sleep35:
	li $v0, 32			# sleep operation 35 to see the doodler
	li $a0, 35
	syscall
	j ERASE
sleep45:
	beq $t5, 1, sleep_above_middle_sleep45
	beq $t4, 0, speed1_sleep45
	beq $t4, 1, speed1_sleep45
	beq $t4, 2, speed1_sleep45
	beq $t4, 3, speed1_sleep45
	beq $t4, 4, speed1_sleep45
	beq $t4, 5, speed2_sleep45
	beq $t4, 6, speed2_sleep45
	beq $t4, 7, speed2_sleep45
	beq $t4, 8, speed2_sleep45
	beq $t4, 9, speed2_sleep45
	beq $t4, 10, speed3_sleep45
	beq $t4, 11, speed3_sleep45
	beq $t4, 12, speed3_sleep45
	beq $t4, 13, speed4_sleep45
	beq $t4, 14, speed4_sleep45
	beq $t4, 15, speed4_sleep45
	beq $t4, 16, speed5_sleep45
	beq $t4, 16, speed5_sleep45
	beq $t4, 16, speed5_sleep45
	beq $t4, 16, speed6_sleep45
	beq $t4, 17, speed6_sleep45
	beq $t4, 18, speed7_sleep45
	beq $t4, 19, speed7_sleep45
	beq $t4, 20, speed8_sleep45
	beq $t4, 21, speed8_sleep45
	sleep_above_middle_sleep45:
	beq $t4, 13, speed1_sleep45
	beq $t4, 14, speed1_sleep45
	beq $t4, 15, speed1_sleep45
	beq $t4, 16, speed1_sleep45
	beq $t4, 17, speed1_sleep45
	beq $t4, 18, speed2_sleep45
	beq $t4, 19, speed2_sleep45
	beq $t4, 20, speed2_sleep45
	beq $t4, 21, speed3_sleep45
	beq $t4, 22, speed3_sleep45
	beq $t4, 23, speed3_sleep45
	beq $t4, 24, speed4_sleep45
	beq $t4, 25, speed4_sleep45
	beq $t4, 26, speed5_sleep45
	beq $t4, 27, speed5_sleep45
	beq $t4, 28, speed5_sleep45
	beq $t4, 29, speed6_sleep45
	beq $t4, 30, speed6_sleep45
	beq $t4, 31, speed6_sleep45
	beq $t4, 32, speed7_sleep45
	speed8_sleep45:
	li $v0, 32			# sleep operation 45 to see the doodler
	li $a0, 255
	syscall
	j ERASE	
	speed7_sleep45:
	li $v0, 32			# sleep operation 45 to see the doodler
	li $a0, 205
	syscall
	li $v0, 31			# sound effect
	li $a0, 62
	li $a1, 500
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed6_sleep45:
	li $v0, 32			# sleep operation 45 to see the doodler
	li $a0, 155
	syscall
	j ERASE	
	speed5_sleep45:
	li $v0, 32			# sleep operation 45 to see the doodler
	li $a0, 115
	syscall
	j ERASE	
	speed4_sleep45:
	li $v0, 32			# sleep operation 45 to see the doodler
	li $a0, 95
	syscall 
	j ERASE	
	speed3_sleep45:
	li $v0, 32			# sleep operation 45 to see the doodler
	li $a0, 75
	syscall
	li $v0, 31			# sound effect
	li $a0, 56
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed2_sleep45:
	li $v0, 32			# sleep operation 45 to see the doodler
	li $a0, 55
	syscall
	j ERASE	
	speed1_sleep45:
	li $v0, 32			# sleep operation 45 to see the doodler
	li $a0, 45
	syscall
	j ERASE
sleep65:
	beq $t4, 0, speed1_sleep65
	beq $t4, 1, speed1_sleep65
	beq $t4, 2, speed1_sleep65
	beq $t4, 3, speed1_sleep65
	beq $t4, 4, speed1_sleep65
	beq $t4, 5, speed2_sleep65
	beq $t4, 6, speed2_sleep65
	beq $t4, 7, speed2_sleep65
	beq $t4, 8, speed2_sleep65
	beq $t4, 9, speed2_sleep65
	beq $t4, 10, speed3_sleep65
	beq $t4, 11, speed3_sleep65
	beq $t4, 12, speed3_sleep65
	beq $t4, 13, speed4_sleep65
	beq $t4, 14, speed4_sleep65
	beq $t4, 15, speed4_sleep65
	beq $t4, 16, speed5_sleep65
	beq $t4, 16, speed5_sleep65
	beq $t4, 16, speed5_sleep65
	beq $t4, 16, speed6_sleep65
	beq $t4, 17, speed6_sleep65
	beq $t4, 18, speed7_sleep65
	beq $t4, 19, speed7_sleep65
	beq $t4, 20, speed8_sleep65
	beq $t4, 21, speed8_sleep65
	speed8_sleep65:
	li $v0, 32			# sleep operation 65 to see the doodler
	li $a0, 265
	syscall
	li $v0, 31			# sound effect
	li $a0, 61
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed7_sleep65:
	li $v0, 32			# sleep operation 65 to see the doodler
	li $a0, 225
	syscall
	j ERASE	
	li $v0, 31			# sound effect
	li $a0, 60
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	speed6_sleep65:
	li $v0, 32			# sleep operation 65 to see the doodler
	li $a0, 175
	syscall
	j ERASE	
	speed5_sleep65:
	li $v0, 32			# sleep operation 65 to see the doodler
	li $a0, 145
	syscall
	li $v0, 31			# sound effect
	li $a0, 58
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed4_sleep65:
	li $v0, 32			# sleep operation 65 to see the doodler
	li $a0, 125
	syscall
	j ERASE	
	speed3_sleep65:
	li $v0, 32			# sleep operation 65 to see the doodler
	li $a0, 95
	syscall
	j ERASE	
	speed2_sleep65:
	li $v0, 32			# sleep operation 65 to see the doodler
	li $a0, 75
	syscall
	li $v0, 31			# sound effect
	li $a0, 56
	li $a1, 700
	li $a2, 32
	li $a3, 90
	syscall
	j ERASE	
	speed1_sleep65:
	li $v0, 32			# sleep operation 65 to see the doodler
	li $a0, 65
	syscall
	j ERASE	
	
platform_sound_effect_1:
	li $v0, 31			# sound effect
	li $a0, 45
	li $a1, 700
	li $a2, 0
	li $a3, 127
	syscall
	j START_BOUNCE_UP
	
platform_sound_effect_2:
	li $v0, 31			# sound effect
	li $a0, 45
	li $a1, 700
	li $a2, 0
	li $a3, 127
	syscall
	j BOUNCE_UP_FROM_MIDDLE
	
draw_lethal:
	addi $t8, $zero, 0
	lw $t8, arrayOfFirstLethal($t8)
	addi $t7, $zero, 0x10008F80
	addi $t9, $zero, 1
	slt $t7, $t7, $t8 
	beq $t9, $t7 update_first_lethal
	finishUpdatingFirstLethal:
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump1_lethal_1st_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump1_lethal_1st_lethal: addi $t8, $t8, 4
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump2_lethal_1st_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump2_lethal_1st_lethal: addi $t8, $t8, 124
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump3_lethal_1st_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump3_lethal_1st_lethal: addi $t8, $t8, 4
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t6 to $t2
	beq $t9, $s2, jump4_lethal_1st_lethal		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump4_lethal_1st_lethal: 
	j finishDrawingLethal

draw_lethal2:
	addi $t8, $zero, 0
	lw $t8, arrayOfSecondLethal($t8)
	addi $t7, $zero, 0x10008F80
	addi $t9, $zero, 1
	slt $t7, $t7, $t8 
	beq $t9, $t7 update_second_lethal
	finishUpdatingSecondLethal:
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump1_lethal_2nd_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump1_lethal_2nd_lethal: addi $t8, $t8, 4
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump2_lethal_2nd_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump2_lethal_2nd_lethal: addi $t8, $t8, 124
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump3_lethal_2nd_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump3_lethal_2nd_lethal: addi $t8, $t8, 4
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t6 to $t2
	beq $t9, $s2, jump4_lethal_2nd_lethal		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump4_lethal_2nd_lethal: 
	j finishDrawingLethal2
	
draw_lethal3:
	addi $t8, $zero, 0
	lw $t8, arrayOfThirdLethal($t8)
	addi $t7, $zero, 0x10008F80
	addi $t9, $zero, 1
	slt $t7, $t7, $t8 
	beq $t9, $t7 update_third_lethal
	finishUpdatingThirdLethal:
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump1_lethal_3rd_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump1_lethal_3rd_lethal: addi $t8, $t8, 4
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump2_lethal_3rd_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump2_lethal_3rd_lethal: addi $t8, $t8, 124
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump3_lethal_3rd_lethal		# compare if colour in $t6 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump3_lethal_3rd_lethal: addi $t8, $t8, 4
	addi $sp, $sp, -4	# paint doodler normally
	sw $t8, 0($sp)			# store the address of first pixel in the first stack
	lw $t9, 0($t8)			# load the colour value from $t6 to $t2
	beq $t9, $s2, jump4_lethal_3rd_lethal		# compare if colour in $t1 is red, if not, change from blue to green, if yes, jump
	sw $s6, 0($t8)			# store black color to the $t8 address
	jump4_lethal_3rd_lethal: 
	j finishDrawingLethal3	

	
erase_lethal:
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back1_1st_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back1_1st_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back2_1st_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back2_1st_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back3_1st_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back3_1st_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back4_1st_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back4_1st_lethal: addi $sp, $sp, 4
	lw $t8, arrayOfFirstLethal($zero)
	addi $t8, $t8, 128
	sw $t8, arrayOfFirstLethal($zero)
	j finishErasingLethal
	
	
erase_lethal2:
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back1_2nd_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back1_2nd_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back2_2nd_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back2_2nd_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back3_2nd_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back3_2nd_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back4_2nd_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back4_2nd_lethal: addi $sp, $sp, 4
	lw $t8, arrayOfSecondLethal($zero)
	addi $t8, $t8, 128
	sw $t8, arrayOfSecondLethal($zero)
	j finishErasingLethal2
	
erase_lethal3:
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back1_3rd_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back1_3rd_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back2_3rd_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back2_3rd_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back3_3rd_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back3_3rd_lethal: addi $sp, $sp, 4
	lw $t8, 0($sp)			# load the address of sixth pixel from sixth stack
	lw $t9, 0($t8)			# load the colour value from $t1 to $t2
	beq $t9, $s2, jump_back4_3rd_lethal	# compare if colour in $t1 is red, if not, change back from green to blue, if yes, jump
	sw $s1, 0($t8)			# change back the colour of sixth pixel from black to blue
	jump_back4_3rd_lethal: addi $sp, $sp, 4
	lw $t8, arrayOfThirdLethal($zero)
	addi $t8, $t8, 128
	sw $t8, arrayOfThirdLethal($zero)
	j finishErasingLethal3
	
update_first_lethal:
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 30			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	lw $t0, displayAddress		# $t0 stores the base address
	add $t8, $a0, $t0
	sw $t8, arrayOfFirstLethal($zero)
	j finishUpdatingFirstLethal
	
update_second_lethal:
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 30			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	lw $t0, displayAddress		# $t0 stores the base address
	add $t8, $a0, $t0
	sw $t8, arrayOfSecondLethal($zero)
	j finishUpdatingSecondLethal
	
update_third_lethal:
	li $v0, 42			# generate a random number in $a0, from 0 to 22
	li $a0, 0			# generate a random number in $a0, from 0 to 22
	li $a1, 30			# generate a random number in $a0, from 0 to 22
	syscall
	sll $a0, $a0, 2			# shift the random number in $a0 2 bits left, so that it is a multiple of 4
	lw $t0, displayAddress		# $t0 stores the base address
	add $t8, $a0, $t0
	sw $t8, arrayOfThirdLethal($zero)
	j finishUpdatingThirdLethal
	
	


      	
      	
      	
      	
      	
      	
      	
