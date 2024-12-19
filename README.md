# MinUI282 (Miyoo A30)

Updated ARMv7-HF-NEON cores.

Supports organized ROM and image structures (e.g., Roms/Console/Imgs/Game.png, where images are named to match their corresponding ROM zip files, such as Game.zip).

[used code from (vMyFinUI_20240401)](https://github.com/Turro75/MyFinUI_RG35XXOG/releases/tag/vMyFinUI_20240401)  
Thanks to [Turro75](https://github.com/Turro75)!

## How to Build

Clone the repository:

```bash
git clone https://github.com/05warmupsdelayer/MinUI282.git
cd MinUI282
make
```

Default make downloads lastest cores from [here (armv7-hf-neon cores)](https://zoltanvb.github.io/armv7-hf-neon/)

Core are built using using [zoltanvb/retroarch-cross-compile](https://github.com/zoltanvb/retroarch-cross-compile)

To build cores, run this before `make`:

```bash
mv workspace/my282/cores/makefile workspace/my282/cores/makefile.download && \
mv workspace/my282/cores/makefile.build workspace/my282/cores/makefile
```
