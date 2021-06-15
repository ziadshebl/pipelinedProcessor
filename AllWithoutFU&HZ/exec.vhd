LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity exec IS
generic ( n : integer := 32);
PORT( clk,rst:                                                                     IN std_logic;
      Rdst:                                                                    IN std_logic_vector(2 downto 0);
      shamtBuffer:                                                             IN std_logic_vector(4 downto 0);
      controlSignalsBuffer:                                                    IN std_logic_vector(17 downto 0);
      PCBuffer,SPBuffer,RDstDataBuffer,RSrcDataBuffer,ExtendedImmBuffer,inport:IN std_logic_vector(n-1 downto 0);
      ALUResultFU,MemoryResultFU:                                                  IN std_logic_vector(n-1 downto 0);
      FUop1,FUop2:                                                             IN std_logic_vector(1 downto 0);
      
      controlSignalsOut:                                                      OUT std_logic_vector(17 downto 0);
      ALUResultOut,PCOut,SPOut,RdstDataOut:                                  OUT std_logic_vector(n-1 downto 0); 
      RdstOut:                                                                OUT std_logic_vector(2 downto 0);   
      zeroFlag,carryFlag,negFlag:                                             OUT std_logic
      );

END entity;

ARCHITECTURE ExecStageArch OF exec IS
	
    signal operand1Alu : std_logic_vector(n-1 downto 0);
    signal operand2Alu : std_logic_vector(n-1 downto 0);
    signal shamtSignalConcat : std_logic_vector(n-1 downto 0);
    
    signal coutFlagAlu : std_logic;
    signal zeroFlagAlu : std_logic;
    signal negFlagAlu : std_logic;
    
BEGIN
        FH : entity work.flagHandler PORT MAP (clk,controlSignalsBuffer(8),rst,zeroFlagAlu,negFlagAlu,coutFlagAlu,controlSignalsBuffer(3 downto 0),zeroFlag,negFlag,carryFlag);
        alu : entity work.Alu PORT MAP (operand1Alu,operand2Alu,controlSignalsBuffer(3 downto 0),ALUResultOut,coutFlagAlu,zeroFlagAlu,negFlagAlu);
    
        operand1Alu <= inport WHEN controlSignalsBuffer(17) = '1'
        ELSE RSrcDataBuffer WHEN controlSignalsBuffer(17) = '0' AND FUop1="00"
        ELSE MemoryResultFU WHEN controlSignalsBuffer(17) = '0' AND FUop1="01"
        ELSE ALUResultFU WHEN controlSignalsBuffer(17) = '0' AND FUop1="10";

        shamtSignalConcat(4 downto 0) <= shamtBuffer;
        shamtSignalConcat(31 downto 5) <= (OTHERS=>'0');
        
        operand2Alu <= SPBuffer WHEN controlSignalsBuffer(16 downto 15) = "10" AND FUop2="00"
        ELSE shamtSignalConcat WHEN controlSignalsBuffer(16 downto 15) = "11" AND FUop2="00"
        ELSE ExtendedImmBuffer WHEN controlSignalsBuffer(16 downto 15) = "01" AND FUop2="00"
        ELSE RDstDataBuffer WHEN controlSignalsBuffer(16 downto 15) = "00" AND FUop2="00"
        ELSE MemoryResultFU WHEN  FUop2="01"
        ELSE ALUResultFU WHEN FUop2="10";

        controlSignalsOut <= controlSignalsBuffer;
        RdstOut <= Rdst;
        RdstDataOut <= RDstDataBuffer;
        SPOut <= SPBuffer;

        PCOut <= std_logic_vector(unsigned(PCBuffer) + ('0'&'1'));

        
END ARCHITECTURE;