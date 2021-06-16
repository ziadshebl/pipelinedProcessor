LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY memory IS
GENERIC (d : integer := 32);
PORT (
clk : IN std_logic;
rst : IN std_logic;

zeroFlag : IN std_logic;
negFlag : IN std_logic;
carryFlag : IN std_logic;

rdst : IN std_logic_vector(2 DOWNTO 0);
rdstData : IN std_logic_vector(d-1 DOWNTO 0);
sp : IN std_logic_vector(d-1 DOWNTO 0);
pc : IN std_logic_vector(d-1 DOWNTO 0);
aluResult : IN std_logic_vector(d-1 DOWNTO 0);
controlSignals : IN std_logic_vector(17 DOWNTO 0);

zeroFlagOut : OUT std_logic;
negFlagOut : OUT std_logic;
carryFlagOut : OUT std_logic;

rdstOut : OUT std_logic_vector(2 DOWNTO 0);
aluResultOut : OUT std_logic_vector(d-1 DOWNTO 0);
controlSignalsOut : OUT std_logic_vector(17 DOWNTO 0);
memoryDataOut : OUT std_logic_vector(d-1 DOWNTO 0) );
END ENTITY memory;


ARCHITECTURE memoryArch OF memory IS

COMPONENT dataMem IS
GENERIC ( a : integer := 32;
d : integer := 32;
w : integer := 16);
PORT (clk : IN std_logic;
writeEnable : IN std_logic;
address : IN std_logic_vector(a-1 DOWNTO 0);
writeData : IN std_logic_vector(d-1 DOWNTO 0);
memoryData : OUT std_logic_vector(d-1 DOWNTO 0) );
END COMPONENT dataMem;

SIGNAL addressSignal: std_logic_vector(d-1 DOWNTO 0);
SIGNAL writeDataSignal: std_logic_vector(d-1 DOWNTO 0);
SIGNAL memoryDataSignal : std_logic_vector(d-1 DOWNTO 0);

SIGNAL maxMemSignal : std_logic_vector(d-1 DOWNTO 0) := "00000000000011111111111111111110";

BEGIN

    data: dataMem GENERIC MAP (d,d,16) PORT MAP (clk,controlSignals(10),addressSignal,writeDataSignal,memoryDataSignal);    -- to get instr at M[PC]

    zeroFlagOut <= zeroFlag;
    negFlagOut <= negFlag ;
    carryFlagOut <= carryFlag;

    rdstOut <= rdst;

    aluResultOut <= aluResult ;
    controlSignalsOut <= controlSignals;

    process (aluResult,sp)
    begin 
        IF (maxMemSignal < aluResult) THEN
            addressSignal <= sp;
        else
            IF (controlSignals(6) = '0') THEN
                addressSignal <= aluResult;
            else
                addressSignal <= sp;
            end if;
        end if;
    end process;

    -- addressSignal(19 downto 0) <= aluResult(19 downto 0) WHEN controlSignals(6) = '0'
    -- ELSE sp(19 downto 0);

    -- addressSignal(31 downto 20) <=(OTHERS=>'0');

    writeDataSignal <= pc WHEN controlSignals(14) = '1' AND controlSignals(10) = '1'
    ELSE rdstData; 

    memoryDataOut <= memoryDataSignal;

END memoryArch;

