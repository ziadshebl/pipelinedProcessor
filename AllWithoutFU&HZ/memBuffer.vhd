LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity memBuffer is
    GENERIC ( d : integer := 32);
    port(
        clk,rst           :             IN  STD_LOGIC;
        controlSignalsMem:              IN std_logic_vector(17 downto 0);
        zeroFlag,carryFlag,negFlag:     IN std_logic;
        memData :                       IN std_logic_vector(d-1 DOWNTO 0);
        aluResult :                     IN std_logic_vector(d-1 DOWNTO 0);
        rdst :                          IN std_logic_vector(2 DOWNTO 0);

        controlSignalsMemOut:             OUT std_logic_vector(17 downto 0);
        zeroFlagOut,carryFlagOut,negFlagOut:     OUT std_logic;
        memDataOut :                     OUT std_logic_vector(d-1 DOWNTO 0);
        aluResultOut :                      OUT std_logic_vector(d-1 DOWNTO 0);
        rdstOut :                          OUT std_logic_vector(2 DOWNTO 0)
    );
end entity;

architecture memBufferArch OF memBuffer IS
begin

    process(clk, rst)
    BEGIN
        IF(rst = '1') THEN
            controlSignalsMemOut<=(OTHERS=>'0');
            zeroFlagOut <='0';
            carryFlagOut<='0';
            negFlagOut<='0';
            aluResultOut <=(OTHERS=>'0');
            memDataOut <=(OTHERS=>'0');
            rdstOut <=(OTHERS=>'0');
        ELSIF rising_edge(clk) THEN
            controlSignalsMemOut<=controlSignalsMem;
            zeroFlagOut <=zeroFlag;
            carryFlagOut<=carryFlag;
            negFlagOut<=negFlag;
            aluResultOut <=aluResult;
            memDataOut <=memData;
            rdstOut <=rdst;
        END IF;
    END PROCESS;

END ARCHITECTURE;




