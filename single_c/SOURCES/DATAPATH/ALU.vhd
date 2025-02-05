----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:01:43 04/11/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
	 
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           op : in  STD_LOGIC_VECTOR (3 downto 0);
           out1 : out  STD_LOGIC_VECTOR (31 downto 0);
           zero : out  STD_LOGIC;
           cout : out  STD_LOGIC;
           ovfl : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal temp: std_logic_vector(32 downto 0);
signal out0: std_logic_vector(31 downto 0);
signal cout0: std_logic;
signal ovfl0: std_logic;
signal zero0: std_logic;

begin

process(A,B,op,temp)
begin

case op is 
when "0000" => 
		temp <=std_logic_vector(('0' & signed(A)) + ('0' & signed(B)));
		out0 <= temp(31 downto 0);
		cout0 <= temp(32);

		-- Check overflow (Add).
		if A(31)= '0' and B(31)='0' and temp(31) ='1' then 
				ovfl0 <= '1';
		elsif A(31)= '1' and B(31)='1' and temp(31) ='0' then
				ovfl0 <= '1';
		else 
				ovfl0 <= '0';
		end if;
		
when "0001" => 
		temp <=std_logic_vector(('0' & signed(A)) - ('0' & signed(B)));
		out0 <= temp(31 downto 0);
		cout0 <= temp(32);
		
		-- Check overflow (Sub).
		if A(31)= '0' and B(31)='1' and temp(31) ='1' then 
				ovfl0 <= '1';
		elsif A(31)= '1' and B(31)='0' and temp(31) ='0' then
				ovfl0 <= '1';
		else 
				ovfl0 <= '0';
		end if;
			
when "0010" => 
		out0 <= std_logic_vector(signed(A) AND signed(B));
		cout0 <= '0';
		ovfl0 <= '0';
when "0011" => 
		out0 <= std_logic_vector(signed(A) OR signed(B));
		cout0 <= '0';
		ovfl0 <= '0';
when "0100" =>
		out0 <= std_logic_vector(NOT(signed(A)));
		cout0 <= '0';
		ovfl0 <= '0';
when "0101" => 
		out0 <= std_logic_vector(signed(A) NAND signed(B));
		cout0 <= '0';
		ovfl0 <= '0';
when "0110" => 
		out0 <=std_logic_vector(signed(A) NOR signed(B));
		cout0 <= '0';
		ovfl0 <= '0';
when "1000" =>
		out0 <= std_logic_vector(shift_right(signed(A),1));
		cout0 <= '0';
		ovfl0 <= '0';
when "1001" =>
		out0 <= std_logic_vector(shift_right(unsigned(A),1));
		cout0 <= '0';
		ovfl0 <= '0';
when "1010" => 
		out0 <= std_logic_vector(shift_left(unsigned(A),1));
		cout0 <= '0';
		ovfl0 <= '0';
when "1100" =>
		out0 <= std_logic_vector(rotate_left(unsigned(A),1));
		cout0 <= '0';
		ovfl0 <= '0';
when "1101" => 
		out0 <= std_logic_vector(rotate_right(unsigned(A),1));
		cout0 <= '0';
		ovfl0 <= '0';
when others => 
		out0 <= (others => '0');
		cout0 <= '0';
		ovfl0 <= '0';
end case; 

if temp = "000000000000000000000000000000000" then 
		zero0 <= '1' ;
else 
		zero0 <= '0';
end if;
end process;

out1<= out0 after 10 ns;
ovfl<= ovfl0;
cout<=cout0;
zero<=zero0;

end Behavioral;