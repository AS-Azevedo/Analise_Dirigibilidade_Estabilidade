s%% SCRIPT MESTRE PARA ANÁLISE DO MODELO COM ROLAGEM (FASE 3)
% Este script executa uma simulação do modelo de 4-DOF e analisa os
% resultados de guinada, rolagem e transferência de carga.

% --- 1. Preparação do Ambiente ---
clear all; 
clc;       
close all; 

fprintf('1. Carregando parâmetros do veículo (Fase 3)...\n');
run('parametros_veiculo.m'); 
load('params_veiculo.mat'); 

% --- 2. Configuração da Simulação ---
fprintf('2. Configurando o cenário de teste...\n');

model_name = 'modelo_roll_4dof';
model_path = ['../01_Modelos_Simulink/' model_name];

% Condições do Teste (um degrau moderado para ver bem o efeito da rolagem)
vx = 20; % m/s
delta_input = 0.1; % rad (~5.7 graus)
t_sim = 10; % segundos

% --- 3. Execução da Simulação ---
fprintf('3. Executando o modelo de 4-DOF...\n');

% Carrega o sistema na memória e depois executa a simulação
load_system(model_path);
out = sim(model_path, 'StopTime', num2str(t_sim));

fprintf('4. Simulação concluída!\n');

% --- 4. Análise e Visualização dos Resultados ---
fprintf('5. Gerando gráficos de análise da Fase 3...\n');

% Extraindo os dados da estrutura de saída 'out'
tempo = out.tout;
taxa_guinada = out.r_sim.Data;
angulo_rolagem = out.phi_sim.Data;
cargas_pneus = out.Fz_sim.Data;

% Criando uma figura com múltiplos subplots
figure('Name', 'Análise Completa da Manobra - Fase 3');

% Subplot 1: Resposta da Taxa de Guinada
subplot(3, 1, 1);
plot(tempo, taxa_guinada, 'b-', 'LineWidth', 2);
title('Resposta da Taxa de Guinada (r)');
xlabel('Tempo (s)');
ylabel('rad/s');
grid on;

% Subplot 2: Resposta da Rolagem
subplot(3, 1, 2);
plot(tempo, angulo_rolagem * (180/pi), 'r-', 'LineWidth', 2); % Convertido para graus para fácil leitura
title('Ângulo de Rolagem da Carroceria (\phi)');
xlabel('Tempo (s)');
ylabel('Graus');
grid on;

% Subplot 3: Transferência de Carga
subplot(3, 1, 3);
plot(tempo, cargas_pneus / 1000, 'LineWidth', 2); % Dividido por 1000 para ver em kN
title('Carga Vertical Dinâmica nos Pneus (Fz)');
xlabel('Tempo (s)');
ylabel('Carga (kN)');
legend('Diant. Esq. (FL)', 'Diant. Dir. (FR)', 'Tras. Esq. (RL)', 'Tras. Dir. (RR)');
grid on;

fprintf('Análise finalizada.\n');

% Opcional: Abrir o Scope para visualização interna
% open_system([model_name '/Scope']); % Descomente se quiser abrir um Scope específico

