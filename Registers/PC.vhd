
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity PC is
    generic ( n : integer := 32);
    port(
        clk,rst         : IN  STD_LOGIC;
        inPC             : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        outPC            : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
    );
end entity;

architecture pcArch OF PC IS
begin
    process(clk, rst)
    BEGIN
       IF(rst = '1') THEN
        outPC <=(OTHERS=>'0');
    ELSIF rising_edge(clk) THEN
        outPC <= inPC;
    END IF;

    END PROCESS;
END ARCHITECTURE;
