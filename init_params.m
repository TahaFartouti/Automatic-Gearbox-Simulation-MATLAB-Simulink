%% init_params.m
% Projet : Modélisation d'une boîte de vitesse automobile automatique - Simulink
% Phase 1 - Paramètres du modèle (VALIDÉS)
% Véhicule de référence : Volkswagen Golf 1.5 TSI 150 ch
% Boîte de vitesse : DSG DQ200 (7 rapports, double embrayage sec)

clear; clc;

%% --- Courbe de couple moteur (Lookup Table) ---
% Moteur 1.5 TSI 150ch : couple max 250 Nm entre 1500-3500 tr/min (donnée constructeur)
engine_rpm    = [800 1500 2000 2500 3000 3500 4500 5500 6500];   % tr/min
engine_torque = [150 250  250  250  250  250  220  190  150];    % Nm

%% --- Paramètres véhicule (Golf 1.5 TSI 150ch) ---
m   = 1310;      % masse véhicule DIN (kg)
r_w = 0.316;      % rayon de roue, pneus 205/55 R16 (m)
g   = 9.81;       % accélération gravité (m/s^2)

%% --- Résistances à l'avancement ---
Crr   = 0.012;    % coefficient de résistance au roulement (pneu tourisme moderne)
Cx    = 0.275;    % coefficient de traînée aérodynamique (Golf, donnée constructeur)
A_f   = 2.23;     % surface frontale (m^2) - constante Golf V à VIII
rho   = 1.225;    % densité de l'air (kg/m^3)
slope = 0;        % angle de pente (rad) - 0 par défaut, utilisé en Phase 4 scénario B

%% --- Boîte de vitesse : DSG DQ200 (7 rapports) ---
gear_ratios   = [3.769, 2.150, 1.452, 1.109, 0.848, 0.667, 0.541];  % rapports 1 à 7
reverse_ratio = -3.615;                                              % marche arrière
final_drive   = 3.94;                                                % rapport de pont
eta_trans     = 0.94;                                                % rendement transmission (embrayages secs)

%% --- Conversions utiles ---
rpm2rads = 2*pi/60;    % tr/min -> rad/s
rads2rpm = 60/(2*pi);  % rad/s -> tr/min

%% --- Conditions initiales (pour Phase 2) ---
v0    = 0;      % vitesse véhicule initiale (m/s)
rpm0  = 800;    % régime moteur initial (tr/min, ralenti)
gear0 = 1;      % rapport initial

disp('Paramètres chargés avec succès - init_params.m (Golf 1.5 TSI 150ch / DSG DQ200)');
