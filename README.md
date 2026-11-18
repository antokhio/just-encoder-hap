# Video encoding recipes

On Windows, install [just](https://just.systems/) and run from this directory. Replace the example paths with your own files.

## Hap to ProRes 4444

```powershell
just prores4444 ".\videos\input.mov"
```

By default this writes `input_prores.mov` alongside the input. It uses `lib\win-64\ffmpeg.exe` and preserves alpha.

## ProRes to Hap R

```powershell
just hapr ".\videos\input_prores.mov"
just hapr ".\videos\input_prores.mov" --quality 1 --output ".\videos\result.mov"
```

The default output is `input_prores_hapr.mov` alongside the input. This uses `lib\win-64\ffmpeg.exe`, a GPLv3-or-later build. Hap R uses lossy BC7 compression; its RGBA input is 8-bit, so higher-precision source alpha is reduced.

## Configuration

Each recipe encodes the first video stream, copies any audio streams, and refuses to overwrite existing output. Relative input and output paths are resolved from the directory where `just` is invoked.

The executable paths and default thread count are in `.just\common.just`. Both pipelines use the same FFmpeg build by default; `HAP_FFMPEG` can be overridden separately. Pipeline-specific defaults are in `.just\prores4444.just` and `.just\hapr.just`. Change them there or override them for one invocation with `just --set NAME VALUE`, for example:

```powershell
just --set THREADS 8 prores4444 ".\videos\input.mov"
just --set HAP_QUALITY 1 hapr ".\videos\input_prores.mov"
```

Run `just --usage prores4444` or `just --usage hapr` for options. Existing output files are not overwritten; choose a different output path or move the existing file first.

## Contributing and license

See [CONTRIBUTING.md](CONTRIBUTING.md) for adding profiles. Project files are licensed under [MIT](LICENSE). The bundled FFmpeg build and its components have separate licenses; see the license files in `lib\win-64`.

## Credits

- [DemolitionStudios](https://github.com/DemolitionStudios)

Based on [fork](https://github.com/DemolitionStudios/FFmpeg/tree/hap_bc6h) by [DemolitionStudios](https://github.com/DemolitionStudios)
