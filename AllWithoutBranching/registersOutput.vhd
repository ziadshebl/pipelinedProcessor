LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity registerOutput IS
generic ( n : integer := 32);
PORT( clk,outPortEnable,nop,rst:             IN std_logic;
      RsrcRegister,RdstRegister,writeRegister:  IN std_logic_vector(2 downto 0);
      data:                                     IN std_logic_vector(n-1 downto 0);
      RsrcData,RdstData:                        OUT std_logic_vector(n-1 downto 0);
      outPortRegister:                        OUT std_logic_vector(n-1 downto 0);
      regWriteEnable:                        IN std_logic
      );

END entity;


ARCHITECTURE registerOutputArch OF registerOutput IS
	TYPE RegisterArray IS ARRAY(0 TO 7) of std_logic_vector(n-1 DOWNTO 0);
	signal Registers : RegisterArray;
    -- signal outPortRegister : std_logic_vector(n-1 downto 0);
BEGIN
    RdstData <= Registers(to_integer(unsigned((RdstRegister))));
    RsrcData <= Registers(to_integer(unsigned((RsrcRegister))));

    process(clk)
    begin
        if (rst='1') then
        -- Resetting Registers
            Registers(0)<= (OTHERS=>'0');
            Registers(1)<= (OTHERS=>'0');
            Registers(2)<= (OTHERS=>'0');
            Registers(3)<= (OTHERS=>'0');
            Registers(4)<= (OTHERS=>'0');
            Registers(5)<= (OTHERS=>'0');
            Registers(6)<= (OTHERS=>'0');
            Registers(7)<= (OTHERS=>'0');
            outPortRegister <= (OTHERS=>'0');
        else
        IF(nop = '0' and regWriteEnable = '1') THEN
          if  falling_edge(clk) then 
                IF(outPortEnable = '1') THEN
                  outPortRegister<=data;
                else
                  Registers(to_integer(unsigned((writeRegister)))) <= data;       
                END IF;
          end if;
        END IF;
      end if;
    end process;
END ARCHITECTURE;

