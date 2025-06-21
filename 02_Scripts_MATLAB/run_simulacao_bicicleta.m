%% SCRIPT MESTRE PARA ANÁLISE DE DIRIGIBILIDADE
% Este script executa uma varredura em velocidade para determinar a
% característica de dirigibilidade (understeer/oversteer) do veículo.

% --- 1. Preparação do Ambiente ---
clear all; 
clc;       
close all; 

fprintf('1. Executando script de parâmetros para gerar o arquivo .mat...\n');
% Garante que os parâmetros estejam sempre atualizados antes de carregar
run('parametros_veiculo.m'); 
load('params_veiculo.mat'); 

% --- 2. Configuração da Análise ---
fprintf('2. Configurando a varredura em velocidade...\n');
velocidades_teste = 10:2:40; % Testa de 10 a 30 m/s
delta_input = 0.05; % Ângulo de degrau no volante (rad)
r_ss = zeros(size(velocidades_teste)); 

% --- 3. Loop de Simulação Automatizada ---
fprintf('3. Iniciando simulações...\n');
for i = 1:length(velocidades_teste)
    vx = velocidades_teste(i);
    fprintf('   Simulando para vx = %.1f m/s...\n', vx);
    
    out = sim('modelo_bicicleta.slx', 'StopTime', '30');
    
    taxa_guinada_vetor = out.r_sim.Data;
    r_ss(i) = taxa_guinada_vetor(end);
end
fprintf('4. Simulações concluídas!\n');

% --- 4. Análise e Visualização dos Resultados ---
fprintf('5. Gerando gráfico de característica de dirigibilidade...\n');
ganho_guinada = r_ss / delta_input;

figure('Name', 'Característica de Dirigibilidade');
plot(velocidades_teste, ganho_guinada, 'b-o', 'LineWidth', 2, 'MarkerSize', 6);
grid on;
title('Característica de Dirigibilidade do Veículo');
xlabel('Velocidade Longitudinal (vx) [m/s]');
ylabel('Ganho de Taxa de Guinada [ (rad/s) / rad ]');

% Lógica para determinar a característica e adicionar ao título
if ganho_guinada(end) < ganho_guinada(1)
    caracteristica = 'Subesterçante (Understeer)';
else
    caracteristica = 'Sobre-esterçante (Oversteer)';
end
title({'Característica de Dirigibilidade do Veículo', ['Comportamento: ', caracteristica]});

fprintf('Análise finalizada.\n');