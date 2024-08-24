# Pytom setup and use tutorial

### Setup on SSH (5-10 min)
1. Login to Supercomputer
2. You will need to setup an environment using the following commands:
([Here](https://github.com/SBC-Utrecht/pytom-match-pick?tab=readme-ov-file) is the github we got this from, so check here if it's not working) 
```conda create -n pytom_tm python=3```
3. Activate: `conda activate pytom_tm`
4. Install cupy using ```mamba install cupy```
5. Now pip install pytom match pick: `python -m pip install pytom-match-pick`

### Use
**Before you try to use pytom for other things, run through the tutorial**
- To make it easier, we will attach all the files you need to download for the tutorial under the [tm_tutorial](https://github.com/byu-biophysics-sandbox/template_matching/tree/main/PyTom_testing/tm_tutorial) directory that way it will save you some hassle downloading the correct files
- [Here](https://sbc-utrecht.github.io/pytom-match-pick/tutorials/Tutorial/) is the tutorial from pytom
- There are more instructions in the [tm_tutorial](https://github.com/byu-biophysics-sandbox/template_matching/tree/main/PyTom_testing/tm_tutorial) directory

\*\****If you're still reading here than you've already completed the tutorial***
- You should now know that pytom-match-pick has 5 basic functions:
    - pytom_create_template.py
    - pytom_create_mask.py
    - pytom_match_template.py
    - pytom_estimate_roc.py
    - pytom_extract_candidates.py
### Overview of functions
- Creating the Template and Mask
    - The create template and create mask functions are used to create the template and mask of a certain structure of a certain species.
    - These are made by feeding in an electron density map of the structure and understanding the general shape of the structure

- Template Matching
  - The match template function performs the template matching.
  - While the previous functions simply create the template and mask, this function uses those two files to find the specific structure within the 3D tomogram
  - Thus, a single template and mask can be used to perform template matching on any number of tomograms of the species from which it comes
  - Template matching is done through a matching algorithm which typically works like so:
  - **Matching Algorithm**
    - Feature Extraction: Extract features from both the template and the volume. These features could include surface details, edges, or keypoints.
    - Matching and Transformation: The matching algorithm searches for the template within the volume by applying various transformations, such as translation, rotation, and scaling, to the template. Techniques include:
    - Cross-Correlation: Compute the correlation between the template and various regions of the volume to find the best match.
    - Similarity Measures: Use measures like Mutual Information or Sum of Squared Differences to assess similarity between the template and the volume.
    - Optimization: Use optimization algorithms to refine the position and orientation of the template to achieve the best match.

- Estimate Roc and Extract Candidates
  - These functions somehow extract important information about the accuracy of the template matching and display visuals 

