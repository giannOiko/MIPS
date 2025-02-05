----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:18:33 05/19/2020 
-- Design Name: 
-- Module Name:    CONTROL_MC - Behavioral 
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

entity CONTROL_MC is
	PORT (  Clock: in  STD_LOGIC;
			  Instruction : in  STD_LOGIC_VECTOR (31 downto 0);
			  Reset : in  STD_LOGIC;
			  brflag : in STD_LOGIC;
           PC_sel : out  STD_LOGIC;
			  PC_LdEn : out STD_LOGIC;
			  RF_WrEn : out  STD_LOGIC;
           RF_WrDatasel : out  STD_LOGIC;
           RF_B_sel :out  STD_LOGIC;
           ALUSrcA: out  STD_LOGIC;
			  ALUSrcB: out  STD_LOGIC_VECTOR(1 downto 0);
           ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
           Mem_WrEn : out  STD_LOGIC;
			  Byte_Op : out STD_LOGIC;
			  IRWrite : out STD_LOGIC;
			  AWrite : out STD_LOGIC;
			  BWrite : out STD_LOGIC;
			  RMEMWrite : out STD_LOGIC;
			  ALUWrite : out STD_LOGIC
			  
			  );
end CONTROL_MC;

architecture Behavioral of CONTROL_MC is
		TYPE state IS (START, START1, RTYPE, RTYPE1, RTYPE2, LI, LUI, ADDI, NANDI, ORI, I1, I2, LOAD, LOAD1, LOAD2, LOAD3, STORE, STORE1, STORE2, BRANCH, BEQ, BEQ1, BEQ2, BNE, BNE1, BNE2, ZEROS1);
							
		SIGNAL State1, State2: state;
			

signal OpCode : STD_LOGIC_VECTOR(5 downto 0);	
signal func : STD_LOGIC_VECTOR(3 downto 0);	
		
begin
OpCode <= Instruction(31 downto 26);
func <= Instruction(3 downto 0);

process(OpCode) begin
if (OpCode = "000011" or OpCode = "000111") then
	Byte_Op <= '1';
else 
	Byte_Op <= '0';
end if;
end process;

rst:	process(Clock,Reset)		
begin
		IF (Reset='1') THEN State1 <= START;
		elsif (rising_edge(Clock)) then State1<=State2;
		END IF;
end process;
		
		states: process(State1,OpCode,func)
		begin
			case State1 is
			when START => State2<= START1;
			
			when START1 =>
						if OpCode="100000" then State2<=RTYPE;
						elsif OpCode="111111" then State2<=BRANCH;
						elsif OpCode="000000" then State2<=BEQ;
						elsif OpCode="000001" then State2<=BNE;
						elsif OpCode="111000" then State2<=LI;
						elsif OpCode="111001" then State2<=LUI;
						elsif OpCode="110000" then State2<=ADDI; 
						elsif OpCode="110010" then State2<=NANDI; 
						elsif OpCode="110011" then State2<=ORI;
						elsif OpCode="011111" then State2<=STORE;
						elsif OpCode="001111" then State2<=LOAD;
						elsif OpCode="000111" then State2<=STORE;
						elsif OpCode="000011" then State2<=LOAD;
						else State2<=START;
						end if;
			
						
		  when RTYPE => State2<=RTYPE1;
		  when RTYPE1 => State2<=RTYPE2;
		  when RTYPE2 => State2<=START;
					  
	
		  
		  when  LI => State2 <= I1;
		  when  LUI => State2 <= I1;
		  when  ADDI => State2 <= I1;
		  when  NANDI => State2 <= I1;
		  when  ORI => State2 <= I1;
		  
		  when I1 => State2 <= I2;
		  when I2 => State2 <= START;
	
	     when LOAD => State2 <= LOAD1;
	     when LOAD1 => State2 <= LOAD2;
	     when LOAD2 => State2 <= LOAD3;
	     when LOAD3 => State2 <= START;
	     
	
	     when STORE => State2 <= STORE1;
	     when STORE1 => State2 <= STORE2;
	     when STORE2 => State2 <= START;
	
	     when BRANCH => State2 <= START;
	
	     when BEQ => State2 <= BEQ1;
		  when BEQ1 => State2 <= BEQ2;
	     when BEQ2 => if (brflag='1') then
								STATE2<= ZEROS1;
							elsif (brflag='0') then STATE2<=START;
							else STATE2<=START;
							end if;
	
	     when BNE => State2 <= BNE1;	
	     when BNE1 => State2 <= BNE2;
		  when BNE2 => if (brflag='1') then
								STATE2<= START;
							elsif (brflag='0') then STATE2<=ZEROS1;
							else STATE2<=START;
							end if;
	
	     when ZEROS1 => State2 <= START;
	     when others => State2 <= START;
	
	     end case;
			
			
			
		end process;
		
		OUTS: process(State1,State2,brflag)
		begin
			case State1 is
			
			when START=>
			  PC_sel <= '0';
			  PC_LdEn <= '1';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '0';
           ALUSrcA <= '0';
			  ALUSrcB <= "01";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '1';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			 when START1=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '0';
           ALUSrcA <= 'X';
			  ALUSrcB <= "XX";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
						
			when RTYPE=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '1';
           RF_WrDatasel <= '0';
           RF_B_sel <= '0';
           ALUSrcA <= '1';
			  ALUSrcB <= "00";
           ALU_func <= func;
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '1';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			 
			 when RTYPE1=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '1';
           RF_WrDatasel <= '0';
           RF_B_sel <= '0';
           ALUSrcA <= '1';
			  ALUSrcB <= "00";
           ALU_func <= func;
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '1';
			  
			 when RTYPE2=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '1';
           RF_WrDatasel <= '0';
           RF_B_sel <= '0';
           ALUSrcA <= '1';
			  ALUSrcB <= "00";
           ALU_func <= func;
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			when LI=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			 when LUI=> 
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			 when ADDI=> 
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			 when NANDI=> 
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '1';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0101";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			 when ORI=> 
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0011";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			  when I1=> 
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '0';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '1';
			  
			when I2=> 
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '1';
           RF_WrDatasel <= '0';
           RF_B_sel <= '0';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			 
			 when BRANCH=>
			  PC_sel <= '0';
			  PC_LdEn <= '1';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '0';
           ALUSrcA <= '0';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			 when BEQ=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '0';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '1'; 
			  
			 when BEQ1=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "00";
           ALU_func <= "0001";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '1';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			  when BEQ2=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "00";
           ALU_func <= "0001";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '1';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			
		   when BNE=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '0';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '1';
			 
			 when BNE1=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "00";
           ALU_func <= "0001";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '1';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			  when BNE2=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "00";
           ALU_func <= "0001";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '1';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			
			when LOAD=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '1';
           RF_WrDatasel <= '1';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '0';
			  RMEMWrite <= '1';
			  ALUWrite <= '0';
			  
			when LOAD1=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '1';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '1';
			  ALUWrite <= '1';
			
			when LOAD2=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '1';
           RF_WrDatasel <= '1';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '1';
			  ALUWrite <= '0';
			  
			when LOAD3=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '1';
           RF_WrDatasel <= '1';
           RF_B_sel <= '1';
           ALUSrcA <= '0';
			  ALUSrcB <= "00";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '1';
			  ALUWrite <= '0';
			
			
			when STORE=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '1';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '1';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '1';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			when STORE1=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '1';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '1';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '1';
			  RMEMWrite <= '0';
			  ALUWrite <= '1';
			 
			when STORE2=>
			  PC_sel <= '0';
			  PC_LdEn <= '0';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '1';
           RF_B_sel <= '1';
           ALUSrcA <= '1';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '1';
			  IRWrite <= '0';
			  AWrite <= '1';
			  BWrite <= '1';
			  RMEMWrite <= '0';
			  ALUWrite <= '1';
			  
			when ZEROS1=>
			  PC_sel <= '1';
			  PC_LdEn <= '1';
			  RF_WrEn <= '0';
           RF_WrDatasel <= '0';
           RF_B_sel <= '1';
           ALUSrcA <= '0';
			  ALUSrcB <= "10";
           ALU_func <= "0000";
           Mem_WrEn <= '0';
			  IRWrite <= '0';
			  AWrite <= '0';
			  BWrite <= '0';
			  RMEMWrite <= '0';
			  ALUWrite <= '0';
			  
			end case;
		end process;

end Behavioral;

