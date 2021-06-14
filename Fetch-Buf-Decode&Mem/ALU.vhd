library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Alu IS
  GENERIC (n : integer := 32); 
  port(
		Rsrc,Rdst : IN std_logic_vector(n-1 DOWNTO 0);  
		operation : IN std_logic_vector(3 DOWNTO 0);
		carry_in : IN std_logic;
		
		Result : OUT std_logic_vector(n-1 DOWNTO 0);
		cout_flag : OUT std_logic;
		zero_flag : OUT std_logic;
		negative_flag : OUT std_logic
);
   end ALU;
   
   
 Architecture arch of Alu is
 
signal extendedResult:  unsigned(32 DOWNTO 0):=(others=>'0');
signal RsrcUnsigned:	unsigned(31 DOWNTO 0);
signal RdstUnsigned:	unsigned(31 DOWNTO 0);

Begin

RsrcUnsigned<=unsigned(Rsrc);
RdstUnsigned<=unsigned(Rdst);

extendedResult <= '0'& (not RdstUnsigned) 																											when operation= "0001" --NOT
				else ('0'&RdstUnsigned)  + ('0'&'1')																								when operation="0010" --INC
				else ('0'&RdstUnsigned)  - ('0'&'1')																								when operation="0011" --DEC
				else  '0'& RsrcUnsigned																												when operation="0100" --MOV
				else ('0'&RsrcUnsigned)  +  ('0'&RdstUnsigned)																						when operation= "0101" or operation="1101" --Add & IADD
				else ('0'&RsrcUnsigned)  -  ('0'&RdstUnsigned)																						when operation= "0110" --SUB
				else ('0'&RsrcUnsigned) and ('0'&RdstUnsigned) 																						when operation="0111" --AND
				else ('0'&RsrcUnsigned)  or ('0'&RdstUnsigned)																						when operation="1000"; --OR
				
--ALU Output
Result<= std_logic_vector(shift_right(RdstUnsigned,to_integer(RsrcUnsigned))) when (operation = "1010" )
else std_logic_vector(shift_left(RdstUnsigned,to_integer(RsrcUnsigned)))	when operation="1001"
else std_logic_vector(extendedResult(31 DOWNTO 0));

--Zero flag
zero_flag <= '1' when extendedResult(31 DOWNTO 0) = (extendedResult(31 DOWNTO 0)'range => '0') else '0'; 
	
--Carry flag
cout_flag <=  not(extendedResult(32)) when (operation = "0110" or operation="0011") --SUB
         else extendedResult(32) when (operation = "0101") --Add 
         else RdstUnsigned(31) when (operation = "1001" ) --SHL 
         else RdstUnsigned(0) when (operation = "1010" ) --SHR
		 else  carry_in;
	
--Negative flag
negative_flag <= extendedResult(31) ;
 
 END arch;