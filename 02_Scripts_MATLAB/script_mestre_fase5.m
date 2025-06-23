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
% Data: 22/06/2025
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
