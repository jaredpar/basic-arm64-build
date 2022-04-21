# Failed Experiment
This repo started as an experiment in using System.Reflection.Metadata as a quick way to rewrit a binary from being AnyCPU to ARM64. The assumption was that it would be as simple as flipping the Machine portion of the CoffHeader. Turns out the rewrite is significantly more complicated than that. As such I moved onto other ideas like using shared projects. 

# Basic Arm64 Building

The .NET Framework now has ARM64 support. On Windows ARM64 a .NET binary that is marked as AnyCPU will be executed under x64 emulation, not as ARM64 native. In order to run as ARM64 native the Platform must be set to ARM64.

The challenge is that on all other processors AnyCPU gives the desired behavior. That means .NET Framework projects that want ARM64 execution need to effectively multi-target. One exe needs to be produced with Platform set to AnyCPU and another with ARM64. Unfortunately there is no nativte MSBuild support for doing this.

This NuPkg is meant to make this process simple for the vast majority of .NET developers. When added to an Exe project it will create a sibling directory with the suffix `-arm64` that has an exact copy of the original build output except the Platform of the Exe will be ARM64. 

For example if the project was `HelloWorld.csproj` and the target framework was `net472`. Then the expected output after adding this project would be the following:

```
bin\Debug\
  net472\HelloWorld.exe
  net472-arm64\HelloWorld.exe
```

Limitations:
- This only works on SDK style projects
- This only works with .NET Framework applications
- This does not work with signed binaries. Signing must occur afterwards
