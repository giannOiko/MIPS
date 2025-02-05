--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:10:04 04/21/2020
-- Design Name:   
-- Module Name:   /home/beef/Decode/sign_extend_tb.vhd
-- Project Name:  Decode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sign_extend
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
 
ENTITY sign_extend_tb IS
END sign_extend_tb;
 
ARCHITECTURE behavior OF sign_extend_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sign_extend
    PORT(
         Instr_im : IN  std_logic_vector(15 downto 0);
         ImmExt : IN  std_logic_vector(1 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr_im : std_logic_vector(15 downto 0) := (others => '0');
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sign_extend PORT MAP (
          Instr_im => Instr_im,
          ImmExt => ImmExt,
          Immed => Immed
        );

   -- Clock process definitions
   

   -- Stimulus process
   stim_proc: process
   begin		
      Instr_im <= "1010101010101010";
		ImmExt <= "00";
      wait for 100 ns;
		ImmExt <= "01";
		wait for 100 ns;
		ImmExt <= "10";
		Instr_im <= "1101010101010101";
		wait for 100 ns;
		ImmExt <= "11";

     

      -- insert stimulus here 

      wait;
   end process;

END;
