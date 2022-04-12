
try {
  Push-Location $PSScriptRoot

  gps dotnet -ErrorAction SilentlyContinue | kill

  & dotnet pack -nologo ..\Basic.Arm64.Build -p:Version=0.0.0.1

  $restoreSource = Join-Path $PSScriptRoot "..\Basic.Arm64.Build\bin\Debug"
  & dotnet build -nologo -p:RestoreSources="$restoreSource"
}
finally {
  Pop-Location
}