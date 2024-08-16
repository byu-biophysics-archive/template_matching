#### Testing Installation
1. Run `git clone https://github.com/KosinskiLab/pyTME.git`
2. Run `cd pyTME`
3. Run `salloc --nodes=1 --mem=64G --gpus=1 --time=00:10:00` or whatever time you need
4. Once on the GPU node, run `pytest` there