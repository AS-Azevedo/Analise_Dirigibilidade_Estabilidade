%% SCRIPT MESTRE PARA ANÁLISE DO MODELO PACEJKA (FASE 2)
% Este script executa duas simulações para comparar a resposta do veículo
% com pneus não-lineares sob diferentes amplitudes de esterçamento.

% --- 1. Preparação do Ambiente ---
clear all; 
clc;       
close all; 

fprintf('1. Carregando parâmetros do veículo (com coeficientes Pacejka)...\n');
% Garante que os parâmetros estejam sempre atualizados antes de carregar
% O script de parâmetros agora deve conter as structs 'PneuDianteiro' e 'PneuTraseiro'
run('parametros_veiculo.m'); 
load('params_veiculo.mat'); 

% --- 2. Configuração dos Testes ---
fprintf('2. Configurando os cenários de teste...\n');

% Cenário 1: Esterçamento pequeno (deve se comportar de forma quase linear)
delta_pequeno = 0.05; % ~2.8 graus

% Cenário 2: Esterçamento grande (deve mostrar saturação do pneu)
delta_grande = 0.2;  % ~11.5 graus (4x maior que o pequeno)

% Parâmetros de simulação (velocidade constante para este teste)
vx = 20; % m/s
t_sim = 10; % segundos

% --- 3. Execução das Simulações ---
fprintf('3. Executando simulação com DELTA PEQUENO...\n');
% Define a entrada do Step block para o valor pequeno
delta_input = delta_pequeno;
% Executa o novo modelo USANDO O CAMINHO RELATIVO
out_pequeno = sim('../01_Modelos_Simulink/modelo_pacejka.slx', 'StopTime', num2str(t_sim));

fprintf('4. Executando simulação com DELTA GRANDE...\n');
% Define a entrada do Step block para o valor grande
delta_input = delta_grande;
% Executa o novo modelo USANDO O CAMINHO RELATIVO
out_grande = sim('../01_Modelos_Simulink/modelo_pacejka.slx', 'StopTime', num2str(t_sim));

fprintf('5. Simulações concluídas!\n');

% --- 4. Análise e Visualização Comparativa ---
fprintf('6. Gerando gráfico comparativo...\n');

% Extraindo os dados de cada simulação
tempo_pequeno = out_pequeno.tout;
r_pequeno = out_pequeno.r_sim.Data;

tempo_grande = out_grande.tout;
r_grande = out_grande.r_sim.Data;

% Plotando as duas respostas no mesmo gráfico
figure('Name', 'Análise de Saturação do Pneu');
hold on; % Permite plotar múltiplas curvas na mesma figura
plot(tempo_pequeno, r_pequeno, 'b-', 'LineWidth', 2);
plot(tempo_grande, r_grande, 'r-', 'LineWidth', 2);
hold off;

% Adicionando rótulos e legenda
title('Comparação da Resposta de Guinada (Linear vs. Saturação)');
xlabel('Tempo (s)');
ylabel('Taxa de Guinada (r) [rad/s]');
legend( ...
    sprintf('Delta Pequeno (%.2f rad)', delta_pequeno), ...
    sprintf('Delta Grande (%.2f rad)', delta_grande) ...
);
grid on;

% Análise Quantitativa
ganho_linear_aproximado = max(abs(r_pequeno)) / delta_pequeno;
ganho_saturado = max(abs(r_grande)) / delta_grande;

fprintf('\n--- Análise de Ganhos ---\n');
fprintf('Ganho Aparente (regime linear): %.2f\n', ganho_linear_aproximado);
fprintf('Ganho Aparente (regime saturado): %.2f\n', ganho_saturado);
fprintf('Se o ganho saturado for menor, a não-linearidade foi comprovada!\n');