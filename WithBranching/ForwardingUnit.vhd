Library ieee;
use ieee.std_logic_1164.all;

ENTITY ForwardingUnit IS
	PORT ( 	rsrc, rdst, rdstEx, rdstMem 	:IN std_logic_vector(2 downto 0);
			writeMemoryEx, regMemoryEx, stackEx, writeMemoryMem, regMemoryMem, stackMem	:IN std_logic;
			op1Selector, op2Selector        : OUT  std_logic_vector(1 downto 0);
			stackDec	:IN std_logic;
			stackSelector	:OUT std_logic_vector(1 downto 0);
			checkCall1:IN std_logic;
			checkCall2:IN std_logic;
			checkRet:IN std_logic
			);
END ENTITY ForwardingUnit;

ARCHITECTURE  ForwardingUnitArch OF ForwardingUnit IS
BEGIN
	op1Selector <= "10" WHEN rdstEx = rsrc and regMemoryEx = '0' and writeMemoryEx = '0' and stackEx = '0' --Alu result
		ELSE "01" WHEN rdstMem = rsrc and checkCall1='0' and checkCall2='0' and checkRet='0' --and (regMemoryMem = '1' or writeMemoryMem = '1' or stackMem = '1')   -- memory result
		ELSE "00"																						   -- No forwarding
		;

	op2Selector <= "10" WHEN rdstEx = rdst and regMemoryEx = '0' and writeMemoryEx = '0' and stackEx = '0' 
		ELSE "01" WHEN rdstMem = rdst and checkCall1='0' and checkCall2='0' and checkRet='0'													--and (regMemoryMem = '1' or writeMemoryMem = '1' or stackMem = '1')
		ELSE "00"
		;

	stackSelector <= "01" WHEN 	stackDec = '1' and stackEx ='1'      -- take value from SP from Ex
		ELSE "10"  WHEN stackDec = '1' and stackMem = '1'	 -- take value from SP from Mem
		ELSE "00";    -- take value from original SP

END ForwardingUnitArch;
