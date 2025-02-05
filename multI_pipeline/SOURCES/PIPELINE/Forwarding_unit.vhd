library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Forwarding_unit is
Port (
			RF_WrEn_EXMEM: in STD_LOGIC;
			RF_WrEn_MEMWB: in STD_LOGIC;
			Rd_EXMEM: in STD_LOGIC_VECTOR(4 downto 0);
			OpCodeIDEX: in STD_LOGIC_VECTOR(5 downto 0);
			OpCodeEXMEM : in STD_LOGIC_VECTOR(5 downto 0);
			Rd_IDEX : in STD_LOGIC_VECTOR(4 downto 0);
			Rs_IDEX: in STD_LOGIC_VECTOR(4 downto 0);
			Rd_MEMWB: in STD_LOGIC_VECTOR(4 downto 0);
			Rt_IDEX: in STD_LOGIC_VECTOR(4 downto 0);
			ForwardA: out STD_LOGIC_VECTOR(1 downto 0);			
			ForwardB: out STD_LOGIC_VECTOR(1 downto 0);
			ForwardC: out STD_LOGIC_VECTOR(1 downto 0)
		);
end Forwarding_unit;

architecture Behavioral of Forwarding_unit is


signal tempA: STD_LOGIC_VECTOR(1 downto 0);			
signal tempB: STD_LOGIC_VECTOR(1 downto 0);
signal tempC: STD_LOGIC_VECTOR(1 downto 0);
begin

	process(OpCodeIDEX,OpCodeEXMEM, RF_WrEn_EXMEM, RF_WrEn_MEMWB, Rd_IDEX, Rd_EXMEM, Rs_IDEX, Rd_MEMWB, Rt_IDEX)
	begin	
	if(((OpCodeIDEX ="011111") or (OpCodeIDEX = "000111")) and ((OpCodeEXMEM ="001111") or (OpCodeEXMEM = "000011"))) then
			if (Rd_EXMEM /= "00000" and Rd_IDEX /= "00000" and Rd_EXMEM = Rd_IDEX) then
				tempC <= "11";
				tempA <= "00";
				tempB <= "00";
			else
				tempC <= "00";
				tempA <= "00";
				tempB <= "00";
			end if;
		elsif (OpCodeIDEX = "011111" or OpCodeIDEX = "000111") then
			if (Rd_EXMEM /= "00000" and Rd_IDEX /= "00000" and Rd_EXMEM = Rd_IDEX) then
				tempC <= "10";
				tempA <= "00";
				tempB <= "00";
			elsif (Rd_MEMWB /= "00000" and Rd_IDEX /= "00000" and Rd_MEMWB = Rd_IDEX) then
				tempC <= "01";
				tempA <= "00";
				tempB <= "00";
			else
				tempC <= "00";
				tempA <= "00";
				tempB <= "00";
			end if;
			
		else
			if ((RF_WrEn_EXMEM = '1' and Rd_EXMEM /= "00000") and (Rd_EXMEM = Rs_IDEX)) then
				tempA <= "10";
			elsif ((RF_WrEn_MEMWB = '1' and Rd_MEMWB /= "00000") and (Rd_MEMWB = Rs_IDEX)) then
				tempA <= "01";
			else
				tempA <= "00";
			end if;
			
			if ((RF_WrEn_EXMEM = '1' and Rd_EXMEM /= "00000") and (Rd_EXMEM = Rt_IDEX)) then
				tempB <= "10";
			elsif ((RF_WrEn_MEMWB = '1' and Rd_MEMWB /= "00000") and (Rd_MEMWB = Rt_IDEX)) then
				tempB <= "01";
			else
				tempB <= "00";
			end if;
		end if;
	end process;

	ForwardA <= tempA;
	ForwardB <= tempB;
	ForwardC <= tempC;
end Behavioral;

