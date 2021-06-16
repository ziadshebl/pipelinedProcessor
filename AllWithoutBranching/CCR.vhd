LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;

entity CCR is
    port(
        clk,rst           : IN  STD_LOGIC;
        zero,neg,carry:                        IN std_logic;
        zeroFlagOut,negFlagOut,carryFlagOut:   OUT std_logic
    );
end entity;

architecture ccrArch OF CCR IS
begin
    process(clk, rst)
    BEGIN
       IF(rst = '1') THEN
        zeroFlagOut <='0';
        negFlagOut <='0';
        carryFlagOut <='0';
    ELSIF rising_edge(clk) THEN
        zeroFlagOut <=zero;
        negFlagOut <=neg;
        carryFlagOut <=carry;
    END IF;

    END PROCESS;
END ARCHITECTURE;
