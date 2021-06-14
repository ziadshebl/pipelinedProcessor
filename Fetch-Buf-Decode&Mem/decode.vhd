LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY decode IS
GENERIC (d : integer := 32);
PORT (
clk : IN std_logic;
rst : IN std_logic;

nop : IN std_logic;
pc : IN std_logic_vector(d-1 DOWNTO 0);
instr : IN std_logic_vector(d-1 DOWNTO 0);

zeroFlagWB : IN std_logic;
negFlagWB : IN std_logic;
carryFlagWB : IN std_logic;
controlSignalsWB : IN std_logic_vector(17 DOWNTO 0);
writeRegisterWB : IN std_logic_vector(2 DOWNTO 0);
writeDataWB : IN std_logic_vector(d-1 DOWNTO 0);

nopOut : OUT std_logic;
pcOut : OUT std_logic_vector(d-1 DOWNTO 0);
controlSignalsCU : OUT std_logic_vector(17 DOWNTO 0);
zeroFlagOut : OUT std_logic;
negFlagOut : OUT std_logic;
carryFlagOut : OUT std_logic;

rscrDataOut : OUT std_logic_vector(d-1 DOWNTO 0);
rdstDataOut : OUT std_logic_vector(d-1 DOWNTO 0);
extendImmOut : OUT std_logic_vector(d-1 DOWNTO 0);
shamtOut: OUT std_logic_vector(4 DOWNTO 0);
rscrOut : OUT std_logic_vector(2 DOWNTO 0);
rdstOut : OUT std_logic_vector(2 DOWNTO 0);
spOut : OUT std_logic_vector(d-1 DOWNTO 0) );
END ENTITY decode;


ARCHITECTURE decodeArch OF decode IS

COMPONENT registerOutput IS
generic ( n : integer := 32);
PORT( clk,outPortEnable,nop,rst:             IN std_logic;
      RsrcRegister,RdstRegister,writeRegister:  IN std_logic_vector(2 downto 0);
      data:                                     IN std_logic_vector(n-1 downto 0);
      RsrcData,RdstData:                        OUT std_logic_vector(n-1 downto 0)
      );
END COMPONENT;

COMPONENT SP is
    generic ( n : integer := 32);
    port(
        clk,rst         : IN  STD_LOGIC;
        inSP             : IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
        outSP            : OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
    );
end COMPONENT;

COMPONENT CCR is
    port(
        clk,rst           : IN  STD_LOGIC;
        zero,neg,carry:                        IN std_logic;
        zeroFlagOut,negFlagOut,carryFlagOut:   OUT std_logic
    );
end COMPONENT;

SIGNAL inputSP: std_logic_vector(d-1 DOWNTO 0);
SIGNAL outputSP: std_logic_vector(d-1 DOWNTO 0);

-- SIGNAL rscrDataSignal: std_logic_vector(d-1 DOWNTO 0);

BEGIN

    spModule: SP GENERIC MAP (d) PORT MAP (clk,rst,inputSP,outputSP);  
    regOutModule: registerOutput GENERIC MAP (d) PORT MAP (clk,controlSignalsWB(7),controlSignalsWB(8),rst,instr(23 downto 21),instr(26 downto 24),writeRegisterWB,writeDataWB,rscrDataOut,rdstDataOut);  -- Outport enable, Nop signal  
    ccrModule: CCR PORT MAP (clk,rst,zeroFlagWB,negFlagWB,carryFlagWB,zeroFlagOut,negFlagOut,carryFlagOut);  

    inputSP <= outputSP WHEN controlSignalsWB(5) = '0'  -- Stack control signal
    ELSE writeDataWB;

    pcOut <= pc;
    nopOut <= nop;

    rdstOut <= instr(26 downto 24);
    rscrOut <= instr(23 downto 21);
    shamtOut <= instr(20 downto 16);

    extendImmOut(15 downto 0) <= instr(20 downto 5);
    extendImmOut(31 downto 16) <= (OTHERS=>'0') WHEN instr(20) ='0'
    ELSE (OTHERS=>'1');

    spOut <= (outputSP); 
    
    controlSignalsCU <= "111111111111111111";

END decodeArch;


