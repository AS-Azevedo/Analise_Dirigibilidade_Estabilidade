%% SCRIPT MESTRE PARA ANÁLISE DO VEÍCULO COMPLETO (FASE 4)
% Executa uma simulação de passagem por obstáculo em uma única roda
% para analisar os movimentos acoplados de rolagem e arfagem.

% --- 1. Preparação do Ambiente ---
clear all; 
clc;       
close all; 

fprintf('1. Carregando parâmetros completos do veículo...\n');
run('parametros_veiculo.m'); 
load('params_veiculo.mat'); 

% --- 2. Configuração da Simulação ---
fprintf('2. Configurando o cenário de teste: obstáculo em 1 roda...\n');

% Modelo a ser simulado
model_name = 'modelo_veiculo_7dof'; % Use o nome do seu modelo final
model_path = fullfile('..', '01_Modelos_Simulink', model_name);

% --- Seção 2: Configuração da Simulação ---
% ...

% Condições do Teste
vx = 15; % m/s, uma velocidade moderada
t_sim = 5; % segundos, tempo suficiente para ver a resposta
t_obstaculo = 0.5; %Tempo em que o obstáculo aparece (s)

% ... (resto do código) ...

% Entrada da Pista: Apenas a roda dianteira direita (FR) passa por um obstáculo
% Os outros cantos permanecem no chão (z=0)
z_pista_fl_input = 0; % Dianteiro Esquerdo
z_pista_fr_input = 0.1; % Dianteiro Direito passa por um degrau de 10cm
z_pista_rl_input = 0; % Traseiro Esquerdo
z_pista_rr_input = 0; % Traseiro Direito

% Entrada de Volante: Nenhuma, o carro segue reto
delta_input = 0;

% --- 3. Execução da Simulação ---
fprintf('3. Executando o modelo completo...\n');

% Verifica se o modelo existe e o carrega na memória
if ~exist([model_path '.slx'], 'file')
    error("Arquivo do modelo não encontrado em: %s.", model_path);
end
load_system(model_path);

% Executa a simulação
out = sim(model_path, 'StopTime', num2str(t_sim));

fprintf('4. Simulação concluída!\n');

% --- 4. Análise e Visualização dos Resultados ---
fprintf('5. Gerando gráficos de análise da Fase 4...\n');

% Extraindo os dados da estrutura de saída 'out'
tempo = out.tout;
angulo_rolagem_deg = out.phi_sim.Data * (180/pi);
angulo_arfagem_deg = out.theta_sim.Data * (180/pi);
pos_carroceria_fr = out.zs_canto_fr_sim.Data;
pos_roda_fr = out.zus_fr_sim.Data;

% Calculando o deslocamento da suspensão
deslocamento_susp_fr = pos_carroceria_fr - pos_roda_fr;

% Criando uma figura com múltiplos subplots
figure('Name', 'Análise do Veículo Completo - Obstáculo em 1 Roda');

% --- Subplot 1: Ângulos do Chassi (Rolagem e Arfagem) ---
subplot(2, 1, 1);
hold on; % Ativa o modo de "segurar" o gráfico para adicionar mais curvas
plot(tempo, angulo_rolagem_deg, 'LineWidth', 2, 'Color', 'r'); % Vermelho para Rolagem
plot(tempo, angulo_arfagem_deg, 'LineWidth', 2, 'Color', 'b'); % Azul para Arfagem
hold off; % Desativa o modo

title('Atitude do Chassi (\phi e \theta)');
xlabel('Tempo (s)');
ylabel('Ângulo (Graus)');
legend('Rolagem (\phi)', 'Arfagem (\theta)');
grid on;

% --- Subplot 2: Dinâmica da Suspensão Dianteira Direita ---
subplot(2, 1, 2);
hold on;
% Plotando com uma cor vibrante (verde) em vez de preto
plot(tempo, deslocamento_susp_fr * 100, 'LineWidth', 2, 'Color', 'g'); % 'g' para verde
hold off;

title('Deslocamento da Suspensão Dianteira Direita');
xlabel('Tempo (s)');
ylabel('Compressão (cm)');
legend('Deslocamento da Suspensão (Carroceria - Roda)'); % Adicionando a legenda que faltava
grid on;

disp('Análise finalizada.');