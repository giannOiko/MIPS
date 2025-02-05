----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:24:54 04/27/2020 
-- Design Name: 
-- Module Name:    PROC_SC - Behavioral 
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

entity PROCESSOR_PIPELINE is
	PORT (   CLOCK : IN STD_LOGIC;
				RESET : IN STD_LOGIC);		
end PROCESSOR_PIPELINE;

architecture Behavioral of PROCESSOR_PIPELINE is

signal signal_Instruction : std_logic_vector(31 downto 0);
signal signal_Byte_Op : std_logic;
signal signal_RF_WrEn : std_logic;
signal signal_RF_WrDatasel : std_logic;
signal signal_RF_B_sel : std_logic;
signal signal_PCsel : std_logic;
signal signal_bflag : std_logic;
signal signal_ALUSourceB : std_logic;
signal signal_ALU_func : std_logic_vector(3 downto 0);
signal signal_MEM_WrEn : std_logic;
signal signal_control_sel : std_logic;


COMPONENT CONTROL_PIPELINE
	PORT(
		Instruction : IN std_logic_vector(31 downto 0);
		controlFlag : IN std_logic;
		equal : IN std_logic;          
		PC_sel : OUT std_logic;
		RF_WrEn : OUT std_logic;
		RF_WrData_sel : OUT std_logic;
		RF_B_sel : OUT std_logic;
		ALU_Bin_sel : OUT std_logic;
		ALU_func : OUT std_logic_vector(3 downto 0);
		byteOp : OUT std_logic;
		Mem_WrEn : OUT std_logic
		);
	END COMPONENT;

COMPONENT DATAPATH_PIPELINE
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		PC_SOURCE : IN std_logic;
		RF_WREN : IN std_logic;
		RF_B_SEL : IN std_logic;
		RF_WRDATASEL : IN std_logic;
		ALUSRCB : IN std_logic;
		ALU_FUNC : IN std_logic_vector(3 downto 0);
		MEM_WREN : IN std_logic;
		BYTE_OP : IN std_logic;          
		Control_select : OUT std_logic;
		Instruction : OUT std_logic_vector(31 downto 0);
		equal : OUT std_logic
		);
	END COMPONENT;

begin

Inst_CONTROL: CONTROL_PIPELINE PORT MAP(
		Instruction => signal_Instruction,
		controlFlag => signal_control_sel,
		equal => signal_bflag,
		PC_sel => signal_PCsel,
		RF_WrEn => signal_RF_WrEn,
		RF_WrData_sel => signal_RF_WrDatasel,
		RF_B_sel => signal_RF_B_sel,
		ALU_Bin_sel => signal_ALUSourceB,
		byteOp => signal_Byte_Op,
		ALU_func => signal_ALU_func,
		Mem_WrEn => signal_MEM_WrEn
	);	

Inst_Datapath: DATAPATH_PIPELINE PORT MAP(
		CLK => CLOCK,
		RST => RESET,
		PC_SOURCE => signal_PCsel,
		RF_WREN => signal_RF_WrEn,
		RF_B_SEL => signal_RF_B_sel,
		RF_WRDATASEL =>signal_RF_WrDatasel ,
		ALUSRCB => signal_ALUSourceB,
		ALU_FUNC => signal_ALU_func ,
		MEM_WREN => signal_MEM_WrEn,
		BYTE_OP => signal_Byte_Op,
		Control_select => signal_control_sel,
		Instruction => signal_Instruction,
		equal => signal_bflag
	);
	
end Behavioral;

