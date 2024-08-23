#!/bin/bash

# This script is used to update the permissions of the TM directory 
# inside of the fsl_imagseg group so that all group members can access the files inside

chmod -R ug+rxw /home/jblaser2/groups/fslg_imagseg/nobackup/archive/TM
chmod -R ug+rxw /home/jblaser2/scripts
