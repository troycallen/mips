# TROY ALLEN - CDA 3100 
# FINAL SUBMISSION 
# WORD ANALYZER AND COUNTER

	.data

	returnres: .space 10000
	tempres: .space 100
	target: .asciiz "th"
	dialog : .asciiz "BEDFORD Coward of France! how much he wrongs his fame,Despairing of his own arm's fortitude,To join with witches and the help of hell!BURGUNDY Traitors have never other company.But what's that Pucelle whom they term so pure?TALBOT A maid, they say.BEDFORD A maid! and be so martial!BURGUNDY Pray God she prove not masculine ere long,If underneath the standard of the FrenchShe carry armour as she hath begun.
TALBOT Well, let them practise and converse with spirits:God is our fortress, in whose conquering nameLet us resolve to scale their flinty bulwarks.BEDFORD Ascend, brave Talbot; we will follow thee.TALBOT Not all together: better far, I guess,That we do make our entrance several ways;That, if it chance the one of us do fail,The other yet may rise against their force.BEDFORD Agreed: I'll to yond corner.BURGUNDY And I to this.TALBOT And here will Talbot mount, or make his grave.Now, Salisbury, for thee, and for the rightOf English Henry, shall this night appearHow much in duty I am bound to both.Sentinels Arm! arm! the enemy doth make assault!ALENCON How now, my lords! what, all unready so?BASTARD OF ORLEANS Unready! ay, and glad we 'scaped so well.REIGNIER 'Twas time, I trow, to wake and leave our beds,Hearing alarums at our chamber-doors.ALENCON Of all exploits since first I follow'd arms,Ne'er heard I of a warlike enterpriseMore venturous or desperate than this.BASTARD OF ORLEANS I think this Talbot be a fiend of hell.REIGNIER If not of hell, the heavens, sure, favour him.ALENCON Here cometh Charles: I marvel how he sped.BASTARD OF ORLEANS Tut, holy Joan was his defensive guard.Enter CHARLES and JOAN LA PUCELLECHARLES Is this thy cunning, thou deceitful dame?Didst thou at first, to flatter us withal,Make us partakers of a little gain,That now our loss might be ten times so much?JOAN LA PUCELLE Wherefore is Charles impatient with his friend!
At all times will you have my power alike?Sleeping or waking must I still prevail,Or will you blame and lay the fault on me?Improvident soldiers! had your watch been good,This sudden mischief never could have fall'n.CHARLES Duke of Alencon, this was your default,That, being captain of the watch to-night,Did look no better to that weighty charge.ALENCON Had all your quarters been as safely keptAs that whereof I had the government,We had not been thus shamefully surprised.BASTARD OF ORLEANS Mine was secure.REIGNIER And so was mine, my lord.CHARLES And, for myself, most part of all this night,Within her quarter and mine own precinctI was employ'd in passing to and fro,About relieving of the sentinels:Then how or which way should they first break in?JOAN LA PUCELLE Question, my lords, no further of the case,How or which way: 'tis sure they found some placeBut weakly guarded, where the breach was made.And now there rests no other shift but this;To gather our soldiers, scatter'd and dispersed,And lay new platforms to endamage them.Soldier I'll be so bold to take what they have left.The cry of Talbot serves me for a sword;For I have loaden me with many spoils,Using no other weapon but his name.ExitSCENE II. Orleans. Within the town.Enter TALBOT, BEDFORD, BURGUNDY, a Captain, and others BEDFORD The day begins to break, and night is fled,Whose pitchy mantle over-veil'd the earth.Here sound retreat, and cease our hot pursuit.Retreat soundedTALBOT Bring forth the body of old Salisbury,And here advance it in the market-place,The middle centre of this cursed town.Now have I paid my vow unto his soul;For every drop of blood was drawn from him,There hath at least five Frenchmen died tonight.And that hereafter ages may beholdWhat ruin happen'd in revenge of him,Within their chiefest temple I'll erect
A tomb, wherein his corpse shall be interr'd:Upon the which, that every one may read,Shall be engraved the sack of Orleans,The treacherous manner of his mournful deathAnd what a terror he had been to France.But, lords, in all our bloody massacre,I muse we met not with the Dauphin's grace,His new-come champion, virtuous Joan of Arc,Nor any of his false confederates.BEDFORD 'Tis thought, Lord Talbot, when the fight began,Roused on the sudden from their drowsy beds,They did amongst the troops of armed menLeap o'er the walls for refuge in the field.BURGUNDY Myself, as far as I could well discernFor smoke and dusky vapours of the night,Am sure I scared the Dauphin and his trull,When arm in arm they both came swiftly running,Like to a pair of loving turtle-dovesThat could not live asunder day or night.After that things are set in order here,We'll follow them with all the power we have.Enter a MessengerMessenger All hail, my lords! which of this princely trainCall ye the warlike Talbot, for his actsSo much applauded through the realm of France?TALBOT Here is the Talbot: who would speak with him?Messenger The virtuous lady, Countess of Auvergne,With modesty admiring thy renown,By me entreats, great lord, thou wouldst vouchsafeTo visit her poor castle where she lies,That she may boast she hath beheld the manWhose glory fills the world with loud report.BURGUNDY Is it even so? Nay, then, I see our warsWill turn unto a peaceful comic sport,When ladies crave to be encounter'd with.You may not, my lord, despise her gentle suit.TALBOT Ne'er trust me then; for when a world of menCould not prevail with all their oratory,Yet hath a woman's kindness over-ruled:And therefore tell her I return great thanks,And in submission will attend on her.Will not your honours bear me company?BEDFORD No, truly; it is more than manners will:And I have heard it said, unbidden guestsAre often welcomest when they are gone.TALBOT Well then, alone, since there's no remedy,I mean to prove this lady's courtesy.
Come hither, captain.\n\n"
	str_changeline: .asciiz "\n"

	.text
	.globl main
main:
	#li $v0, 4
	#la $a0, dialog
	#syscall

	la $a0, dialog
	la $a1, target
	la $a2, returnres
	la $a3, tempres
	
	jal findwords 
	
	li $t0, 0
	ori $t1, $v0, 0
	la $a0, returnres
	li $v0, 4

main_L1:
	beq $t0, $t1, main_done 
	syscall
	ori $s0, $a0, 0
	la $a0, str_changeline
	syscall
	ori $a0, $s0, 0
	addi $t0, $t0, 1

main_L2:
	addi  $a0, $a0, 1
	lb $t9, 0($a0)
	bne $t9, $0, main_L2
	addi  $a0, $a0, 1
	j main_L1

main_done:
	li $v0, 10           	
	syscall


##############BEGINNING OF FINDWORDS#############
findwords:

	addi $sp, $sp, -28	# adjusting stack 
	sw $s4, 24($sp)
	sw $s7, 20($sp)
	sw $s5, 16($sp)
	sw $s3, 12($sp)		# storing values on stack
	sw $s1, 8($sp)
	sw $s0, 4($sp)
	sw $ra, 0($sp)
	
	ori $s0, $a0, 0		# store dialog in s0
	ori $s1, $a1, 0		# store target in s1
	ori $s7, $a2, 0		# store returnres in s7
	ori $s4, $a2, 0		# zero pos returnres in s4
	ori $s5, $a3, 0		# zero pos tempres in s5
	li $s3, 0			# s3 is counter to put in v0 later

CHECKPOS:
	lb $t7, 0($s0)		# check if at end of dialog
	bne $t7, $0, SAVEPOS
	j DIALOGOVER
	
CHECKBYTE:
	lb $a0, 0($s0)		# load 1st byte of dialog into a0

	jal isletter		# call isletter to check
	
	bne $v0, $0, LETTER 	# if returns 1 = letter
	beq $v0, $0, NOTLETTER	# otherwise not letter

SAVEPOS:
	ori $a3, $0, 0		# if not we clear out tempres
	addi $a3, $s5, 0	# point tempres to pos 0
	j CHECKBYTE			# then check byte to store them
	
LETTER:
	sb $a0, 0($a3)		# add letter to tempres
	addi $a3, $a3, 1	# move temp res over 1
	addi $s0, $s0, 1	# move dialog to next byte		
	
	j CHECKBYTE			# otherwise call is letter again
	
NOTLETTER:				# word over as soon as not letter
	sb $0, 0($a3)		# put a 0 on end to make it asciiz
	j CALLHASTARGET		# call hastarget to check

CALLHASTARGET:
	addi $a3, $s5, 0	# go back to beginning of tempres
	ori $a0, $a3, 0		# put tempres in a0
	ori $a1, $s1, 0		# put target into a1
	
	jal hastarget		# call hastarget
	
	
	bne $v0, $0, HASTARGET	# if 1 it has target
	beq $v0, $0, NOTARGET	# if 0 it doesnt
	
HASTARGET:
	j CALLISUNIQUE		# if it has target we go to call isunique
	
NOTARGET:
	addi $s0, $s0, 1	# otherwise move dialog
	j CHECKPOS			# and check the next byte
		
CALLISUNIQUE:
	ori $a0, $s7, 0		# put list of words into a0
	addi $a0, $s4, 0	# point return res back to start of list
	ori $a1, $a3, 0		# put word to check in a1	
	ori $a2, $s3, 0		# num words in list from our counter
	
	beq $s3, $0, WORDNOTINLIST #if first word found just skip isunique
	
	jal isunique		# call isunique
	
	beq $v0, $0, WORDINLIST		# 0 if word already there
	bne $v0, $0, WORDNOTINLIST	# 1 if unique

WORDINLIST:
	j CHECKPOS			# go check next word
						# dont inc counter
WORDNOTINLIST:
	addi $s3, $s3, 1	# inc counter by 1 if new word

	strcpy:
		lb $t0, 0($a3)		# copy word from tempres to s7 
		sb $t0, 0($s7)		# put words in s7 which we will 
		addi $a3, $a3, 1	# put in a2 at end
		addi $s7, $s7, 1
		bne $t0, $0, strcpy

	j NOTARGET			# and go to find next word

DIALOGOVER:				# if asciiz is over
	ori $v0, $s3, 0		# put our counter in v0
	addi $s7, $s4, 0	# point s7(list) back to pos 0
	ori $a2, $s4, 0		# put a2 back to empty tempres pos 0
	
	strcpy2:				
		lb $t2, 0($s7)		# copy words from s7 to returnres 
		sb $t2, 0($a2)		
		addi $s7, $s7, 1	
		addi $a2, $a2, 1
		bne $t2, $0, strcpy2

	
EXIT:				
	lw $ra, 0($sp)		# restore stack values
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s3, 12($sp)
	lw $s5, 16($sp)
	lw $s7, 20($sp)
	lw $s4, 24($sp)
	addi $sp, $sp, 28	# adjust changes	

	jr $ra				# return to main
##############END OF FINDWORDS################


##############BEGINNING OF HASTARGET###########
hastarget:
	ori $t2, $a1, 0		# storing current spot of a1
						# inside t2 for use in NOMATCH4
LOOP4:
	lb $t0, 0($a0)		# load current byte	
	lb $t1, 0($a1)		# of each string

	beq $t0, $t1, MATCH4	# if equal jump to match
	beq $t1, $0, FOUND4		# or if tar is at end its found
	j NOMATCH4				# otherwise no match

MATCH4:				
	beq $t0, $0, FOUND4		# if both at 0 target is found
	addi $a0, $a0, 1		# otherwise check next letter
	addi $a1, $a1, 1		# of both target and word
	j LOOP4					# by going back to loop

NOMATCH4:
	beq $t0, $0, NOTFOUND4	# if at end of word exit
	addi $a0, $a0, 1		# otherwise go to next spot in word
	addi $a1, $t2, 0		# and set tar back to pos 0
	j LOOP4					# and loop to check again

FOUND4:
	addi $v0, $0, 1		# return 1 if target found
	j EXIT4				# skip NOTFOUND4
	
NOTFOUND4:				# return 0 if no target found
	addi $v0, $0, 0
	
EXIT4:					# return to findwords
	jr $ra		

############END OF HASTARGET#################


##############BEGINNING OF ISUNIQUE############
isunique:

	addi $sp, $sp, -16		# adjusting stack
	sw $s5, 12($sp)
	sw $s6, 8($sp)			# put values on stack
	sw $s2, 4($sp)
	sw $ra, 0($sp)		
	
	li $s2, 0				# s4 is counter
	ori $s6, $a0, 0			# put list in s6
	ori $s5, $a1, 0			# put word in s5

FINDWORD3:			
	lb $t3, 0($s6)				# if not a 0
	beq $t3, $0, NEXTWORD3		# then we go to callstrcmp

CALLSTRCMP3:
	beq $s2, $a2, NOWORDINLIST3	# if counter = num words exit
	ori $a0, $s6, 0				# put where we currently are 
	ori $a1, $s5, 0
								# in the list inside a0
	jal strcmp					# and call strcmp
	
	bne $v0, $0, WORDINLIST3	# if word found exit

	addi $s2, $s2, 1			# otherwise inc counter
	beq $s2, $a2, NOWORDINLIST3	# if counter = num words exit

	beq $v0, $0, NEXTWORD3		# not necessary but clearer
	

NEXTWORD3:				# moving list to next word
	lb $t2, 0($s6)
	bne $t2, $0, INC3	# while not 0 keep shifting
	j NEXT3				# until we hit 0 

INC3:
	addi $s6, $s6, 1	# move current over 1
	j NEXTWORD3			# and loop

NEXT3:
	addi $s6, $s6, 1	# once 0 we go right one more
	j FINDWORD3			# since it will be start of 
						# the next word
		
WORDINLIST3:	
	addi $v0, $0, 0		# return 0 if non unique word
	j EXIT3	

NOWORDINLIST3:			# return 1 if unique word
	addi $v0, $0, 1		
					
EXIT3:
	lw $ra, 0($sp)		# restoring values we put
	lw $s2, 4($sp)		# onto the stack
	lw $s6, 8($sp)
	lw $s5, 12($sp)
	addi $sp, $sp, 16	# undo changes to stack

	jr $ra				# return to findwords

############END OF INSUNIQUE################


############BEGINNING OF STRCMP################
strcmp:

CHECK2:	
	lb $t0, 0($a0)		# loading current byte
	lb $t1, 0($a1)		# loading current byte
				
	beq $t0, $t1, INC2	# if same byte go to inc

	j NOMATCH2			# otherwise exit
	
INC2:				
	beq $t0, $0, MATCH2	# if both 0 match found
	addi $a0, $a0, 1	# otherwise go next byte
	addi $a1, $a1, 1	# for each
	
	j CHECK2			# and check again
	
NOMATCH2:			
	addi $v0, $0, 0		# return 0 for no
	j EXIT2

MATCH2: 				# return 1 for match
	addi $v0, $0, 1
	
EXIT2:					# return to isunique
	jr $ra
#############END OF STRCMP#################


###########BEGINNING OF ISLETTER############
isletter: 

	li $t0, 65			# loading bottom of range
	li $t1, 90			# in ascii
	li $t2, 97
	li $t3, 122			# loading top
	
	blt $a0, $t0, NOTLETTER1	# if <65 not letter
	bgt $a0, $t3, NOTLETTER1	# if >122 not letter 
	bgt $a0, $t1, CHECK1		# if in between but >90
						# we check if <97 

	j LETTER1			# otherwise its letter

CHECK1:
	blt $a0, $t2, NOTLETTER1	# if <97 not letter	

LETTER1:
	addi $v0, $0, 1				# return 1 if letter
	j EXIT1

NOTLETTER1:
	addi $v0, $0, 0				# return 0 if not 
				
EXIT1:					# return to findwords
	jr $ra

#############END OF ISLETTER###############



