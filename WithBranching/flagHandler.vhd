LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity flagHandler IS
PORT( clk,nop,rst:                           IN std_logic;
      zero,neg,carry:                        IN std_logic;
      opCode:                                IN std_logic_vector(3 downto 0);
      zeroFlagOut,negFlagOut,carryFlagOut:   OUT std_logic;
      branchFlags:                           IN std_logic_vector(2 downto 0)
      );

END entity;


ARCHITECTURE flagHandlerArch OF flagHandler IS
TYPE opFlag IS ARRAY(0 TO 15) of std_logic;
signal changeFlag : opFlag;
BEGIN
    changeFlag(0)<='0';
    changeFlag(1)<='1';
    changeFlag(2)<='1';
    changeFlag(3)<='1';
    changeFlag(4)<='0';
    changeFlag(5)<='1';
    changeFlag(6)<='1';
    changeFlag(7)<='1';
    changeFlag(8)<='1';
    changeFlag(9)<='1';
    changeFlag(10)<='1';
    changeFlag(11)<='1';
    changeFlag(12)<='1';
    changeFlag(13)<='0';
    changeFlag(14)<='0';
    changeFlag(15)<='0';

    process(clk)
    begin 
    if (rst='1') then
        -- Resetting Registers
           zeroFlagOut<='0';
           negFlagOut<='0';
           carryFlagOut<='0';
    else
        if(nop = '0') THEN
            -- if (branchFlags = "100" ) then 
            --     zeroFlagOut<= '0';
            -- elsif (branchFlags = "101" ) then 
            --     negFlagOut<= '0';
            -- elsif (branchFlags = "110" ) then 
            --     carryFlagOut<= '0';
            if (opCode="0001" or opCode="0111" or opCode="1000" ) then --and or not   removed: inc dec
                zeroFlagOut<= zero;
                negFlagOut<= neg;
            elsif (opCode = "1011" or opCode ="1100") THEN -- setc clrc
                carryFlagOut<= carry;
            elsif (changeFlag(to_integer(unsigned((opCode))))='1') then
                zeroFlagOut<= zero;
                negFlagOut<= neg;
                carryFlagOut<= carry;
            end if;
        end if;
    end if;     
    end process;
END ARCHITECTURE;

