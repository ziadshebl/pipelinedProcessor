LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY dataMem IS
GENERIC ( a : integer := 32;
d : integer := 32;
w : integer := 16);
PORT (clk : IN std_logic;
writeEnable : IN std_logic;
address : IN std_logic_vector(a-1 DOWNTO 0);
writeData : IN std_logic_vector(d-1 DOWNTO 0);
memoryData : OUT std_logic_vector(d-1 DOWNTO 0) );
END ENTITY dataMem;


ARCHITECTURE asyncDataMem OF dataMem IS

TYPE ram_type IS ARRAY(0 TO (2**19)-1) of std_logic_vector(w-1 DOWNTO 0);
SIGNAL dataram : ram_type ;

BEGIN
	PROCESS(clk) IS
	BEGIN
 		IF rising_edge(clk) THEN
 			IF writeEnable = '1' THEN
				dataram(to_integer(unsigned(address))) <= writeData(31 downto 16);
				dataram(to_integer(unsigned(address))+1) <= writeData(15 downto 0);
 			END IF;
 		END IF;
	END PROCESS;

 	memoryData(31 downto 16) <= dataram(to_integer(unsigned(address)));
	memoryData(15 downto 0) <= dataram(to_integer(unsigned(address))+1);

END asyncDataMem;