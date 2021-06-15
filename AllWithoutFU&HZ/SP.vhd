LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity SP is
    generic ( n : integer := 32);
    port(
        clk,rst         : IN  STD_LOGIC;
        inSP             : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        outSP            : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
    );
end entity;

architecture spArch OF SP IS
begin
    process(clk, rst)
    BEGIN
       IF(rst = '1') THEN                                     -- 2**20 - 2
        outSP(20 DOWNTO 1) <= (OTHERS=>'1');
        outSP(n-1 DOWNTO 21) <=(OTHERS=>'0');
	outSP(0)<='0';
    ELSIF rising_edge(clk) THEN
        outSP <= inSP;
    END IF;

    END PROCESS;
END ARCHITECTURE;
