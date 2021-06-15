LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity fetchBuffer is
    GENERIC ( d : integer := 32);
    port(
        clk,rst           : IN  STD_LOGIC;
        branchNop,loadUseStall  : IN  STD_LOGIC;
       
        pc : IN std_logic_vector(d-1 DOWNTO 0);
        instr : IN std_logic_vector(d-1 DOWNTO 0);

        nopOut: OUT  STD_LOGIC;
        pcOut : OUT std_logic_vector(d-1 DOWNTO 0);
        instrOut : OUT std_logic_vector(d-1 DOWNTO 0)
    );
end entity;

architecture fetchBufferArch OF fetchBuffer IS
begin

    process(clk, rst)
    BEGIN
       IF(rst = '1') THEN
       pcOut <=(OTHERS=>'0');
       instrOut <=(OTHERS=>'0');
       nopOut <= '0';
    ELSIF rising_edge(clk) THEN
        nopOut <= branchNop;
        IF(loadUseStall = '0') THEN
            pcOut <= pc;
            instrOut <= instr;
       END IF;
    END IF;
    END PROCESS;
    
    -- pcOut <= pc WHEN rst ='0' AND loadUseStall ='0'
    -- ELSE (OTHERS=>'0') WHEN rst ='1';

    -- instrOut <= instr WHEN rst ='0' AND loadUseStall ='0'
    -- ELSE (OTHERS=>'0') WHEN rst ='1';

    -- nopOut <= branchNop WHEN rst ='0'
    -- ELSE '0';

END ARCHITECTURE;

