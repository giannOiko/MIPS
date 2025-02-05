----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:21:16 05/19/2020 
-- Design Name: 
-- Module Name:    Datapath_MC - Behavioral 
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

entity Datapath_MC is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  
			  --Dec
           RF_WrEn : in  STD_LOGIC;
           RF_WrDatasel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
			  
			  --if
           PCLdEn: in  STD_LOGIC;
           PCSource : in  STD_LOGIC;
			  
			  --sel
           ALUSrcA : in  STD_LOGIC; 
			  ALUSrcB: in  STD_LOGIC_VECTOR(1 downto 0);
			  
			  --mem
			  MemWrite : in STD_LOGIC;
			  ByteOp : in STD_LOGIC;
			  
			  
			  --registers
			  IRWrite : in STD_LOGIC;
			  AWrite : in STD_LOGIC;
			  BWrite : in STD_LOGIC;
			  RMEMWrite : in STD_LOGIC;
			  ALUWrite : in STD_LOGIC;
			  
			  --control
           Instruction : out  STD_LOGIC_VECTOR (31 downto 0);
			  func : in std_logic_vector(3 downto 0);
			  equal : out std_logic);
end Datapath_MC;

architecture Behavioral of Datapath_MC is

--ALU signal
signal Alu_reg_out : std_logic_vector (31 downto 0); -- Immed from ALU register
signal Alu_out : std_logic_vector (31 downto 0);
signal pcout : std_logic_vector (31 downto 0);
signal inst : std_logic_vector (31 downto 0);
signal instin : std_logic_vector (31 downto 0);
signal Mem_reg_out : std_logic_vector(31 downto 0);
signal Mem_reg_in : std_logic_vector(31 downto 0);
signal imm : std_logic_vector(31 downto 0);
signal A_reg_in : std_logic_vector(31 downto 0);
signal A_reg_out : std_logic_vector(31 downto 0);
signal B_reg_in : std_logic_vector(31 downto 0);
signal B_reg_out : std_logic_vector(31 downto 0);
signal A_mux_out : std_logic_vector(31 downto 0);
signal MM_adr : std_logic_vector(31 downto 0);
signal miniaddr : std_logic_vector(12 downto 2);
signal miniaddr1 : std_logic_vector(12 downto 2);
signal WrData : std_logic_vector(31 downto 0);
signal RdData : std_logic_vector(31 downto 0);
signal MWrEn :std_logic;

--Memstagesiggnals

COMPONENT IFSTAGE
	PORT(
		PC_Immed : IN std_logic_vector(31 downto 0);
		PC_4 : IN std_logic_vector(31 downto 0);
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		RST : IN std_logic;
		CLK : IN std_logic;          
		PC : OUT std_logic_vector(31 downto 0)
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
		Clk : IN std_logic;
		RST : IN std_logic;          
		Immed : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		RF_B : OUT std_logic_vector(31 downto 0));
	END COMPONENT;
	
	COMPONENT EXSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		ALU_Bin_sel : IN std_logic_vector(1 downto 0);
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_out : OUT std_logic_vector(31 downto 0);
		ALU_zero : OUT std_logic;
		ALU_cout : OUT std_logic;
		ALU_ovfl : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT MEMSTAGE
	PORT(
		ByteOp : in STD_LOGIC;
		MEM_WrEn: in STD_LOGIC;
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
	
	COMPONENT mult
	PORT(
		A : IN std_logic_vector(31 downto 0);
		B : IN std_logic_vector(31 downto 0);
		sel : IN std_logic;          
		outt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT Registerr 
	PORT(
		RST : in  STD_LOGIC;
      CLK : in  STD_LOGIC;
      WE : in  STD_LOGIC;
      Datain : in  STD_LOGIC_VECTOR (31 downto 0);
      Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
   END COMPONENT;
	
	COMPONENT Instruction_reg 
	PORT(
		RST : in  STD_LOGIC;
      CLK : in  STD_LOGIC;
      WE : in  STD_LOGIC;
      Datain : in  STD_LOGIC_VECTOR (31 downto 0);
      Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
   END COMPONENT;
		

begin

Inst_IFSTAGE: IFSTAGE PORT MAP(
		PC_Immed => Alu_reg_out,
		PC_4 => Alu_out,
		PC_sel => PCSource,
		PC_LdEn => PCLdEn,
		RST => RST,
		CLK => CLK,
		PC => pcout
	);

Inst_DECSTAGE: DECSTAGE PORT MAP(
		Instr => inst,
		RF_WrEn => RF_WrEn,
		ALU_out => Alu_out,
		MEM_out => Mem_reg_out,
		RF_WrData_sel => RF_WrDatasel,
		RF_B_sel => RF_B_sel,
		Clk => CLK,
		RST => RST,
		Immed => imm,
		RF_A => A_reg_in,
		RF_B => B_reg_in
	);


Inst_EXSTAGE: EXSTAGE PORT MAP(
		RF_A => A_mux_out,
		RF_B => B_reg_out,
		Immed => imm,
		ALU_Bin_sel => ALUSrcB,
		ALU_func => func,
		ALU_out => Alu_out,
		ALU_zero => equal,
		ALU_cout => open,
		ALU_ovfl => open
	);

	Inst_MEMSTAGE: MEMSTAGE PORT MAP(
		ByteOp => ByteOp,
		MEM_WrEn => MemWrite,
		ALU_MEM_Addr => Alu_reg_out,
		MEM_DataIn => B_reg_out,
		MEM_DataOut => Mem_reg_in,
		MM_Addr => MM_adr,
		MM_WrEn => MWrEn,
		MM_WrData => WrData,
		MM_RdData => RdData
	);
	
	Inst_RAM: RAM PORT MAP(
		clk => CLK,
		inst_addr => pcout(12 downto 2),
		inst_dout => instin,
		data_we => MWrEn,
		data_addr => miniaddr1,
		data_din => WrData,
		data_dout => RdData
	);
	
ALU_in_sel_Mux: mult PORT MAP(
		A => pcout,
		B => A_reg_out,
		sel => ALUSrcA,
		outt =>  A_mux_out

	);

Instruction_Register : Instruction_reg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => IRWrite,
		Datain => instin,
		Dataout => inst
	);
Memory_Register: Registerr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => RMEMWrite,
		Datain => Mem_reg_in,
		Dataout => Mem_reg_out
	);
A_Register: Registerr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => AWrite,
		Datain => A_reg_in,
		Dataout => A_reg_out
	);
B_Register: Registerr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => BWrite,
		Datain => B_reg_in,
		Dataout => B_reg_out
	);
ALU_Register: Registerr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => ALUWrite,
		Datain => Alu_out,
		Dataout => Alu_reg_out
	);

Instruction <= inst;


miniaddr <= std_logic_vector(MM_adr(12 downto 2));
miniaddr1 <= std_logic_vector(unsigned(miniaddr) + 1024);

end Behavioral;

