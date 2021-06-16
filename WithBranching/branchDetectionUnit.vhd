Library ieee;
use ieee.std_logic_1164.all;

ENTITY BranchDetectionUnit IS
	PORT ( 	
		branch 	:IN std_logic_vector(2 downto 0);
		zeroFlag,carryFlag,negFlag        : IN  std_logic;
        outputSelector  : OUT std_logic
        );
END ENTITY BranchDetectionUnit;

ARCHITECTURE  BranchDetectionUnitArch OF BranchDetectionUnit IS
BEGIN

    --JZ
	outputSelector <= '1' WHEN (branch(2) = '1' and branch(1) = '0' and branch(0) = '0' and zeroFlag = '1') 
    --JN
    OR (branch(2) = '1' and branch(1) = '0' and branch(0) = '1' and negFlag = '1')
    --JC
    OR (branch(2) = '1' and branch(1) = '1' and branch(0) = '0' and carryFlag = '1')
    --JMP
    OR (branch(2) = '1' and branch(1) = '1' and branch(0) = '1') --unconditional jump & call & return
    --NO JMP
    ELSE '0';
    

END BranchDetectionUnitArch;


