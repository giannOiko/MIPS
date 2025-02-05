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
			  EX_MEM_out : IN std_logic_vector(31 downto 0);
			  MEM_WRB_out : IN std_logic_vector(31 downto 0);
			  MEM_OUT : IN std_logic_vector(31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           Forward_ALU_A_sel : in  STD_LOGIC_VECTOR (1 downto 0);
			  Forward_ALU_B_sel :in  STD_LOGIC_VECTOR (1 downto 0);
			  Forward_Store_sel : in STD_LOGIC_VECTOR(1 downto 0);
			  ALU_B_sel : in STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
           ALU_zero : out  STD_LOGIC;
			  ALU_cout : out STD_LOGIC;
			  Store_data_in : out std_logic_vector(31 downto 0);
			  ALU_ovfl : out STD_LOGIC);
			  
end EXSTAGE;

architecture Behavioral of EXSTAGE is

signal Mulxxxout : STD_LOGIC_VECTOR (31 downto 0);
signal Multout : STD_LOGIC_VECTOR (31 downto 0);
signal rf_b_immed_sig : STD_LOGIC_VECTOR (31 downto 0);


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
	
COMPONENT Mulxxx
	PORT(
		RF_B_or_Immed : IN std_logic_vector(31 downto 0);
		EX_MEM_out : IN std_logic_vector(31 downto 0);
		MEM_WRB_out : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic_vector(1 downto 0);          
		outt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT mult
	PORT(
		A : IN std_logic_vector(31 downto 0);
		EX_MEM_out : IN std_logic_vector(31 downto 0);
		MEM_WRB_out : IN std_logic_vector(31 downto 0);
		sel : IN std_logic_vector(1 downto 0);          
		outt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT RF_B_MUX
	PORT(
		B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		outt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT LAST_MULX
	PORT(
		RF_B_or_Immed : IN std_logic_vector(31 downto 0);
		EX_MEM_out : IN std_logic_vector(31 downto 0);
		MEM_WRB_out : IN std_logic_vector(31 downto 0);
		MEM_OUT : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic_vector(1 downto 0);          
		outt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

begin

	
Inst_ALU: ALU PORT MAP(
		A => multout,
		B => Mulxxxout,
		op => ALU_func,
		out1 => ALU_out,
		zero => ALU_zero,
		cout => ALU_cout,
		ovfl => ALU_ovfl
	);

Inst_Mulxxx: Mulxxx PORT MAP(
		RF_B_or_Immed => rf_b_immed_sig,
		EX_MEM_out => EX_MEM_out,
		MEM_WRB_out => MEM_WRB_out,
		ALU_Bin_sel => Forward_ALU_B_sel,
		outt => Mulxxxout
	);

Inst_mult: mult PORT MAP(
		A => RF_A,
		EX_MEM_out => EX_MEM_out,
		MEM_WRB_out => MEM_WRB_out,
		sel => Forward_ALU_A_sel,
		outt => multout
	);
	
B_OR_IMMED: RF_B_MUX PORT MAP(
		B => RF_B,
		Immed => Immed,
		sel => ALU_B_sel,
		outt => rf_b_immed_sig
	);


Inst_LAST_MULX: LAST_MULX PORT MAP(
		RF_B_or_Immed => RF_B,
		EX_MEM_out => EX_MEM_out,
		MEM_WRB_out => MEM_WRB_out,
		MEM_OUT => MEM_OUT,
		ALU_Bin_sel => Forward_Store_sel,
		outt => Store_data_in
	);

end Behavioral;

