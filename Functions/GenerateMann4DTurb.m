%% This function read in a turbulence structure which defines the 4D Mann turbulence parameters
% Then call the .exe to generate stochastic 4D Mann turbulence field.

% by Feng Guo on 13 Jan 2022£¬ @FUAS
% Developed within the LIKE (Lidar Knowledge Europe) project, funded by the European Union¡¯s Horizon, 2020 research
% innovation programme under the Marie-Curie grant agreement No. 858358
% according to the manuscript£º The space-time structure of turbulence for
% lidar-assisted wind turbine control, Feng Guo, Jakob Mann, Alfredo Pe?a, David Schlipf, Po Wen Cheng 


function Turbulence = GenerateMann4DTurb(Turbulence,TargetDir,ExeDir)

%TargetDir where to put the results
%ExeDir:   where the MannTurb4D.exe exist

if ~exist(TargetDir, 'dir')
       mkdir(TargetDir)
end


TextCell{1} = num2str(Turbulence.Field.n1);
TextCell{2} = num2str(Turbulence.Field.n2);
TextCell{3} = num2str(Turbulence.Field.n3);
TextCell{4} = num2str(Turbulence.Field.LMax(1));
TextCell{5} = num2str(Turbulence.Field.LMax(2));
TextCell{6} = num2str(Turbulence.Field.LMax(3));
TextCell{7} = num2str(Turbulence.Field.n_upstream);

for it = 1:Turbulence.Field.n_upstream
    TextCell{7+it} = num2str(round(Turbulence.Field.t_upstream(it),2));    
end


TextCell{end+1} = num2str(Turbulence.alphaeps);
TextCell{end+1} = num2str(Turbulence.L);
TextCell{end+1} = num2str(Turbulence.Gamma);
TextCell{end+1} = num2str(Turbulence.gamma);  
TextCell{end+1} = num2str(Turbulence.factor(1));
TextCell{end+1} = num2str(Turbulence.factor(2));
TextCell{end+1} = num2str(-Turbulence.Field.seed);

Text_temp= [TextCell{1} 'x' TextCell{2} 'x' TextCell{3} '_' TextCell{4}...
                'x' TextCell{5} 'x' TextCell{6} 'm_t'];
for it = 1:Turbulence.Field.n_upstream
 Text_temp = [Text_temp  strrep(TextCell{7+it},'.','d') '_'];                
end
Text_temp = [Text_temp 'ae' strrep(num2str(Turbulence.alphaeps),'.','d') 'L' strrep(num2str(Turbulence.L),'.','d') 'Gamma' strrep(num2str(Turbulence.Gamma),'.','d') 'Seed' num2str(Turbulence.Field.seed)];

TextCell{end+1} = [Text_temp   '.mt4d'];

Turbulence.Field.CaseName        =   Text_temp;          



if ~isfile([TargetDir '\' TextCell{end}])
    copyfile([ExeDir '\4Dtest_Input_v1.inp'],[Text_temp '.inp'])
    fileID      = fopen([Text_temp '.inp'],'w');            
    fprintf(fileID,'%s\n',TextCell{:});
    fclose(fileID);
    dos([ExeDir '\MannTurb4D_v1.exe',' ',Text_temp '.inp']);
    movefile([TextCell{end}], [TargetDir '\']) 
    movefile( [Text_temp '.inp'], [TargetDir '\']) 
else
    fprintf('The turbulence box already exist! \n')
end






end