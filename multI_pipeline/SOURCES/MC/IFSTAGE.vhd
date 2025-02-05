----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:05:23 05/14/2020 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_4 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is

signal pcin : std_logic_vector (31 downto 0);


COMPONENT IF_Mux
	PORT(
		PC_4 : IN std_logic_vector(31 downto 0);
		PC_Immed : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		Mux_outt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT PC_register
	PORT(
		newPCin : IN std_logic_vector(31 downto 0);
		ld_en : IN std_logic;
		reset : IN std_logic;
		CLK : IN std_logic;          
		newPCout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

begin

Inst_IF_Mux: IF_Mux PORT MAP(
		PC_4 => PC_4,
		PC_Immed => PC_Immed,
		sel => PC_sel,
		Mux_outt => pcin
	);

Inst_PC_register: PC_register PORT MAP(
		newPCin => pcin,
		ld_en => PC_LdEn,
		reset => RST,
		CLK => CLK,
		newPCout => PC
	);
	
end Behavioral;

