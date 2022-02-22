%% Configurate a 4D Mann model based turbulence based on a name
% 
% by Feng Guo on 13 Jan 2022£¬ @FUAS
% Developed within the LIKE (Lidar Knowledge Europe) project, funded by the European Union¡¯s Horizon, 2020 research
% innovation programme under the Marie-Curie grant agreement No. 858358
% according to the manuscript£º The space-time structure of turbulence for
% lidar-assisted wind turbine control, Feng Guo, Jakob Mann, Alfredo Pe?a, David Schlipf, Po Wen Cheng 

%% Parameter Definition
% URef       : reference wind speed usually consider the hub height mean wind
% alphaeps   : energy level constant
% L          : turbulence length scale 
% Gamma      : anisotropy
% gamma      : time constant for eddy life time
% factor(1)  : eddy life time slope, set 1 will give the original Mann model slope
% factor(2)  : eddy life time slope, set 1 will give the original Mann model slope
% alpha_shear: vertical shear exponent  
% TurbulenceName: Name of the case;


function Turbulence = MannTurbConfig(TurbName,URef)

switch TurbName
    
case 'Neutral'   
    %% Turbulence Configuration
    
    Turbulence.URef              = URef;   % reference wind speed usually consider the hub height mean wind
    Turbulence.alphaeps          = 0.18; % energy level constant
    Turbulence.L                 = 49;   % turbulence length scale 
    Turbulence.Gamma             = 3.37;  % anisotropy
    Turbulence.gamma             = 430;  % time constant for eddy life time
    Turbulence.factor(1)         = 1;    % eddy life time slope
    Turbulence.factor(2)         = 3.5;    % eddy life time slope
    Turbulence.alpha_shear = 0.2;  % shear exponent  
    Turbulence.TurbulenceName          = TurbName;

case 'Stable'   
    Turbulence.URef              = URef;   % reference wind speed usually consider the hub height mean wind
    Turbulence.alphaeps          = 0.18; % energy level constant
    Turbulence.L                 = 30;   % turbulence length scale 
    Turbulence.Gamma             = 2.37;  % anisotropy
    Turbulence.gamma             = 207;  % time constant for eddy life time
    Turbulence.factor(1)         = 0.8;    % eddy life time slope
    Turbulence.factor(2)         = 3.5;    % eddy life time slope
    Turbulence.alpha_shear       = 0.2;  % shear exponent  
    Turbulence.TurbulenceName          = TurbName;

    %add more if needed 
end

end