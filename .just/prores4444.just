PROFILE := '4'
ALPHA_BITS := '16'
PIXEL_FORMAT := 'yuva444p10le'
OUTPUT_SUFFIX := '_prores'

# Encode the first video stream as ProRes 4444 with alpha; copy any audio.
[arg('output', long, help='Output path (default: input name + _prores.mov)')]
[arg('suffix', long, help='Default output filename suffix')]
[arg('threads', long, help='Decoder and encoder thread count')]
[arg('profile', long, help='ProRes profile')]
[arg('alpha_bits', long='alpha-bits', help='ProRes alpha bit depth')]
[arg('pixel_format', long='pixel-format', help='Output pixel format')]
[script('powershell.exe', '-NoLogo', '-NoProfile', '-File')]
prores4444 $input_path $output='' $threads=THREADS $alpha_bits=ALPHA_BITS $profile=PROFILE $pixel_format=PIXEL_FORMAT $suffix=OUTPUT_SUFFIX:
    & $env:ENCODE_SCRIPT -Ffmpeg $env:FFMPEG -VideoArgs @(
        '-c:v', 'prores_ks', '-profile:v', $env:profile,
        '-alpha_bits', $env:alpha_bits, '-pix_fmt', $env:pixel_format
    )
    exit $LASTEXITCODE