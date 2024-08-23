# Pytom setup and use tutorial

### Setup on SSH
1. Login to Supercomputer
2. You will need to setup an environment using the following commands:
([Here](https://github.com/SBC-Utrecht/pytom-match-pick?tab=readme-ov-file) is the github we got this from, so check here if it's not working) 
```conda create -n pytom_tm python=3```
3. Activate: `conda activate pytom_tm`
4. Install cupy using ```mamba install cupy```
5. Now pip install pytom match pick: `python -m pip install pytom-match-pick`

### Use
**Before you try to use pytom for other things, run through the tutorial**
- To make it easier, we will attach all the files you need to download for the tutorial under the [tm_tutorial](https://github.com/byu-biophysics/template_matching/tree/main/PyTom_testing/tm_tutorial) directory that way it will save you some hassle downloading the correct files
- [Here](https://sbc-utrecht.github.io/pytom-match-pick/tutorials/Tutorial/) is the tutorial from pytom
- There are more instructions in the [tm_tutorial](https://github.com/byu-biophysics/template_matching/tree/main/PyTom_testing/tm_tutorial) directory

\*\****If you're still reading here than you've already completed the tutorial***
- You should now know that pytom-match-pick has 5 basic functions:
    - pytom_create_template.py
    - pytom_create_mask.py
    - pytom_match_template.py
    - pytom_estimate_roc.py
    - pytom_extract_candidates.py


