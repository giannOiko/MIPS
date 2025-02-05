--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:47:33 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/DECODER_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
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
 
ENTITY DECODER_tb IS
END DECODER_tb;
 
ARCHITECTURE behavior OF DECODER_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         awr : IN  std_logic_vector(4 downto 0);
         outt : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal awr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal outt : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          awr => awr,
          outt => outt
        );

   -- Clock process definitions
 

   -- Stimulus process
   stim_proc: process
   begin		
      awr <= "00000";
      wait for 50 ns;
		awr <= "00001";
      wait for 50 ns;
		awr <= "00010";
      wait for 50 ns;
		awr <= "00011";
      wait for 50 ns;
		awr <= "00100";
      wait for 50 ns;
		awr <= "00101";
      wait for 50 ns;
		awr <= "00110";
      wait for 50 ns;
		awr <= "00111";
      wait for 50 ns;
		awr <= "01000";
      wait for 50 ns;
		awr <= "01001";
      wait for 50 ns;
		awr <= "01010";
      wait for 50 ns;
		awr <= "01011";
      wait for 50 ns;
		awr <= "01100";
      wait for 50 ns;
		awr <= "01101";
      wait for 50 ns;
		awr <= "01110";
      wait for 50 ns;
		awr <= "01111";
      wait for 50 ns;
		awr <= "10000";
      wait for 50 ns;
		awr <= "10001";
      wait for 50 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
