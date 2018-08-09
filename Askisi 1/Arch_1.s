######################################################################################################
######################################################################################################
########### Ioanna Lykoudi 1115201400091 ################ Melina Skoura 1115201400185 ################
######################################################################################################
######################################################################################################

.data

array:

.word32	1073741825,-903,-614,311,946,906,-211,-576,-936,-313,-985,833,540,-616,-50,356,639,-334,-114,98304
.word32 455,661,929,-697,-383,-26,517,-31,-981,-66,-243,913,-739,-910,-831,917,-773,693,244,-727
.word32 379,417,-297,-88,-887,-455,-493,687,852,812,433,-681,453,188,503,-920,-961,-199,-400,692
.word32 855,-735,-49,-954,63,-416,-406,481,396,-434,3,801,-4,811,-27,975,-168,906,267,115
.word32 -234,684,99,-380,-442,-485,308,460,890,772,517,-196,-197,-33,600,-360,181,944,-536,866
.word32 720,-957,806,-560,-195,-448,-996,755,958,463,945,253,-401,736,-935,-795,-148,-707,384,-555
.word32 -857,-428,533,-460,982,164,-930,98304,-697,-613,2147483647,-487,98304,-913,-323,-730,60,-124,787,-143
.word32 570,-180,315,-609,816,-314,-776,-173,-931,-144,986,-961,-955,803,795,821,551,-232,629,295
.word32 443,-461,984,-206,608,715,-379,383,-318,-270,278,925,603,-575,-77,0,-311,309,-186,-891
.word32 -600,905,-395,93,-553,849,-695,-955,-586,334,729,618,-764,-183,-718,104,869,6,-676,310
.word32 566,382,289,576,370,-34,-767,386,828,130,822,-940,697,-993,959,150,-479,790,-475,-861
.word32 -403,502,-668,-669,713,-803,-423,16,783,440,31,2,282,905,-786,719,-718,-582,-915,-492
.word32 952,304,945,857,334,-174,-775,-392,679,579,803,-46,-290,-873,214,460,-491,-463,-783,441
.word32 -148,576,557,235,914,-137,527,835,-232,815,-986,496,-430,805,595,256,-158,230,-946,-570
.word32 974,-71,392,-95,747,-834,700,-382,774,-532,-646,22,910,528,-266,406,537,-559,-425,663
.word32 350,-674,98304,-847,250,537,952,-222,-534,-135,701,-724,750,19,-899,-638,-156,-628,-623,-199
.word32 -520,969,-132,-670,825,-106,-626,222,-802,745,-38,-21,857,792,335,404,581,-171,-323,579
.word32 934,788,-408,342,-259,383,543,360,659,762,-403,-876,-525,468,166,951,-582,678,226,-725
.word32 131,700,-106,-346,394,256,9,420,684,-222,994,-292,-891,-934,736,-629,-534,-198,-226,593
.word32 857,322,-324,1000,1001,-874,-48,-519,590,-194,571,163,-635,-396,577,763,-818,245,-619, 2147483647



print1:
			.asciiz "X= "							# no. of X
print2:
			.asciiz "Z= "							# no. of Z
print3:
			.asciiz "B= " 							# no. of B
print4:
			.asciiz "C= " 							# no. of C
print5:
			.asciiz "P= " 							# no. of P


X:			.word32 0
Z:			.word32 0
B:			.word32 0
C:			.word32 0
P:			.word32 0


ARRAY_SIZE:
			.word 1600 								#1600 = 400(ints)*4(bytes)

CONTROL:
			.word32 0x10000
DATA:
      		.word32 0x10008


.text

			lw R8, X(R0)							# R8 = X
			lw R9, Z(R0)							# R9 = Z
			lw R10, B(R0)							# R10 = B
			lw R11, C(R0)							# R11 = C
			lw R12, P(R0)							# R12 = P
													#R14 = i = 0 counter for loop
			lw R27, array(R0)						#for P


			ld R18,ARRAY_SIZE(R0)					#R18 = 1600 = 400(ints)*4(bytes)

for:
			lw R17, array(R14)          			#R17=array[i]
			daddi R14, R14, 4						#i++


			beqz R17, Ypologismos_Z
			daddi R20, R17, 0						#Current num
			daddi R1, R0, 0							#initialize R1=0 each time
			daddi R2, R0, 0							#initialize R2=0 each time

Ypologismos_X:
			beqz R20, Ypologismos_Antithetou		#if R20 = 0, go to Ypologismos_Antithetou
			andi R15, R20, 1						#check if the last bit is 1 or 0
			dadd R1, R1, R15						#counter of 1's
			dsrl R20, R20, 1						#shift 1 bit right
			j Ypologismos_X

Ypologismos_Antithetou:
			daddi R5, R17, 0
			xori R20, R5, 4294967295				#1->0, 0->1
			daddi R20, R20, 1               		#negative of R17

Loop_Antithetos:
			beqz R20, Sygkrisi
			andi R15, R20, 1						#check if the last bit is 1 or 0
			dadd R2, R2, R15						#counter of 1's
			dsrl R20, R20, 1						#shift 1 bit right
			j Loop_Antithetos

Sygkrisi:
			bne R1, R2, Ypologismos_Z
		  	daddi R8, R8, 1

			#daddi R3, R0, 11						# R3= 11

Ypologismos_Z:
			daddi R5, R0, 21						#R5=21
			slt R2, R1, R5							#check if R1<R5 (for the comparison of 1's)
			beqz R2, Ypologismos_B					#if R1>21, go to B
			daddi R9, R9, 1							#else Z++


Ypologismos_B:
			daddi R1, R0, 1000
			daddi R2, R0, -1000
			slt R15, R2, R17						#-1000 < R17
			slt R20, R17, R1						#R17 < 1000
			and R4, R15, R20						#check if -1000<R17<1000 (R15=R20=1)
			bnez R4, Ypologismos_C					#if R4=1, go to C
			daddi R10, R10, 1						#else B++

Ypologismos_C:
			daddi R1,R0,32							#R1=32, counter of loop_C
			daddi R20, R17, 0						#Current num
			daddi R7, R0, 0							#initialize R7=0 each time
loop_C:
			beqz R1, sygkrisi_C						#if R1=0
			dsll R7, R7, 1							#shift 1 bit left
			andi R15, R20, 1 						#keep the last bit
			or R7, R7, R15
			dsrl R20, R20, 1						#shift Current num 1 bit right
			daddi R1, R1, -1						#R1--
			j loop_C


sygkrisi_C:
			bne R7,R17, Ypologismos_P				#if R17!=R7, go to P
	    	daddi R11, R11, 1						#else C++

Ypologismos_P:
			slt R23, R17, R27						#check if R17<R27
			bnez R23, go_there						#if R17<R27, go to go_there
			daddi R27, R17, 0						#R27=R17 because R17>R27
			daddi R12, R14, 0 						#keep the position of the biggest num

go_there: 	bne R14,R18,for							#if i<399, go for

Prints:
			lwu R21, CONTROL(R0)
			lwu R22, DATA(R0)

			daddi R2, R0, 4
			daddi R1,R0,print1						#no. of X
			sd R1,(R22)
	        sd R2,(R21)

			daddi R3,R0,1     						#integer output
	        sd R8,(R22)
	        sd R3,(R21)

			daddi R1,R0,print2						#no. of Z
			sd R1,(R22)
	        sd R2,(R21)

	        sd R9,(R22)								#integer output
	        sd R3,(R21)

			daddi R1,R0,print3						#no. of B
			sd R1,(R22)
	        sd R2,(R21)

	        sd R10,(R22)							#integer output
	        sd R3,(R21)

			daddi R1,R0,print4						#no. of C
			sd R1,(R22)
	        sd R2,(R21)

	        sd R11,(R22)							#integer output
	        sd R3,(R21)

			daddi R1,R0,print5						#no. of P
			sd R1,(R22)
	        sd R2,(R21)

			daddi R4, R0, 4							#R4=4
			ddiv R12, R12, R4						#R12/4
			daddi R12, R12, -1						#R12=1, to calculate the exact position
	        sd R12,(R22)							#integer output
	        sd R3,(R21)


Exit: 		halt
