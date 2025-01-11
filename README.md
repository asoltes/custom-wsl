# custom-wsl

This folder contains scripts and instructions to generate a personalized WSL Ubuntu image.

To make the image type:

```shell
> ./build_image.sh
```

To test the image, open a Powershell (in Windows) and execute

```shell
PS> .\test.ps1
```

To install the image type

```shell
wsl --import <name> <destination> /path/to/wsl-ubuntu-22.04.tar.gz
```
