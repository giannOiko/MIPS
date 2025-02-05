----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:37:30 05/24/2020 
-- Design Name: 
-- Module Name:    LAST_MULX - Behavioral 
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

entity LAST_MULX is
    Port ( RF_B_or_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
			  EX_MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_WRB_out : in  STD_LOGIC_VECTOR (31 downto 0);
			  MEM_OUT : in STD_LOGIC_VECTOR(31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC_VECTOR(1 downto 0);
           outt : out  STD_LOGIC_VECTOR (31 downto 0));
end LAST_MULX;

architecture Behavioral of LAST_MULX is

signal four : std_logic_vector(31 downto 0) := "00000000000000000000000000000100";

begin
process (ALU_Bin_sel , RF_B_or_Immed, MEM_WRB_out , EX_MEM_out) begin
case (ALU_Bin_sel) is

when "00" => outt <= RF_B_or_Immed;
when "01" => outt <= MEM_WRB_out;
when "10" => outt <= EX_MEM_out;
when "11" => outt <= MEM_OUT;
when others => outt <= (others =>'0');

end case;
end process;
end Behavioral;

