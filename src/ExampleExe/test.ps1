
try {
  Push-Location $PSScriptRoot

  $packages = Join-Path $PSScriptRoot ".nuget\packages"
  Remove-Item -Recurse $packages -ErrorAction SilentlyContinue
  Remove-Item -Recurse bin,obj -ErrorAction SilentlyContinue

  Create-Directory $packages
  ${env:NUGET_PACKAGES}=$packages

  gps dotnet -ErrorAction SilentlyContinue | kill

  & dotnet pack -restore -nologo ..\Basic.Arm64.Build -p:Version=0.0.0.1
  & dotnet build -nologo -bl -p:RestoreAdditionalProjectSources="..\Basic.Arm64.Build\bin\Debug"
}
finally {
  Remove-Item env:\NUGET_PACKAGES
  Pop-Location
}