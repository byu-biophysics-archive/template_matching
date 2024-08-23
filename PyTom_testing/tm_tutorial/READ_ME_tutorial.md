# Instructions for tutorial
This tutorial will work best when running on GPUs. If running on CPU you must edit the bash scripts
- Take a brief look through [this](https://sbc-utrecht.github.io/pytom-match-pick/tutorials/Tutorial/#running-template-matching_1) website
  - We have conveniently already uploaded the necessary tutorial files to this folder
  - We have also written scripts to run each individual function which can be found under the scripts folder
- Be sure to activate your conda environment by running `conda activate pytom_tm`
  - Go through each script in order, examine the different parameters and options and what they each mean
  - You can even learn more about each function by running `pytom_match_template --help` etc.
  - Run each script by simply typing `create_mask.sh`, etc. within the scripts dir
- You will see that each of the scripts run a different function and create a different set of output files
  - You should be able to compare these output files with those located in the example_results directory
    - Two files of note are the scores.mrc file which is generated from the match_template function and the roc.svg file which is generated from the estimate_roc function
    - Take a second to view the scores.mrc file next to it's original tomogram using the tomogram_viewer.py script which is located a few directories back with instructions on how to make it exectubale from anywhere within your environment
    - The .svg file can be viewed easily in vscode. The data point of note is the RUC, which is a sort of accuracy rating of the template matching-- 0 is bad, 1 is good

Good job on your completion of the tutorial!!

### Order of scripts:
```bash
pytom_create_template.py
pytom_create_mask.py
pytom_match_template.py
pytom_estimate_roc.py
pytom_extract_candidates.py
```
