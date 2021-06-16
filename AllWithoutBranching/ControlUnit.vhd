Library ieee;
use ieee.std_logic_1164.all;

ENTITY ControlUnit IS
	PORT ( 	
		rst: IN std_logic;
		opCode 	:IN std_logic_vector(4 downto 0);
		controlSignals        : OUT  std_logic_vector(17 downto 0));
END ENTITY ControlUnit;

ARCHITECTURE  ControlUnitArch OF ControlUnit IS
BEGIN
	--ALU
	controlSignals(17 downto 4) <=  (others =>'0') WHEN rst='1'

	ELSE (others =>'0') WHEN opCode = "01011" or opCode = "01100" or opCode = "01101" or opCode = "10000" or opCode = "10001" or opCode = "10011" or opCode = "10100" or opCode = "10101" or opCode = "01001" or opCode = "01010"
	-- IADD
	ELSE (15=>'1', others => '0') WHEN opCode = "10010" 
	--Load&IMM
	ELSE  (15 => '1', 11=>'0', 9=>'0', others => '0') WHEN opCode = "00001"
	--SHIFT&ALU
	ELSE  (16 => '1', 15=>'1', others => '0') WHEN opCode = "10110" or opCode = "10111"
	--STORE	
	ELSE  (15 => '1', 10=>'1', others => '0') WHEN opCode = "00011"
	--LOAD
	ELSE  (15 => '1', 11=>'1', 9=>'1', others => '0') WHEN opCode = "00010"
	--BRANCH	
	ELSE  (14 => '1', others => '0') WHEN opCode = "11001" or opCode = "11010" or opCode = "11011" or opCode = "11100" 
	--NOP	
	ELSE  (8 => '1', others => '0') WHEN opCode = "01000"
	--OUT
	ELSE  (7 => '1', others => '0') WHEN opCode = "01110"
	--IN
	ELSE  (17 => '1', others => '0') WHEN opCode = "01111"
	--PUSH
	ELSE  (16 => '1', 10=>'1', 6=> '1', 5=>'1', others => '0') WHEN opCode = "00100"
	--POP
	ELSE  (16 => '1', 9=>'1', 5=>'1', others => '0') WHEN opCode = "00101"
	--CALL
	ELSE (16 => '1', 14=>'1', 10=>'1',6=>'1', 5=>'1', others => '0') WHEN opCode = "11101"
	--RETURN
	ELSE (16 => '1', 14=>'1', 9=>'1',5=>'1', 4=>'1', others => '0') WHEN opCode = "11110"
	;


	--15
	controlSignals(3 downto 0) <=  (others =>'0') WHEN rst='1'

	ELSE "1111" WHEN opCode = "11110" or opCode = "00101" 
	--14
	ELSE "1110" WHEN opCode = "00100" or opCode = "11101"
	--13
	ELSE "1101" WHEN opCode = "00010" or opCode = "00011"
	--12	
	ELSE "1100" WHEN opCode = "01010"
	--11
	ELSE "1011" WHEN opCode = "01001"
	--10	
	ELSE "1010" WHEN opCode = "10111" 
	--9	
	ELSE "1001" WHEN opCode = "10110"
	--8
	ELSE "1000" WHEN opCode = "10101"
	--7
	ELSE "0111" WHEN opCode = "10100"
	--6
	ELSE "0110" WHEN opCode = "10011"
	--5
	ELSE "0101" WHEN opCode = "10010" or opCode = "10001" 
	--4
	ELSE "0100" WHEN opCode = "10000" or opCode = "01111" or opCode = "01110"
	--3
	ELSE "0011" WHEN opCode = "01101"
	--2
	ELSE "0010" WHEN opCode = "01100"
	--1
	ELSE "0001" WHEN opCode = "01011"
	--0
	ELSE "0000" WHEN opCode = "11001" or opCode = "11010" or opCode = "11011" or opCode = "11100" or opCode = "01000" or opCode = "00001"
	;





END ControlUnitArch;

