LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity execBuffer is
    GENERIC ( d : integer := 32);
    port(
        clk,rst           :             IN  STD_LOGIC;
        controlSignalsExec:             IN std_logic_vector(17 downto 0);
        zeroFlag,carryFlag,negFlag:     IN std_logic;
        aluResult :                     IN std_logic_vector(d-1 DOWNTO 0);
        pc :                            IN std_logic_vector(d-1 DOWNTO 0);
        sp :                            IN std_logic_vector(d-1 DOWNTO 0);
        rdstData :                      IN std_logic_vector(d-1 DOWNTO 0);
        rdst :                          IN std_logic_vector(2 DOWNTO 0);

        controlSignalsExecOut:             OUT std_logic_vector(17 downto 0);
        zeroFlagOut,carryFlagOut,negFlagOut:     OUT std_logic;
        aluResultOut :                     OUT std_logic_vector(d-1 DOWNTO 0);
        pcOut :                            OUT std_logic_vector(d-1 DOWNTO 0);
        spOut :                            OUT std_logic_vector(d-1 DOWNTO 0);
        rdstDataOut :                      OUT std_logic_vector(d-1 DOWNTO 0);
        rdstOut :                          OUT std_logic_vector(2 DOWNTO 0)
    );
end entity;

architecture execBufferArch OF execBuffer IS
begin

    process(clk, rst)
    BEGIN
        IF(rst = '1') THEN
            controlSignalsExecOut<=(OTHERS=>'0');
            zeroFlagOut <='0';
            carryFlagOut<='0';
            negFlagOut<='0';
            aluResultOut <=(OTHERS=>'0');
            pcOut <=(OTHERS=>'0');
            spOut <=(OTHERS=>'0');
            rdstDataOut <=(OTHERS=>'0');
            rdstOut <=(OTHERS=>'0');
        ELSIF rising_edge(clk) THEN
            controlSignalsExecOut<=controlSignalsExec;
            zeroFlagOut <=zeroFlag;
            carryFlagOut<=carryFlag;
            negFlagOut<=negFlag;
            aluResultOut <=aluResult;
            pcOut <=pc;
            spOut <=sp;
            rdstDataOut <=rdstData;
            rdstOut <=rdst;
        END IF;
    END PROCESS;

END ARCHITECTURE;



