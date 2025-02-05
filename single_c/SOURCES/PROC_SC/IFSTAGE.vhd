----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:30:39 04/21/2020 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
 Port (  PC_Immed : in STD_LOGIC_VECTOR(31 downto 0);
			PC_sel : in  STD_LOGIC;
			PC_LdEn : in  STD_LOGIC;
			Reset : in  STD_LOGIC;
			CLK : in  STD_LOGIC;
			inst_dout : out std_logic_vector(31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

signal inst_in : std_logic_vector(10 downto 0);
signal PC_signal : std_logic_vector(31 downto 0);

COMPONENT RAM
	PORT(
		clk : IN std_logic;
		inst_addr : IN std_logic_vector(10 downto 0);
		data_we : IN std_logic;
		data_addr : IN std_logic_vector(10 downto 0);
		data_din : IN std_logic_vector(31 downto 0);          
		inst_dout : OUT std_logic_vector(31 downto 0);
		data_dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT IF_segment
	PORT(
		PC_Imm : IN std_logic_vector(31 downto 0);
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		Reset : IN std_logic;
		CLK : IN std_logic;          
		PC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
begin 

Inst_IF_segment: IF_segment PORT MAP(
		PC_Imm => PC_Immed,
		PC_sel => PC_sel,
		PC_LdEn => PC_LdEn,
		Reset => Reset,
		CLK => CLK,
		PC => PC_signal
	);
	
	Inst_RAM: RAM PORT MAP(
		clk => CLK,
		inst_addr => inst_in,
		inst_dout => inst_dout,
		data_we => '0',
		data_addr => (OTHERS => '0'),
		data_din => (OTHERS => '0'),
		data_dout => open
	);
	
process (PC_signal) begin
inst_in <= PC_signal(12 downto 2);
end process;
	
end Behavioral;

