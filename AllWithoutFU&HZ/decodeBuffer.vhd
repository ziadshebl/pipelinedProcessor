LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity decodeBuffer is
    GENERIC ( d : integer := 32);
    port(
        clk,rst                      : IN  STD_LOGIC;

        -- enable to my buffer
         nopHazardDetection         : IN STD_LOGIC;  

        -- INPUT s
        nopFetch: IN  STD_LOGIC;
        PC : IN std_logic_vector(d-1 DOWNTO 0);
        SP : IN std_logic_vector(d-1 DOWNTO 0);
        ControlSignals : IN std_logic_vector(17 DOWNTO 0);
        RsrcData,RdstData,ExtendedImmValue : IN std_logic_vector(d-1 DOWNTO 0);
        shamt : IN std_logic_vector(4 DOWNTO 0);
        Rsrc,Rdst: IN std_logic_vector(2 DOWNTO 0);
        
        -- OUTPUT
        PCOut : OUT std_logic_vector(d-1 DOWNTO 0);
        SPOut : OUT std_logic_vector(d-1 DOWNTO 0);
        ControlSignalsOut : OUT std_logic_vector(17 DOWNTO 0);
        RsrcDataOut,RdstDataOut,ExtendedImmValueOut : OUT std_logic_vector(d-1 DOWNTO 0);
        shamtOut : OUT std_logic_vector(4 DOWNTO 0);
        RsrcOut,RdstOut: OUT std_logic_vector(2 DOWNTO 0)
    );
end entity;

architecture decodeBufferArch OF decodeBuffer IS
begin

    process(clk, rst)
    BEGIN
       IF(rst = '1') THEN
            PCOut<=(OTHERS=>'0'); 
            SPOut<=(OTHERS=>'0'); 
            ControlSignalsOut<=(OTHERS=>'0'); 
            RsrcDataOut<=(OTHERS=>'0');
            RdstDataOut<=(OTHERS=>'0');
            ExtendedImmValueOut<=(OTHERS=>'0');
            shamtOut<=(OTHERS=>'0'); 
            RsrcOut<=(OTHERS=>'0');
            RdstOut<=(OTHERS=>'0');     
       ELSIF rising_edge(clk) THEN
            ControlSignalsOut <= ControlSignals;
            ControlSignalsOut(8) <= (ControlSignals(8) or nopFetch or nopHazardDetection);
            IF(nopHazardDetection = '0') THEN
                    PCOut<=PC; 
                    SPOut<=SP; 
                    RsrcDataOut<=RsrcData;
                    RdstDataOut<=RdstData;
                    ExtendedImmValueOut<=ExtendedImmValue;
                    shamtOut<=shamt; 
                    RsrcOut<=Rsrc;
                    RdstOut<=Rdst;     
            END IF;
    END IF;
    END PROCESS;
END ARCHITECTURE;
