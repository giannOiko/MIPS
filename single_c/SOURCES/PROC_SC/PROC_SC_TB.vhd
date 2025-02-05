--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:47:44 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/PROC_SC_TB.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PROC_SC
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
 
ENTITY PROC_SC_TB IS
END PROC_SC_TB;
 
ARCHITECTURE behavior OF PROC_SC_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PROC_SC
    PORT(
         CLOCK : IN  std_logic;
         RESET : IN  std_logic;
         PC_LD_EN : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLOCK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal PC_LD_EN : std_logic := '0';

   -- Clock period definitions
   constant CLOCK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PROC_SC PORT MAP (
          CLOCK => CLOCK,
          RESET => RESET,
          PC_LD_EN => PC_LD_EN
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
      RESET <= '1';
      wait for 100 ns;
		RESET <= '0';
		
		PC_LD_EN <= '1';
      

      -- insert stimulus here 

      wait;
   end process;

END;
