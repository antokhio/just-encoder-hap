# Contributing

## Adding an encoding profile

1. Check that the bundled FFmpeg supports the encoder and options you need, for example:

   ```powershell
   .\lib\win-64\ffmpeg.exe -hide_banner -h encoder=hap
   ```

2. Add a `.just\<profile>.just` file and import it from the root `.justfile`. Use the existing [ProRes](.just/prores4444.just) and [Hap R](.just/hapr.just) recipes as examples.
3. Give the recipe a descriptive name, define profile-specific defaults in its file, and expose useful overrides with `just` argument attributes. Use distinct variable names so imported profiles do not conflict. Put settings shared by multiple profiles in [.just\common.just](.just/common.just).
4. For a MOV profile that maps the first video stream and copies audio, reuse [.just\encode.ps1](.just/encode.ps1). Export recipe parameters `input_path`, `output`, `threads`, and `suffix` with `$`; pass the FFmpeg executable as `-Ffmpeg` and the video encoder options as a `-VideoArgs` array. The helper resolves relative paths from the invocation directory, refuses to overwrite output, and propagates FFmpeg's exit code. Profiles requiring different stream mapping, audio handling, or containers need an appropriate implementation rather than assuming this helper supports them.
5. Document the command, defaults, output naming, supported alpha, and any format limitations in [README.md](README.md).

## Validation

Run `just --list`, `just --usage <profile>`, and `just --fmt --check`. Encode a small representative fixture to a new output path and inspect it with `.\lib\win-64\ffprobe.exe`; verify the intended codec, format, duration, and any required alpha or audio behavior. Also check that missing input and an existing output fail. Test existing recipes when changing shared settings or the helper.

Keep test media outside the project where possible. Git ignores the default `_prores.mov` and `_hapr.mov` outputs; use a different name or explicitly add a file if a small fixture must be tracked.

## Third-party binaries

Keep FFmpeg's runtime DLLs and license files together. The bundled build is GPLv3-or-later, and its components may have additional license requirements; consult the files in `lib\win-64` when updating or distributing it. The project files are licensed separately under [MIT](LICENSE).

## Credits

- [leavittx](https://github.com/leavittx)

Based on [DemolitionStudios](https://github.com/DemolitionStudios) https://github.com/DemolitionStudios/FFmpeg/tree/hap_bc6h
