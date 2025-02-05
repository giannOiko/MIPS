----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:02:26 04/22/2020 
-- Design Name: 
-- Module Name:    EXSTAGE - Behavioral 
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

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC;
			  ALU_cout : out STD_LOGIC;
			  ALU_ovfl : out STD_LOGIC);
			  
end EXSTAGE;

architecture Behavioral of EXSTAGE is

signal Mulxxxout : STD_LOGIC_VECTOR (31 downto 0);

COMPONENT Mulxxx
	PORT(
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;          
		outt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT ALU
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		op : IN std_logic_vector(3 downto 0);          
		out1 : OUT std_logic_vector(31 downto 0);
		zero : OUT std_logic;
		cout : OUT std_logic;
		ovfl : OUT std_logic
		);
	END COMPONENT;

begin

Inst_Mulxxx: Mulxxx PORT MAP(
		RF_B => RF_B,
		Immed => Immed,
		ALU_Bin_sel => ALU_Bin_sel,
		outt => Mulxxxout
	);
	
Inst_ALU: ALU PORT MAP(
		A => RF_A,
		B => Mulxxxout,
		op => ALU_func,
		out1 => ALU_out,
		zero => ALU_zero,
		cout => ALU_cout,
		ovfl => ALU_ovfl
	);

end Behavioral;

