# UnmanageableCuda (aka ManagedCuda)

This is a forked version of ManagedCuda from Surban (https://github.com/surban/managedCuda),
which was forked from original author Kunzmi (https://github.com/kunzmi/managedCuda).

Unfortunately, Surban's port did not address some fundamentals of rolling forward to CUDA 9,
and introduced several non-portable problems. This version addresses those issues, and rolls forward
to the GPU Toolkit version 10. I'm planning on just this release, no others.

The fundamental problem with ManagedCuda is that with each release
the code has to be hand-edited for the newest version. I will be
working out a whole new, automatic-generated API from header files.
I currently maintain Swigged.CUDA, which is a similar API to ManagedCuda. However,
the SWIG-generated API for CUDA requires still too much labor.

## Updates from Surban fork

* Upgrade to Visual Studio 2017.
* Fixed CSPROJ file issues introduced by Surban. In doing an upgrade of CSPROJ files to VS 2017, I found
  that the generated CSPROJ files did not work within VS (see https://developercommunity.visualstudio.com/content/problem/349096/multiple-issues-with-vs2017-reading-dotnet-generat.html).
* Upgrade to NVIDIA GPU Toolkit 10.0.
* Added unknown/unlisted project files to SLN project.
* Fixed documentation of what StubsForLinux is and how to rebuild.
* Added explicit Nuget package creation as I have no idea where or how it was originally done.
* Samples updated--netstandard2.0 framework incompatible with Net Framework <4.6.1. Hangover from Surban, did not port samples as far as I can tell. See https://docs.microsoft.com/en-us/dotnet/standard/net-standard
* To do: Update the API for version 10. Surban's fork says it works with version 9, but it was never updated with new declarations, e.g., CUdevice_attribute, cuDeviceGetUuid().

## Documentation

Older reference documentation is available at <http://surban.github.io/managedCuda> or <https://kunzmi.github.io/managedCuda/>.

## NuGet packages

Prebuilt NuGet packages are [available on nuget.org](https://www.nuget.org/packages/UnmanageableCuda/).
