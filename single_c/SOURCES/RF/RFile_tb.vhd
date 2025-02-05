--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:50:02 04/12/2020
-- Design Name:   
-- Module Name:   /home/beef/MyCode/RFile_tb.vhd
-- Project Name:  MyCode
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RFile
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
use work.myPackage.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RFile_tb IS
END RFile_tb;
 
ARCHITECTURE behavior OF RFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RFile
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
         Rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RFile PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
          Rst => Rst
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		Rst <= '1';
		wait for 150 ns;
		Rst <= '0';
		Din <= "11111111100000000000000000000001";
		Awr <= "00000";
		WrEn <= '1';
		wait for 150 ns;
      Din <= "11111111100000000000000000000001";
		Awr <= "00101";
		WrEn <= '1';
		wait for 150 ns;
		Din <= "00000000011111111111111111111111";
		Awr <= "11010";
		WrEn <= '0';
		wait for 150 ns;
		Din <= "00000000010000000000000000000001";
		Awr <= "11111";
		wait for 10 ns;
		WrEn <= '1';
		wait for 150 ns;
		Ard1 <= "00101";
		Ard2 <= "11111";
		wait for 150 ns;
		end process;
END;
