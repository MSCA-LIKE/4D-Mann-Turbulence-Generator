# 4D-Mann-Turbulence-Generator
A 4D turbulence simulation tool based on Mann model and the eddy lifetime solution (Ropelewski,Tennekes and Panofsk) Developed within the LIKE (Lidar Knowledge Europe) project, funded by the European Union’s Horizon, 2020 research innovation programme under the Marie-Curie grant agreement No. 858358 Author:  Feng Guo from Flensburg University of Applied Sciences,  Jakob Mann from Technical University of Denmark

## 1 Input parameters
<pre>
The Input parameters (in the example '4Dtest_adjLT.inp' file) are described below:<br />
4096  -Nx: The number of discrete points in the longitudinal dimention<br />
32    -Ny: The number of discrete points in the laveral dimention<br />
32    -Nz: The number of discrete points in the vertical dimention<br />
16384 -Lx: The total field length in the longitudinal dimention<br />
128   -Ly: The total field length in the laveral dimention<br />
128   -Lz: The total field length in the vertical dimention<br />
3     -Nt: The number of time steps of the 3D velocity field<br />
0     -t1: The first time of the field<br />
5     -t2: The second time of the field<br />
12    -t3: The third time of the field, note the times of the fields should match the number of time steps!<br />
0.11  -alphaEps: A energy level constant, can be adjust to reach target turbulence intensity<br />
50    - L: Turbulence length scale related to the size of the eddies that contains most of the energy<br />
3.2   - Gamma: The anisotropy constant defines the shear distortion effect <br />
400   - gamma: The evolution time constant, can be adjusted to get different longitudinal coherence <br />
1     - factor1:  for adjusting the slope of the shear related eddy lifetime "tau", the actual slope = -factor1,  for k magnitude approximate 0<br />
3.5   - factor2:  for adjusting the slope of the evolution related eddy lifetime "tau_e", the actual slope = -2/3*factor2,  for k magnitude approximate inf<br />
-33682           - A random seed number<br />
4DTurbExample.mt4d  - The output file name, with an extention of '.mt4d'. <br />
</pre>


## 2 How to run
Open a command line window, go to the directory where "MannTurb4D_v1.exe" and "4Dtest_Input_v1.inp" exist, then type in "MannTurb4D_v1.exe 4Dtest_Input_v1.inp" and press enter.
Alternatively, check the Matlab based example code "RunExampleAndVisualize.m", which calls the exetuable to generate 4D turbulence, import the results and visualize. 
Below is the example field generator by "MannTurb4D_v1.exe", which can be obtained by running "RunExampleAndVisualize.m".
![Field_two_Snapshots](https://user-images.githubusercontent.com/62547702/155133482-eba55353-7113-49ce-a1ce-a088c6949799.png)
The 3D turbulence fields snapshot taken at two different time slots and sliced at the space domain edges. 

![YzTurb_evo](https://user-images.githubusercontent.com/62547702/155133276-a53a4849-34ae-449e-8983-8ba0c06394e9.gif)
Two yz-plane turbulence fields recorded by different times are shown, the turbulence is animated by swaping in the x direction. 

## 3 Special Note
In the output file, the turbulence field is written as binary floating-point numbers ('real*4) in the following order: z->y->x->time->velocity component,  for the z y x dimention, the increasing index means the positive direction and the right hand rule is used for the z y x directions. Note that the turbulence is assumed to propogate towards the positive x direction. It is important to use the turbulence field in correct sqeuence because the uniform-linear wind shear included in Mann model results in eddies first arriving at higher vertical locations and then at lower vertical locations. When being applied to a turbine, the field should be read firstly from the largest x to the smallest x.

For example, the field with '.mt4d' extention can be imported to Matlab by 
<pre>

fileID         = fopen(['4DTurbExample.mt4d']);
uvw            = fread(fileID,'real*4');
fclose(fileID);

uvw            = reshape(uvw, [n3 n2 n1 length(t) 3]);  % the dimention and sequnce should be fixed here
u              = squeeze(uvw(:,:,:,:,1));
v              = squeeze(uvw(:,:,:,:,2));
w              = squeeze(uvw(:,:,:,:,3));
u              = permute(u,[4 1 2 3]);           % time, z, y , x
v              = permute(v,[4 1 2 3]);           % time, z, y , x
w              = permute(w,[4 1 2 3]);           % time, z, y , x
</pre>


## 4 Acknowledgement
This research has received partial funding from the European Union’s Horizon 2020 research and innovation program under the Marie Skłodowska-Curie Grant Agreement No. 858358 (LIKE—Lidar Knowledge Europe). See https://www.msca-like.eu/ for more details about the LIKE project.

## 5 Citing
Feng Guo, & Jakob Mann. (2022, Feb 22).  MannTurb4D_v1 (Version v1.0). Zenodo.: Initial release of the 4D Mann Turbulence Generator
DOI: 10.5281/zenodo.6223785 
