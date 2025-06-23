%% SCRIPT MESTRE DEFINITIVO - FASE 5: ANÁLISE E VISUALIZAÇÃO
% =========================================================================
% Este script é o ponto de entrada principal para executar o projeto.
% Ele realiza as seguintes tarefas:
%   1. Prepara o ambiente MATLAB.
%   2. Define a estrutura de dados (Bus Object) para a interface do modelo.
%   3. Carrega os parâmetros físicos do veículo do script de parâmetros.
%   4. Define as condições da manobra a ser simulada (velocidade, pista, etc.).
%   5. Executa o modelo de cenário do Simulink que contém a animação 3D.
%   6. (Opcional) Plota gráficos 2D para análise técnica.
%
% Autor: Anderson Azevedo
% Data: [22/06/2025]
% =========================================================================


%% --- 1. PREPARAÇÃO DO AMBIENTE ---
% Limpa o ambiente para garantir que não haja variáveis antigas interferindo.
clear all; 
clc;       
close all; 
fprintf('Ambiente limpo e pronto para a simulação.\n');


%% --- 2. DEFINIÇÃO DA ESTRUTURA DE DADOS (Simulink.Bus) ---
% Define um "contrato" de dados formal para a saída do modelo do veículo.
% Isso é crucial para a robustez em projetos com Model Referencing.
fprintf('2. Definindo a estrutura de dados Bus: PoseBusType...\n');

% Cria os elementos individuais do "ônibus" de sinais
elems(1) = Simulink.BusElement;
elems(1).Name = 'Translation';      % Posição [X Y Z]
elems(1).Dimensions = 3;
elems(1).DataType = 'double';

elems(2) = Simulink.BusElement;
elems(2).Name = 'Rotation';         % Rotação [Roll, Pitch, Yaw] em radianos
elems(2).Dimensions = 3;
elems(2).DataType = 'double';

elems(3) = Simulink.BusElement;
elems(3).Name = 'Scale';            % Escala [X Y Z] (geralmente [1 1 1])
elems(3).Dimensions = 3;
elems(3).DataType = 'double';

% Cria o objeto Bus principal que agrupa os elementos
PoseBusType = Simulink.Bus;
PoseBusType.Elements = elems;
PoseBusType.Description = 'Bus de Pose 6DOF para animação 3D';

% Limpa a variável temporária para manter o workspace organizado
clear elems;


%% --- 3. CARREGAMENTO DOS PARÂMETROS FÍSICOS DO VEÍCULO ---
fprintf('3. Carregando parâmetros físicos do veículo...\n');

params_script_name = 'parametros_veiculo.m';
% Verifica se o script de parâmetros existe
if ~exist(params_script_name, 'file')
    error("Script de parâmetros '%s' não encontrado.", params_script_name);
end
% Executa o script para carregar m, Iz, ks, etc. no workspace
run(params_script_name); 


%% --- 4. DEFINIÇÃO DA MANOBRA E CONDIÇÕES DE TESTE ---
fprintf('4. Configurando a manobra: Obstáculo em 1 roda...\n');

% Condições da Simulação
t_sim = 5;       % [s] Tempo total de simulação

% Condições do Veículo e do Piloto
% Estas variáveis são usadas como parâmetros pelos blocos DENTRO do modelo de cenário
vx = 15;          % [m/s] Velocidade longitudinal constante
delta_steer = 0;  % [rad] O carro segue em linha reta
t_steer = 1;      % [s] (Não usado no teste de obstáculo, mas definido)

% Condições da Pista: Apenas a roda dianteira direita (FR) passa por um obstáculo
z_pista_FL = 0;   % [m]
z_pista_FR = 0.1; % [m] A roda FR passa por um degrau de 10cm
z_pista_RL = 0;   % [m]
z_pista_RR = 0;   % [m]
t_obstaculo = 1;  % [s] Instante em que o obstáculo aparece na pista


%% --- 5. EXECUÇÃO DO CENÁRIO DE SIMULAÇÃO 3D ---
fprintf('5. Executando o cenário de simulação 3D...\n');

% Define o nome do modelo de CENÁRIO a ser executado
model_name = 'cenario_animacao_3d'; 

% Executa a simulação
% O Simulink usará todas as variáveis que criamos acima
out = sim(model_name, 'StopTime', num2str(t_sim));

fprintf('6. SIMULAÇÃO CONCLUÍDA COM SUCESSO!\n');


%% --- 6.PÓS-PROCESSAMENTO E PLOTS 2D ---


tempo = out.tout;
angulo_rolagem = out.phi_out.Data * (180/pi); % Supondo que você criou uma saída 'phi_out'
 
figure;
plot(tempo, angulo_rolagem);
title('Ângulo de Rolagem Durante a Manobra');
xlabel('Tempo (s)');
ylabel('Rolagem (Graus)');
grid on;