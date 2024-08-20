#!/bin/bash

pytom_match_template.py \
 -t ../templates/80S.mrc \
 -m ../templates/mask.mrc \
 -v ../dataset/tomo200528_100.mrc \
 -d ../results_80S/ \
 --particle-diameter 300 \
 -a ../dataset/tomo200528_100.rawtlt \
 --low-pass 40 \
 --defocus 3 \
 --amplitude 0.08 \
 --spherical 2.7 \
 --voltage 200 \
 --tomogram-ctf-model phase-flip \
 -g 0
