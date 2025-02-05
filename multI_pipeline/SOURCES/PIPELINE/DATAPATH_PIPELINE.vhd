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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DATAPATH_PIPELINE is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			
			PC_SOURCE : IN STD_LOGIC;
			
			RF_WREN : IN  STD_LOGIC;
			RF_B_SEL : IN STD_LOGIC;
			
			
         RF_WRDATASEL : IN STD_LOGIC;
			ALUSRCB: IN  STD_LOGIC;
			ALU_FUNC : IN  STD_LOGIC_VECTOR (3 downto 0);
         MEM_WREN : IN  STD_LOGIC;
			BYTE_OP : IN STD_LOGIC; 
			--control
			Control_select : out STD_LOGIC;
         Instruction : out  STD_LOGIC_VECTOR (31 downto 0);
			equal : out std_logic);
end DATAPATH_PIPELINE;

architecture Behavioral of DATAPATH_PIPELINE is

signal if_id_wren_sig : std_logic;
signal pc_lden_sig : std_logic;
signal pcout_sig : std_logic_vector(31 downto 0);
signal pc4out_sig : std_logic_vector(31 downto 0);
signal inst_in_sig : std_logic_vector(31 downto 0);
signal inst_out_sig : std_logic_vector(31 downto 0);
signal reg_pc_4_out_sig : std_logic_vector(31 downto 0);
signal pc_immed_sig : std_logic_vector(31 downto 0);
signal sign_extend_out_sig : std_logic_vector (31 downto 0);
signal rfa_sig : std_logic_vector(31 downto 0);
signal rfb_sig : std_logic_vector(31 downto 0);
signal rfa_out_sig :std_logic_vector(31 downto 0);
signal rfb_out_sig :std_logic_vector(31 downto 0);
signal immed_out_sig :std_logic_vector(31 downto 0);
signal alusrcb_out_sig : std_logic;
signal alu_func_out_sig : std_logic_vector (3 downto 0);
signal alu_out_sig : std_logic_vector(31 downto 0);
signal rd_out_sig :std_logic_vector(4 downto 0);
signal mem_wren_out_sig : std_logic;
signal byte_op_out_sig : std_logic;
signal rf_wren_out_sig : std_logic;
signal rf_wrdatasel_out_sig : std_logic;
signal alu_out_sig1 : std_logic_vector(31 downto 0);
signal rfb_out_sig1 :std_logic_vector(31 downto 0);
signal mem_wren_out_sig1 : std_logic;
signal byte_op_out_sig1 : std_logic;
signal lw_data_sig : std_logic_vector(31 downto 0);
signal rd_out_sig1 :std_logic_vector(4 downto 0);
signal rf_wren_out_sig1 : std_logic;
signal rf_wrdatasel_out_sig1 : std_logic;
signal mem_wren_out_sig2 : std_logic;
signal aluAsel_sig : std_logic_vector(1 downto 0);
signal aluBsel_sig : std_logic_vector(1 downto 0);
signal RF_write_data_sig : std_logic_vector(31 downto 0);
signal rt_out_sig :std_logic_vector(4 downto 0);
signal rs_out_sig :std_logic_vector(4 downto 0);
signal alu_out_sig2 : std_logic_vector(31 downto 0);
signal rd_out_sig_2 : std_logic_vector(4 downto 0);
signal rf_wren_out_sig2 : std_logic;
signal rf_wrdatasel_out_sig2 : std_logic; 
signal lw_data_sig_out : std_logic_vector(31 downto 0);
signal control_mux_sig : std_logic_vector(31 downto 0);
signal muxtomem_sig : std_logic_vector(31 downto 0);
signal opcode_out_sig : std_logic_vector(5 downto 0);
signal opcode_out_sig1 : std_logic_vector(5 downto 0);
signal forward_store_sel_sig : std_logic_vector(1 downto 0);
--mem

signal MM_adr : std_logic_vector(31 downto 0);
signal miniaddr : std_logic_vector(12 downto 2);
signal miniaddr1 : std_logic_vector(12 downto 2);
signal WrData : std_logic_vector(31 downto 0);
signal RdData : std_logic_vector(31 downto 0);

--Memstagesiggnals

COMPONENT IFSTAGE
	PORT(
		PC_Immed : IN std_logic_vector(31 downto 0);
		PC_sel : IN std_logic;
		PC_LdEn : IN std_logic;
		RST : IN std_logic;
		CLK : IN std_logic;          
		PC : OUT std_logic_vector(31 downto 0);
		PC_4 : OUT std_logic_vector(31 downto 0)
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
	

COMPONENT IF_ID
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WREN : IN std_logic;
		PC4 : IN std_logic_vector(31 downto 0);
		INSTR : IN std_logic_vector(31 downto 0);          
		PC4_OUT : OUT std_logic_vector(31 downto 0);
		INSTR_OUT : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT DECSTAGE
	PORT(CLK : in std_logic;
			RST : in std_logic;
		Instr : IN std_logic_vector(31 downto 0);
		RF_WrEn : IN std_logic;
		RF_B_sel : IN std_logic;
		RF_Datain : IN std_logic_vector(31 downto 0);
		PC_4 : IN std_logic_vector(31 downto 0);
		delayedRD : IN std_logic_vector(4 downto 0);
		PC_4_IMMED_out : OUT std_logic_vector(31 downto 0);
		Sign_extend_out : OUT std_logic_vector(31 downto 0);
		RF_A : OUT std_logic_vector(31 downto 0);
		branchflag : OUT std_logic;
		RF_B : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT ID_EX
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		WREN : IN std_logic;
		RF_A_IN : IN std_logic_vector(31 downto 0);
		RF_B_IN : IN std_logic_vector(31 downto 0);
		IMMED_IN : IN std_logic_vector(31 downto 0);
		RD_IN : IN std_logic_vector(4 downto 0);
		RT_IN : IN std_logic_vector(4 downto 0);
		RS_IN : IN std_logic_vector(4 downto 0);
		OPCODE_IN : IN std_logic_vector(5 downto 0);
		RF_WREN : IN std_logic;
		RF_WRDATASEL : IN std_logic;
		ALUSRCB : IN std_logic;
		ALU_FUNC : IN std_logic_vector(3 downto 0);
		MEM_WREN : IN std_logic;
		BYTE_OP : IN std_logic;          
		RF_A_OUT : OUT std_logic_vector(31 downto 0);
		RF_B_OUT : OUT std_logic_vector(31 downto 0);
		IMMED_OUT : OUT std_logic_vector(31 downto 0);
		RD_OUT : OUT std_logic_vector(4 downto 0);
		RT_OUT : OUT std_logic_vector(4 downto 0);
		RS_OUT : OUT std_logic_vector(4 downto 0);
		OPCODE_OUT :OUT std_logic_vector(5 downto 0);
		RF_WREN_OUT : OUT std_logic;
		RF_WRDATASEL_OUT : OUT std_logic;
		ALUSRCB_OUT : OUT std_logic;
		ALU_FUNC_OUT : OUT std_logic_vector(3 downto 0);
		MEM_WREN_OUT : OUT std_logic;
		BYTE_OP_OUT : OUT std_logic
		);
	END COMPONENT;

COMPONENT EXSTAGE
	PORT(
		RF_A : IN std_logic_vector(31 downto 0);
		RF_B : IN std_logic_vector(31 downto 0);
		EX_MEM_out : IN std_logic_vector(31 downto 0);
		MEM_WRB_out : IN std_logic_vector(31 downto 0);
		MEM_OUT :IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);
		Forward_ALU_A_sel : IN std_logic_vector(1 downto 0);
		Forward_ALU_B_sel : IN std_logic_vector(1 downto 0);
		Forward_Store_sel : IN std_logic_vector(1 downto 0);
		ALU_B_sel : IN std_logic;
		ALU_func : IN std_logic_vector(3 downto 0);          
		ALU_out : OUT std_logic_vector(31 downto 0);
		ALU_zero : OUT std_logic;
		ALU_cout : OUT std_logic;
		Store_data_in : OUT std_logic_vector(31 downto 0);
		ALU_ovfl : OUT std_logic
		);
	END COMPONENT;
	
COMPONENT EX_MEM
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		WREN : IN std_logic;
		RFB_IN_MEM : IN std_logic_vector(31 downto 0);
		ALU_IN : IN std_logic_vector(31 downto 0);
		RD_IN : IN std_logic_vector(4 downto 0);
		MEM_WREN : IN std_logic;
		BYTE_OP : IN std_logic;
		RF_WREN : IN std_logic;
		RF_WRDATASEL : IN std_logic;
		OPCODE_IN :IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		RFB_OUT_MEM : OUT std_logic_vector(31 downto 0);
		ALU_OUT : OUT std_logic_vector(31 downto 0);
		RD_OUT : OUT std_logic_vector(4 downto 0);
		RF_WREN_OUT : OUT std_logic;
		RF_WRDATASEL_OUT : OUT std_logic;
		MEM_WREN_OUT : OUT std_logic;
		BYTE_OP_OUT : OUT std_logic;
		OPCODE_OUT :OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
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

COMPONENT MEM_WB
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;
		WREN : IN std_logic;
		ALU_IN : IN std_logic_vector(31 downto 0);
		MEM_IN : IN std_logic_vector(31 downto 0);
		RD_IN : IN std_logic_vector(4 downto 0);
		RF_WREN : IN std_logic;
		RF_WRDATASEL : IN std_logic;          
		ALU_OUT : OUT std_logic_vector(31 downto 0);
		MEM_OUT : OUT std_logic_vector(31 downto 0);
		RD_OUT : OUT std_logic_vector(4 downto 0);
		RF_WREN_OUT : OUT std_logic;
		RF_WRDATASEL_OUT : OUT std_logic
		);
	END COMPONENT;

COMPONENT Mulx
	PORT(
		ALU_out : IN std_logic_vector(31 downto 0);
		MEM_out : IN std_logic_vector(31 downto 0);
		RF_WrData_sel : IN std_logic;          
		outt : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT Forwarding_unit
	PORT(
		RF_WrEn_EXMEM : IN std_logic;
		RF_WrEn_MEMWB : IN std_logic;
		Rd_EXMEM : IN std_logic_vector(4 downto 0);
		Rs_IDEX : IN std_logic_vector(4 downto 0);
		Rd_MEMWB : IN std_logic_vector(4 downto 0);
		OpCodeIDEX : IN std_logic_vector(5 downto 0);
		OpCodeEXMEM : IN std_logic_vector(5 downto 0);
		Rd_IDEX : IN STD_LOGIC_VECTOR(4 downto 0);
		Rt_IDEX : IN std_logic_vector(4 downto 0);  
		ForwardA : OUT std_logic_vector(1 downto 0);
		ForwardB : OUT std_logic_vector(1 downto 0);
		ForwardC : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
COMPONENT StallUnit
	PORT(
		OpCodeIDEX : IN std_logic_vector(5 downto 0);
		Rs_IFID : IN std_logic_vector(4 downto 0);
		Rt_IFID : IN std_logic_vector(4 downto 0);
		Rd_IDEX : IN std_logic_vector(4 downto 0);          
		Mux_sel : OUT std_logic;
		IFID_WrEn : OUT std_logic;
		Pc_LdEn_Out : OUT std_logic
		);
	END COMPONENT;

begin

Inst_IFSTAGE: IFSTAGE PORT MAP(
		PC_Immed => pc_immed_sig,
		PC_sel => PC_SOURCE,
		PC_LdEn => pc_lden_sig,
		RST => RST,
		CLK => CLK,
		PC => pcout_sig,
		PC_4 => pc4out_sig
	);

Inst_RAM: RAM PORT MAP(
		clk => CLK,
		inst_addr => pcout_sig(12 downto 2),
		inst_dout => inst_in_sig,
		data_we => mem_wren_out_sig2,
		data_addr => miniaddr1,
		data_din => WrData,
		data_dout => RdData
	);

	Inst_IF_ID: IF_ID PORT MAP(
		RST => RST,
		CLK => CLK,
		WREN => if_id_wren_sig,
		PC4 => pc4out_sig,
		INSTR => inst_in_sig,
		PC4_OUT => reg_pc_4_out_sig,
		INSTR_OUT => inst_out_sig
	);
	

	Inst_DECSTAGE: DECSTAGE PORT MAP(
		CLK => CLK, 
		RST => RST,
		Instr => inst_out_sig,
		RF_WrEn => rf_wren_out_sig2,
		RF_B_sel => RF_B_SEL,
		RF_Datain => RF_write_data_sig,
		PC_4 => reg_pc_4_out_sig,
		delayedRD => rd_out_sig_2,
		PC_4_IMMED_out => pc_immed_sig,
		Sign_extend_out => sign_extend_out_sig,
		RF_A => rfa_sig,
		branchflag => equal,
		RF_B => rfb_sig
	);
	
Inst_ID_EX: ID_EX PORT MAP(
		CLK => CLK,
		RST => RST,
		WREN => '1',
		RF_A_IN => rfa_sig,
		RF_B_IN => rfb_sig,
		IMMED_IN => sign_extend_out_sig,
		RD_IN => inst_out_sig(20 downto 16),
		RT_IN => inst_out_sig(15 downto 11),
		RS_IN => inst_out_sig(25 downto 21),
		OPCODE_IN => inst_out_sig(31 downto 26),
		RF_WREN => RF_WREN,
		RF_WRDATASEL => RF_WRDATASEL,
		ALUSRCB => ALUSRCB,
		ALU_FUNC => ALU_FUNC,
		MEM_WREN => MEM_WREN,
		BYTE_OP => BYTE_OP,
		RF_A_OUT => rfa_out_sig,
		RF_B_OUT => rfb_out_sig,
		IMMED_OUT => immed_out_sig,
		RD_OUT => rd_out_sig,
		RT_OUT => rt_out_sig,
		RS_OUT => rs_out_sig,
		OPCODE_OUT => opcode_out_sig,
		RF_WREN_OUT => rf_wren_out_sig,
		RF_WRDATASEL_OUT => rf_wrdatasel_out_sig,
		ALUSRCB_OUT => alusrcb_out_sig,
		ALU_FUNC_OUT => alu_func_out_sig,
		MEM_WREN_OUT => mem_wren_out_sig,
		BYTE_OP_OUT => byte_op_out_sig
	);
	
Inst_EXSTAGE: EXSTAGE PORT MAP(
		RF_A => rfa_out_sig,
		RF_B => rfb_out_sig,
		EX_MEM_out => alu_out_sig1,
		MEM_WRB_out => RF_write_data_sig,
		MEM_OUT => lw_data_sig,
		Immed => immed_out_sig,
		Forward_ALU_A_sel => aluAsel_sig,
		Forward_ALU_B_sel => aluBsel_sig,
		Forward_Store_sel => forward_store_sel_sig,
		ALU_B_sel => alusrcb_out_sig,
		Store_data_in => muxtomem_sig,
		ALU_func => alu_func_out_sig,
		ALU_out => alu_out_sig,
		ALU_zero => open,
		ALU_cout => open,
		ALU_ovfl => open
	);

	Inst_EX_MEM: EX_MEM PORT MAP(
		CLK => CLK,
		RST => RST,
		WREN => '1',
		RFB_IN_MEM => muxtomem_sig,
		ALU_IN => alu_out_sig,
		RD_IN => rd_out_sig,
		MEM_WREN => mem_wren_out_sig,
		BYTE_OP => byte_op_out_sig,
		RF_WREN => rf_wren_out_sig,
		RF_WRDATASEL => rf_wrdatasel_out_sig,
		OPCODE_IN => opcode_out_sig,
		RFB_OUT_MEM => rfb_out_sig1,
		ALU_OUT => alu_out_sig1,
		RD_OUT => rd_out_sig1,
		RF_WREN_OUT => rf_wren_out_sig1,
		RF_WRDATASEL_OUT => rf_wrdatasel_out_sig1,
		MEM_WREN_OUT => mem_wren_out_sig1,
		BYTE_OP_OUT => byte_op_out_sig1,
		OPCODE_OUT => opcode_out_sig1
	);
	
	Inst_MEMSTAGE: MEMSTAGE PORT MAP(
		ByteOp => byte_op_out_sig1,
		MEM_WrEn => mem_wren_out_sig1,
		ALU_MEM_Addr => alu_out_sig1,
		MEM_DataIn => rfb_out_sig1,
		MEM_DataOut => lw_data_sig,
		MM_Addr => MM_adr,
		MM_WrEn => mem_wren_out_sig2,
		MM_WrData => WrData,
		MM_RdData => RdData
	);

	Inst_MEM_WB: MEM_WB PORT MAP(
		CLK => CLK,
		RST => RST,
		WREN => '1',
		ALU_IN => alu_out_sig1,
		MEM_IN => lw_data_sig,
		RD_IN => rd_out_sig1,
		RF_WREN => rf_wren_out_sig1,
		RF_WRDATASEL => rf_wrdatasel_out_sig1,
		ALU_OUT => alu_out_sig2,
		MEM_OUT => lw_data_sig_out,
		RD_OUT => rd_out_sig_2,
		RF_WREN_OUT => rf_wren_out_sig2,
		RF_WRDATASEL_OUT => rf_wrdatasel_out_sig2
	);
	

	Inst_Mulx: Mulx PORT MAP(
		ALU_out => alu_out_sig2,
		MEM_out => lw_data_sig_out,
		RF_WrData_sel => rf_wrdatasel_out_sig2,
		outt => RF_write_data_sig
	);

Inst_Forwarding_unit: Forwarding_unit PORT MAP(
		RF_WrEn_EXMEM => rf_wren_out_sig1,
		RF_WrEn_MEMWB => rf_wren_out_sig2,
		Rd_EXMEM => rd_out_sig1,
		Rs_IDEX => rs_out_sig,
		OpCodeIDEX => opcode_out_sig,
		OpCodeEXMEM => opcode_out_sig1,
		Rd_IDEX => rd_out_sig,
		Rd_MEMWB => rd_out_sig_2,
		Rt_IDEX => rt_out_sig,
		ForwardA => aluAsel_sig,
		ForwardB => aluBsel_sig,
		ForwardC => forward_store_sel_sig
	);

Inst_StallUnit: StallUnit PORT MAP(
		OpCodeIDEX => opcode_out_sig,
		Rs_IFID => inst_out_sig(25 downto 21),
		Rt_IFID => inst_out_sig(15 downto 11),
		Rd_IDEX => rd_out_sig,
		Mux_sel => Control_select,
		IFID_WrEn => if_id_wren_sig,
		Pc_LdEn_Out =>pc_lden_sig
	);



Instruction <= inst_out_sig;
miniaddr <= std_logic_vector(MM_adr(12 downto 2));
miniaddr1 <= std_logic_vector(unsigned(miniaddr) + 1024);

end Behavioral;

