----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:13:38 05/14/2020 
-- Design Name: 
-- Module Name:    mult - Behavioral 
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

entity mult is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           EX_MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_WRB_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  sel : in STD_LOGIC_VECTOR(1 downto 0);
           outt : out  STD_LOGIC_VECTOR (31 downto 0));
end mult;

architecture Behavioral of mult is

begin
process (sel , A , EX_MEM_out, MEM_WRB_out) begin
case (sel) is

when "00" => outt <= A;
when "01" => outt <= MEM_WRB_out;
when "10" => outt <= EX_MEM_out;
when others => outt <= (others =>'0');

end case;
end process;
end Behavioral;

