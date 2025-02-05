----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:15:16 05/22/2020 
-- Design Name: 
-- Module Name:    MEM_WB - Behavioral 
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

entity MEM_WB is
Port (	CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			WREN : IN STD_LOGIC;
			
			ALU_IN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			MEM_IN: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			RD_IN : IN STD_LOGIC_VECTOR(4 DOWNTO 0);		
			RF_WREN : IN  STD_LOGIC;
         RF_WRDATASEL : IN STD_LOGIC;
			
			
			ALU_OUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			MEM_OUT: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			RD_OUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			RF_WREN_OUT: OUT  STD_LOGIC;
         RF_WRDATASEL_OUT : OUT STD_LOGIC);

end MEM_WB;

architecture Behavioral of MEM_WB is

COMPONENT FiveBitReg
	PORT(
		RST : IN std_logic;
		CLK : IN std_logic;
		WE : IN std_logic;
		Datain : IN std_logic_vector(4 downto 0);          
		Dataout : OUT std_logic_vector(4 downto 0)
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

begin

RD_REGG: FiveBitReg PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => RD_IN,
		Dataout => RD_OUT);

ALU_OUT_REG: Registerrr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => ALU_IN,
		Dataout => ALU_OUT);
		
MEM_OUT_REG: Registerrr PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain => MEM_IN ,
		Dataout =>MEM_OUT );

WB: WB_REG PORT MAP(
		RST => RST,
		CLK => CLK,
		WE => WREN,
		Datain(0) => RF_WREN,
		Datain(1) => RF_WRDATASEL,
		Dataout(0) => RF_WREN_OUT,
		Dataout(1) => RF_WRDATASEL_OUT);
end Behavioral;

