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

entity PROC_SC is
	PORT (   CLOCK : IN STD_LOGIC;
				RESET : IN STD_LOGIC;
				PC_LD_EN: IN STD_LOGIC);		
end PROC_SC;

architecture Behavioral of PROC_SC is

signal signal_RF_WrEn : std_logic;
signal signal_RF_WrDatasel : std_logic;
signal signal_RF_B_sel : std_logic;
signal signal_ImmExt_s : std_logic_vector(1 downto 0);
signal signal_PCsel : std_logic;
signal signal_ALU_Binsel : std_logic;
signal signal_ALU_func : std_logic_vector(3 downto 0);
signal signal_MEM_WrEn : std_logic;
signal signal_Byte_Op : std_logic;          
signal signal_Instruction : std_logic_vector(31 downto 0);
signal signal_bflag : std_logic;

COMPONENT CONTROL
	PORT(
		Clock : IN std_logic;
		Instruction : IN std_logic_vector(31 downto 0);
		Reset : IN std_logic;
		brflag : IN std_logic;          
		PC_sel : OUT std_logic;
		RF_WrEn : OUT std_logic;
		RF_WrData_sel : OUT std_logic;
		RF_B_sel : OUT std_logic;
		ALU_Bin_sel : OUT std_logic;
		ALU_func : OUT std_logic_vector(3 downto 0);
		Mem_WrEn : OUT std_logic;
		Byte_Op : OUT std_logic;
		ImmExt_s : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

COMPONENT Datapath
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		RF_WrEn : IN std_logic;
		RF_WrDatasel : IN std_logic;
		RF_B_sel : IN std_logic;
		ImmExt_s : IN std_logic_vector(1 downto 0);
		PCsel : IN std_logic;
		PC_LdEn : IN std_logic;
		ALU_Binsel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);
		MEM_WrEn : IN std_logic;
		Byte_Op : IN std_logic;          
		Instruction : OUT std_logic_vector(31 downto 0);
		bflag : OUT std_logic
		);
	END COMPONENT;

begin

Inst_CONTROL: CONTROL PORT MAP(
		Clock => CLOCK,
		Instruction => signal_Instruction,
		Reset => RESET,
		brflag => signal_bflag,
		PC_sel => signal_PCsel,
		RF_WrEn => signal_RF_WrEn,
		RF_WrData_sel => signal_RF_WrDatasel,
		RF_B_sel => signal_RF_B_sel,
		ALU_Bin_sel => signal_ALU_Binsel,
		ALU_func => signal_ALU_func,
		Mem_WrEn => signal_MEM_WrEn,
		Byte_Op => signal_Byte_Op,
		ImmExt_s => signal_ImmExt_s 
	);

Inst_Datapath: Datapath PORT MAP(
		CLK => CLOCK,
		RST => RESET,
		RF_WrEn => signal_RF_WrEn,
		RF_WrDatasel => signal_RF_WrDatasel,
		RF_B_sel => signal_RF_B_sel,
		ImmExt_s => signal_ImmExt_s,
		PCsel => signal_PCsel,
		PC_LdEn => PC_LD_EN,
		ALU_Binsel => signal_ALU_Binsel,
		ALU_func => signal_ALU_func,
		MEM_WrEn => signal_MEM_WrEn,
		Byte_Op => signal_Byte_Op,
		Instruction => signal_Instruction,
		bflag => signal_bflag
	);
end Behavioral;

