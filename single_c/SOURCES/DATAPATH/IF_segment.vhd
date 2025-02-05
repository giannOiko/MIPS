----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:20:47 04/17/2020 
-- Design Name: 
-- Module Name:    IF - Behavioral 
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

entity IF_segment is
    Port ( PC_Imm : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           PC : out  STD_LOGIC_VECTOR (31 downto 0));
end IF_segment;

architecture Behavioral of IF_segment is

signal adder4out : std_logic_vector(31 downto 0);
signal adderimout : std_logic_vector(31 downto 0);
signal muxout : std_logic_vector(31 downto 0);
signal PC_out : std_logic_vector(31 downto 0);

component IF_Mux
port ( PC_4 : in  STD_LOGIC_VECTOR (31 downto 0);
       PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
       sel : in  STD_LOGIC;
       Mux_outt : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Adder_4
port ( pc : in  STD_LOGIC_VECTOR (31 downto 0);
       pc_4 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Adder_Immed
Port ( SE_PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
       PC_4 : in  STD_LOGIC_VECTOR (31 downto 0);
		 Adder_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC_register
Port ( newPCin : in  STD_LOGIC_VECTOR (31 downto 0);
       ld_en : in  STD_LOGIC;
       reset : in  STD_LOGIC;
       CLK : in  STD_LOGIC;
       newPCout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

begin
process (PC_out) begin
PC <= PC_out;
end process;

PCC : PC_register
port map(  newPCin => muxout,
		     ld_en => PC_LdEn,
			  reset => Reset,
			  CLK => CLK,
			  newPCout => PC_out);

ADD4 : Adder_4 
port map(  pc => PC_out,
			  pc_4 => adder4out);
			  
ADDIM : Adder_Immed
port map(  SE_PC_Immed => PC_Imm,
			  PC_4 => adder4out,
			  Adder_out => adderimout);
			  
MUXX : IF_Mux
port map(  PC_4 => adder4out,
			  PC_Immed => adderimout,
			  sel => PC_sel,
			  Mux_outt => muxout);

			  
end Behavioral;

