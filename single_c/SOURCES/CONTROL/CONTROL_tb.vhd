--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:22:14 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/CONTROL_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CONTROL
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
 
ENTITY CONTROL_tb IS
END CONTROL_tb;
 
ARCHITECTURE behavior OF CONTROL_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CONTROL
    PORT(
         Clock : IN  std_logic;
         Instruction : IN  std_logic_vector(31 downto 0);
         Reset : IN  std_logic;
         brflag : IN  std_logic;
         PC_sel : OUT  std_logic;
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         Mem_WrEn : OUT  std_logic;
         Byte_Op : OUT  std_logic;
         ImmExt_s : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Instruction : std_logic_vector(31 downto 0) := (others => '0');
   signal Reset : std_logic := '0';
   signal brflag : std_logic := '0';

 	--Outputs
   signal PC_sel : std_logic;
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal Mem_WrEn : std_logic;
   signal Byte_Op : std_logic;
   signal ImmExt_s : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CONTROL PORT MAP (
          Clock => Clock,
          Instruction => Instruction,
          Reset => Reset,
          brflag => brflag,
          PC_sel => PC_sel,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          Mem_WrEn => Mem_WrEn,
          Byte_Op => Byte_Op,
          ImmExt_s => ImmExt_s
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      Reset <= '1';
      wait for 20 ns;	
		Reset <= '0';
		--add
		Instruction <= "10000000000000000000000000110000";
		wait for 20 ns;
		
		--sub
		Instruction <= "10000000000000000000000000110001";
		wait for 20 ns;
		
		--and
		Instruction <= "10000000000000000000000000110010";
		wait for 20 ns;
		
		--or
		Instruction <= "10000000000000000000000000110011";
		wait for 20 ns;
		
		--not
		Instruction <= "10000000000000000000000000110100";
		wait for 20 ns;
		
		--li
		Instruction <= "11100000000000000000000000000000";
		wait for 20 ns;
		
		--nand
		Instruction <= "10000000000000000000000000110101";
		wait for 20 ns;
		
		--nor
		Instruction <= "10000000000000000000000000110110";
		wait for 20 ns;
		
		--sra
		Instruction <= "10000000000000000000000000111000";
		wait for 20 ns;
		
		--srl
		Instruction <= "10000000000000000000000000111001";
		wait for 20 ns;
		
		--sll
		Instruction <= "10000000000000000000000000111010";
		wait for 20 ns;
		
		--rol
		Instruction <= "10000000000000000000000000111100";
		wait for 20 ns;
		
		--ror
		Instruction <= "10000000000000000000000000111101";
		wait for 20 ns;
		
		--lui
		Instruction <= "11100100000000000000000000000000";
		wait for 20 ns;
		
		--addi
		Instruction <= "11000000000000000000000000000000";
		wait for 50 ns;
		
		--nandi
		Instruction <= "11001000000000000000000000000000";
		wait for 20 ns;
		
		--ori
		Instruction <= "11001100000000000000000000000000";
		wait for 20 ns;
		
		--branch
		Instruction <= "11111100000000000000000000000000";
		wait for 50 ns;
		
		--beq1
		Instruction <= "00000000000000000000000000000000";
		brflag <= '1';
		wait for 50 ns;
		
		--bne1
		Instruction <= "00000100000000000000000000000000";
		brflag <= '1';
		wait for 50 ns;
		
		--beq0
		Instruction <= "00000000000000000000000000000000";
		brflag <= '0';
		wait for 50 ns;
		
		--bne0
		Instruction <= "00000100000000000000000000000000";
		brflag <= '0';
		wait for 50 ns;
		
		--lb
		Instruction <= "00001100000000000000000000000000";
		wait for 50 ns;
		
		--sb
		Instruction <= "00011100000000000000000000000000";
		wait for 50 ns;
		
		--lw
		Instruction <= "00111100000000000000000000000000";
		wait for 50 ns;
		
		--sb
		Instruction <= "01111100000000000000000000000000";
		wait for 50 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
