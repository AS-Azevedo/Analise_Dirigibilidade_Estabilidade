%% SCRIPT MESTRE DEFINITIVO - ANÁLISE E ANIMAÇÃO GRÁFICA (FASE 5)
% =========================================================================
% Este script é o ponto de entrada final do projeto. Ele realiza o ciclo completo:
%   1. Prepara o ambiente MATLAB.
%   2. Define a estrutura de dados 'Bus Object' para a interface do modelo.
%   3. Carrega os parâmetros físicos do veículo.
%   4. Define as condições da simulação (tempo, velocidade).
%   5. Executa o modelo de cenário do Simulink.
%   6. Gera uma animação quadro a quadro dos principais resultados gráficos.
%
% Autor: Anderson Azevedo
% Data: 23/06/2025
% =========================================================================

%% --- 1. PREPARAÇÃO DO AMBIENTE ---
clear all; 
clc;       
close all; 
fprintf('Ambiente limpo e pronto para a simulação.\n');

%% --- 2. DEFINIÇÃO DA ESTRUTURA DE DADOS (Simulink.Bus) ---
% Define um "contrato" de dados formal para a interface entre os modelos.
fprintf('2. Definindo a estrutura de dados Bus: PoseBusType...\n');
elems(1) = Simulink.BusElement;
elems(1).Name = 'Translation';
elems(1).Dimensions = 3;
elems(1).DataType = 'double';
elems(2) = Simulink.BusElement;
elems(2).Name = 'Rotation';
elems(2).Dimensions = 3;
elems(2).DataType = 'double';
elems(3) = Simulink.BusElement;
elems(3).Name = 'Scale';
elems(3).Dimensions = 3;
elems(3).DataType = 'double';
PoseBusType = Simulink.Bus;
PoseBusType.Elements = elems;
PoseBusType.Description = 'Bus de Pose 6DOF para animação 3D';
clear elems;

%% --- 3. CARREGAMENTO DOS PARÂMETROS FÍSICOS DO VEÍCULO ---
fprintf('3. Carregando parâmetros físicos do veículo...\n');
params_script_name = 'parametros_veiculo.m';
% Garante que o script de parâmetros não tenha 'clear all' no início.
run(params_script_name); 

%% --- 4. DEFINIÇÃO DA MANOBRA E CONDIÇÕES DE TESTE ---
fprintf('4. Configurando manobra de Slalom com Obstáculo...\n');
t_sim = 8;      % [s] Tempo de simulação otimizado
vx = 15;        % [m/s] Velocidade do teste

% NOTA: Os perfis de volante (delta) e de pista (z_pista) são definidos
% diretamente nos blocos 'Signal Editor' e 'Pulse Generator' no Simulink.

%% --- 5. EXECUÇÃO DO CENÁRIO DE SIMULAÇÃO 3D ---
fprintf('5. Executando o cenário de simulação...\n');
model_name = 'cenario_animacao_3d'; % Nome do seu arquivo de cenário .slx
out = sim(model_name, 'StopTime', num2str(t_sim));
fprintf('6. Simulação concluída com sucesso!\n');

%% --- 6. ANIMAÇÃO GRÁFICA 2D DOS RESULTADOS ---
% Esta seção cria uma animação frame a frame dos gráficos de análise.
fprintf('7. Iniciando a geração da animação dos gráficos...\n');

% Extrai todos os dados necessários da saída da simulação 'out'
tempo = out.tout;
X_pos = out.X_out.Data;
Y_pos = out.Y_out.Data;
psi_deg = out.psi_out.Data * (180/pi);
phi_deg = out.phi_out.Data * (180/pi);
theta_deg = out.theta_out.Data * (180/pi);
susp_cm = out.deslocamento_susp_fr.Data * 100;

% --- Preparação da Figura e dos Eixos ---
figure('Name', 'Animação da Análise da Manobra', 'NumberTitle', 'off', 'Color', [0.15 0.15 0.15]);

% Subplot 1: Trajetória
subplot(2, 2, 1);
% Plota a trajetória completa em cinza para servir de guia
plot(Y_pos, X_pos, 'Color', [0.4 0.4 0.4]); 
hold on;
% Guarda o "handle" (identificador) da linha e do ponto que serão animados
h_trajetoria = plot(Y_pos(1), X_pos(1), 'Color', 'y', 'LineWidth', 2); % Amarelo
h_carro = plot(Y_pos(1), X_pos(1), 'o', 'MarkerFaceColor', 'y', 'MarkerEdgeColor', 'w', 'MarkerSize', 8);
hold off;
title('Trajetória do Veículo (Vista de Cima)', 'Color', 'w');
xlabel('Posição Lateral Y (m)', 'Color', 'w'); 
ylabel('Posição Frontal X (m)', 'Color', 'w');
grid on; axis equal;
set(gca, 'Color', [0.1 0.1 0.1], 'XColor', 'w', 'YColor', 'w');

% Subplot 2: Atitude do Chassi
subplot(2, 2, 2);
hold on;
h_rolagem = plot(tempo(1), phi_deg(1), 'r-', 'LineWidth', 2);
h_arfagem = plot(tempo(1), theta_deg(1), 'c-', 'LineWidth', 2); % Ciano
hold off;
title('Atitude do Chassi (\phi e \theta)', 'Color', 'w');
xlabel('Tempo (s)', 'Color', 'w'); 
ylabel('Ângulo (Graus)', 'Color', 'w'); 
grid on;
legend({'Rolagem (\phi)', 'Arfagem (\theta)'}, 'TextColor', 'w', 'Color', [0.25 0.25 0.25]);
set(gca, 'Color', [0.1 0.1 0.1], 'XColor', 'w', 'YColor', 'w');
ylim([min(min(phi_deg), min(theta_deg))-1 max(max(phi_deg), max(theta_deg))+1]); % Trava o eixo Y

% Subplot 3: Guinada
subplot(2, 2, 3);
h_guinada = plot(tempo(1), psi_deg(1), 'm-', 'LineWidth', 2); % Magenta
title('Ângulo de Guinada (\psi)', 'Color', 'w');
xlabel('Tempo (s)', 'Color', 'w'); 
ylabel('Graus', 'Color', 'w'); 
grid on;
set(gca, 'Color', [0.1 0.1 0.1], 'XColor', 'w', 'YColor', 'w');
ylim([min(psi_deg)-5 max(psi_deg)+5]); % Trava o eixo Y

% Subplot 4: Suspensão
subplot(2, 2, 4);
h_suspensao = plot(tempo(1), susp_cm(1), 'g-', 'LineWidth', 2); % Verde
title('Deslocamento da Suspensão Dianteira Direita', 'Color', 'w');
xlabel('Tempo (s)', 'Color', 'w'); 
ylabel('Compressão (cm)', 'Color', 'w'); 
grid on;
xline(2.5, '--r', 'Impacto', 'LineWidth', 2, 'Color', 'w', 'LabelColor','w');
set(gca, 'Color', [0.1 0.1 0.1], 'XColor', 'w', 'YColor', 'w');
ylim([min(susp_cm)-5 max(susp_cm)+5]); % Trava o eixo Y

% --- O Loop de Animação ---
for i = 1:300:length(tempo) % Pula de 20 em 20 frames para a animação ser rápida
    % Atualiza os dados de cada gráfico até o frame 'i' de forma eficiente
    set(h_trajetoria, 'XData', Y_pos(1:i), 'YData', X_pos(1:i));
    set(h_carro, 'XData', Y_pos(i), 'YData', X_pos(i));
    
    set(h_rolagem, 'XData', tempo(1:i), 'YData', phi_deg(1:i));
    set(h_arfagem, 'XData', tempo(1:i), 'YData', theta_deg(1:i));
    
    set(h_guinada, 'XData', tempo(1:i), 'YData', psi_deg(1:i));
    
    set(h_suspensao, 'XData', tempo(1:i), 'YData', susp_cm(1:i));
    
    % Atualiza o título principal da figura para mostrar o tempo passando
    sgtitle(sprintf('Análise da Manobra - Tempo: %.2f s', tempo(i)), 'Color', 'w');
    
    drawnow; % Força o MATLAB a redesenhar a tela
end

fprintf('Animação concluída.\n');