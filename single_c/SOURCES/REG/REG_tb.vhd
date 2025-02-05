--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:15:01 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/REG_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Registerr
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
 
ENTITY REG_tb IS
END REG_tb;
 
ARCHITECTURE behavior OF REG_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Registerr
    PORT(
         RST : IN  std_logic;
         CLK : IN  std_logic;
         WE : IN  std_logic;
         Datain : IN  std_logic_vector(31 downto 0);
         Dataout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';
   signal WE : std_logic := '0';
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Registerr PORT MAP (
          RST => RST,
          CLK => CLK,
          WE => WE,
          Datain => Datain,
          Dataout => Dataout
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
      RST <= '1';
		Datain <= "00000000000000000000000101010101";
      wait for 100 ns;	
		RST <= '0';
		WE <= '1';
		
      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
