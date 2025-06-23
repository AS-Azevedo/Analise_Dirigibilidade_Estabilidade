%% PARÂMETROS DO VEÍCULO - CONFIGURAÇÃO FINAL "À PROVA DE FALHAS"
% Este script define as características de um veículo exageradamente subesterçante
% para validar a estrutura do modelo Simulink.

close all;

fprintf('Carregando parâmetros de um veículo\n');

% --- Parâmetros Físicos ---
m = 1500;       % Massa total do veículo (kg)
Iz = 4500;      % Iz ALTO (carro preguiçoso para girar, muito estável)
a = 1.1;        % CG BEM PARA A FRENTE
b = 1.7;        % Traseira longa
L = a + b;      % Distância entre eixos (m)
g = 9.81;       % Aceleração da gravidade (m/s^2)

% --- Parâmetros dos Pneus (Fase 2: Modelo Pacejka Simplificado) ---

% Coeficientes da "Magic Formula" para o pneu dianteiro
PneuDianteiro.B = 10;
PneuDianteiro.C = 1.9;
PneuDianteiro.D_mult = 1.0; % Multiplicador para o pico da aderência (D)
PneuDianteiro.E = 0.97;

% Coeficientes para o pneu traseiro (mesmo tipo de pneu)
PneuTraseiro.B = 10;
PneuTraseiro.C = 1.9;
PneuTraseiro.D_mult = 1.0;
PneuTraseiro.E = 0.97;

% --- Cálculos Derivados Adicionais ---
% Cargas verticais estáticas em cada eixo (em Newtons)
% (Já deve existir no seu script, mas confirme)
Fz_f_static = m * g * b / L;
Fz_r_static = m * g * a / L;

% --- Parâmetros da Fase 3: Dinâmica de Rolagem ---
ms = 1350;      % Massa suspensa (kg), um pouco menos que a massa total 'm'
Ix = 600;       % Momento de inércia de rolagem (kg*m^2)
h_rc = 0.4;     % Distância vertical do CG ao eixo de rolagem (m)
K_phi_f = 40000;  % Rigidez de rolagem dianteira (N*m/rad)
K_phi_r = 30000;  % Rigidez de rolagem traseira (N*m/rad)
K_phi_total = K_phi_f + K_phi_r; % Rigidez total
C_phi_f = 2000;   % Amortecimento de rolagem dianteiro (N*m*s/rad)
C_phi_r = 1500;   % Amortecimento de rolagem traseiro (N*m*s/rad)
C_phi_total = C_phi_f + C_phi_r; % Amortecimento total
t_f = 1.5;      % Bitola (distância entre rodas) dianteira (m)
t_r = 1.5;      % Bitola traseira (m)

% --- Parâmetros da Fase 4: Dinâmica Vertical (Modelo 1/4 de Veículo) ---

ms_q = m / 4;      % Massa suspensa por roda (kg) - 'q' de 'quarter'
mus_q = 60;        % Massa não-suspensa por roda (kg)

ks = 25000;        % Rigidez da mola da suspensão (N/m)
cs = 2500;         % Coeficiente de amortecimento da suspensão (N*s/m)
kt = 200000;       % Rigidez vertical do pneu (N/m)

% --- Parâmetros Adicionais para a Fase 4: Dinâmica de Arfagem ---
Iy = 2500; % Momento de Inércia de Arfagem (Pitch) (kg*m^2)
% Para este modelo, vamos assumir que não há rigidez ou amortecimento
% passivo de arfagem. Eles serão gerados pelas suspensões.
Cy_passive = 5000; % Amortecimento passivo de Arfagem (Pitch) (N*m*s/rad)

% --- Definição do Objeto Bus para a Pose 6-DOF ---
% Este bloco de código cria uma estrutura de dados formal para a saída de pose.



% --- Salvando os Parâmetros ---
script_path = fileparts(mfilename('fullpath'));
if ~isfolder(script_path)
    mkdir(script_path);
end
save(fullfile(script_path, 'params_veiculo.mat'));

fprintf('Parâmetros salvos em "params_veiculo.mat".\n');