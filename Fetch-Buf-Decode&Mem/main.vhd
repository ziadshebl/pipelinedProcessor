LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY main IS
GENERIC (d : integer := 32);
PORT (
    -- Fetch Inputs
    clk : IN std_logic;
    rst : IN std_logic;
    
    addHold : IN std_logic;
    ret : IN std_logic;
    branch : IN std_logic;
    
    rdstBDecode : IN std_logic_vector(d-1 DOWNTO 0);
    rdstWB : IN std_logic_vector(d-1 DOWNTO 0);
    -- Fetch Buffer Inputs
    branchNop,loadUseStall  : IN  STD_LOGIC;
    -- Decode Inputs
    zeroFlagWB : IN std_logic;
    negFlagWB : IN std_logic;
    carryFlagWB : IN std_logic;
    controlSignalsWB : IN std_logic_vector(17 DOWNTO 0);
    writeRegisterWB : IN std_logic_vector(2 DOWNTO 0);
    writeDataWB : IN std_logic_vector(d-1 DOWNTO 0);
    -- Decode Outputs
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
    spOut : OUT std_logic_vector(d-1 DOWNTO 0)
  
);
END ENTITY main;


ARCHITECTURE mainArch OF main IS

COMPONENT fetch IS
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
END COMPONENT fetch;

COMPONENT fetchBuffer is
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
end COMPONENT;

COMPONENT decode IS
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
END COMPONENT decode;


SIGNAL pcValueSignalFromFetch: std_logic_vector(d-1 DOWNTO 0);
SIGNAL instrValueSignalFromFetch: std_logic_vector(d-1 DOWNTO 0);

SIGNAL nopOutFromFetchBuffer:  STD_LOGIC;
SIGNAL pcOutFromFetchBuffer : std_logic_vector(d-1 DOWNTO 0);
SIGNAL instrOutFromFetchBuffer : std_logic_vector(d-1 DOWNTO 0);


BEGIN

    fetchModule: fetch GENERIC MAP (d) PORT MAP (clk,rst,addHold,ret,branch,rdstBDecode,rdstWB,pcValueSignalFromFetch,instrValueSignalFromFetch);    
    
    fetchBufferModule: fetchBuffer GENERIC MAP (d) PORT MAP (clk,rst,branchNop,loadUseStall,pcValueSignalFromFetch,instrValueSignalFromFetch,nopOutFromFetchBuffer,pcOutFromFetchBuffer,instrOutFromFetchBuffer);    

    decodeModule: decode GENERIC MAP (d) PORT MAP (clk,rst,nopOutFromFetchBuffer,pcOutFromFetchBuffer,instrOutFromFetchBuffer,zeroFlagWB ,negFlagWB ,carryFlagWB,controlSignalsWB,writeRegisterWB,writeDataWB,nopOut,pcOut,controlSignalsCU,zeroFlagOut,negFlagOut,carryFlagOut,rscrDataOut,rdstDataOut,extendImmOut,shamtOut,rscrOut,rdstOut,spOut);    

END mainArch;


