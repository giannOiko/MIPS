--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:23:43 05/19/2020
-- Design Name:   
-- Module Name:   /home/beef/test/PROC_MC_TB.vhd
-- Project Name:  test
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROC_MC
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
 
ENTITY PROC_MC_TB IS
END PROC_MC_TB;
 
ARCHITECTURE behavior OF PROC_MC_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROC_MC
    PORT(
         CLOCK : IN  std_logic;
         RESET : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';

   -- Clock period definitions
   constant CLOCK_period : time := 30 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROC_MC PORT MAP (
          CLOCK => CLOCK,
          RESET => RESET
        );

   -- Clock process definitions
   CLOCK_process :process
   begin
		CLOCK <= '0';
		wait for CLOCK_period/2;
		CLOCK <= '1';
		wait for CLOCK_period/2;
   end process;
 

   -- Stimulus process
  stim_proc: process
   begin		
		RESET <= '1'; -- hold reset state for 100 ns.	

      wait for CLOCK_period*1;
		RESET <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
