--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:13:21 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/IFSEGMENT_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IF_segment
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
 
ENTITY IFSEGMENT_tb IS
END IFSEGMENT_tb;
 
ARCHITECTURE behavior OF IFSEGMENT_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IF_segment
    PORT(
         PC_Imm : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         CLK : IN  std_logic;
         PC : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Imm : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal PC : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IF_segment PORT MAP (
          PC_Imm => PC_Imm,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          CLK => CLK,
          PC => PC
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Reset <= '1';
		PC_Imm <= "00000000000000000000000011100101";
      wait for 100 ns;	
		Reset <= '0';
		PC_LdEn <= '1';
		PC_sel <= '0';
      wait for CLK_period*10;
		PC_sel <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
