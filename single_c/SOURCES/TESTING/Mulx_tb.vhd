--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:42:47 04/21/2020
-- Design Name:   
-- Module Name:   /home/beef/Decode/Mulx_tb.vhd
-- Project Name:  Decode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Mulx
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
 
ENTITY Mulx_tb IS
END Mulx_tb;
 
ARCHITECTURE behavior OF Mulx_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Mulx
    PORT(
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         outt : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';

 	--Outputs
   signal outt : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Mulx PORT MAP (
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          outt => outt
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      ALU_out <= "00000000001010101010101010101010";
		MEM_out <= "00000000000000000000000001111111";
		RF_WrData_sel <= '1';
      wait for 100 ns;
		RF_WrData_sel <= '0';
      wait for 100 ns;	
		


      -- insert stimulus here 

      wait;
   end process;

END;
