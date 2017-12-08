---
title: "ORCA: A comprehensive bioinformatics container environment for education and research"
author: [Shaun D Jackman^\*1^, Tatyana Mozgacheva^\*1^, Brendan O'Huiginn^1^, Lance Bailey^1^, Inanc Birol^1^, Steven JM Jones^1^]
bibliography: orca.bib
csl: orca.csl
keywords: [container, docker, software installation, package manager, open source, reproducible research, high performance computing]
permalink: /
---

| ^\*^ SDJ and TM are joint first authors and contributed equally.
| ^1^ British Columbia Cancer Agency, Genome Sciences Centre, Vancouver, BC V5Z 4S6, Canada

# Abstract

**Summary:** The ORCA bioinformatics environment is a Docker image that contains hundreds of bioinformatics tools and their dependencies. The ORCA image and accompanying server infrastructure provide a comprehensive bioinformatics environment for education and research. The ORCA environment on a server is implemented using Docker containers, but without requiring users to interact directly with Docker, suitable for novices who may not yet have familiarity with managing containers. ORCA has been used successfully to provide a private bioinformatics environment to external collaborators at a large genome institute, for teaching an undergraduate class on bioinformatics targeted at biologists, and to provide a ready-to-go bioinformatics suite for a hackathon. Using ORCA frees up that that would be spent debugging software installation issues, so that time may be better spent on education and research.

**Availability and implementation:** The ORCA Docker image is available at <https://hub.docker.com/r/bcgsc/orca/>. The source code of ORCA is available at <https://github.com/bcgsc/orca> under the MIT license.

**Contact:** <dmiller@bcgsc.ca>

**Supplementary Information:** Software packages available in ORCA are listed at <https://bcgsc.github.io/orca/>.

# Introduction

Setting up a suitable platform for effective bioinformatics analysis can be challenging. Determining the dependencies and version requirements needed to install standard software packages is a barrier before analysis can even begin. Installing a bioinformatics tool requires first installing its dependencies, which themselves have dependencies, and so on. Easy-to-install software is vital to encourage reproducible data analyses [@Leprevost2014]. Docker provides the ability to configure a computing environment that contains complex pipelines and workflows and distribute it across multiple platforms [@Menegidio2017]. Several recent projects have provided bioinformatics container environments for research. For example, BioContainers gives access to bioinformatics software from the BioConda repository, which creates an isolated Docker container for each software package [@daVeigaLeprevost2017], and BioBoxes serves a similar purpose [@Belmann2015]. Combining isolated containers into an analysis pipeline may however be challenging for beginners, and is not suitable for a novice audience not yet familiar with containers or data analysis pipeline tools. When the goal is to teach bioinformatics, it is not desirable to first have to teach containers. A monolithic container that provides all of the desired software in a single container is preferable to isolated containers in this situation. ORCA, the Genomics Research Container Architecture, provides a bioinformatics environment for education or research that includes hundreds of popular bioinformatics tools and their dependencies.

# Architecture

ORCA uses Docker to provide a private containerized environment, but without the user interacting directly with Docker. The user logs into the ORCA server using the secure shell utility ssh. The user's login shell is configured to run an interactive shell inside their private container, transparently to the user. The user does not themselves run or interact with Docker. The container and the users' processes inside it continue running when the user logs out, so that the user may later return to that same container to check status and results. Data is transferred into and out of the container using any of the utilities scp, sftp, or rsync. Graphical applications, such as the Integrative Genomics Viewer (IGV), may be used by tunneling the X11 protocol through ssh.

ORCA may be installed on a user's workstation or laptop by installing Docker (<https://www.docker.com/get-docker>) and then running the command `docker run -it bcgsc/orca`, providing command line access to all of the software included in the ORCA image. Configuring ORCA on a multi-user server is described in the ORCA documentation (<https://github.com/bcgsc/orca#readme>) to use a login shell script to present each user with a shell inside their individual container.

Building the ORCA container image is completely automated, and an overview of the its architecture is shown in Fig. 1. The Dockerfile script to build the container image is stored on GitHub. The continuous integration service TravisCI is used to analyze the Dockerfile for common mistakes and pitfalls after each commit to GitHub. The container image is built by Docker Hub from the Dockerfile stored on GitHub using the automated builds feature of Docker Hub. Tagging a new release of ORCA on GitHub causes a new Docker image to built, tested, and tagged on Docker Hub. Each stable release of the ORCA image is assigned a version number, so that users may pull an earlier version of ORCA from Docker Hub to repeat a previous analysis. Automating the build and test procedure of the ORCA image permits deploying a new image in a few hours and ensures a reproducible build of the Docker image.

![Figure 1: The architecture of ORCA. The package scripts of Linuxbrew, called formulae, are stored on Github. The precompiled binary packages of Linuxbrew are built and tested on CircleCI and stored on Bintray. The ORCA Dockerfile is stored on GitHub and checked for common errors on TravisCI. The ORCA Docker image is built, tested, and stored on Docker Hub. The system administrator or user pulls the image from Docker Hub to run on their server or workstation.](figures/architecture.png)

The majority of the software packages distributed with ORCA are installed using the Linuxbrew (<http://linuxbrew.sh>) package manager. Linuxbrew can install software in the user's home directory on Linux, macOS, or Windows, using Windows Subsystem for Linux, and does not require administrator privileges [@Jackman2016]. Linuxbrew provides precompiled binaries for many packages, which alleviates the need to build each tool from source. A binary package is built on CircleCI and stored on Bintray whenever each tool is updated. Building the ORCA Docker image would take many days if each package were built from source when the image is built.

The bioinformatics packages available to Linuxbrew are pre-installed in ORCA. Users may easily install and manage other packages that are not included by default with ORCA using Linuxbrew. The Debian package management tool apt-get and the language-specific package management systems for Python (pip) and R may be used to install additional software packages. Interested users may contribute new tools or new versions of existing tools to Linuxbrew through Homebrew (<https://github.com/Homebrew/homebrew-core>), which both share a common library of software tools.

# Example Uses of ORCA

The BC Cancer Genome Sciences Centre uses ORCA to provide access to their compute resources to external collaborators. Giving external collaborators direct access to the internal cluster could risk exposing sensitive patient data. Instead, each collaborator is provided a private container, which also isolates their data from the view of other external collaborators.

An undergraduate class at the University of British Columbia used ORCA to teach the concepts and applications of bioinformatics research to biologists. Students each had their own isolated container, protecting their individual work from each other, and access to a shared course folder provided by the instructor.

Hackseq is a Vancouver-based hackathon focused on genomics that brings individuals with diverse backgrounds together to collaborate on scientific questions and problems in genomics [@Hackseq2016]. In a hackathon environment, installing and configuring software can consume much of the limited time available for the event. ORCA provided a ready-to-go bioinformatics environment for the participants of Hackseq. The members of a team each have their own user account and home directory, access to a shared project folder, and share a single container. Sharing a single container allowed system resources like memory (RAM) to be allocated to and shared by the team. ORCA allowed participants to spend less time installing tools and more time developing their project.

# Conclusion

ORCA provides a comprehensive bioinformatics container environment, which may be installed with a single Docker command, and includes hundreds of pre-installed bioinformatics tools. It may be used to bootstrap a new computer system, provide private containers to users, or shared containers to a group of users. It has been used successfully to provide compute resources to external collaborators at a core sequencing facility, to provide a ready-to-go bioinformatics environment for a collaborative hackathon, and to introduce bioinformatics to undergraduate biology students.

# Acknowledgements

We thank the developers of the software packages included with ORCA, the developers of the Homebrew and Linuxbrew package managers, and their users who contributed the scripts to package these tools.

# References
