--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:21:54 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/ADDIM_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Adder_Immed
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ADDIM_tb IS
END ADDIM_tb;
 
ARCHITECTURE behavior OF ADDIM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder_Immed
    PORT(
         SE_PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_4 : IN  std_logic_vector(31 downto 0);
         Adder_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SE_PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_4 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Adder_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder_Immed PORT MAP (
          SE_PC_Immed => SE_PC_Immed,
          PC_4 => PC_4,
          Adder_out => Adder_out
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      SE_PC_Immed <= "00000000000000000000111111111100";
		PC_4 <= "00000000000000000000000000000110";
      wait for 100 ns;	

      -- insert stimulus here 

      wait;
   end process;

END;
