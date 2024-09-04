# CTS -- CryoTomoSim

This dir contains info on how to use [this](https://github.com/carsonpurnell/cryotomosim_CTS) matlab program

This is obviously not finished, but I wanted to put all the info I have here so that progress can continue to be made - Josh Blaser

1. There will be a version under the releases tab on the github home page, download the .zip file onto the supercomputer (I already did this under fsl_imagseg, it is under TM/tomo-sim/)

2. Also make sure the emtoolbox and IMOD and uipickfiles are installed like it says in the README

3. To load the program, just type 
```bash
module load matlab
matlab
```
make sure you have xforwarding setup first

4. The matlab GUI should pop up. From within the GUI, type ctsgui to load the CryoTomoSim program.
(I have only gotten it to work like this but we will need to learn how to run the tomogram simulation on the GPU using CTS on the command line. Will need to read up on [rc.byu.edu](rc.byu.edu) to see how to run matlab jobs on GPUs)

5. Finally, I got all of these parameters from Stefano:

Pixel size: 13.3 ang
\# of layers: 1
Iterations: 1000
Volume dimensions: X:1024 Y:1440 Z:400
Vitreous Ice:Y
Filaments:N
Membrane:Y
Vesicle #:1
Carbon Hole:Y
Diameter:2000nm
Thickness:11nm
Fiducials:Y
Fid. Diameter:10nm
Fid. Number:20
Constraint:none
Particle Density:0.6

Tilt Parameters: Max:60 Min:-60 Tilt Step:3
Defocus:8 microns
Voltage:300kV
Abberation:2.7mm
Envelope:1 or 0.7
Total Dose:160
Radiation Damage:1
Tilt Error:0
Dose Symmetric:1
Suffix:Whatever name you want



Input these all with the .pdb file of the flagellar motor from the RCSB website and it will generate a tomogram!
