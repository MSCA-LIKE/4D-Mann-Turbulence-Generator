function Turbulence = GetVelocityField(Turbulence,TargetDir,AddShearFlag)

% This code read in the 4D Mann turb into matlab and add shear
% by Feng Guo on 13 Jan 2022£¬ @FUAS
% Developed within the LIKE (Lidar Knowledge Europe) project, funded by the European Union¡¯s Horizon, 2020 research
% innovation programme under the Marie-Curie grant agreement No. 858358
% according to the manuscript£º The space-time structure of turbulence for
% lidar-assisted wind turbine control, Feng Guo, Jakob Mann, Alfredo Pe?a, David Schlipf, Po Wen Cheng 



%TargetDir  contains the mt4d to convert and the resulting binary will be written in this folder
FileName    = [ TargetDir '\' Turbulence.Field.CaseName];

n1          = Turbulence.Field.n1;
n2          = Turbulence.Field.n2;
n3          = Turbulence.Field.n3;
nt          = Turbulence.Field.n_upstream;
shearExp    = Turbulence.alpha_shear;

% write out the bladed style wnd
Turbulence.Field.nn          = [Turbulence.Field.n1 Turbulence.Field.n2 Turbulence.Field.n3];
Turbulence.Field.LMax        = Turbulence.Field.LMax;



z           = Turbulence.Field.z;
HubHeight   = Turbulence.Field.HRef;
URef        = Turbulence.URef;
Xunfrozen   = Turbulence.Field.x_upstream;


fileID      = fopen([FileName  '.mt4d']);
uvw         = fread(fileID,'real*4');
fclose(fileID);

uvw         = reshape(uvw, [n3 n2 n1 nt 3]);  % the dimention and sequnce should be fixed here

u           = squeeze(uvw(:,:,:,:,1));
v           = squeeze(uvw(:,:,:,:,2));
w           = squeeze(uvw(:,:,:,:,3));
u           = permute(u ,[4 3 2 1]);  %Nt Nx Ny Nz   We actually use Nx as time in the simulation
v	        = permute(v ,[4 3 2 1]);
w	        = permute(w ,[4 3 2 1]);

% flip   uncomment the three lines below if you want to change the propagation direction, by default it propogates towards positive x
% u           = flip(flip(u,2),3);   
% v           = flip(flip(v,2),3);
% w           = flip(flip(w,2),3);

if AddShearFlag==1
for iz = 1:length(z)
    Uz           = URef*((z(iz)+HubHeight)/HubHeight)^shearExp;
    if ~isreal(Uz)
        u(:,:,:,iz)  = u(:,:,:,iz);
        error('Failure in adding shear profile, the smallest height in the field is negative, resulting in complex mean wind speed. Please adjust the reference height or the field size!')
    else
    u(:,:,:,iz)  = u(:,:,:,iz)+Uz;
    end
end
end

Turbulence.windfield.u = u;
Turbulence.windfield.v = v;
Turbulence.windfield.w = w;
Turbulence.windfield.x = Turbulence.Field.x;
Turbulence.windfield.y = Turbulence.Field.y;
Turbulence.windfield.z = Turbulence.Field.z;
Turbulence.windfield.t = Turbulence.Field.t;
Turbulence.windfield.x_evo = Xunfrozen;