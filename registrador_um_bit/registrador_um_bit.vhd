-- Arthur Coronho, Lucas Szuster Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity registrador_um_bit is
    port (
    	-- entradas
        clk : in std_logic;
        reset : in std_logic;
        I : in std_logic;
        
        -- saídas
        Q : out std_logic
    );
end entity;

architecture reg of registrador_um_bit is
begin
	process(clk, reset)
    begin
    	if (reset = '1') then
        	-- caso o reset esteja ativa, a saída é 0
        	Q <= '0';
        elsif (rising_edge(clk)) then
        	-- caso reset não esteja ativo
            -- e seja borda de subida do clock
            -- deve-se amostrar a entrada I na saída Q
        	Q <= I;
        end if;
    end process;
end architecture;
