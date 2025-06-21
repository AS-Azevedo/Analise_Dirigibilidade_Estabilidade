%% PARÂMETROS DO VEÍCULO - CONFIGURAÇÃO FINAL "À PROVA DE FALHAS"
% Este script define as características de um veículo exageradamente subesterçante
% para validar a estrutura do modelo Simulink.

clear all;
clc;
close all;

fprintf('Carregando parâmetros de um veículo propositalmente subesterçante...\n');

% --- Parâmetros Físicos ---
m = 1500;       % Massa total do veículo (kg)
Iz = 4500;      % Iz ALTO (carro preguiçoso para girar, muito estável)
a = 1.1;        % CG BEM PARA A FRENTE
b = 1.7;        % Traseira longa
L = a + b;      % Distância entre eixos (m)
g = 9.81;       % Aceleração da gravidade (m/s^2)

% --- Parâmetros dos Pneus (Modelo Linear) ---
% A maior causa de subesterço: pneus dianteiros "macios" e traseiros "duros"
Caf = 70000;    % Rigidez de Deriva Dianteira (N/rad) - RELATIVAMENTE BAIXA
Car = 140000;   % Rigidez de Deriva Traseira (N/rad) - O DOBRO DA DIANTEIRA

% --- Salvando os Parâmetros ---
script_path = fileparts(mfilename('fullpath'));
if ~isfolder(script_path)
    mkdir(script_path);
end
save(fullfile(script_path, 'params_veiculo.mat'));

fprintf('Parâmetros salvos em "params_veiculo.mat".\n');