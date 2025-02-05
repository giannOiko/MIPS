----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:35:37 04/21/2020 
-- Design Name: 
-- Module Name:    Mulx - Behavioral 
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

entity Mulx is
    Port ( ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_WrData_sel : in  STD_LOGIC;
           outt : out  STD_LOGIC_VECTOR (31 downto 0));
end Mulx;

architecture Behavioral of Mulx is

begin
process (RF_WrData_sel , ALU_out , MEM_out) begin
case (RF_WrData_sel) is

when '0' => outt <= ALU_out;
when '1' => outt <= MEM_out;
when others => outt <= (others =>'0');

end case;
end process;
end Behavioral;

