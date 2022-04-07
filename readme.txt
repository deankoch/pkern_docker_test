Steps for rpy2 test run using Windows 10 Pro (19043) on my x64 PC
===============================================================================

1 Enable hardware virtualization in BIOS

2 Install WSL 2 with Debian V11 (bullseye) from Windows Store

3 Install Docker Desktop V4.6.1 (76265)

4 make configuration files in working directory:
	Dockerfile defines the container and installation steps
	requirements.txt lists required python libraries
	get_pkern_deps.R is an R script to install required R libraries

5 call docker build from windows terminal at working directory
	`docker build --progress=plain --no-cache -t pkern .`

6 run the container
	`docker run -it pkern` 

===============================================================================
references 
https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/manage-windows-dockerfile
https://dockerwebdev.com/tutorials/install-docker/
https://www.reddit.com/r/Python/comments/jz386v/how_to_run_python_within_a_docker_container_on/












