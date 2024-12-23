# MinUI282 

MinUI282 is for the Miyoo A30.

It has updated ARMv7-HF-NEON cores and supports organized ROM & Imgs structure for boxart / screenshots.
(e.g., Roms/Console/Imgs/Game.png, where images are named to match their corresponding ROM zip files, such as Game.zip).

## How to Build

Clone the repository:

```bash
git clone https://github.com/05warmupsdelayer/MinUI282.git
cd MinUI282
make
```

Default make downloads lastest cores from [here (armv7-hf-neon cores)](https://zoltanvb.github.io/armv7-hf-neon/) 
The cores are built using using [zoltanvb/retroarch-cross-compile](https://github.com/zoltanvb/retroarch-cross-compile) 

To build the cores using old patches and releases from MinUI, run this before `make`:

```bash
mv workspace/my282/cores/makefile workspace/my282/cores/makefile.download && \
mv workspace/my282/cores/makefile.build workspace/my282/cores/makefile
```
