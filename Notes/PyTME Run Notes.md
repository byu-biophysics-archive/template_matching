## Questions:
- What are is the tilt range on our tomograms? The tilt step?
- Tilt range: in tilt series header (usually ± 55°)
- Tilt step: try 3°
#### Building a Template
From what Stefano told me, we need an electron density map. I'm going to start by testing *Caulobacter Crescentus (vibrioides)* because we have some good tomograms of that one with flagellar motors.

For the first run, I got the electron density map from https://www.ebi.ac.uk/emdb/EMD-10943. I downloaded the map.gz file, which per pyTME's docs we don't need to unpack? I still have questions about the file format.

#### To try for running template matching
- use `--use_gpu` and figure out how to create a job on the supercomputer for this
- use `--invert_target_contrast` pyTME uses the opposite convention for electron density than our tomograms I'm pretty sure. We use dark to represent high electron density, they want light for high electron density
- run with `--no_fourier_padding` we should be ok because we have a lot of data and can use GPU
- figure out `--tilt_range` - ask Stefano or Grant what the tilt range was for the microscope used

##### Attempt 1 (4/3/24) - FAILED
###### Initial Thoughts
- Run time was 05:28:09, so maybe increase wall time next time to make sure it can finish?
- The output file (`tm_test_1.pickle`) was never generated, which makes me think it never finished
- Possible problems:
	- Resampling problems?
	- According to copilot, it ran out of memory
	- This doesn't make sense though because I allocated 100G of memory, but the output script never references allocating more than 3G
	- Reading more, I may not have allocated resources on the supercomputer correctly in my pytme script, which could definitely have caused my issue. Going to change parameters and try again

Script:
```bash title:FM_Attempt_1
#!/bin/bash --login

  

#SBATCH --time=6:00:00 # walltime

#SBATCH --ntasks=1 # number of processor cores (i.e. tasks)

#SBATCH --nodes=1 # number of nodes

#SBATCH --gres=gpu:2

#SBATCH -C 'pascal' # features syntax (use quotes): -C 'a&b&c&d'

#SBATCH --mail-user=ejl62@byu.edu # email address

#SBATCH --mail-type=BEGIN

#SBATCH --mail-type=END

#SBATCH --export=NONE

#SBATCH --mem 100G

  

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

  

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

  

module load miniconda3/latest

source activate pytme

  

python /home/ejl62/pyTME/scripts/match_template.py \

-m /home/ejl62/fsl_groups/grp_tomo_db1_d1/compute/TomoDB1_d1/FlagellarMotor_P1/Caulobacter\ crescentus/flag_3_full.rec \

-i /home/ejl62/pyTME/emd_10943.map.gz \

--invert_target_contrast \

-n 1 \

-a 1 \

--use_gpu \

--no_fourier_padding \

-o /home/ejl62/pyTME/tm_test_1.pickle # this file never properly generated
```

##### Attempt 2 (4/6/24)
- Major changes
	- Increased walltime to 8hrs (6 previously)
	- --gpus=4 (from 2)
	- --mem 60G (from 100G)
	- -n 4 (from 2) (still not sure if this is the right number)
	- -a 5 (from 1)
	- -r 60G (didn't have it before)
Script:
```bash title:FM_Attempt_2
#!/bin/bash --login

  

#SBATCH --time=8:00:00 # walltime

#SBATCH --ntasks=1 # number of processor cores (i.e. tasks)

#SBATCH --nodes=1 # number of nodes

#SBATCH --gpus=4

#SBATCH -C 'pascal' # features syntax (use quotes): -C 'a&b&c&d'

#SBATCH --mail-user=ejl62@byu.edu # email address

#SBATCH --mail-type=BEGIN

#SBATCH --mail-type=END

#SBATCH --export=NONE

#SBATCH --mem 60G

  

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

  

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

  

module load miniconda3/latest

source activate pytme

  

python /home/ejl62/pyTME/scripts/match_template.py \

--target /home/ejl62/fsl_groups/grp_tomo_db1_d1/compute/TomoDB1_d1/FlagellarMotor_P1/Caulobacter\ crescentus/flag_3_full.rec \

--template /home/ejl62/pyTME/emd_10943.map.gz \

--invert_target_contrast \

--use_gpu \

-n 4 \

-a 5 \

-r 60000000000 \

--no_fourier_padding \

-o /home/ejl62/pyTME/tm_test_1.pickle
```

##### Attempt 3 (7/2/24)
- This attempt is very similar to 2, as I'm trying to remember where I was on this/get it set up on RHEL 9. The only real difference was that I added a module load for CUDA, which may be important.
- For what I'm calling attempt 3.1, I'm just changing the miniconda3 module load line to `module load miniconda3/24.3.0-poykqmt`. Apparently `module load miniconda3/latest` doesn't work in RHEL 9 yet? Keep an eye on this and manually update it I guess
- After some debugging the script, got it working and got a CuPy error. It's a new one though, so that's progress!
```bash title:FM_Attempt_3
#!/bin/bash --login

#SBATCH --time=8:00:00 # walltime
#SBATCH --ntasks=1 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1 # number of nodes
#SBATCH --gpus=4
#SBATCH -C 'pascal' # features syntax (use quotes): -C 'a&b&c&d'
#SBATCH --mail-user=ejl62@byu.edu # email address
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END
#SBATCH --export=NONE
#SBATCH --mem 60G
# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE
module load miniconda3/24.3.0-poykqmt
module load cuda/12.4.1-pw6cogp

source activate pytme

  

  

python /home/ejl62/pyTME/scripts/match_template.py \

  

--target /home/ejl62/fsl_groups/grp_tomo_db1_d1/nobackup/archive/TomoDB1_d1/FlagellarMotor_P1/Caulobacter crescentus/flag_3_full.rec \

  

--template /home/ejl62/Documents/template_matching/fm_caulo_tm/flagellum_AvgVol_4P120.mrc \

  

--invert_target_contrast \

  

--use_gpu \

  

-n 4 \

  

-a 5 \

  

--memory_scaling 0.96 \

  

--no_fourier_padding \

  

-o /home/ejl62/nobackup/archive/template_matching
```

##### Attempt 4 (7/2/24)
- Still got the `CuPy failed to load libnvrtc.so.12` error, even after installing `cudatoolkit` in the mamba environment. Do I need to load the module instead?
- Ended up trying setting cuda paths manually in the job script for the next attempt
##### Attempt 5 (7/3/24)
- Added these lines to the job script
```bash
export PATH=/apps/spack/root/opt/spack/linux-rhel9-haswell/gcc-13.2.0/cuda-12.4.1-pw6cogp5nuczn2qcgqnw6lvqdznny2ef/bin:${PATH}
export LD_LIBRARY_PATH=/apps/spack/root/opt/spack/linux-rhel9-haswell/gcc-13.2.0/cuda-12.4.1-pw6cogp5nuczn2qcgqnw6lvqdznny2ef/lib64:${LD_LIBRARY_PATH}
```
- Hopefully this will help the system find `libnvrtc.so.12` module
- It worked! Took 01:23:55 to finish
- **Review of output**
	- Basically, pytme did not do very well. I gave it a tomogram with 1 motor, and it returned 227 'matching' regions. However, my hyperparameters and mask were probably not ideal. For now, I'm going to focus on pytom, as it seems to be working better.