-- Arthur Coronho, Lucas Szuster, Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity alternador is
    port(
        -- entradas
        entrada         : in  std_logic := '0';
        clear_assincrono: in std_logic;
        clk             : in  std_logic;

        -- saídas
        saida   : out std_logic := '0'
    );
end entity;

architecture arq of alternador is
    signal inversor : std_logic := '1'; 
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if entrada = '1' then
                -- alterna o valor de inversor quando a entrada for '1'
                inversor <= not inversor;
            else
            	-- resetar o inversor para '1'
            	inversor <= '1';
            end if;
        end if;
    end process;

    -- a saída é o valor de inversor quando entrada = '1'
    	saida <= '0' when clear_assincrono = '1' else
    	inversor when entrada = '1' else '0';
end architecture;
