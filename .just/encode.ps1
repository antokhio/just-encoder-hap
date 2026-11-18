param(
    [Parameter(Mandatory = $true)]
    [string] $Ffmpeg,
    [Parameter(Mandatory = $true)]
    [string[]] $VideoArgs
)

$ErrorActionPreference = 'Stop'
$inputPath = $env:input_path
if (-not [IO.Path]::IsPathRooted($inputPath)) {
    $inputPath = Join-Path $env:INVOCATION_DIRECTORY $inputPath
}
$inputFile = Get-Item -LiteralPath $inputPath
if ($inputFile.PSIsContainer) {
    throw "Input is not a file: $inputPath"
}

$outputPath = $env:output
if ([string]::IsNullOrEmpty($outputPath)) {
    $outputPath = Join-Path $inputFile.DirectoryName ($inputFile.BaseName + $env:suffix + '.mov')
} elseif (-not [IO.Path]::IsPathRooted($outputPath)) {
    $outputPath = Join-Path $env:INVOCATION_DIRECTORY $outputPath
}

& $Ffmpeg -n -xerror -threads $env:threads -i $inputFile.FullName `
    -map 0:v:0 -map '0:a?' -threads $env:threads @VideoArgs -c:a copy $outputPath
exit $LASTEXITCODE
