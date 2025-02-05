--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:18:31 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/ADDER4_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Adder_4
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
 
ENTITY ADDER4_tb IS
END ADDER4_tb;
 
ARCHITECTURE behavior OF ADDER4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Adder_4
    PORT(
         pc : IN  std_logic_vector(31 downto 0);
         pc_4 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal pc : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal pc_4 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Adder_4 PORT MAP (
          pc => pc,
          pc_4 => pc_4
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		pc <= "00000000000000000000000000000000";
		wait for 100 ns;
      pc <= "00000000000000000000000000001111";

      wait;
   end process;

END;
