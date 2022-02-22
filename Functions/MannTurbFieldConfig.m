%% Configurate a 4D Mann model based turbulence Grid parameter for simulating discrete turbulent field
% 
% by Feng Guo on 13 Jan 2022£¬ @FUAS
% Developed within the LIKE (Lidar Knowledge Europe) project, funded by the European Union¡¯s Horizon, 2020 research
% innovation programme under the Marie-Curie grant agreement No. 858358
% according to the manuscript£º The space-time structure of turbulence for
% lidar-assisted wind turbine control, Feng Guo, Jakob Mann, Alfredo Pe?a, David Schlipf, Po Wen Cheng 

%% Parameter Definition
% NComp       = 3;    % number of velocity component, fixed
% n1          = 4096; % steps in x
% n2          = 32;   % steps in y
% n3          = 32;   % steps in z
% t_upstream  = t_upstream; % time slots
% n_upstream  = length(Turbulence.Field.t_upstream); % length of time slots, also the number of upstream yz planes
% dx          = 8;    % steps size in x
% dy          = 6;    % steps size in y
% dz          = 6;    % steps size in z
% seed        = seednum;    % seed number
% HRef        = 108;  % horizontal wind speed


function Turbulence = MannTurbFieldConfig(TurbSizeName,Turbulence,t_upstream,seednum)

switch TurbSizeName
    
%% Turbulence Configuration    
case '4096x32x32'   

Turbulence.Field.NComp       = 3;    % number of velocity component, fixed
Turbulence.Field.n1          = 4096; % steps in x
Turbulence.Field.n2          = 32;   % steps in y
Turbulence.Field.n3          = 32;   % steps in z
Turbulence.Field.t_upstream  = t_upstream; % time slots
Turbulence.Field.n_upstream  = length(Turbulence.Field.t_upstream); % length of time slots, also the number of upstream yz planes
Turbulence.Field.dx          = 8;    % steps size in x
Turbulence.Field.dy          = 6;    % steps size in y
Turbulence.Field.dz          = 6;    % steps size in z
Turbulence.Field.seed        = seednum;    % seed number
Turbulence.Field.HRef        = 108;  % horizontal wind speed

Turbulence.Field.dt          = Turbulence.Field.dx/Turbulence.URef;   % time step
Turbulence.Field.T           = (Turbulence.Field.n1-1)*Turbulence.Field.dt; % length in time
Turbulence.Field.LMax        = [Turbulence.Field.n1*Turbulence.Field.dx Turbulence.Field.n2*Turbulence.Field.dy Turbulence.Field.n3*Turbulence.Field.dz]; % field length in three directions
Turbulence.Field.x_upstream  = Turbulence.Field.t_upstream*Turbulence.URef; % position of upstream yz plane
Turbulence.Field.y           = linspace(-Turbulence.Field.LMax(2)/Turbulence.Field.n2*(Turbulence.Field.n2/2-1),Turbulence.Field.LMax(2)/2,Turbulence.Field.n2); % position vector in y
Turbulence.Field.z           = linspace(-Turbulence.Field.LMax(3)/Turbulence.Field.n3*(Turbulence.Field.n3/2-1),Turbulence.Field.LMax(3)/2,Turbulence.Field.n3); % position vector in z
Turbulence.Field.x           = 0:Turbulence.Field.dx:(Turbulence.Field.n1-1)*Turbulence.Field.dx;
Turbulence.Field.t           = 0:Turbulence.Field.dt:(Turbulence.Field.n1-1)*Turbulence.Field.dt;

  
case '4096x64x64'   
Turbulence.Field.NComp       = 3;    % number of velocity component, fixed
Turbulence.Field.n1          = 4096; % steps in x
Turbulence.Field.n2          = 64;   % steps in y
Turbulence.Field.n3          = 64;   % steps in z
Turbulence.Field.t_upstream  = t_upstream; % time slots
Turbulence.Field.n_upstream  = length(Turbulence.Field.t_upstream); % length of time slots, also the number of upstream yz planes
Turbulence.Field.dx          = 8;    % steps size in x
Turbulence.Field.dy          = 4.5;    % steps size in y
Turbulence.Field.dz          = 4.5;    % steps size in z
Turbulence.Field.seed        = seednum;    % seed number
Turbulence.Field.HRef        = 119;  % horizontal wind speed

Turbulence.Field.dt          = Turbulence.Field.dx/Turbulence.URef;   % time step
Turbulence.Field.T           = (Turbulence.Field.n1-1)*Turbulence.Field.dt; % length in time
Turbulence.Field.LMax        = [Turbulence.Field.n1*Turbulence.Field.dx Turbulence.Field.n2*Turbulence.Field.dy Turbulence.Field.n3*Turbulence.Field.dz]; % field length in three directions
Turbulence.Field.x_upstream  = Turbulence.Field.t_upstream*Turbulence.URef; % position of upstream yz plane
Turbulence.Field.y           = linspace(-Turbulence.Field.LMax(2)/Turbulence.Field.n2*(Turbulence.Field.n2/2-1),Turbulence.Field.LMax(2)/2,Turbulence.Field.n2); % position vector in y
Turbulence.Field.z           = linspace(-Turbulence.Field.LMax(3)/Turbulence.Field.n3*(Turbulence.Field.n3/2-1),Turbulence.Field.LMax(3)/2,Turbulence.Field.n3); % position vector in z
Turbulence.Field.x           = 0:Turbulence.Field.dx:(Turbulence.Field.n1-1)*Turbulence.Field.dx;
Turbulence.Field.t           = 0:Turbulence.Field.dt:(Turbulence.Field.n1-1)*Turbulence.Field.dt;


case '512x128x128'   
Turbulence.Field.NComp       = 3;    % number of velocity component, fixed
Turbulence.Field.n1          = 512; % steps in x
Turbulence.Field.n2          = 128;   % steps in y
Turbulence.Field.n3          = 128;   % steps in z
Turbulence.Field.t_upstream  = t_upstream; % time slots
Turbulence.Field.n_upstream  = length(Turbulence.Field.t_upstream); % length of time slots, also the number of upstream yz planes
Turbulence.Field.dx          = 2;    % steps size in x
Turbulence.Field.dy          = 2;    % steps size in y
Turbulence.Field.dz          = 2;    % steps size in z
Turbulence.Field.seed        = seednum;    % seed number
Turbulence.Field.HRef        = 119;  % horizontal wind speed

Turbulence.Field.dt          = Turbulence.Field.dx/Turbulence.URef;   % time step
Turbulence.Field.T           = (Turbulence.Field.n1-1)*Turbulence.Field.dt; % length in time
Turbulence.Field.LMax        = [Turbulence.Field.n1*Turbulence.Field.dx Turbulence.Field.n2*Turbulence.Field.dy Turbulence.Field.n3*Turbulence.Field.dz]; % field length in three directions
Turbulence.Field.x_upstream  = Turbulence.Field.t_upstream*Turbulence.URef; % position of upstream yz plane
Turbulence.Field.y           = linspace(-Turbulence.Field.LMax(2)/Turbulence.Field.n2*(Turbulence.Field.n2/2-1),Turbulence.Field.LMax(2)/2,Turbulence.Field.n2); % position vector in y
Turbulence.Field.z           = linspace(-Turbulence.Field.LMax(3)/Turbulence.Field.n3*(Turbulence.Field.n3/2-1),Turbulence.Field.LMax(3)/2,Turbulence.Field.n3); % position vector in z
Turbulence.Field.x           = 0:Turbulence.Field.dx:(Turbulence.Field.n1-1)*Turbulence.Field.dx;
Turbulence.Field.t           = 0:Turbulence.Field.dt:(Turbulence.Field.n1-1)*Turbulence.Field.dt;
     
end

Turbulence.TurbSizeName = TurbSizeName;
end