--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:54:27 04/11/2020
-- Design Name:   
-- Module Name:   C:/organwsi/HPY312/ALU_test.vhd
-- Project Name:  HPY312
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_test IS
END ALU_test;
 
ARCHITECTURE behavior OF ALU_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         op : IN  std_logic_vector(3 downto 0);
         out1 : OUT  std_logic_vector(31 downto 0);
         zero : OUT  std_logic;
         cout : OUT  std_logic;
         ovfl : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal out1 : std_logic_vector(31 downto 0);
   signal zero : std_logic;
   signal cout : std_logic;
   signal ovfl : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          op => op,
          out1 => out1,
          zero => zero,
          cout => cout,
          ovfl => ovfl
        );

   -- Stimulus process
   stim_proc: process
   begin		
      
		--Zero flag 
		A<="00000000000000000000000000000000";
		B<="00000000000000000000000000000000";
		op<="0000";
		wait for 50 ns;
     	
		--add 1 
		A<="00000000000000000000000000011111";
		B<="00000000000000000000000000011111";
		op<="0000";
		wait for 50 ns;
		
		--add 2 
		A<="11110000000001111100000000000011";
		B<="10000000000000000000000000000000";
		op<="0000";
		wait for 50 ns;
		
		--add 3 
		A<="11111111111111111111111111111111";
		B<="11111111111111111111111111111111";
		op<="0000";
		wait for 50 ns;
		
		--sub 1 
		A<="00000000000000000000000000000011";
		B<="00000000000000000000000000000001";
		op<="0001";
		wait for 50 ns;
		
		--sub 2 
		A<="01111111111111111111111111111111";
		B<="11111111111111111111111111111111";
		op<="0001";
		wait for 50 ns;
		
		--sub 3 
		A<="10000000000000000000000000000000";
		B<="01111111111111111111111111111111";
		op<="0001";
		wait for 50 ns;
		
		--AND
		A<="11111111111111111111111111111111";
		B<="11100010011000001100001110000101";
		op<="0010";
		wait for 50 ns;
		
		--OR
		A<="11111111111111111111111111111111";
		B<="11100010011000001100001110000101";
		op<="0011";
		wait for 50 ns;
		
		--NOT A
		A<="01111000110101000000011100010011";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		op<="0100";
		wait for 50 ns;
		
		--NAND
		A<="11111111111111111111111111111111";
		B<="11100010011000001100001110000101";
		op<="0101";
		wait for 50 ns;
     
		--NOR
		A<="11111111111111111111111111111111";
		B<="11100010011000001100001110000101";
		op<="0110";
		wait for 50 ns;
		
		-- Shift right arithmetic MSB 1 A
		A<="11111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		op<="1000";
		wait for 50 ns;
		
		-- Shift right arithmetic MSB 0 A
		A<="01111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		op<="1000";
		wait for 50 ns;
		
		-- Shift right logical A
		A<="01111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		op<="1001";
		wait for 50 ns;
		
		-- Shift left logical A
		A<="01111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		op<="1010";
		wait for 50 ns;
		
		--Rotate left A
		A<="01111000110101000000011100010011";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		op<="1100";
		wait for 50 ns;
		
		--Rotate right A
		A<="11111000110101000000011100010010";
		B<="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU";
		op<="1101";
		wait for 50 ns;
		
      wait;
   end process;

END;
