--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:54:51 04/27/2020
-- Design Name:   
-- Module Name:   /home/beef/MyProject/Datapath1_tb.vhd
-- Project Name:  MyProject
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Datapath
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
 
ENTITY Datapath1_tb IS
END Datapath1_tb;
 
ARCHITECTURE behavior OF Datapath1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Datapath
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         RF_WrEn : IN  std_logic;
         RF_WrDatasel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt_s : IN  std_logic_vector(1 downto 0);
         PCsel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         ALU_Binsel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         MEM_WrEn : IN  std_logic;
         Byte_Op : IN  std_logic;
         Instruction : OUT  std_logic_vector(31 downto 0);
         bflag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal RF_WrEn : std_logic := '0';
   signal RF_WrDatasel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt_s : std_logic_vector(1 downto 0) := (others => '0');
   signal PCsel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal ALU_Binsel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal MEM_WrEn : std_logic := '0';
   signal Byte_Op : std_logic := '0';

 	--Outputs
   signal Instruction : std_logic_vector(31 downto 0);
   signal bflag : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Datapath PORT MAP (
          CLK => CLK,
          RST => RST,
          RF_WrEn => RF_WrEn,
          RF_WrDatasel => RF_WrDatasel,
          RF_B_sel => RF_B_sel,
          ImmExt_s => ImmExt_s,
          PCsel => PCsel,
          PC_LdEn => PC_LdEn,
          ALU_Binsel => ALU_Binsel,
          ALU_func => ALU_func,
          MEM_WrEn => MEM_WrEn,
          Byte_Op => Byte_Op,
          Instruction => Instruction,
          bflag => bflag
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
      -- hold reset state for 100 ns.
    
		
		RST <= '1';
		wait for 100 ns;
		  -- addi r5,r0,8
		RST <= '0';
		PCsel <='0'; 
		PC_LdEn<='1'; 
		RF_WrEn <='1';
		RF_WrDatasel <='0'; --Alu out 
		RF_B_sel  <='1';
		ImmExt_s<="00";  -- SIGN EXT
		ALU_Binsel <='1';  --Immed
		ALU_func <="0000"; --add			
		MEM_WrEn  <='0';
		Byte_Op <= 'X';
		wait for clk_period*1;
		
		--ori r3,r0,ABCD]
		
		PCsel <='0'; 			
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrDatasel <='0'; --Alu out 
		RF_B_sel  <='1';
		ImmExt_s<="01"; --zero fill
		ALU_Binsel <='1';  --Immed
		ALU_func <="0011"; --OR			
		MEM_WrEn  <='0';
		Byte_Op <= 'X';
		wait for clk_period*1;
		
		 --sw r3 4(r0)
		
		PCsel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='0';
		RF_WrDatasel <='0'; --Mem out dont care
		RF_B_sel  <='1';
		ImmExt_s<="00";
		ALU_Binsel <='1';  --Immed
		ALU_func  <="0000";	--add	
		MEM_WrEn  <='1';
		Byte_Op   <='0';
		wait for clk_period*1;

		--lw r10,-4(r5)
		 
		PCsel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrDatasel <='1'; --Mem out 
		RF_B_sel  <='1';
		ImmExt_s<="00";
		ALU_Binsel <='1';  --Immed
		ALU_func  <="0000";--add		
		MEM_WrEn  <='0'; 
		Byte_Op   <='0';
		wait for clk_period*1;
		
		-- lb r16 4(r0)
		
		PCsel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrDatasel <='1'; --Mem out 
		RF_B_sel  <='1';
		ImmExt_s<="00";
		ALU_Binsel <='1';  --Immed
		ALU_func  <="0000"; --add		
		MEM_WrEn  <='0';
		Byte_Op   <='1';

		wait for clk_period*1;
		
		-- nand r4,r0,r16
		PCsel <='0'; 
		PC_LdEn <='1'; 
		RF_WrEn <='1';
		RF_WrDatasel <='0'; --Mem out 
		RF_B_sel  <='0'; --rt
	   ImmExt_s<="XX"; -- dont care
	   ALU_Binsel <='0';  --RF_B
	   ALU_func  <="0101"; --nand		
		MEM_WrEn  <='0'; 
		
		wait for clk_period*1;
		
		-- bne r5, r5, 8
		bflag <= '1';
		PCsel <= not bflag;
		PC_LdEn <='1';
	   RF_WrEn <='0';
		RF_WrDatasel <='0';
      RF_B_sel <='1';
		ImmExt_s <="11";
      ALU_Binsel <='0';
	   ALU_func <="0001";
		Mem_WrEn <='0';
	   Byte_Op <= 'X';
		
		wait for clk_period*1;

		-- b -2
		PCsel <='1';
		PC_LdEn <='1';
		RF_WrEn <='0';
		RF_WrDatasel <='0';
      RF_B_sel <='0';
      ImmExt_s <="11"; 
      ALU_Binsel <='0';
      ALU_func <="0000";
      Mem_WrEn <='0';
	   Byte_Op <= 'X';
	   
		wait for clk_period*1;
    
		-- addi r1, r0, 1
		PCsel <='0';
		PC_LdEn <='1';
		RF_WrEn <='1';
		RF_WrDatasel <='0';
      RF_B_sel <='1';
      ImmExt_s <="00"; 
	   ALU_Binsel <='1';
	   ALU_func <="0000";
      Mem_WrEn <='0';
	   Byte_Op <= 'X';
			  
      wait;
   end process;

END;
