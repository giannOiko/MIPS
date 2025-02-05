----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:50:08 04/22/2020 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
port ( CLK : in std_logic;
		 Instr : in std_logic_vector (31 downto 0);
		 RF_WrEn : in std_logic;
		 RF_B_sel : in std_logic;
		 RST : in std_logic;
		 RF_Datain : in std_logic_vector(31 downto 0);
		 PC_4 : in std_logic_vector(31 downto 0);
		 delayedRD: in std_logic_vector(4 downto 0);
		 PC_4_IMMED_out : out std_logic_vector(31 downto 0);
		 Sign_extend_out : out std_logic_vector(31 downto 0);
		 RF_A : out std_logic_vector (31 downto 0);
		 branchflag : out std_logic;
		 RF_B : out std_logic_vector (31 downto 0));
		 

end DECSTAGE;

architecture Behavioral of DECSTAGE is


signal mulinsout : std_logic_vector(4 downto 0);
signal rfout1 : std_logic_vector(31 downto 0);
signal rfout2 : std_logic_vector(31 downto 0);
signal sig_Sign_extend_out : std_logic_vector(31 downto 0);

COMPONENT RFile
	PORT( CLK : in std_logic;
		Ard1 : IN std_logic_vector(4 downto 0);
		Ard2 : IN std_logic_vector(4 downto 0);
		Awr : IN std_logic_vector(4 downto 0);
		Din : IN std_logic_vector(31 downto 0);
		WrEn : IN std_logic;
		Rst : IN std_logic;
		Dout1 : OUT std_logic_vector(31 downto 0);
		Dout2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

COMPONENT Mulins
	PORT(
		InsAdrA : IN std_logic_vector(4 downto 0);
		InsAdrB : IN std_logic_vector(4 downto 0);
		RF_B_sel : IN std_logic;          
		Adr : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;
	
COMPONENT sign_extend
	PORT(
		Instr_im : IN std_logic_vector(15 downto 0);
		op : IN std_logic_vector(5 downto 0);          
		Immed : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
COMPONENT AdderImmed
	PORT(
		PC_4 : IN std_logic_vector(31 downto 0);
		Immed : IN std_logic_vector(31 downto 0);          
		PC_4_IMMED : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;


begin

Inst_RFile: RFile PORT MAP(
		CLK => CLK, 
		Ard1 => Instr (25 downto 21),
		Ard2 => mulinsout,
		Awr => delayedRD,
		Dout1 =>rfout1 ,
		Dout2 =>rfout2 ,
		Din => RF_Datain,
		WrEn => RF_WrEn,
		Rst => RST
	);

Inst_Mulins: Mulins PORT MAP(
		InsAdrA => Instr(15 downto 11),
		InsAdrB => Instr(20 downto 16),
		RF_B_sel => RF_B_sel,
		Adr => mulinsout
	);

Inst_sign_extend: sign_extend PORT MAP(
		Instr_im => Instr(15 downto 0),
		op => Instr(31 downto 26),
		Immed => sig_Sign_extend_out
	);
	
Inst_AdderImmed: AdderImmed PORT MAP(
		PC_4 => PC_4,
		Immed => sig_Sign_extend_out,
		PC_4_IMMED => PC_4_IMMED_out
	);
	
process(rfout1 , rfout2)  begin
	if (rfout1 = rfout2) then
		branchflag<= '1';
	else
		branchflag <= '0';
	end if;
end process;

RF_A <=rfout1;
RF_B<=rfout2;
	
process(sig_Sign_extend_out) begin
Sign_extend_out <= sig_Sign_extend_out;
end process;

end Behavioral;

