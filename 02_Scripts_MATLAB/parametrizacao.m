% Parâmetros do Veículo - Modelo Bicicleta

m = 1500;       % Massa (kg)
Iz = 2800;      % Momento de Inércia de Guinada (kg*m^2)
a = 1.2;        % Distância CG-Eixo Dianteiro (m)
b = 1.6;        % Distância CG-Eixo Traseiro (m)
L = a + b;      % Distância entre eixos
Caf = 80000;    % Rigidez de Deriva Dianteira (N/rad)
Car = 80000;    % Rigidez de Deriva Traseira (N/rad)
vx = 20;        % Velocidade longitudinal constante (m/s)

% Salvar para usar no Simulink
save('params.mat');