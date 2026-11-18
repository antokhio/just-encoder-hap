# Override these defaults here or with `just --set NAME VALUE ...`.
export FFMPEG := justfile_directory() / 'lib' / 'win-64' / 'ffmpeg.exe'
export HAP_FFMPEG := FFMPEG
THREADS := '12'
export INVOCATION_DIRECTORY := invocation_directory()
export ENCODE_SCRIPT := justfile_directory() / '.just' / 'encode.ps1'
