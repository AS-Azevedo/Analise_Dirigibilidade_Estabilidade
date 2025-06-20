% SCRIPT MESTRE PARA ANÁLISE DE DIRIGIBILIDADE
% Este script executa uma varredura em velocidade para determinar a
% característica de dirigibilidade (understeer/oversteer) do veículo.

% --- 1. Preparação do Ambiente ---
clear all; 
clc;       
close all; 

fprintf('1. Carregando parâmetros base do veículo...\n');
load('params.mat'); % Carrega as variáveis do seu arquivo .mat

% --- 2. Configuração da Análise ---
fprintf('2. Configurando a varredura em velocidade...\n');

% Vetor de velocidades que vamos testar (em m/s)
velocidades_teste = 10:2:30; % Testa de 10 a 30 m/s, com passos de 2 m/s

% Ângulo de degrau no volante que usaremos para todos os testes (em rad)
delta_input = 0.05; % Usando um valor menor para garantir que o pneu fique na faixa linear

% Pré-alocação de memória para guardar os resultados (boa prática)
r_ss = zeros(size(velocidades_teste)); % 'ss' significa 'steady-state' (regime permanente)

% --- 3. Loop de Simulação Automatizada ---
fprintf('3. Iniciando simulações...\n');

for i = 1:length(velocidades_teste)
    
    % Atualiza a velocidade para a iteração atual do loop
    vx = velocidades_teste(i);
    
    % Imprime o status na tela
    fprintf('   Simulando para vx = %.1f m/s...\n', vx);
    
    % Executa a simulação. Note que o Simulink usará o 'vx' atualizado.
    out = sim('modelo_bicicleta.slx', 'StopTime', '10');
    
    % Extrai os dados de saída da simulação
    taxa_guinada_vetor = out.r_sim.Data;
    
    % Pega o ÚLTIMO valor da taxa de guinada, que é o valor de regime permanente
    r_ss(i) = taxa_guinada_vetor(end);
    
end

fprintf('4. Simulações concluídas!\n');

% --- 4. Análise e Visualização dos Resultados ---
fprintf('5. Gerando gráfico de característica de dirigibilidade...\n');

% Cálculo do Ganho de Taxa de Guinada para cada velocidade
ganho_guinada = r_ss / delta_input;

% Gerando o gráfico final da análise
figure('Name', 'Característica de Dirigibilidade');
plot(velocidades_teste, ganho_guinada, 'b-o', 'LineWidth', 2, 'MarkerSize', 6);
title('Característica de Dirigibilidade do Veículo');
xlabel('Velocidade Longitudinal (vx) [m/s]');
ylabel('Ganho de Taxa de Guinada [ (rad/s) / rad ]');
grid on;
%axis([min(velocidades_teste)-1 max(velocidades_teste)+1 0 max(ganho_guinada)*1.2]);
% Define os limites do eixo X
xlim([min(velocidades_teste)-1 max(velocidades_teste)+1]);

% Calcula um limite seguro para o eixo Y
ymax_limit = max(ganho_guinada) * 1.2;
if ymax_limit <= 0 % Checagem de segurança para ganhos zero ou negativos
    ymax_limit = 1; % Define um limite superior padrão para o gráfico não quebrar
end
ylim([0 ymax_limit]);



% --- 5. Interpretação (Adicionado ao Título) ---
% Pega o primeiro e o último ponto para determinar a tendência
if ganho_guinada(end) < ganho_guinada(1)
    caracteristica = 'Subesterçante (Understeer)';
elseif ganho_guinada(end) == ganho_guinada(1)
    caracteristica = 'Neutro (Neutral Steer)';
else
    caracteristica = 'Sobre-esterçante (Oversteer)';
end

% Adiciona a conclusão ao título do gráfico
title({'Característica de Dirigibilidade do Veículo', ['Comportamento: ', caracteristica]});

fprintf('Análise finalizada.\n');
