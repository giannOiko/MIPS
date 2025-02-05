----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:44:10 04/12/2020 
-- Design Name: 
-- Module Name:    Multiplexer1 - Behavioral 
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
entity Multiplexer1 is 
port(  mulIn : in bus_array;
		 ard   : in std_logic_vector(4 downto 0);
		 out1  : out std_logic_vector(31 downto 0));
end Multiplexer1;

architecture Behavioral of Multiplexer1 is

signal out0 : std_logic_vector(31 downto 0);
begin process (ard , mulIn)
begin

case ard is
	when "00000" => out0 <= mulIn(0);
	when "00001" => out0 <= mulIn(1);
	when "00010" => out0 <= mulIn(2);
	when "00011" => out0 <= mulIn(3);
	when "00100" => out0 <= mulIn(4);
	when "00101" => out0 <= mulIn(5);
	when "00110" => out0 <= mulIn(6);
	when "00111" => out0 <= mulIn(7);
	when "01000" => out0 <= mulIn(8);
	when "01001" => out0 <= mulIn(9);
	when "01010" => out0 <= mulIn(10);
	when "01011" => out0 <= mulIn(11);
	when "01100" => out0 <= mulIn(12);
	when "01101" => out0 <= mulIn(13);
	when "01110" => out0 <= mulIn(14);
	when "01111" => out0 <= mulIn(15);
	when "10000" => out0 <= mulIn(16);
	when "10001" => out0 <= mulIn(17);
	when "10010" => out0 <= mulIn(18);
	when "10011" => out0 <= mulIn(19);
	when "10100" => out0 <= mulIn(20);
	when "10101" => out0 <= mulIn(21);
	when "10110" => out0 <= mulIn(22);
	when "10111" => out0 <= mulIn(23);
	when "11000" => out0 <= mulIn(24);
	when "11001" => out0 <= mulIn(25);
	when "11010" => out0 <= mulIn(26);
	when "11011" => out0 <= mulIn(27);
	when "11100" => out0 <= mulIn(28);
	when "11101" => out0 <= mulIn(29);
	when "11110" => out0 <= mulIn(30);
	when "11111" => out0 <= mulIn(31);
	when others  => out0 <= "00000000000000000000000000000000";
	end case;
	end process;
out1 <= out0 after 10 ns;
end Behavioral;

