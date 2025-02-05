----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:49:26 04/23/2020 
-- Design Name: 
-- Module Name:    MEM - Behavioral 
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM is

Port (     Clk :  in std_logic;
			  RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
			  ByteOp : in  STD_LOGIC;
			  Mem_WrEn : in  STD_LOGIC;
			  MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_out1 : out  STD_LOGIC_VECTOR (31 downto 0));
end MEM;

architecture Behavioral of MEM is

signal ALUt : STD_LOGIC_VECTOR (31 downto 0);
signal Addr : STD_LOGIC_VECTOR (31 downto 0);
signal miniAddr : std_logic_vector (10 downto 0);
signal miniAddr1 : std_logic_vector (10 downto 0);
signal WrEn : std_logic;
signal WrData : STD_LOGIC_VECTOR (31 downto 0);
signal RdData : STD_LOGIC_VECTOR (31 downto 0);

COMPONENT EXSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_out : OUT std_logic_vector(31 downto 0);
		ALU_zero : OUT std_logic;
		ALU_cout : OUT std_logic;
		ALU_ovfl : OUT std_logic		
		);
	END COMPONENT;

COMPONENT MEMSTAGE
	PORT(
		ByteOp : IN std_logic;
		Mem_WrEn : IN std_logic;
		ALU_MEM_Addr : IN std_logic_vector(31 downto 0);
		MEM_DataIn : IN std_logic_vector(31 downto 0);
		MM_RdData : IN std_logic_vector(31 downto 0);          
		MEM_DataOut : OUT std_logic_vector(31 downto 0);
		MM_Addr : OUT std_logic_vector(31 downto 0);
		MM_WrEn : OUT std_logic;
		MM_WrData : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

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

begin



process(Addr) begin

miniAddr <= Addr(12 downto 2);

end process;

process(miniAddr) begin

miniAddr1 <= std_logic_vector(unsigned(miniAddr) + 1024);

end process;

process(ALUt) begin

ALU_out1 <= ALUt;

end process;

	Inst_EXSTAGE: EXSTAGE PORT MAP(
		RF_A => RF_A,
		RF_B => RF_B,
		Immed => Immed,
		ALU_Bin_sel => ALU_Bin_sel,
		ALU_func => ALU_func,
		ALU_out => ALUt,
		ALU_zero => open,
		ALU_cout => open,
		ALU_ovfl => open
	);
	
	Inst_MEMSTAGE: MEMSTAGE PORT MAP(
		ByteOp => ByteOp,
		Mem_WrEn => Mem_WrEn,
		ALU_MEM_Addr => ALUt,
		MEM_DataIn => RF_B,
		MEM_DataOut => MEM_DataOut,
		MM_Addr => Addr,
		MM_WrEn => WrEn,
		MM_WrData => WrData,
		MM_RdData => RdData
	);
	
	Inst_RAM: RAM PORT MAP(
		clk => Clk,
		inst_addr => (others => '0'),
		inst_dout => open,
		data_we => WrEn,
		data_addr => miniAddr1,
		data_din => WrData,
		data_dout => RdData
	);
end Behavioral;

