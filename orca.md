---
title: "ORCA: A comprehensive bioinformatics container environment for education and research"
author: [Shaun D Jackman, Tatyana Mozgacheva, Inanc Birol, Steven JM Jones]
bibliography: orca.bib
csl: orca.csl
keywords: [container, docker, software installation, package manager, open source, reproducible research, high performance computing]
permalink: /
---

# Abstract

**Summary:** This application note describes ORCA, a Docker image that contains more than 400 bioinformatics tools and their dependencies. ORCA provides a comprehensive bioinformatics environment for education and research. That ORCA is implemented using containers is not exposed to the user, which allows novice users, who are not yet familiar with containers, to combine software into analysis pipelines. ORCA has been used successfully to provide a private bioinformatics environment to external collaborators at a large genome institute, for teaching an undergraduate class on bioinformatics targeted at biologists, and to provide a ready-to-go bioinformatics suite for a hackathon, where time is in short supply. Once Docker is installed, the ORCA container image, including hundreds of pre-installed bioinformatics packages, is easily installed with a single command. ORCA allows the user to spend less time on setting up bioinformatics environments and debugging software installation issues, time better spent on research.

**Availability and implementation:** The ORCA Docker image is available at <https://hub.docker.com/r/bcgsc/orca/>. The source code of ORCA is available at <https://github.com/bcgsc/orca> under the MIT license.

**Contact:** <dmiller@bcgsc.ca>

**Supplementary Information:** Software packages available in ORCA are listed at <https://bcgsc.github.io/orca/>.

# Introduction

A vital feature for software developers in the scientific community and public in general is reproducibility [@Nature2012]. Setting up a suitable platform for effective bioinformatics analysis can be a challenging task. It takes time to determine the dependencies and version requirements to install standard software packages before analysis can even begin. Easy-to-install software is a key requirement reproducibility [@Leprevost2014]. Installing a bioinformatics tool requires first installing its dependencies, which themselves have dependencies, and on, and on. Docker provides the ability to configure a computing environment that contains complex pipelines and workflows and allows distributing it across multiple platforms [@Menegidio2017]. Several recent projects have provided bioinformatics container environments for research. For example, BioContainers gives access to bioinformatics software from the BioConda repository, which creates an isolated Docker container for each software package [@daVeigaLeprevost2017], and BioBoxes serves a similar purpose [@Belmann2015]. Combining isolated containers into an analysis pipeline may be challenging for beginners, and is not suitable for a novice audience not yet familiar with containers. When the goal is to teach bioinformatics, it is not desirable to first have to teach containers. A monolithic container that provides all of the desired software in a single container is preferable in this situation.

We present ORCA, the Genomics Research Container Architecture, that provides a comprehensive bioinformatics environment for education or research by including over 400 bioinformatics and analysis software applications and their dependencies pre-installed.

# Architecture

ORCA uses Docker to provide a private containerized environment, but without the user interacting directly with Docker. The user logs into the ORCA server using the secure shell utility ssh. The user's login shell is configured to run an interactive shell inside their private container, transparently to the user. The user user does not themselves run or interact with Docker. The container and the users' processes inside it continue running when the user logs out, so that the user may later return to that same container to check status and results. Data is transferred into and out of the container using any of the utilities scp, sftp, or rsync. Graphical applications, such as the Integrative Genomics Viewer (IGV), may be used by tunnelling the X11 protocol through ssh.

ORCA may be installed on a user's local workstation or laptop by installing Docker (<https://www.docker.com/get-docker>) and then running the command `docker run -it bcgsc/orca`. Configuring ORCA for use on a multi-user system is described in the ORCA documentation (<https://github.com/bcgsc/orca#readme>).

Building the ORCA container image is completely automated. The Dockerfile script to build the container image are stored on GitHub. Docker Hub Automated Builds is integrated with GitHub to build and test the container image automatically from its source Dockerfile. An automated build and test permits deploying a new image in a few hours. TravisCI is used to statically analyze the Dockerfile for common mistakes and pitfalls with each commit. Each stable release of the ORCA image is assigned a version number, so that users may pull earlier versions of ORCA to repeat an older analysis.

The majority of the software packages distributed with ORCA are installed using the Linuxbrew (<http://linuxbrew.sh>) package manager. Linuxbrew can install software in the user's home directory on Linux, macOS, or Windows, using the Windows Subsystem for Linux, and does not require administrator privileges [@Jackman2016]. All bioinformatics packages available to Linuxbrew are pre-installed in ORCA. Users may easily install and manage packages that are not included by default with ORCA using Linuxbrew. The Debian package management tool apt-get and the language-specific package management systems for Python (pip) and R may be used to install additional software packages. Interested users may contribute new tools or new versions of existing tools to Linuxbrew through Homebrew (<https://github.com/Homebrew/homebrew-core>), which both share a common library of software tools.

# Case studies

The BC Cancer Genome Sciences Centre uses ORCA to provide access to their compute resources to external collaborators. Giving external collaborators direct access to the internal cluster could potentially expose sensitive patient data. Instead, each collaborator is provided a private container, which also isolates their data from the view of other external collaborators.

ORCA was used to teach the concepts and applications of bioinformatics research to biologists at an undergraduate class at UBC. Students each have their own isolated container, protecting their individual work from each other, and access to a shared course folder.

Hackseq is a Vancouver-based hackathon focused on genomics that brings individuals with diverse backgrounds together to collaborate on scientific questions and problems in genomics [@Hackseq2016]. ORCA provided a comprehensive bioinformatics environment for the participants of Hackseq. In a hackathon environment, installing and configuring software can consume a lot of the limited time available for the event. The automated build system of ORCA makes it easy to update the ORCA image prior to the event with software tools requested by the team leads and required for their project. The members of a team each have their own user account and home directory, access to a shared project folder, and share a single container. Sharing a single container allows the resources such as memory (RAM) to be allocated to each team rather than each user. ORCA allows participants to spend less time installing tools and more time developing their project.

# Conclusion

ORCA provides a comprehensive bioinformatics container environment, which may be installed with a single Docker command, and includes hundreds of pre-installed bioinformatics tools. It may be used to bootstrap a new computer system, provide private and isolated containers to users, or shared containers to a group of users. It has been used successfully to provide compute resources to external collaborators at a core sequencing facility, to provide a ready-to-go bioinformatics environment for a collaborative hackathon, and to introduce bioinformatics to undergraduate biology students. We are working on integrating ORCA with Singularity [@Kurtzer2017].

# Funding

todo

# Acknowledgements

We thank the developers of the software packages included with ORCA, the developers of the Homebrew and Linuxbrew package managers, and their users who contributed the scripts to packages these tools.

# References
