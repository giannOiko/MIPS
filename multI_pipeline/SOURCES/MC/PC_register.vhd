----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:01:40 04/17/2020 
-- Design Name: 
-- Module Name:    PC - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_register is
    Port ( newPCin : in  STD_LOGIC_VECTOR (31 downto 0);
           ld_en : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           newPCout : out  STD_LOGIC_VECTOR (31 downto 0));
end PC_register;

architecture Behavioral of PC_register is

signal temp: STD_LOGIC_VECTOR (31 downto 0);

begin process(CLK)
begin 
if rising_edge(CLK) then 
	if(reset = '1') then
	temp <="00000000000000000000000000000000";
elsif (ld_en = '1') then
	temp <= newPCin;
else
	null;
end if;
end if;
end process;

 newPCout <= temp after 10 ns;
 
end Behavioral;

