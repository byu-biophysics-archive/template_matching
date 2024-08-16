###### Tried
- Set cutoff manually
	- Raised to 0.4, this got particles returned, but mostly fiducial beads. Can I bound it on both sides?
- Vary low pass filter on template
	- 0, 10, 20, 30, 35. So far it seems like 20 did the best, but still not great. Try on a different tomogram with more ribosomes and less fiducial beads?
###### To look at
- Vary angles
- Different template?
- Bound correlation on top and bottom?

Learn Job-arrays
## Parameters:
**Here is a list of all the hyperparameters available within the *pytom_match_template.py* function** -- the one's that likely affect TM effectiveness are BOLDED and Sorted into a smaller list at the end, the ones that are required are BOLDED and ENLARGED

Template, search volume, and output:
##### -t --template TEMPLATE
                        Template; MRC file. Object should match the contrast of the tomogram: if the tomogram has black
                        ribosomes, the reference should be black. (pytom_create_template.py has an option to invert contrast)
##### -v --tomogram TOMOGRAM
                        Tomographic volume; MRC file.
-d --destination DESTINATION
                        Folder to store the files produced by template matching.

Mask:
##### -m --mask MASK  Mask with same box size as template; MRC file.
  --non-spherical-mask  Flag to set when the mask is not spherical. It adds the required computations for non-spherical masks and
                        roughly doubles computation time.

Angular search:
  **--particle-diameter** PARTICLE_DIAMETER
                        Provide a particle diameter (in Angstrom) to automatically determine the angular sampling using the
                        Crowther criterion. For the max resolution, (2 * pixel size) is used unless a low-pass filter is
                        specified, in which case the low-pass resolution is used. For non-globular macromolecules choose the
                        diameter along the longest axis.
  **--angular-search** ANGULAR_SEARCH
                        This option overrides the angular search calculation from the particle diameter. If given a float it will
                        generate an angle list with healpix for Z1 and X1 and linear search for Z2. The provided angle will be
                        used as the maximum for the linear search and for the mean angle difference from healpix. Alternatively,
                        a .txt file can be provided with three Euler angles (in radians) per line that define the angular search.
                        Angle format is ZXZ anti-clockwise (see: https://www.ccpem.ac.uk/user_help/rotation_conventions.php).
  **--z-axis-rotational-symmetry** Z_AXIS_ROTATIONAL_SYMMETRY
                        Integer value indicating the rotational symmetry of the template around the z-axis. The length of the
                        rotation search will be shortened through division by this value. Only works for template symmetry around
                        the z-axis.

Volume control: *HELPS WITH SPEED OF TM*
  -s --volume-split VOLUME_SPLIT X Y Z
                        Split the volume into smaller parts for the search, can be relevant if the volume does not fit into GPU
                        memory. Format is x y z, e.g. --volume-split 1 2 1
  --search-x SEARCH_X X_0 X_F
                        Start and end indices of the search along the x-axis, e.g. --search-x 10 490
  --search-y SEARCH_Y SEARCH_Y
                        Start and end indices of the search along the y-axis, e.g. --search-x 10 490
  --search-z SEARCH_Z SEARCH_Z
                        Start and end indices of the search along the z-axis, e.g. --search-x 30 230
  --tomogram-mask TOMOGRAM_MASK
                        Here you can provide a mask for matching with dimensions equal to the tomogram. If a subvolume only has
                        values <= 0 for this mask it will be skipped.

Filter control:
##### **-a --tilt-angles** TILT_ANGLES
                        Tilt angles of the tilt-series, either the minimum and maximum values of the tilts (e.g. --tilt-angles
                        -59.1 60.1) or a .rawtlt/.tlt file with all the angles (e.g. --tilt-angles tomo101.rawtlt). In case all
                        the tilt angles are provided a more elaborate Fourier space constraint can be used
  --per-tilt-weighting  Flag to activate per-tilt-weighting, only makes sense if a file with all tilt angles have been provided.
                        In case not set, while a tilt angle file is provided, the minimum and maximum tilt angle are used to
                        create a binary wedge. The base functionality creates a fanned wedge where each tilt is weighted by
                        cos(tilt_angle). If dose accumulation and CTF parameters are provided these will all be incorporated in
                        the tilt-weighting.
  **--voxel-size-angstrom** VOXEL_SIZE_ANGSTROM
                        Voxel spacing of tomogram/template in angstrom, if not provided will try to read from the MRC files.
                        Argument is important for band-pass filtering!
  **--low-pass** LOW_PASS
  - Apply a low-pass filter to the tomogram and template. Generally desired if the template was already filtered to a certain resolution. Value is the resolution in A.
  **--high-pass** HIGH_PASS
  - Apply a high-pass filter to the tomogram and template to reduce correlation with large low frequency variations. Value is a resolution in A, e.g. 500 could be appropriate as the CTF is often incorrectly modelled up to 50nm.
  **--dose-accumulation** DOSE_ACCUMULATION
                        Here you can provide a file that contains the accumulated dose at each tilt angle, assuming the same
                        ordering of tilts as the tilt angle file. Format should be a .txt file with on each line a dose value in
                        e-/A2.
  **--defocus DEFOCUS**     Here you can provide an IMOD defocus (.defocus) file (version 2 or 3) , a text (.txt) file with a single
                        defocus value per line (in nm), or a single defocus value (in nm). The value(s), together with the other
                        ctf parameters (amplitude contrast, voltage, spherical abberation), will be used to create a 3D CTF
                        weighting function. IMPORTANT: if you provide this, the input template should not be modulated with a CTF
                        beforehand. If it is a reconstruction it should ideally be Wiener filtered.
  **--amplitude-contrast** AMPLITUDE_CONTRAST
                        Amplitude contrast fraction for CTF.
  **--spherical-aberration** SPHERICAL_ABERRATION
                        Spherical aberration for CTF in mm.
  **--voltage** VOLTAGE     Voltage for CTF in keV.
  **--phase-shift** PHASE_SHIFT
                        Phase shift (in degrees) for the CTF to model phase plates.
  **--tomogram-ctf-model** {phase-flip}
                        Optionally, you can specify if and how the CTF was corrected during reconstruction of the input tomogram.
                        This allows match-pick to match the weighting of the template to the tomogram. Not using this option is
                        appropriate if the CTF was left uncorrected in the tomogram. Option 'phase-flip' : appropriate for IMOD's
                        strip-based phase flipping or reconstructions generated with novaCTF/3dctf.
  **--spectral-whitening**  Calculate a whitening filtering from the power spectrum of the tomogram; apply it to the tomogram patch and template. Effectively puts more weight on high resolution features and sharpens the correlation peaks.

Additional options:
  **-r, --random-phase-correction**
                        Run template matching simultaneously with a phase randomized version of the template, and subtract this
                        'noise' map from the final score map. For this method please see STOPGAP as a reference:
                        https://doi.org/10.1107/S205979832400295X .
  **--rng-seed RNG_SEED**   Specify a seed for the random number generator used for phase randomization for consistent results!

Device control:
##### -g GPU_IDS 
  [GPU_IDS ...], --gpu-ids GPU_IDS [GPU_IDS ...]
                        GPU indices to run the program on.

Logging/debugging:
  --log LOG             Can be set to `info` or `debug`

## Params to test:
1. **--particle-diameter**. Y
2. **--angular-search**. Y
3. **--z-axis-rotational-symmetry** Y- have a guess fo FM
4. ***-a --tilt-angles*** Y
5. **--voxel-size-angstrom**
6. **--low-pass** 0.05
7. **--high-pass** 0.35 --can tune on reference tomogram
8. **--dose-accumulation**. N
9. **--defocus**. Y
10. **--amplitude-contrast** 0.1 or 0.07
11. **--spherical-aberration** 2.7
12. **--voltage** 300 (keV)
13. **--phase-shift** N
14. **--tomogram-ctf-model**, N
15. **--spectral-whitening** Y (on/off)
16. **-r, --random-phase-correction** N (on/off)
17. **--rng-seed RNG_SEED** N


One with Sirt-- more human friendly but gets rid of  and one with weighted beck projection-- useful for high frequency information
reconstruction algorithms

open imod
	add point with left click, move to end of diameter point and press q, will print diameter in pixels and nanometer
