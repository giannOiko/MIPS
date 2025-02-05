----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:57:55 05/22/2020 
-- Design Name: 
-- Module Name:    IF_ID - Behavioral 
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

entity IF_ID is
Port ( 	  RST : in STD_LOGIC;
			  CLK : in STD_LOGIC;
			  WREN : in STD_LOGIC;
			  PC4 : in  STD_LOGIC_VECTOR (31 downto 0);
           INSTR : in  STD_LOGIC_VECTOR (31 downto 0);
           PC4_OUT : out  STD_LOGIC_VECTOR (31 downto 0);
           INSTR_OUT : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_ID;

architecture Behavioral of IF_ID is

COMPONENT Instruction_reg
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT Registerrr
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	
	

begin

Instruction_regg: Instruction_reg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => INSTR,
		Dataout => INSTR_OUT
	);
	
PC_4_REG: Registerrr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => PC4,
		Dataout => PC4_OUT
	);

end Behavioral;

