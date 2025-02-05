----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:06:18 04/26/2020 
-- Design Name: 
-- Module Name:    CONTROL - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CONTROL is
	PORT (  Clock: in  STD_LOGIC;
			  Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
			  Reset : in  STD_LOGIC;
			  brflag : in STD_LOGIC;
           PC_sel : out  STD_LOGIC;
           RF_WrEn : out  STD_LOGIC;
           RF_WrData_sel : out  STD_LOGIC;
           RF_B_sel : out  STD_LOGIC;
           ALU_Bin_sel : out  STD_LOGIC;
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WrEn : out  STD_LOGIC;
			  Byte_Op : out STD_LOGIC;
			  ImmExt_s : out STD_LOGIC_VECTOR (1 downto 0)
			  );
end CONTROL;

architecture Behavioral of CONTROL is

		TYPE state IS (START, RTYPE, LI,LUI,ADDI,NANDI,ORI, BRANCH, SW, SB, LW, LB, BEQ, BNE, ZEROS1, ZEROS0);
		SIGNAL State1, State2: state;
			
signal OpCode : STD_LOGIC_VECTOR(5 downto 0);	
signal func : STD_LOGIC_VECTOR(3 downto 0);	
		
begin
OpCode <= Instruction(31 downto 26);
func <= Instruction(3 downto 0);

rst:	process(Instruction,Clock,Reset)		
begin
		IF (Reset='1') THEN State1 <= START;
		elsif state2 /= state1 then state1<=state2;
		END IF;
		
		end process;
		
		states: process(State1,OpCode,func)
		begin
			case State1 is
			when START =>
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
						
			when RTYPE=> 
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;

			when LUI=> 
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;

			when ADDI=> 		
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
						
			when NANDI=> 						
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;

			when ORI=> 						
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
			
			when BRANCH=>						
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
	
			when BEQ=> 
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
						
		   when BNE=>
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;

			when LB=>						
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
			
			when SB=>						
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
			
			when LW=>						
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
			
			when SW=>						
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=SW;
						elsif OpCode="001111" then State2<=LW;
						elsif OpCode="000111" then State2<=SB;
						elsif OpCode="000011" then State2<=LB;
						else State2<=START;
						end if;
			
			when others=> State2 <= START;
			end case;
			
		end process;
		
		OUTS: process(State1,State2,brflag)
		begin
			case State1 is
			
			when START=>
			  PC_sel <='0';
           RF_B_sel <='0';
           RF_WrEn <='0';
           RF_WrData_sel <='0';
           ALU_Bin_sel <='0';
           ALU_func <="0000";
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="XX";
						
			when RTYPE=>
			  PC_sel <='0';
           RF_B_sel <='0'; --rt
           RF_WrEn <='1';
           RF_WrData_sel <='0'; --ALU
           ALU_Bin_sel <='0';
           ALU_func <=func;
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="XX";
			  
			when LI=> 
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='1';
           RF_WrData_sel <='0';
			  ALU_Bin_sel <='1'; --Immed
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="00";
			  
			  when LUI=> 
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='1';
           RF_WrData_sel <='0';
			  ALU_Bin_sel <='1';
			  ALU_func <="0000"; --add
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="10";
			  
			  when ADDI=> 
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='1';
           RF_WrData_sel <='0';
			  ALU_Bin_sel <='1';
			  ALU_func <="0000";
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="00";
			  
			  when NANDI=> 
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='1';
           RF_WrData_sel <='0';
			  ALU_Bin_sel <='1';
			  ALU_func <="0010";
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="01";--zerofill
			  
			  when ORI=> 
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='1';
           RF_WrData_sel <='0';
			  ALU_Bin_sel <='1';
			  ALU_func <="0011";
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="01";
			  
			  when BRANCH=>
			  PC_sel <='1';
           RF_B_sel <='0';
           RF_WrEn <='0';
           RF_WrData_sel <='0';
           ALU_Bin_sel <='0';
           ALU_func <="0000";
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="11";
			  
			  when BEQ=>
			  PC_sel <= brflag;
           RF_B_sel <='1';
           RF_WrEn <='0';
           RF_WrData_sel <='0';
           ALU_Bin_sel <='0';
           ALU_func <="0001";
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="11";
			
		   when BNE=>
			  PC_sel <= not brflag;
           RF_B_sel <='1';
           RF_WrEn <='0';
           RF_WrData_sel <='0';
           ALU_Bin_sel <='0';
           ALU_func <="0001";
           Mem_WrEn <='0';
			  Byte_Op <= 'X';
			  ImmExt_s <="11";
			
			when LB=>
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='1';
           RF_WrData_sel <='1';
           ALU_Bin_sel <='1';
           ALU_func <="0000";
           Mem_WrEn <='0';
			  Byte_Op <= '1';
			  ImmExt_s <="00";
			  
			when SB=>
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='0';
           RF_WrData_sel <='0';
           ALU_Bin_sel <='1';
           ALU_func <="0000";
           Mem_WrEn <='1';
			  Byte_Op <= '1';
			  ImmExt_s <="00";
			
			when LW=>
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='1';
           RF_WrData_sel <='1';
           ALU_Bin_sel <='1';
           ALU_func <="0000";
           Mem_WrEn <='0';
			  Byte_Op <= '0';
			  ImmExt_s <="00";
			
			when SW=>
			  PC_sel <='0';
           RF_B_sel <='1';
           RF_WrEn <='0';
           RF_WrData_sel <='0';
           ALU_Bin_sel <='1';
           ALU_func <="0000";
           Mem_WrEn <='1';
			  Byte_Op <= '0';
			  ImmExt_s <="00";
			  
			when others=> 
			  PC_sel <='0';
           RF_B_sel <='0';
           RF_WrEn <='0';
           RF_WrData_sel <='0';
           ALU_Bin_sel <='0';
           ALU_func <="0000";
           Mem_WrEn <='0';
			end case;
		end process;

end Behavioral;

