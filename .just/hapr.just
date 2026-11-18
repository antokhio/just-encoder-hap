HAP_QUALITY := '0'
HAP_CHUNKS := '1'
HAP_COMPRESSOR := 'snappy'
HAP_OUTPUT_SUFFIX := '_hapr'

# Encode the first video stream as Hap R with alpha; copy any audio.
[arg('output', long, help='Output path (default: input name + _hapr.mov)')]
[arg('suffix', long, help='Default output filename suffix')]
[arg('threads', long, help='Decoder and encoder thread count')]
[arg('quality', long, help='Hap R texture quality: 0 speed, 1 balanced, 2 quality')]
[arg('chunks', long, help='Snappy chunk count (-1 for fixed 64 KiB chunks)')]
[arg('compressor', long, help='Second-stage compressor: snappy or none')]
[script('powershell.exe', '-NoLogo', '-NoProfile', '-File')]
hapr $input_path $output='' $threads=THREADS $quality=HAP_QUALITY $chunks=HAP_CHUNKS $compressor=HAP_COMPRESSOR $suffix=HAP_OUTPUT_SUFFIX:
    & $env:ENCODE_SCRIPT -Ffmpeg $env:HAP_FFMPEG -VideoArgs @(
        '-c:v', 'hap', '-format', 'hap_r', '-pix_fmt', 'rgba',
        '-texture_quality_hap_r', $env:quality, '-chunks', $env:chunks,
        '-compressor', $env:compressor
    )
    exit $LASTEXITCODE
