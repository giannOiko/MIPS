--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   04:16:05 04/26/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/IFTAGE_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IFSTAGE
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
 
ENTITY IFTAGE_tb IS
END IFTAGE_tb;
 
ARCHITECTURE behavior OF IFTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         CLK : IN  std_logic;
         inst_dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal inst_dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          CLK => CLK,
          inst_dout => inst_dout
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
		
		Reset<='1';
		wait for 100 ns;	
		Reset<='0';
		PC_LdEn<='1';
      PC_sel<='0';
		wait for 100 ns;
		PC_LdEn<='1';
      PC_sel<='0';
		wait for 100 ns;
		PC_LdEn<='1';
      PC_sel<='0';
		wait for 100 ns;
		PC_LdEn<='0';
      PC_sel<='0';
		wait for 100 ns;
		Reset <= '1';
		wait for 100 ns;
		Reset <= '0';
		PC_Immed <= "00000000000000000000000000000000";
		PC_LdEn<='1';
      PC_sel<='1';
		wait for 100 ns;
		PC_Immed <= "00000000000000000000000000001000";
		PC_LdEn<='1';
      PC_sel<='1';
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
