----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:02:14 04/24/2020 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
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

entity Datapath is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  
			  --Dec
           RF_WrEn : in  STD_LOGIC;
           RF_WrDatasel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ImmExt_s : in  STD_LOGIC_VECTOR(1 downto 0);
			  
			  --if
           PCsel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
			  
			  --mem
           ALU_Binsel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR(3 downto 0); 
           MEM_WrEn : in  STD_LOGIC;
			  Byte_Op : in STD_LOGIC;
			  
			  --control
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0);
			  bflag : out std_logic);
end Datapath;

architecture Behavioral of Datapath is

signal inst : std_logic_vector(31 downto 0);
signal MEMdout : std_logic_vector(31 downto 0);
signal alusig : std_logic_vector(31 downto 0);
signal imsig : std_logic_vector(31 downto 0);
signal rfa : std_logic_vector(31 downto 0);
signal rfb : std_logic_vector(31 downto 0);

COMPONENT IFSTAGE
	PORT(
		PC_Immed : IN std_logic_vector(31 downto 0);
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		Reset : IN std_logic;
		CLK : IN std_logic;          
		inst_dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT DECSTAGE
	PORT(
		Instr : IN std_logic_vector(31 downto 0);
		RF_WrEn : IN std_logic;
		ALU_out : IN std_logic_vector(31 downto 0);
		MEM_out : IN std_logic_vector(31 downto 0);
		RF_WrData_sel : IN std_logic;
		RF_B_sel : IN std_logic;
		ImmExt : IN std_logic_vector(1 downto 0);
		Clk : IN std_logic;
		RST : IN std_logic;          
		Immed : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0);
		branchflag : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT MEM
	PORT(
		Clk : IN std_logic;
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);
		ByteOp : IN std_logic;
		Mem_WrEn : IN std_logic;          
		MEM_DataOut : OUT std_logic_vector(31 downto 0);
		ALU_out1 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


begin

Inst_IFSTAGE: IFSTAGE PORT MAP(
		PC_Immed => imsig,
		PC_sel => PCsel,
		PC_LdEn => PC_LdEn,
		Reset => RST,
		CLK => CLK,
		inst_dout => inst
	);

Inst_DECSTAGE: DECSTAGE PORT MAP(
		Instr => inst,
		RF_WrEn => RF_WrEn,
		ALU_out => alusig,
		MEM_out => MEMdout,
		RF_WrData_sel => RF_WrDatasel,
		RF_B_sel => RF_B_sel,
		ImmExt => ImmExt_s,
		Clk => CLK,
		RST => RST,
		Immed => imsig,
		RF_A => rfa,
		RF_B => rfb,
		branchflag => bflag
	);

Inst_MEM: MEM PORT MAP(
		Clk => CLK,
		RF_A => rfa,
		RF_B => rfb,
		Immed => imsig,
		ALU_Bin_sel => ALU_Binsel,
		ALU_func => ALU_func,
		ByteOp => Byte_Op,
		Mem_WrEn => MEM_WrEn,
		MEM_DataOut => MEMdout,
		ALU_out1 => alusig
	);
	


Instruction <= inst;


end Behavioral;

