----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:23:46 05/22/2020 
-- Design Name: 
-- Module Name:    ID_EX - Behavioral 
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

entity ID_EX is
Port (	CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			WREN : IN STD_LOGIC;
			
			RF_A_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			RF_B_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			IMMED_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			RD_IN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			RT_IN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			RS_IN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			OPCODE_IN : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			RF_WREN : IN  STD_LOGIC;
         RF_WRDATASEL : IN STD_LOGIC;
			ALUSRCB: IN  STD_LOGIC;
			ALU_FUNC : IN  STD_LOGIC_VECTOR (3 downto 0);
         MEM_WREN : IN  STD_LOGIC;
			BYTE_OP : IN STD_LOGIC;
			
			RF_A_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RF_B_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			IMMED_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RD_OUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			RT_OUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			RS_OUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			OPCODE_OUT : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
			RF_WREN_OUT: OUT  STD_LOGIC;
         RF_WRDATASEL_OUT : OUT STD_LOGIC;
			ALUSRCB_OUT: OUT  STD_LOGIC;
			ALU_FUNC_OUT : OUT  STD_LOGIC_VECTOR (3 downto 0);
         MEM_WREN_OUT : OUT  STD_LOGIC;
			BYTE_OP_OUT : OUT STD_LOGIC);

end ID_EX;

architecture Behavioral of ID_EX is

COMPONENT FiveBitReg
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(4 downto 0);          
		Dataout : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

COMPONENT M_REG
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(1 downto 0);          
		Dataout : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;

COMPONENT WB_REG
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(1 downto 0);          
		Dataout : OUT std_logic_vector(1 downto 0)
		);
	END COMPONENT;
	
COMPONENT Registerrr
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(31 downto 0);          
		Dataout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT Opcode_reg
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(5 downto 0);          
		Dataout : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

begin

RD_REG: FiveBitReg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => RD_IN,
		Dataout => RD_OUT
	);

RS_REG: FiveBitReg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => RS_IN,
		Dataout => RS_OUT
	);

RT_REG: FiveBitReg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => RT_IN,
		Dataout => RT_OUT
	);

EX: FiveBitReg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain(0) => ALUSRCB,
		Datain(4 DOWNTO 1) => ALU_FUNC,
		Dataout(0) => ALUSRCB_OUT,
		Dataout(4 DOWNTO 1) => ALU_FUNC_OUT
	);
	
M: M_REG PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain(0) => BYTE_OP,
		Datain(1) => MEM_WREN,
		Dataout(0) => BYTE_OP_OUT,
		Dataout(1) => MEM_WREN_OUT 

	);
	
WB: WB_REG PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain(0) => RF_WREN,
		Datain(1) => RF_WRDATASEL,
		Dataout(0) => RF_WREN_OUT,
		Dataout(1) => RF_WRDATASEL_OUT

	);

A_Registerr: Registerrr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => RF_A_IN,
		Dataout => RF_A_OUT
	);

B_Registerr: Registerrr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => RF_B_IN,
		Dataout => RF_B_OUT 
	);

Immed_Registerr: Registerrr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => IMMED_IN,
		Dataout => IMMED_OUT 
	);
	
Inst_Opcode_reg: Opcode_reg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => OPCODE_IN,
		Dataout => OPCODE_OUT
	);

end Behavioral;

