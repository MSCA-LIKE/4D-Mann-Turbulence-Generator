clear all
close all
clc

%% Configurate a 4D Mann model based turbulence based and visualize
% this example plots two yz plane turbulence, one at upstream one at down stream

% by Feng Guo on 13 Jan 2022£¬ @FUAS
% Developed within the LIKE (Lidar Knowledge Europe) project, funded by the European Union¡¯s Horizon, 2020 research
% innovation programme under the Marie-Curie grant agreement No. 858358
% according to the manuscript£º The space-time structure of turbulence for
% lidar-assisted wind turbine control, Feng Guo, Jakob Mann, Alfredo Pe?a, David Schlipf, Po Wen Cheng 


addpath('Functions')

URef       = 10;                            % Reference hub height mean wind speed      
SeedNum    = 22;
Turbulence = MannTurbConfig('Neutral',URef);
Turbulence = MannTurbFieldConfig('512x128x128',Turbulence,[0 7.5],SeedNum); % inputs: field case name, case objective, time slots
Turbulence = GenerateMann4DTurb(Turbulence,'TurbResults',[pwd]);  % inputs: case objective, turbulence result directory, exe directory
Turbulence = GetVelocityField(Turbulence,'TurbResults',0); % inputs: case objective, turbulence result directory, add shear profile flag



[X,Y,Z] = meshgrid(Turbulence.windfield.x,Turbulence.windfield.y,Turbulence.windfield.z);
xmin = min(X(:));
xmax = max(X(:));
ymax = max(Y(:));
ymin = min(Y(:));
zmin = min(Z(:));
zmax = max(Z(:));


%% Plot Turbulence slices
fig1=figure('Name','Sketch Boxes');
% set(gcf, 'color', 'none');  
grid off
subplot(2,1,1)
% field at t1
set(gcf,'color','w')
TurbBox = slice(X,Y,Z,permute(squeeze(Turbulence.windfield.u(2,:,:,:)),[2 1 3]),[xmin xmax],[ymax ymin],[zmin zmax]);
set(TurbBox,'FaceColor','interp','EdgeColor','none','facelighting','none');
view(45,15)
axis equal
xlabel('x [m]')
ylabel('y [m]')
zlabel('z [m]')
title('u component snapshot at t1 (upstream)')

subplot(2,1,2)
set(gcf,'color','w')
% field at t2
TurbBox2 = slice(X,Y,Z,permute(squeeze(Turbulence.windfield.u(1,:,:,:)),[2 1 3]),[xmin xmax],[ymax ymin],[zmin zmax]);
set(TurbBox2,'FaceColor','interp','EdgeColor','none','facelighting','none');
view(45,15)
axis equal
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
xlabel('x [m]')
ylabel('y [m]')
zlabel('z [m]')
title('u component snapshot at t2 (downstream)')


%% Show the yz planes
minU      = min(Turbulence.windfield.u(:));
maxU      = max(Turbulence.windfield.u(:));

fig2=figure('Color','w','Position',[969 102 811 357]);
movegui(fig2,'center')
for it=length(Turbulence.windfield.x):-1:length(Turbulence.windfield.x)-200 % with Taylor theory to convert x to time
    subplot(1,2,1)
    imagesc(Turbulence.windfield.y,Turbulence.windfield.z,squeeze(Turbulence.windfield.u(2,it,:,:))');
    caxis([minU maxU])
    %colormap redblue
    xlabel('y [m]');
    ylabel('z [m]');
    set(gca,'ydir','normal')
    title('u component at first yz planes (upstream)');
    axis equal
    ylim([min(Turbulence.windfield.y) max(Turbulence.windfield.y)])
    
    subplot(1,2,2)
    imagesc(Turbulence.windfield.y,Turbulence.windfield.z,squeeze(Turbulence.windfield.u(1,it,:,:))');
    caxis([minU maxU])
    %colormap redblue
    xlabel('y [m]');
    ylabel('z [m]');
    set(gca,'ydir','normal')
    title('u component at second yz planes (downstream)');
    axis equal
    ylim([min(Turbulence.windfield.y) max(Turbulence.windfield.y)])
    
    drawnow;
    pause(0.001)   
    
    
end
