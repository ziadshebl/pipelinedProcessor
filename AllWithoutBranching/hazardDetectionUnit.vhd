LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY hazardDetectionUnit IS
PORT (
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

    addHold <= '1' WHEN (loadUse = '1' AND (rdst = rdstnew OR rdst = rscrnew )) OR branch = '1'
    ELSE '0';

    nop2 <= '1' WHEN (loadUse = '1' AND (rdst = rdstnew OR rdst = rscrnew )) OR branch = '1'
    ELSE '0';

    nop1 <= '1' WHEN loadUse = '1' AND (rdst = rdstnew OR rdst = rscrnew )
    ELSE '0';

    nop1B <= '1' WHEN branch = '1'
    ELSE '0';

END asynchazardDetectionUnit;
