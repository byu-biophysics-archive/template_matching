#!/bin/bash

pytom_create_template.py \
 -i ../templates/emd_2938.map \
 -o ../templates/80S.mrc \
 --input-voxel 1.1 \
 --output-voxel 13.79 \
 --center \
 --invert \
 -b 60
