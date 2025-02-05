--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:46:10 04/23/2020
-- Design Name:   
-- Module Name:   /home/beef/ALU/MEM_tb.vhd
-- Project Name:  ALU
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEM
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
 
ENTITY MEM_tb IS
END MEM_tb;
 
ARCHITECTURE behavior OF MEM_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEM
    PORT(
         Clk : IN  std_logic;
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '1');
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEM PORT MAP (
          Clk => Clk,
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          MEM_DataOut => MEM_DataOut
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
		 --sw 1024
      RF_A <= "00000000000000000000000000000000";
		RF_B <= "10101010101111111101000000000011";
		Immed <= "00000000000000000000000000000000";
		ALU_Bin_sel <= '1';
		
		ByteOp <= '0';
		Mem_WrEn <= '1';
		
		ALU_func <= "0000";
     wait for 100 ns;
		
		--lw 1024
		RF_A <= "00000000000000000000000000000000";
		RF_B <= "10101010101111111101000000000011";
		Immed <= "00000000000000000000000000000000";
		ALU_Bin_sel <= '1';
		
		Mem_WrEn <= '0';
		ByteOp <= '0';
		wait for 100 ns;
		
		--sb 1025
		RF_A <= "00000000000000000000000000000100";
		RF_B <= "00000000000000000001111111111111";
		Immed <= "00000000000000000000000000000000";
		ALU_Bin_sel <= '1';
		ALU_func <= "0000";
		ByteOp <= '0';
		Mem_WrEn <= '1';
		wait for 100 ns;
		
		--lb 1025
		RF_A <= "00000000000000000000000000000100";
		RF_B <= "00000000000000000001111111111111";
		Immed <= "00000000000000000000000000000000";
		ALU_Bin_sel <= '1';
		
		ByteOp <= '0';
		Mem_WrEn <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
