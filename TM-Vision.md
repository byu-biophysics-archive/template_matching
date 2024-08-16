## What is Template matching?

## TM Vision:
**Use and optimize Template Matching to better the particle picking process in CryoET**
#### Overall Goal
**Our greater Template Matching vision is to:**
- Learn how to do Template Matching
	- Understand the process:
		1. How the structure is formed (ChimeraX)
		2. creating a mask and a template from the PDB files
		3. Find which tomograms and templates to use
		4. Possibly create a synthetic tomogram
		5. Running the template matching program (pytom) with all the different parameters
			- Know how TM actually works: (Cross-correlation, density map, etc)
		6. Evaluate how well the program did
		7. Use the evaluation to return to previous steps and tweak them
		8. Do it all on the supercomputer (just adds a little extra level of trickiness but it is necessary bc TM has to run on GPUs)
- Try to combine the TM process with other methods 
	- (such as a combination of ML and TM, SAM could be useful to find the specific area within the tomogram to search for TM, which are relatively easy parameters to set.)
- Once we understand it well, we apply the knowledge to finding the greatest solution to the problem of particle picking!


- We do not have all the exact files and parameters that create the most effective template matching based on our data
	- (when I say information I mean the parameters/options in pytom's TM function)
	- lots of the information needed comes from the microscope itself (angles, z-axis rotational symmetry, etc)
	- some of the microscope info grant may know and some we may be able to make an educated guess
	- some of the info just needs to be tweaked based on the tomogram and bacteria and what we're searching for like LP and HP
- Point is, we will have to figure out which parameters to use on which tomograms
- **Flagellar Motors**
	- Template matching is usually pretty good at finding lots of objects within a 3d tomogram
	- As far as flagellar motors go, there are usually 0-3 in each tomogram-- pretty sparse
	- In order to tweak our template matching to be the most effective, we are planning on creating a **Synthetic Tomogram** to give the algorithm even more Flagellar motors to find, ***This is an important problem to solve*** 
		- We need to first find a mask and template that we have of the flagellar motor
		- Then we need to use that mask to simulate a tomogram
		- Then we need to test the effectiveness of template matching of the FM on this synthetic tomogram
	- Once we prove that TM for FM can work well on a synthetic tomogram, and we have fine-tuned the parameters for it, we will try it on normal tomograms and fine tune it to show the exact locations of the motors
	- Using the score map, we will need to extract the coordinates of the positive locations (where TM said there is a motor) and be able to pull it up in imod or napari

## Current File setup for TM on SSH

- the root directory/folder is `~/groups/fsl_imagseg/nobackup/archive/TM/`
- The TM folder is located within the shared fsl group...
	- However, sometimes the file and directory permissions will inhibit other group members from accessing the files. Therefore, it is important to consistently run:
	 ```bash 
	 chmod -R ug+rwx ~/groups/fsl_imagseg/nobackup/archive/TM/
```
- it will also be **important** that our output data is saved somewhere online (in the [github](https://github.com/byu-biophysics/template_matching))
- The architecture of the TM directory looks like so:`
- pytom
	- pytom_tutorial
		- dataset
		- templates
		- results
- qd_tm_results
	- 45
	- 50
	- 55
	- 60
- fm_tm
	- Caulobacter-Crecsentus
		- templates
		- dataset
		- results
	- Hylemonella-Gracillus
		- templates
		- dataset
		- results
	- Synthetic
		- templates
		- dataset
		- results
			- angles
			- 

## Simulate a tomogram
```bash
conda create -n tomo-sim
conda activate tomo-sim
```
Install synthetic tomogram **program** as a package
***Need to pick which one***^^
Useful info for when simulating tomogram:
- should know what the dimensions of tomograms usually are
- should find a flagellar motor template and mask from EMDB or EMPIAR
- make sure that there are membranes without the FM in it as well-- this way we can tune TM to find the FM and not just the inner and outer membrane
- 

## Update Github
- important scripts, add to repo, make instructions with how to make accessible from the pytom_tm environment
- scripts on local device to view tomograms
- scripts to update permissions
- documentation to describe how to setup pytom, use it, and do the tutorial- OVER EXPLAIN
- add all the files from the tutorial to speed up new user setup process
