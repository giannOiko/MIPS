----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:47:08 04/12/2020 
-- Design Name: 
-- Module Name:    RFile - Behavioral 
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
use work.myPackage.all;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RFile is
Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0); 
		Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
		Awr : in  STD_LOGIC_VECTOR (4 downto 0);
		Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
		Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
		Din : in  STD_LOGIC_VECTOR (31 downto 0);
		WrEn : in  STD_LOGIC;
		Clk : in  STD_LOGIC;
		Rst : in  STD_LOGIC);
end RFile;

architecture Behavioral of RFile is

signal DaOUT : bus_array;
signal decout : std_logic_vector(31 downto 1);
signal decout0 : std_logic;
signal andout : std_logic_vector(31 downto 1); 

component Registerr 
Port ( RST : in  STD_LOGIC;
       CLK : in  STD_LOGIC;
       WE : in  STD_LOGIC;
       Datain : in  STD_LOGIC_VECTOR (31 downto 0);
       Dataout : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Decoder
Port ( awr : in  STD_LOGIC_VECTOR (4 downto 0);
       outt : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Multiplexer1
Port ( mulIn : in bus_array;
		 ard   : in std_logic_vector(4 downto 0);
		 out1  : out std_logic_vector(31 downto 0));
end component; 
	
begin
REG0 : Registerr 
port map(RST => Rst,
			CLK => Clk,
			WE => decout0,
			Datain => (others => '0'),
			Dataout => Daout(0));

GEN_REG: for I in 1 to 31 generate
	REGX : Registerr
		port map(Rst, Clk, andout(I), Din, Daout(I));
	end generate GEN_REG;
	

Mux1: Multiplexer1 port map(
	mulIn => Daout,
	ard => Ard1,
	out1 => Dout1);
		
Mux2: Multiplexer1 port map(
	mulIn => Daout,
	ard => Ard2,
	out1 => Dout2);
		
DEC: Decoder port map(
	awr => Awr,
	outt(31 downto 1) => decout,
	outt(0) => decout0);
	
process (WrEn , decout) begin
	for I in 1 to 31 loop
		andout(I) <= decout(I) and WrEn;
	end loop;	
end process;
end Behavioral;
