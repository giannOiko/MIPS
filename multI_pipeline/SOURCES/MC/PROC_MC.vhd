----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:16:48 05/19/2020 
-- Design Name: 
-- Module Name:    PROC_MC - Behavioral 
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

entity PROC_MC is
	PORT (   CLOCK : IN STD_LOGIC;
				RESET : IN STD_LOGIC);		
end PROC_MC;

architecture Behavioral of PROC_MC is

signal signal_RF_WrEn : std_logic;
signal signal_PC_LdEn : std_logic;
signal signal_RF_WrDatasel : std_logic;
signal signal_RF_B_sel : std_logic;
signal signal_PCsel : std_logic;
signal signal_ALUSourceA : std_logic;
signal signal_ALUSourceB : std_logic_vector(1 downto 0);
signal signal_ALU_func : std_logic_vector(3 downto 0);
signal signal_MEM_WrEn : std_logic;
signal signal_Byte_Op : std_logic;          
signal signal_Instruction : std_logic_vector(31 downto 0);
signal signal_bflag : std_logic;
signal awr : std_logic;
signal bwr : std_logic;
signal instr_wr : std_logic;
signal mem_wr : std_logic;
signal alu_wr : std_logic;




COMPONENT CONTROL_MC
	PORT(
		Clock : IN std_logic;
		Instruction : IN std_logic_vector(31 downto 0);
		Reset : IN std_logic;
		brflag : IN std_logic;          
		PC_sel : OUT std_logic;
		PC_LdEn : OUT std_logic;
		RF_WrEn : OUT std_logic;
		RF_WrDatasel : OUT std_logic;
		RF_B_sel : OUT std_logic;
		ALUSrcA : OUT std_logic;
		ALUSrcB : OUT std_logic_vector(1 downto 0);
		ALU_func : OUT std_logic_vector(3 downto 0);
		Mem_WrEn : OUT std_logic;
		Byte_Op : OUT std_logic;
		IRWrite : OUT std_logic;
		AWrite : OUT std_logic;
		BWrite : OUT std_logic;
		RMEMWrite : OUT std_logic;
		ALUWrite : OUT std_logic
		);
	END COMPONENT;

	

COMPONENT Datapath_MC
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		RF_WrEn : IN std_logic;
		RF_WrDatasel : IN std_logic;
		RF_B_sel : IN std_logic;
		PCLdEn : IN std_logic;
		PCSource : IN std_logic;
		ALUSrcA : IN std_logic;
		ALUSrcB : IN std_logic_vector(1 downto 0);
		MemWrite : IN std_logic;
		ByteOp : IN std_logic;
		IRWrite : IN std_logic;
		AWrite : IN std_logic;
		BWrite : IN std_logic;
		RMEMWrite : IN std_logic;
		ALUWrite : IN std_logic;
		func : IN std_logic_vector(3 downto 0);          
		Instruction : OUT std_logic_vector(31 downto 0);
		equal : OUT std_logic
		);
	END COMPONENT;

	

begin

Inst_CONTROL: CONTROL_MC PORT MAP(
		Clock => CLOCK,
		Instruction => signal_Instruction,
		Reset => RESET,
		brflag => signal_bflag,
		PC_sel => signal_PCsel,
		PC_LdEn => signal_PC_LdEn,
		RF_WrEn => signal_RF_WrEn,
		RF_WrDatasel => signal_RF_WrDatasel,
		RF_B_sel => signal_RF_B_sel,
		ALUSrcA => signal_ALUSourceA,
		ALUSrcB => signal_ALUSourceB,
		ALU_func => signal_ALU_func,
		Mem_WrEn => signal_MEM_WrEn,
		Byte_Op => signal_Byte_Op,
		IRWrite => instr_wr,
		AWrite => awr,
		BWrite => bwr,
		RMEMWrite => mem_wr,
		ALUWrite => alu_wr
	);

Inst_Datapath: Datapath_MC PORT MAP(
		CLK => CLOCK,
		RST => RESET,
		RF_WrEn => signal_RF_WrEn,
		RF_WrDatasel => signal_RF_WrDatasel,
		RF_B_sel => signal_RF_B_sel,
		PCLdEn => signal_PC_LdEn,
		PCSource => signal_PCsel,
		ALUSrcA => signal_ALUSourceA,
		ALUSrcB => signal_ALUSourceB,
		MemWrite => signal_MEM_WrEn,
		ByteOp => signal_Byte_Op,
		IRWrite => instr_wr,
		AWrite => awr,
		BWrite => bwr,
		RMEMWrite => mem_wr,
		ALUWrite => alu_wr,
		Instruction => signal_Instruction,
		func => signal_ALU_func,
		equal => signal_bflag
	);
	
	
end Behavioral;

