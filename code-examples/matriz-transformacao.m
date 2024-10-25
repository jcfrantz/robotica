clc
clear
close

% Inicia a API do RoboDK do Matlab:
RDK = Robolink();

% Seleciona o robô aberto:
robot = RDK.Item('', RDK.ITEM_TYPE_ROBOT);

home = RDK.Item('Home');
robot.MoveJ(home);

% Salva a posição do robô
poseref = robot.Pose();

% Extrai a matriz de rotação atual e a posição
R = poseref(1:3, 1:3);  % Matriz de rotação atual (3x3)
p = poseref(1:3, 4);    % Vetor de posição atual (3x1)

%% Explicação Posição do robô
% Define o novo vetor posição eixo X
px_new = [500 p(2) p(3)]';

% Cria a nova matriz homogênea com a nova posição e orientação original
pose_new = [R, px_new; 0 0 0 1];

% Move o robô para a nova posição, mantendo a orientação
robot.MoveL(pose_new);

% Define o novo vetor posição eixo Y
py_new = [px_new(1) -1000 p(3)]';

% Cria a nova matriz homogênea com a nova posição e orientação original
pose_new = [R, py_new; 0 0 0 1];

% Move o robô para a nova posição, mantendo a orientação
robot.MoveL(pose_new);

% Define o novo vetor posição eixo Z
pz_new = [px_new(1) py_new(2) 400]';

% Cria a nova matriz homogênea com a nova posição e orientação original
pose_new = [R, pz_new; 0 0 0 1];

% Move o robô para a nova posição, mantendo a orientação
robot.MoveL(pose_new);
 
%% Explicação Matriz de Rotação
% Define o ângulo de rotação
theta = pi/5;
ct = cos(theta);
st = sin(theta);

% Cria a matriz de rotação em torno do eixo X
Rx = [1	0	0;   
	0	ct	-st; 
	0	st	ct ];

% Calcula a nova matriz de rotação combinada
Rx_new = R * Rx;

% Cria a nova matriz homogênea com a nova orientação e posição original
pose_new = [Rx_new, pz_new; 0 0 0 1];

% Move o robô para a nova orientação, mantendo a posição
robot.MoveJ(pose_new);

% Salva a posição do robô
poseref = robot.Pose();

% Extrai a matriz de rotação atual e a posição
R = poseref(1:3, 1:3);  % Matriz de rotação atual (3x3)
p = poseref(1:3, 4);    % Vetor de posição atual (3x1)

% Cria a matriz de rotação em torno do eixo Y
Ry = [ct	0	st;   
	0	1	0; 
	-st	0	ct ];

% Calcula a nova matriz de rotação combinada
Ry_new = R * Ry;

% Cria a nova matriz homogênea com a nova orientação e posição original
pose_new = [Ry_new, p; 0 0 0 1];

% Move o robô para a nova orientação, mantendo a posição
robot.MoveJ(pose_new);

% Salva a posição do robô
poseref = robot.Pose();

% Extrai a matriz de rotação atual e a posição
R = poseref(1:3, 1:3);  % Matriz de rotação atual (3x3)
p = poseref(1:3, 4);    % Vetor de posição atual (3x1)

% Cria a matriz de rotação em torno do eixo Y
Rz = [ct  -st	0;   
	  st   ct	0; 
	  0	   0	1 ];

% Calcula a nova matriz de rotação combinada
Rz_new = R * Rz;

% Cria a nova matriz homogênea com a nova orientação e posição original
pose_new = [Rz_new, p; 0 0 0 1];

% Move o robô para a nova orientação, mantendo a posição
robot.MoveJ(pose_new);