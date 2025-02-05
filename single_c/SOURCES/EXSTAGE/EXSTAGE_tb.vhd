--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:21:19 04/22/2020
-- Design Name:   
-- Module Name:   /home/beef/ALU/EXSTAGE_tb.vhd
-- Project Name:  ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXSTAGE
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
 
ENTITY EXSTAGE_tb IS
END EXSTAGE_tb;
 
ARCHITECTURE behavior OF EXSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic;
         ALU_cout : OUT  std_logic;
         ALU_ovfl : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   signal ALU_cout : std_logic;
   signal ALU_ovfl : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero,
          ALU_cout => ALU_cout,
          ALU_ovfl => ALU_ovfl
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      RF_A <= "11111111111111111111111111111111";
		RF_b <= "11111111111111111111111111111111";
		Immed <="10000000000000000000000000000000";
		ALU_Bin_sel <= '1';
		ALU_func <= "0000";
      wait for 100 ns;
		ALU_Bin_sel <= '0';


      -- insert stimulus here 

      wait;
   end process;

END;
