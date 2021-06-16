def calculateRegisterAddress(register):
    temp = ""
    if(register == "R0"):
        temp = "000"
    elif(register == "R1"):
        temp = "001"    
    elif(register == "R2"):
        temp = "010"
    elif(register == "R3"):
        temp = "011"     
    elif(register == "R4"):
        temp = "100"    
    elif(register == "R5"):
        temp = "101"
    elif(register == "R6"):
        temp = "110"
    elif(register == "R7"):
        temp = "111"
    return temp

def calculateImmediateValue(imm):
    binary = format(int(imm,16),'016b')
    return binary
   


def calculateSHAMT(shamt):
    binary = format(int(shamt,16),'05b')
    print(binary)
    return binary



metaData = "// memory data file (do not edit the following line - required for mem load use)\n// instance = /ram/ram\n// format=mti addressradix=h dataradix=s version=1.0 wordsperline = 1"
with open('output.mem', 'w') as f:
        f.write("%s\n" % metaData)

myFile = open("branch.asm", "r")
myInstructions = []
index = 0
nopInstruction = "0100000000000000"
with open('branch.asm', 'r') as f:
    for line in f:

        line  = myFile.readline()
        if not line.strip():
            continue
        line = line.replace(",", " ")
        objects = line.split( )
        instruction = ""
        objects[0] = objects[0].upper()
        if(objects[0].__contains__('#')):
            continue
        elif(objects[0]==".ORG"):
            index = int(objects[1],16)
        elif(objects[0]=="NOP"):
            instruction = "01000"
            for i in range(11):
                instruction+= "0"
        elif(objects[0]=="SETC"):
            instruction = "01001"
            for i in range(11):
                instruction+= "0"
        elif(objects[0]=="CLRC"):
            instruction = "01010"
            for i in range(11):
                instruction+= "0"
        elif(objects[0]=="NOT"):
            instruction = "01011" 
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"
        elif(objects[0]=="INC"):
            instruction = "01100"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"
        elif(objects[0]=="DEC"):
            instruction = "01101"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"        
        elif(objects[0]=="OUT"):
            instruction = "01110"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"          
        elif(objects[0]=="IN"):
            instruction = "01111"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"        
        elif(objects[0]=="RESET"):
            instruction = "00000"
            for i in range(8):
                instruction+= "0"        
        elif(objects[0]=="INTERRUPT"):
            instruction = "11000"
            for i in range(8):
                instruction+= "0"                       
        elif(objects[0]=="JZ"):
            instruction = "11001"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"        
        elif(objects[0]=="JN"):
            instruction = "11010"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"
        elif(objects[0]=="JC"):
            instruction = "11011"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"      
        elif(objects[0]=="JMP"):
            instruction = "11100"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"
        elif(objects[0]=="CALL"):
            instruction = "11101"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"
        elif(objects[0]=="RET"):
            instruction = "11110"  
            for i in range(11):
                instruction+= "0"    
        elif(objects[0]=="RTI"):
            instruction = "11111"
            for i in range(11):
                instruction+= "0" 
        elif(objects[0]=="MOV"):
            instruction = "10000"
            instruction += calculateRegisterAddress(objects[2])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"
        elif(objects[0]=="ADD"):
            instruction = "10001"
            instruction += calculateRegisterAddress(objects[2])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"  
        elif(objects[0]=="IADD"):
            instruction = "10010"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            #instruction+="000"
            instruction += calculateImmediateValue(objects[2])
            for i in range(5):
                instruction+= "0"              
        elif(objects[0]=="SUB"):
            instruction = "10011"
            instruction += calculateRegisterAddress(objects[2])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"        
        elif(objects[0]=="AND"):
            instruction = "10100"
            instruction += calculateRegisterAddress(objects[2])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"        
        elif(objects[0]=="OR"):
            instruction = "10101"
            instruction += calculateRegisterAddress(objects[2])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"        
        elif(objects[0]=="SHL"):
            instruction = "10110"
            #instruction += "000"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateSHAMT(objects[2])
        elif(objects[0]=="SHR"):
            instruction = "10111"  
            #instruction += "000"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateSHAMT(objects[2])    
        elif(objects[0]=="PUSH"):
            instruction = "00100"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"        
        elif(objects[0]=="POP"):
            instruction = "00101"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            for i in range(5):
                instruction+= "0"
        elif(objects[0]=="LDM"):
            instruction = "00001"
            instruction += calculateRegisterAddress(objects[1])
            instruction += calculateRegisterAddress(objects[1])
            #instruction += "000"
            instruction += calculateImmediateValue(objects[2])
            for i in range(5):
                instruction+= "0"  
        elif(objects[0]=="LDD"):
            instruction = "00010"
            instruction += calculateRegisterAddress(objects[1])
            
            objects[2]=objects[2].replace(")", "")
            objects[2] = objects[2].split("(")
            offset = objects[2][0]
            rsrc = objects[2][1]

            instruction += calculateRegisterAddress(rsrc)
            instruction += calculateImmediateValue(offset)
            for i in range(5):
                    instruction+= "0" 
            
        elif(objects[0]=="STD"):
            instruction = "00011"
            instruction += calculateRegisterAddress(objects[1])
            
            objects[2]=objects[2].replace(")", "")
            offset = objects[2].split("(")[0]
            rsrc = objects[2].split("(")[1]

            instruction += calculateRegisterAddress(rsrc)
            instruction += calculateImmediateValue(offset)
            for i in range(5):
                    instruction+= "0"
        else:
            instruction = format(int(objects[0],16),'032b')              

        if(objects[0]!=".ORG"):   
            if(len(instruction)<=16):
                lineToAppend = str(hex(index))[2:]+": "+instruction
                myInstructions.append(lineToAppend) 
                index+=1
                if(objects[0]=="RET"):
                    lineToAppend = str(hex(index))[2:]+": "
                    myInstructions.append(lineToAppend + nopInstruction) 
                    index+=1     
            else:
                lineToAppend = str(hex(index))[2:]+": "+instruction[0:16]
                myInstructions.append(lineToAppend)
                index+=1
                lineToAppend = str(hex(index))[2:]+": "+instruction[16:32] 
                myInstructions.append(lineToAppend)
                index+=1
                                                        
myFile.close() 
with open('output.mem', 'a') as f:
    for item in myInstructions:
        f.write("%s\n" % item)