LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY hazardDetectionUnit IS
PORT (
clk : IN std_logic;
loadUse : IN std_logic;
branch : IN std_logic;
rdst : IN std_logic_vector(2 DOWNTO 0);
rdstnew : IN std_logic_vector(2 DOWNTO 0);
rscrnew : IN std_logic_vector(2 DOWNTO 0);

addHold : OUT std_logic;
nop1 : OUT std_logic;
nop2 : OUT std_logic;
nop1B : OUT std_logic);
END ENTITY hazardDetectionUnit;


ARCHITECTURE asynchazardDetectionUnit OF hazardDetectionUnit IS

BEGIN

    -- process(clk)
    -- BEGIN
    --   IF rising_edge(clk) THEN
    --     IF ((loadUse = '1' AND (rdst = rdstnew OR rdst = rscrnew )) OR branch = '1') THEN
    --         addHold <= '1';
    --         nop2 <= '1';
    --     ELSE
    --         addHold <= '0';
    --         nop2 <= '0';
    --     END IF;    
    --     IF (loadUse = '1' AND (rdst = rdstnew OR rdst = rscrnew )) THEN
    --         nop1 <= '1';
    --     ELSE
    --         nop1 <= '0';
    --     END IF;
    --     IF (branch = '1') THEN
    --         nop1B <= '1';
    --     ELSE
    --         nop1B <= '1';
    --     END IF;    

    -- END IF;
    -- end process;

    addHold <= '1' WHEN (loadUse = '1' AND (rdst = rdstnew OR rdst = rscrnew )) OR branch = '1'
    ELSE '0';

    nop2 <= '1' WHEN (loadUse = '1' AND (rdst = rdstnew OR rdst = rscrnew )) OR branch = '1'
    ELSE '0';

    nop1 <= '1' WHEN loadUse = '1' AND (rdst = rdstnew OR rdst = rscrnew )
    ELSE '0';

    nop1B <= '1' WHEN branch = '1' AND loadUse = '0'
    ELSE '0';

END asynchazardDetectionUnit;
