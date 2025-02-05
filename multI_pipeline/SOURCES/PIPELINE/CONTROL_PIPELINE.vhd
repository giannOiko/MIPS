library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTROL_PIPELINE is
    Port (
				Instruction : in STD_LOGIC_VECTOR (31 downto 0);
				controlFlag : in STD_LOGIC;
				equal : in STD_LOGIC;
				
			  --IFSTAGE
				PC_sel : out  STD_LOGIC;

			  --DECSTAGE
				RF_WrEn : out  STD_LOGIC;
				RF_WrData_sel : out  STD_LOGIC;
				RF_B_sel : out  STD_LOGIC;
			 
			  --ALUSTAGE
				ALU_Bin_sel : out  STD_LOGIC;
				ALU_func : out  STD_LOGIC_VECTOR (3 downto 0);
			  --MEMSTAGE
			   byteOp : out  STD_LOGIC;
				Mem_WrEn : out  STD_LOGIC
				);
end CONTROL_PIPELINE;

architecture Behavioral of CONTROL_PIPELINE is
signal OpCode : STD_LOGIC_VECTOR (5 downto 0);		
signal func : 	STD_LOGIC_VECTOR (3 downto 0);
	
begin
	process(Instruction)
	begin
	OpCode <= Instruction(31 downto 26);
	func <= Instruction(3 downto 0);
	end process;
	
	process(Opcode, func,controlFlag)
	
	begin
		if(controlFlag = '0') then 
			if (OpCode = "100000") then --RTYPE
				PC_sel <='0';
				RF_B_sel <='0'; 
				RF_WrEn <='1';
				RF_WrData_sel <='0'; 
				ALU_Bin_sel <='0';
				ALU_func <=func;
				Mem_WrEn <='0';
				byteOp <= 'X';
	
			elsif (OpCode = "111000") then --li
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='1';
				RF_WrData_sel <='0';
				ALU_func <="0000"; --add
				ALU_Bin_sel <='1'; --Immed
				Mem_WrEn <='0';
				byteOp <= 'X';
			
			elsif (OpCode = "111001") then --lui
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='1';
				RF_WrData_sel <='0';
				ALU_func <="0000"; --add
				ALU_Bin_sel <='1';	
				Mem_WrEn <='0';
				byteOp <= 'X';
			
			elsif (OpCode = "110000") then --addi
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='1';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='1';
				ALU_func <="0000";
				Mem_WrEn <='0';
				byteOp <= 'X';
			
			elsif (OpCode = "110010") then --nandi
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='1';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='1';
				ALU_func <="0101";
				Mem_WrEn <='0';
				byteOp <= 'X';
				
			elsif (OpCode = "110011") then --ori
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='1';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='1';
				ALU_func <="0011";
				Mem_WrEn <='0';
				byteOp <= 'X';
			
			elsif (OpCode = "000011") then --lb
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='1';
				RF_WrData_sel <='1';
				ALU_Bin_sel <='1';
				ALU_func <="0000";
				Mem_WrEn <='0';
				byteOp <= '1';
		
			elsif (OpCode = "001111") then --lw
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='1';
				RF_WrData_sel <='1';
				ALU_Bin_sel <='1';
				ALU_func <="0000";
				Mem_WrEn <='0';
				byteOp <= '0';

			elsif (OpCode = "000111") then --sb
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='0';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='1';
				ALU_func <="0000";
				Mem_WrEn <='1';
				byteOp <= '1';
				
			elsif (OpCode = "011111") then --sw
				PC_sel <='0';
				RF_B_sel <='1';
				RF_WrEn <='0';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='1';
				ALU_func <="0000";
				Mem_WrEn <='1';
				byteOp <= '0';
				
			elsif (OpCode = "111111") then --b
				PC_sel <='1';
				RF_B_sel <='1';
				RF_WrEn <='0';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='1';
				ALU_func <="0000";
				Mem_WrEn <='0';
				byteOp <= 'X';
				
			elsif (OpCode = "000000") then --beq
				if (equal = '1') then
					PC_sel <='1';
				else
					PC_sel <='0';
				end if;
				RF_B_sel <='1';
				RF_WrEn <='0';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='1';
				ALU_func <="0000";
				Mem_WrEn <='0';
				byteOp <= 'X';
				
			elsif (OpCode = "000001") then --bne
			if (equal = '1') then
					PC_sel <='0';
				else
					PC_sel <='1';
				end if;
				RF_B_sel <='1';
				RF_WrEn <='0';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='1';
				ALU_func <="0000";
				Mem_WrEn <='0';
				byteOp <= 'X';
				
			else
				PC_sel <='0';
				RF_B_sel <='0';
				RF_WrEn <='0';
				RF_WrData_sel <='0';
				ALU_Bin_sel <='0';
				ALU_func <="0000";
				Mem_WrEn <='0';
				byteOp <= '0';
				
		end if;
		
	else
			PC_sel <='0';
			RF_B_sel <='0';
			RF_WrEn <='0';
			RF_WrData_sel <='0';
			ALU_Bin_sel <='0';
			ALU_func <="0000";
			Mem_WrEn <='0';
			byteOp <= '0';
			
		end if;
	end process;
	
end Behavioral;