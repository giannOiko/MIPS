----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:52:03 05/22/2020 
-- Design Name: 
-- Module Name:    EX_MEM - Behavioral 
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

entity EX_MEM is
Port (	CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			WREN : IN STD_LOGIC;
			
			RFB_IN_MEM : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			ALU_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			RD_IN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			MEM_WREN : IN  STD_LOGIC;
			BYTE_OP : IN STD_LOGIC;
			RF_WREN : IN  STD_LOGIC;
         RF_WRDATASEL : IN STD_LOGIC;
			OPCODE_IN :IN STD_LOGIC_VECTOR(5 DOWNTO 0);
			
			RFB_OUT_MEM : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			ALU_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RD_OUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			RF_WREN_OUT: OUT  STD_LOGIC;
         RF_WRDATASEL_OUT : OUT STD_LOGIC;
			MEM_WREN_OUT : OUT  STD_LOGIC;
			BYTE_OP_OUT : OUT STD_LOGIC;
			OPCODE_OUT : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
			);

end EX_MEM;

architecture Behavioral of EX_MEM is

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

RD: FiveBitReg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => RD_IN,
		Dataout => RD_OUT);
	
ALU_REG: Registerrr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => ALU_IN,
		Dataout => ALU_OUT);
		
RF_B_MEM: Registerrr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => RFB_IN_MEM,
		Dataout => RFB_OUT_MEM);
	
M: M_REG PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain(0) => BYTE_OP,
		Datain(1) => MEM_WREN,
		Dataout(0) => BYTE_OP_OUT,
		Dataout(1) => MEM_WREN_OUT);
	
WB: WB_REG PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain(0) => RF_WREN,
		Datain(1) => RF_WRDATASEL,
		Dataout(0) => RF_WREN_OUT,
		Dataout(1) => RF_WRDATASEL_OUT);
	
Inst_Opcode_reg1: Opcode_reg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => OPCODE_IN,
		Dataout => OPCODE_OUT
	);

end Behavioral;

