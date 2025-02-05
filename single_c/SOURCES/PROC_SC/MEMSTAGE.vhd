----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:57:32 04/23/2020 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEMSTAGE is
    Port ( ByteOp : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_WrEn : out  STD_LOGIC;
           MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
           MM_RdData : in  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

signal loadbytesignal : std_logic_vector(7 downto 0);
signal storebytesignal : std_logic_vector(7 downto 0);

begin 

process(MM_RdData , MEM_DataIn) begin

loadbytesignal <= std_logic_vector (MM_RdData(7 downto 0));
storebytesignal <= std_logic_vector (MEM_DataIn(7 downto 0));

end process;

process (ByteOp, Mem_WrEn , ALU_MEM_Addr) begin

MM_Addr <= ALU_MEM_Addr;

if ((ByteOp = '0') and (Mem_WrEn = '0')) then --lw
	
	MM_WrEn <= '0';
	MEM_DataOut <= MM_RdData after 10 ns;
elsif ((ByteOp = '0') and (Mem_WrEn = '1')) then --sw
	
	MM_WrEn <= '1';
	MM_WrData <= MEM_DataIn after 10 ns;
elsif ((ByteOp = '1') and (Mem_WrEn = '0')) then --lb
	
	MM_WrEn <= '0';
	MEM_DataOut <= std_logic_vector(resize(unsigned(loadbytesignal), 32));
elsif ((ByteOp = '1') and (Mem_WrEn = '1')) then --sb
	
	MM_WrEn <= '1';
	MM_WrData <= std_logic_vector(resize(unsigned(storebytesignal), 32));
else 
	MM_WrEn <= '0';
end if;
end process;
end Behavioral;

