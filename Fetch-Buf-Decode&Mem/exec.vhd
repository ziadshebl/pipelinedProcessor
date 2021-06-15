LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY exec IS
GENERIC (d : integer := 32);
PORT (
clk : IN std_logic;
rst : IN std_logic;

addHold : IN std_logic;
ret : IN std_logic;
branch : IN std_logic;

rdstBDecode : IN std_logic_vector(d-1 DOWNTO 0);
rdstWB : IN std_logic_vector(d-1 DOWNTO 0);

pcValue : OUT std_logic_vector(d-1 DOWNTO 0);
instrValue : OUT std_logic_vector(d-1 DOWNTO 0) );
END ENTITY exec;


ARCHITECTURE execArch OF exec IS

COMPONENT PC IS
GENERIC ( n : integer := 32);
PORT(
    clk,rst         : IN  STD_LOGIC;
    resetValue       : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    inPC             : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
    outPC            : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
);
END COMPONENT ;

COMPONENT instructionMem IS
GENERIC ( a : integer := 32;
d : integer := 32;
w : integer := 16);
PORT (
address : IN std_logic_vector(a-1 DOWNTO 0);
resetValue : OUT std_logic_vector(d-1 DOWNTO 0);
dataout : OUT std_logic_vector(d-1 DOWNTO 0) );
END COMPONENT instructionMem;

SIGNAL inputPC: std_logic_vector(d-1 DOWNTO 0);
SIGNAL outputPC: std_logic_vector(d-1 DOWNTO 0);

SIGNAL resetValue: std_logic_vector(d-1 DOWNTO 0);

-- SIGNAL resetSignal: std_logic;

SIGNAL outputAdder: std_logic_vector(d-1 DOWNTO 0);

SIGNAL inputAdder1: std_logic_vector(1 DOWNTO 0);

SIGNAL outputInstr: std_logic_vector(d-1 DOWNTO 0);

BEGIN

    pcModule: PC GENERIC MAP (d) PORT MAP (clk,rst,resetValue,inputPC,outputPC); 

    instr: instructionMem GENERIC MAP (d,d,16) PORT MAP (outputPC,resetValue,outputInstr);    -- to get instr at M[PC]

    inputPC <= rdstBDecode WHEN branch = '1'
    ELSE rdstWB WHEN ret='1'
    ELSE outputAdder;

    -- resetValue WHEN resetSignal = '1'
    -- ELSE 

    inputAdder1 <= "00" WHEN addHold ='1'
    ELSE "10" WHEN outputInstr(31 downto 27) = "10010" OR outputInstr(31 downto 27) = "00001" OR outputInstr(31 downto 27) = "00010" OR outputInstr(31 downto 27) = "00011"
    ELSE "01";

    outputAdder <= std_logic_vector(unsigned(inputAdder1) + (unsigned(outputPC)));
	  
    -- resetSignal <= '1' WHEN outputInstr(31 downto 27) = "00000"
    -- ELSE '0';

    pcValue <= outputPC;
    instrValue <= outputInstr;

END execArch;

