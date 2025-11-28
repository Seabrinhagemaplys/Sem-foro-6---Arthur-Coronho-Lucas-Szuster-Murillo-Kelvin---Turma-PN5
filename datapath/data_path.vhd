-- Arthur Coronho, Lucas Szuster Murillo Kelvin - Turma PN5
library IEEE;
use IEEE.std_logic_1164.all;

entity data_path is
	port (
		--Entradas do Caminho de Dados
		pedestre         : in std_logic;
		outro_pedestre   : in std_logic;
		emergencia       : in std_logic;
		outra_emergencia : in std_logic;
		sinal_verde      : in std_logic;
		sinal_amarelo    : in std_logic;
		sinal_vermelho   : in std_logic;
		ativar_night     : in std_logic;
		resetar_contador : in std_logic;
		clk              : in std_logic;
		clear            : in std_logic;
		
		--Saídas do Caminho de Dados
		led_virar_a_direita    : out std_logic;
		led_sinal_vermelho     : out std_logic;
		led_sinal_amarelo      : out std_logic;
		led_sinal_verde        : out std_logic;
		count                  : out std_logic
	);
end entity;

architecture arq of data_path is
	-- signals para o camiho de dados
	signal virar_a_direita_registrador : std_logic;
	signal alternador_or : std_logic;
	signal or_registrador : std_logic;
	constant qtd_contagens : integer := 4;
	
	-- Declaraçao do componente alternador
	component alternador is
		 port(
			  -- entradas
			  entrada         : in  std_logic := '0';
			  clear_assincrono: in std_logic;
			  clk             : in  std_logic;

			  -- saídas
			  saida   : out std_logic := '0'
		);
	end component;
	
	-- Declaração do bloco or
	component bloco_or is 
		 port(
			-- Entradas  
			clear_assincrono : in std_logic;
			entrada_um       : in std_logic;
			entrada_dois     : in std_logic;
			
			-- Saída
			saida        : out std_logic
		 );
	end component;
	
	-- Declaração bloco virar_a_direita
	component calcular_virar_a_direita is
		port (
			-- entradas
			clear_assincrono : in std_logic;
			pedestre         : in std_logic;
			outro_pedestre   : in std_logic;
			emergencia       : in std_logic;
			outra_emergencia : in std_logic;
		 
			-- saídas
			virar_a_direita : out std_logic := '0'
		);
	end component;
	
	-- Declaração Contador
	component contador_n is
		generic (
			-- quantidade de contagem
			N : integer := 4
		);
		
		port (
			-- entradas
			clear_contador : in std_logic;
			clk : in std_logic;
		 
			-- saídas
			count : out std_logic := '0'
			);
	end component;
	
	-- Declaração de registrador
	component registrador_um_bit is
		 port (
			-- entradas
			  clk : in std_logic;
			  reset : in std_logic;
			  I : in std_logic;
			  
			  -- saídas
			  Q : out std_logic
		 );
	end component;
	
begin
	
		-- Instânciação do alternador
		alt: alternador
		
		port map(
			entrada => ativar_night,
			clear_assincrono => clear,
			clk => clk,
			saida => alternador_or
		);
		
		-- Instanciação do bloco_or
		or_b: bloco_or
		
		port map(
			clear_assincrono => clear,
			entrada_um => sinal_amarelo,
			entrada_dois => alternador_or,
			saida => or_registrador
		);
		
		-- Instanciação do bloco calcular virar a direita
		vd: calcular_virar_a_direita
		
		port map(
			clear_assincrono => clear,
			pedestre => pedestre,
			outro_pedestre => outro_pedestre,
			emergencia => emergencia,
			outra_emergencia => outra_emergencia,
			virar_a_direita => virar_a_direita_registrador
		);
		
		-- Instanciação do bloco contador
		c: contador_n
		
		generic map(
			N => qtd_contagens
		)
		
		port map(
			clear_contador => resetar_contador,
			clk => clk,
			count => count
		);
		
		-- Instanciação registrador do virar a direita
		reg_virar_a_direita: registrador_um_bit
		
		port map(
			clk => clk,
			reset => clear,
			I => virar_a_direita_registrador,
			Q => led_virar_a_direita
		);
		
		-- Instanciação registrador do sinal vermelho
		reg_led_sinal_vermelho: registrador_um_bit
		
		port map(
			clk => clk,
			reset => clear,
			I => sinal_vermelho,
			Q => led_sinal_vermelho
		);
		
		-- Instanciação registrador do sinal amarelo
		reg_led_sinal_amarelo: registrador_um_bit
		
		port map(
			clk => clk,
			reset => clear,
			I => or_registrador,
			Q => led_sinal_amarelo
		);
		
		-- Instanciação registrador do sinal amarelo
		reg_led_sinal_verde: registrador_um_bit
		
		port map(
			clk => clk,
			reset => clear,
			I => sinal_verde,
			Q => led_sinal_verde
		);
end architecture;
		
		
		
		
		
	
		
