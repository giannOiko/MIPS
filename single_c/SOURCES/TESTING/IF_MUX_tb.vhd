--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:25:25 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/IF_MUX_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IF_Mux
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
 
ENTITY IF_MUX_tb IS
END IF_MUX_tb;
 
ARCHITECTURE behavior OF IF_MUX_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IF_Mux
    PORT(
         PC_4 : IN  std_logic_vector(31 downto 0);
         PC_Immed : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         Mux_outt : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_4 : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal Mux_outt : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IF_Mux PORT MAP (
          PC_4 => PC_4,
          PC_Immed => PC_Immed,
          sel => sel,
          Mux_outt => Mux_outt
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
      PC_4 <= "00000000000000000000000000000111";
		PC_Immed <= "00000000000000001111000000000111";
		sel <= '1';
      wait for 100 ns;	
		sel <= '0';
     

      -- insert stimulus here 

      wait;
   end process;

END;
