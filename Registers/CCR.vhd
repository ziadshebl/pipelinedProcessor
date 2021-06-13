LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity CCR is
    port(
        clk,rst           : IN  STD_LOGIC;
        inCCR             : IN  STD_LOGIC_VECTOR(2 DOWNTO 0);
        outCCR            : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
end entity;

architecture ccrArch OF CCR IS
begin
    process(clk, rst)
    BEGIN
       IF(rst = '1') THEN
       outCCR <=(OTHERS=>'0');
    ELSIF rising_edge(clk) THEN
        outCCR <=inCCR;
    END IF;

    END PROCESS;
END ARCHITECTURE;
