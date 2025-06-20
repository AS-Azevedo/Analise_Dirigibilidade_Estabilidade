%% SCRIPT MESTRE PARA SIMULAÇÃO DO MODELO BICICLETA
% Este script prepara o ambiente, executa a simulação e analisa os resultados.

% --- 1. Preparação do Ambiente ---
clear all; % Limpa todas as variáveis anteriores
clc;       % Limpa a janela de comando
close all; % Fecha todas as figuras abertas

fprintf('1. Carregando parâmetros do veículo...\n');
load('params.mat'); % Carrega as variáveis do seu arquivo .mat

% --- 2. Execução da Simulação ---
fprintf('2. Executando o modelo Simulink "modelo_bicicleta.slx"...\n');

% Define o tempo de simulação (opcional, pode ser definido no modelo)
t_sim = 10; % segundos

% Define o nome do modelo com o caminho relativo
model_name = '../01_Modelos_Simulink/modelo_bicicleta.slx';

% Comando para rodar a simulação
out = sim(model_name, 'StopTime', num2str(t_sim));

fprintf('3. Simulação concluída!\n');

% --- 3. Análise e Visualização dos Resultados ---
fprintf('4. Gerando gráficos de resultados...\n');

% 'out' é uma estrutura que contém todos os dados que foram para o Workspace.
% Se você usou um bloco "To Workspace" chamado 'r_sim', ele estará em out.r_sim
% O tempo da simulação estará em out.tout

figure; % Cria uma nova janela de figura
plot(out.tout, out.r_sim.Data, 'b-', 'LineWidth', 2);
title('Resposta da Taxa de Guinada (r)');
xlabel('Tempo (s)');
ylabel('Taxa de Guinada (rad/s)');
grid on;
legend('Taxa de Guinada (r)');

% Adicione outros plots se desejar
% Por exemplo, se você salvou a velocidade lateral 'vy' no workspace:
% figure;
% plot(out.tout, out.vy_sim, 'r-', 'LineWidth', 2);
% title('Velocidade Lateral (vy)');
% etc...

disp('Análise finalizada.');