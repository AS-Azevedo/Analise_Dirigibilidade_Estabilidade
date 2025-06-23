%% PARÂMETROS DO VEÍCULO - CONFIGURAÇÃO FINAL E COMPLETA
% =========================================================================
% Este script define todas as características físicas do veículo a ser 
% simulado. Ele é chamado pelo script mestre para carregar os parâmetros
% no workspace do MATLAB.
%
% NOTA: Este script NÃO deve conter 'clear all' ou 'clc' para não
% apagar variáveis criadas pelo script mestre (como o Bus Object).
% =========================================================================

fprintf('   -> Carregando parâmetros físicos do veículo...\n');

% --- PARÂMETROS FÍSICOS GERAIS E DE GEOMETRIA ---
g = 9.81;       % Aceleração da gravidade (m/s^2)
m = 2000;       % Massa total do veículo (kg) - Um pouco mais pesado para mais estabilidade
a = 1.0;        % Distância CG-Eixo Dianteiro (m) - CG BEM PARA A FRENTE
b = 2.0;        % Distância CG-Eixo Traseiro (m) - Traseira MUITO longa
L = a + b;      % Distância entre eixos (m) - Total de 3.0m, promove estabilidade
t_f = 1.5;      % Bitola (distância entre rodas) dianteira (m)
t_r = 1.5;      % Bitola traseira (m)

% --- PARÂMETROS DE INÉRCIA DO CHASSI ---
ms = 1800;      % Massa suspensa (kg), (massa total - 4 * massa não-suspensa)
Iz = 7000;      % Momento de Inércia de Guinada (kg*m^2) - MUITO ALTO, carro "preguiçoso" para girar
Ix = 600;       % Momento de inércia de rolagem (kg*m^2)
Iy = 4500;      % Momento de Inércia de Arfagem (Pitch) (kg*m^2) - Também aumentado


% --- PARÂMETROS DOS PNEUS (PACEJKA - CONFIGURAÇÃO "SUPER-ESTÁVEL") ---
% Coeficientes da "Magic Formula" que definem o formato da curva de aderência
PneuDianteiro.B = 10;
PneuDianteiro.C = 1.9;
PneuDianteiro.D_mult = 1.0; % Multiplicador para o pico da aderência (D)
PneuDianteiro.E = 0.97;
% Rigidez do pneu dianteiro (N/rad) - Alta para gerar bastante força
Caf = 200000; 

PneuTraseiro.B = 10;
PneuTraseiro.C = 1.9;
PneuTraseiro.D_mult = 1.0;
PneuTraseiro.E = 0.97;
% Rigidez do pneu traseiro (N/rad) - O DOBRO da dianteira para garantir subesterço
Car = 400000; 


% --- PARÂMETROS DA SUSPENSÃO (POR CANTO E ROTAÇÃO) ---
% Parâmetros para o modelo de 1/4 de veículo
mus_q = 50;        % Massa não-suspensa por roda (kg)
ks = 25000;        % Rigidez da mola da suspensão (N/m)
cs = 2500;         % Coeficiente de amortecimento da suspensão (N*s/m)
kt = 200000;       % Rigidez vertical do pneu (N/m)

% Parâmetros de Rolagem (Roll)
K_phi_f = 40000;  % Rigidez de rolagem dianteira (N*m/rad)
K_phi_r = 30000;  % Rigidez de rolagem traseira (N*m/rad)
K_phi_total = K_phi_f + K_phi_r; % Rigidez total
C_phi_f = 2000;   % Amortecimento de rolagem dianteiro (N*m*s/rad)
C_phi_r = 1500;   % Amortecimento de rolagem traseiro (N*m*s/rad)
C_phi_total = C_phi_f + C_phi_r; % Amortecimento total
h_rc = 0.4;     % Distância vertical do CG ao eixo de rolagem (m)

% Parâmetros de Arfagem (Pitch)
Cy_passive = 5000; % Amortecimento passivo de Arfagem (Pitch) (N*m*s/rad) para estabilidade numérica


% --- CÁLCULOS DERIVADOS ---
% Cargas verticais estáticas em cada eixo (em Newtons)
Fz_f_static = m * g * b / L;
Fz_r_static = m * g * a / L;


% --- SALVANDO OS PARÂMETROS ---
% Salva todas as variáveis criadas neste script em um arquivo .mat
save('params_veiculo.mat');

fprintf('   -> Parâmetros físicos carregados e salvos com sucesso.\n');