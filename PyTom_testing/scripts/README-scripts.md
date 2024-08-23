#### These scripts are important and useful when using and setting up Pytom_match_pick
That being said, it will be useful to make them executable while your virtual environment is activated.
Follow these steps to do so:

Find the path to your virtual environment, (when using conda it will be under .conda/envs/pytom_tm)
move into this directory
Create the following directories under your env directory using this command:
```bash
mkdir -p ./etc/conda/activate.d
mkdir -p ./etc/conda/deactivate.d
```
Now 
```bash
vim ./etc/conda/activate.d/path.sh
```
Copy and paste this into your new path.sh file, make sure to update the tmdir path
```bash
#!/bin/bash
tmdir=path/to/your/clone/of/this/repo
export PATH="$tmdir/template_matching/PyTom_testing/scripts:$PATH"
```
Run:
```bash
source ./etc/conda/activate.d/path.sh
```

This will make all scripts in the scripts repo accessible while pytom_tm environment is activated.
