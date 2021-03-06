LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY instructionMem IS
GENERIC ( a : integer := 32;
d : integer := 32;
w : integer := 16);
PORT (
address : IN std_logic_vector(a-1 DOWNTO 0);
resetValue : OUT std_logic_vector(d-1 DOWNTO 0);
dataout : OUT std_logic_vector(d-1 DOWNTO 0) );
END ENTITY instructionMem;


ARCHITECTURE asyncInstructionMem OF instructionMem IS

TYPE ram_type IS ARRAY(0 TO (2**19)-1) of std_logic_vector(w-1 DOWNTO 0);
SIGNAL ram : ram_type ;

BEGIN
 	dataout(31 downto 16) <= ram(to_integer(unsigned(address)));
	dataout(15 downto 0) <= ram(to_integer(unsigned(address))+1);

	resetValue(31 downto 16) <= ram(0);
	resetValue(15 downto 0) <= ram(1);


END asyncInstructionMem;

