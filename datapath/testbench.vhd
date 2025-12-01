library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_top_level is
end entity;

architecture tb of tb_top_level is
	signal clk : std_logic := '1';
    signal clk_enable : std_logic := '1';
    constant tempo : time := 500 us;


	signal pedestre : std_logic := '0';
    signal outro_pedestre : std_logic := '0';
    signal emergencia : std_logic := '0';
    signal outra_emergencia : std_logic := '0';
    signal ativar_night : std_logic := '0';
    signal reset : std_logic := '0';
    signal saida_virar_a_direita : std_logic := '0';
    signal saida_amarelo : std_logic := '0';
    signal saida_verde : std_logic := '0';
    signal saida_vermelho : std_logic := '0';
	signal vetor_estado :  std_logic_vector(2 downto 0);
    signal vetor_proximo_estado :  std_logic_vector(2 downto 0);
    

begin
	-- inicializando o pulso do clock
    clk <= clk_enable and not clk after tempo / 2;
    
    uut: entity work.top_level
    
    port map (
    	clk => clk,
    	pedestre => pedestre,
        outro_pedestre => outro_pedestre,
        emergencia => emergencia,
        outra_emergencia => outra_emergencia,
        reset => reset,
        ativar_night => ativar_night,
        saida_virar_a_direita => saida_virar_a_direita,
        saida_verde => saida_verde,
        saida_amarelo => saida_amarelo,
        saida_vermelho => saida_vermelho,
        vetor_estado => vetor_estado,
        vetor_proximo_estado => vetor_proximo_estado
    );
    
    stim: process
    begin
    	wait for tempo * 100;
        
        clk_enable <= '0';
        
        wait;
    end process;
end architecture;
