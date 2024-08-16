 #### Batch Tomogram Reconstruction
***Notes on [batchruntomo](https://bio3d.colorado.edu/imod/doc/man/batchruntomo.html#TOP)***
- 

| File  | Use                                                           |
| ----- | ------------------------------------------------------------- |
| .adoc | batch and templates used to control reconstruction parameters |
| .ebt  | project file                                                  |
| .mrc  | tilt series                                                   |
| .st   | tilt series, .mrc are converted to this for processing        |
| .com  | command file                                                  |
| .log  | log file with output from run                                 |
Path to cryoSample.adoc on sc: `/home/ejl62/Downloads/imod_4.11.25/SystemTemplate/cryoSample.adoc`
Sample run script from [here](https://liacs.leidenuniv.nl/assets/Bachelorscripties/Inf-studiejaar-2014-2015/2014-2015SimonRKlaver.pdf)
```bash title:sample_batchruntomo
Batchruntomo.no−move −ro 140502 Qbeta tomo2 0 −current / home/user/tomo/Qbeta −deliver /home/tomography/ ResultatenSimon/Qbeta✩{i} /home/user/tomo/ batchQbetatest . adoc
```
- `-ro (-root)` - dataset name
- `-current` - directory dataset is in
- `-deliver` - directory to put dataset in
- The .adoc file has no preceding flag, but is the options for the dataset. Can be preceded by `-directive`

##### Notes on Pipeline from Stefano
*Main functions:*
db3_inc.py  - pipeline variables and functions definitions
db3_start.py - lunching new pipeline or re-run  
db3_proc.py - pipeline main loop over new tilt series
db3_rerun.py - main loop for rerun reconstructions on tilt series already in DB
db3_procone.py - pipeline individual tilt series processing
dirTemplate.adoc - used for IMOD's Batchruntomo and automatic fiducial seeding and tracking
Patch (directory) - code for patch reconstruction (it does not give high quality reconstruction but usually will produce at least a reconstruction if RAPTOR fails)
jpath.shrc - sample PATH setting file (optional)
my guess is that somewhere in the code there should be a line calling Batchruntomo (db3_proc.py or db3_procone.py) I can take a look this evening.
##### My Notes on Pipeline Files
`jpath.shrc` - bash script to add directories to path. Not helpful for me.
`db3_start.py` - writes job script and runs it using `sbatch <jobfile>`. Either runs a FISE reconstruction or makes a movie I think. May be helpful later on.
`db3_inc.py` - sets up MySQL database and defines a variety of functions. These mostly look related to data mangement, not reconstruction so probably not helpful
`db4_proc.py` - Organizes the pipeline in general. Gets uploaded files, reads in flags for processing specifications, and coordinates writing to the MySQL database. Writes some job scripts as well, but I just skimmed that part. Does not call `batchruntomo`
`db3_procone.py` - has a bunch of functions to run processes. Actually runs batchruntomo, helpful
