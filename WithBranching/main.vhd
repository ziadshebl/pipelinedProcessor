LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.all;

ENTITY main IS
GENERIC (d : integer := 32);
PORT (
    -- Fetch Inputs
    clk : IN std_logic;
    rst : IN std_logic;
    
    -- addHold : IN std_logic;  -- from Hazard
    -- ret : IN std_logic;
    -- branch : IN std_logic;  -- from Branch detection 
    
    -- rdstBDecode : IN std_logic_vector(d-1 DOWNTO 0);
    -- rdstWB : IN std_logic_vector(d-1 DOWNTO 0);

    -- Fetch Buffer Inputs
    -- branchNop,loadUseStall  : IN  STD_LOGIC;  -- from Hazard
    -- nopHazardDetectionToDecode : IN std_logic;  -- from Hazard

    -- Decode Inputs
    -- zeroFlagWB : IN std_logic;
    -- negFlagWB : IN std_logic;
    -- carryFlagWB : IN std_logic;
    -- controlSignalsWB : IN std_logic_vector(17 DOWNTO 0);
    -- writeRegisterWB : IN std_logic_vector(2 DOWNTO 0);
    -- writeDataWB : IN std_logic_vector(d-1 DOWNTO 0);

    -- Main Inputs
    inport:  IN std_logic_vector(d-1 downto 0);
    outPortRegister: OUT std_logic_vector(d-1 downto 0)

    -- outputs of FU 
    -- ALUResultFU,MemoryResultFU:   IN std_logic_vector(d-1 downto 0);
    -- FUop1,FUop2:  IN std_logic_vector(1 downto 0);
      
    -- inputs to FU 
    -- RsrcOutFromDecBuffer: OUT std_logic_vector(2 downto 0)


    -- Decode Outputs
    -- nopOut : OUT std_logic;
    -- pcOut : OUT std_logic_vector(d-1 DOWNTO 0);
    -- controlSignalsCU : OUT std_logic_vector(17 DOWNTO 0);
    -- zeroFlagOut : OUT std_logic;
    -- negFlagOut : OUT std_logic;
    -- carryFlagOut : OUT std_logic;

    -- rscrDataOut : OUT std_logic_vector(d-1 DOWNTO 0);
    -- rdstDataOut : OUT std_logic_vector(d-1 DOWNTO 0);
    -- extendImmOut : OUT std_logic_vector(d-1 DOWNTO 0);
    -- shamtOut: OUT std_logic_vector(4 DOWNTO 0);
    -- rscrOut : OUT std_logic_vector(2 DOWNTO 0);
    -- rdstOut : OUT std_logic_vector(2 DOWNTO 0);
    -- spOut : OUT std_logic_vector(d-1 DOWNTO 0)

);
END ENTITY main;


ARCHITECTURE mainArch OF main IS

-- From Fetch Signals
SIGNAL pcValueSignalFromFetch: std_logic_vector(d-1 DOWNTO 0);
SIGNAL instrValueSignalFromFetch: std_logic_vector(d-1 DOWNTO 0);

-- From Fetch Buffer Signals
SIGNAL nopOutFromFetchBuffer:  STD_LOGIC;
SIGNAL pcOutFromFetchBuffer : std_logic_vector(d-1 DOWNTO 0);
SIGNAL instrOutFromFetchBuffer : std_logic_vector(d-1 DOWNTO 0);
SIGNAL inportOutFromFetchBuffer : std_logic_vector(d-1 DOWNTO 0);

-- From Decode Signals
SIGNAL nopOutFromDecode :  std_logic;
SIGNAL pcOutFromDecode :  std_logic_vector(d-1 DOWNTO 0);
SIGNAL controlSignalsCUFromDecode :  std_logic_vector(17 DOWNTO 0);
SIGNAL zeroFlagOutFromDecode :  std_logic;
SIGNAL negFlagOutFromDecode :  std_logic;
SIGNAL carryFlagOutFromDecode :  std_logic;
SIGNAL rscrDataOutFromDecode :  std_logic_vector(d-1 DOWNTO 0);
SIGNAL rdstDataOutFromDecode :  std_logic_vector(d-1 DOWNTO 0);
SIGNAL extendImmOutFromDecode :  std_logic_vector(d-1 DOWNTO 0);
SIGNAL shamtOutFromDecode: std_logic_vector(4 DOWNTO 0);
SIGNAL rscrOutFromDecode :  std_logic_vector(2 DOWNTO 0);
SIGNAL rdstOutFromDecode :  std_logic_vector(2 DOWNTO 0);
SIGNAL spOutFromDecode :  std_logic_vector(d-1 DOWNTO 0);

-- From Decode Buffer Signals
SIGNAL RdstFromDecBuffer:   std_logic_vector(2 downto 0);
SIGNAL shamtFromDecBuffer:   std_logic_vector(4 downto 0);
SIGNAL controlSignalsFromDecBuffer:  std_logic_vector(17 downto 0);
SIGNAL PCFromDecBuffer,SPFromDecBuffer,RDstDataFromDecBuffer,RSrcDataFromDecBuffer,ExtendedImmFromDecBuffer: std_logic_vector(d-1 downto 0);
SIGNAL inportOutFromDecBuffer : std_logic_vector(d-1 DOWNTO 0);
SIGNAL RsrcOutFromDecBuffer: std_logic_vector(2 downto 0);

-- From Execution Signals
SIGNAL controlSignalsFromExec:     std_logic_vector(17 downto 0);
SIGNAL ALUResultFromExec,PCFromExec,SPFromExec,RdstDataFromExec:  std_logic_vector(d-1 downto 0); 
SIGNAL RdstFromExec:       std_logic_vector(2 downto 0);   
SIGNAL zeroFlagFromExec,carryFlagFromExec,negFlagFromExec:  std_logic;

-- From Execution Buffer Signals
SIGNAL controlSignalsFromExecBuffer:       std_logic_vector(17 downto 0);
SIGNAL zeroFlagFromExecBuffer,carryFlagFromExecBuffer,negFlagFromExecBuffer: std_logic;
SIGNAL aluResultFromExecBuffer  : std_logic_vector(d-1 DOWNTO 0);
SIGNAL pcFromExecBuffer         : std_logic_vector(d-1 DOWNTO 0);
SIGNAL spFromExecBuffer         : std_logic_vector(d-1 DOWNTO 0);
SIGNAL rdstDataFromExecBuffer   : std_logic_vector(d-1 DOWNTO 0);
SIGNAL rdstFromExecBuffer       : std_logic_vector(2 DOWNTO 0);

-- From Memory Signals
SIGNAL zeroFlagFromMem:  std_logic;
SIGNAL negFlagFromMem:  std_logic;
SIGNAL carryFlagFromMem:  std_logic;
SIGNAL rdstFromMem:  std_logic_vector(2 DOWNTO 0);
SIGNAL aluResultFromMem:  std_logic_vector(d-1 DOWNTO 0);
SIGNAL controlSignalsFromMem:  std_logic_vector(17 DOWNTO 0);
SIGNAL memoryDataFromMem:  std_logic_vector(d-1 DOWNTO 0);

-- From Memory Buffer Signals (WB)
SIGNAL zeroFlagWB :  std_logic;
SIGNAL negFlagWB :  std_logic;
SIGNAL carryFlagWB :  std_logic;
SIGNAL controlSignalsWB:  std_logic_vector(17 downto 0);
SIGNAL memDataWB :   std_logic_vector(d-1 DOWNTO 0);
SIGNAL aluResultWB :   std_logic_vector(d-1 DOWNTO 0);
SIGNAL rdstWB :   std_logic_vector(2 DOWNTO 0);

SIGNAL writeBackAfterMux: std_logic_vector(d-1 DOWNTO 0);

-- From FU
SIGNAL FUop1,FUop2: std_logic_vector(1 downto 0);
SIGNAL FUstackSelector	: std_logic_vector(1 downto 0);
 
-- From Hazard Detection
SIGNAL addHold : std_logic;
SIGNAL branchNop,loadUseStall  :  STD_LOGIC;  
SIGNAL nopHazardDetectionToDecode : std_logic;

--From branch detection Unit
SIGNAL branch :  std_logic;  
    
        
BEGIN   

    fetchModule: entity work.fetch GENERIC MAP (d) PORT MAP (clk,rst,addHold,controlSignalsWB(4),branch,RdstDataFromExec,writeBackAfterMux,pcValueSignalFromFetch,instrValueSignalFromFetch);    
    
    fetchBufferModule: entity work.fetchBuffer GENERIC MAP (d) PORT MAP (clk,rst,branchNop,loadUseStall,pcValueSignalFromFetch,instrValueSignalFromFetch,nopOutFromFetchBuffer,pcOutFromFetchBuffer,instrOutFromFetchBuffer,inport,inportOutFromFetchBuffer);    

    decodeModule: entity work.decode GENERIC MAP (d) PORT MAP (clk,rst,nopOutFromFetchBuffer,pcOutFromFetchBuffer,instrOutFromFetchBuffer,zeroFlagWB ,negFlagWB ,carryFlagWB,
    controlSignalsWB,rdstWB,writeBackAfterMux,nopOutFromDecode,pcOutFromDecode,controlSignalsCUFromDecode,zeroFlagOutFromDecode,negFlagOutFromDecode,carryFlagOutFromDecode,
    rscrDataOutFromDecode,rdstDataOutFromDecode,extendImmOutFromDecode,shamtOutFromDecode,rscrOutFromDecode,rdstOutFromDecode,spOutFromDecode,outPortRegister,aluResultWB);    

    decodeBufferModule: entity work.decodeBuffer GENERIC MAP (d) PORT MAP (clk,rst,nopHazardDetectionToDecode,nopOutFromFetchBuffer,pcOutFromFetchBuffer,spOutFromDecode,    
    controlSignalsCUFromDecode,rscrDataOutFromDecode,rdstDataOutFromDecode,extendImmOutFromDecode,shamtOutFromDecode,rscrOutFromDecode,rdstOutFromDecode,    
    PCFromDecBuffer,SPFromDecBuffer,controlSignalsFromDecBuffer,RSrcDataFromDecBuffer,RDstDataFromDecBuffer,ExtendedImmFromDecBuffer,shamtFromDecBuffer,
    RsrcOutFromDecBuffer,RdstFromDecBuffer,inportOutFromFetchBuffer,inportOutFromDecBuffer);

    execModule: entity work.exec GENERIC MAP (d) PORT MAP (clk,rst,RdstFromDecBuffer,shamtFromDecBuffer,controlSignalsFromDecBuffer,PCFromDecBuffer,SPFromDecBuffer,RDstDataFromDecBuffer,RSrcDataFromDecBuffer,ExtendedImmFromDecBuffer,inportOutFromDecBuffer,
    aluResultFromExecBuffer,writeBackAfterMux,FUop1,FUop2,controlSignalsFromExec,ALUResultFromExec,PCFromExec,SPFromExec,RdstDataFromExec,RdstFromExec,zeroFlagFromExec,carryFlagFromExec,negFlagFromExec,FUstackSelector,aluResultFromExecBuffer,aluResultWB);    

    execBufferModule: entity work.execBuffer GENERIC MAP (d) PORT MAP (clk,rst,controlSignalsFromExec,zeroFlagFromExec,carryFlagFromExec,negFlagFromExec,ALUResultFromExec,PCFromExec,SPFromExec,RdstDataFromExec,RdstFromExec,   
    controlSignalsFromExecBuffer,zeroFlagFromExecBuffer,carryFlagFromExecBuffer,negFlagFromExecBuffer,aluResultFromExecBuffer,pcFromExecBuffer,spFromExecBuffer,rdstDataFromExecBuffer,rdstFromExecBuffer);
  
    memoryModule: entity work.memory GENERIC MAP (d) PORT MAP (clk,rst,zeroFlagFromExecBuffer,negFlagFromExecBuffer,carryFlagFromExecBuffer,rdstFromExecBuffer,    
    rdstDataFromExecBuffer,spFromExecBuffer,pcFromExecBuffer,aluResultFromExecBuffer,controlSignalsFromExecBuffer,zeroFlagFromMem,negFlagFromMem,carryFlagFromMem, 
    rdstFromMem,aluResultFromMem,controlSignalsFromMem,memoryDataFromMem);

    memBufferModule: entity work.memBuffer GENERIC MAP (d) PORT MAP (clk,rst,controlSignalsFromMem,zeroFlagFromMem,carryFlagFromMem,negFlagFromMem,    
    memoryDataFromMem,aluResultFromMem,rdstFromMem,controlSignalsWB,zeroFlagWB,carryFlagWB,negFlagWB,memDataWB,aluResultWB,rdstWB);   
    
    writeBackAfterMux <= aluResultWB WHEN controlSignalsWB(9) = '0'
    ELSE memDataWB;

    fuModule: entity work.ForwardingUnit PORT MAP (RsrcOutFromDecBuffer,RdstFromDecBuffer,rdstFromExecBuffer,rdstWB,controlSignalsFromExecBuffer(10),controlSignalsFromExecBuffer(9),controlSignalsFromExecBuffer(5),controlSignalsWB(10),controlSignalsWB(9),controlSignalsWB(5),FUop1,FUop2,controlSignalsFromDecBuffer(5),FUstackSelector,controlSignalsFromExecBuffer(14),controlSignalsFromExecBuffer(6),controlSignalsFromExecBuffer(4));    
 
    hazardModule: entity work.hazardDetectionUnit PORT MAP (clk,controlSignalsFromDecBuffer(9),branch,RdstFromDecBuffer,instrOutFromFetchBuffer(26 downto 24),instrOutFromFetchBuffer(23 downto 21),addHold,loadUseStall,nopHazardDetectionToDecode,branchNop);    
 
    branchModule: entity work.BranchDetectionUnit PORT MAP (controlSignalsFromDecBuffer(14 downto 12),zeroFlagFromExec,carryFlagFromExec,negFlagFromExec,branch);    

END mainArch;


