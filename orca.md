---
title: "ORCA:a comprehensive bioinformatics container - environment for education or research"
author: [Shaun D Jackman, Tatyana Mozgacheva, Inanc Birol, Steven JM Jones]
bibliography: orca.bib
csl: orca.csl
keywords: [container, docker, software installation, package manager, open source, reproducible research, high performance computing]
permalink: /
---

# Abstract
**Summary:** This application note describes ORCA, a Docker image based on version 16.04 of Ubuntu that contains more than 400 bioinformatics tools and their dependencies and libraries. ORCA provides a comprehensive, isolated and controlled bioinformatics environment for education and research and allows combining software into analysis pipelines by users not familiarized with Common Workflow Language (CWL). As a result, ORCA was adapted successfully for a teaching and Hackathon environments, such as MICB405 and Hackseq. Just with installing Docker on a user machine and the one command (docker pull bcgsc/orca), ORCA allows the user to spent less time on setting up bioinformatics environments and debugging environment-specific issues.

**Availability and implementation:** Dockerfiles, the documentation and scripts are available at <https://github.com/bcgsc/orca> under the MIT license.

**Contact:** dmiller@bcgsc.ca  (email on the <http://www.bcgsc.ca/services/orca> ????)

**Supplementary Information:** Additional data are available at <http://www.bcgsc.ca/services/orca/>

# Introduction
One of the vital features for software developers in the scientific community and public in general [@2012] is reproducibility. Setting up a suitable platform for effective bioinformatics analysis can be a challenging, task. It takes time to figure out the dependencies and version requirements to install standard software packages before analysis can even begin. Easy-to-install software is one of the main characteristics of reproducibility [@Leprevost2014].  In fact, the bioinformatics workflows and pipelines require complex applications and libraries, which have their own software dependencies as well [@Hung2016].  Docker provides the ability to configure of computing environment that contains complex pipelines and workflows and allows distributing it across multiple platforms [@Menegidio2017]. Several projects have been recently provided bioinformatics environments for research. For example, BioContainers gives access to bioinformatics software from BioConda repository, which wraps up an isolated Docker container per each software [@daVeigaLeprevost2017]. However, this “isolated-containers” approach is not suitable for hackathon and education purposes, because a pre-configured operating system with different bioinformatics software a.k.a “monolithic container” is required. In addition to this, combining “isolated-containers” into analysis pipeline is not straightforward and may be challenged for beginners. Similarly, BioBoxes, another framework for bioinformatics software standardization, can be integrated into more comprehensive pipelines, but it requires specific skills and knowledge from users [@Belmann2015].

In this application note, we present ORCA (the genOmics Research Container Architecture) that provides a comprehensive bioinformatics environment for education or research by including over 400 validated bioinformatics and analysis software applications and their dependencies pre-installed. Supplementary information contains a list of software. 
	
# Architecture

ORCA provides the ability to use bioinformatics tools inside a private and secure containerized environment backed by large mounted storage volumes and hosted on dedicated compute nodes. While ensuring that privacy and security requirements are met, this ensures plenty of resources for the demanding bioinformatics research. After logging in ORCA via a SSH gateway users have access to their own container with dedicated storage. The container is controlled by a standard shell where the user run jobs and then come back to the container over time to check status and results. Data transfers inside and outside of ORCA container by SCP, SFTP, and rsync. This service is collaborative and is available and accessible to any and all qualified researchers. Moreover, a user can pull and install the ORCA on the local machine.

The ORCA is completely automated with GitHub (<https://github.com/bcgsc/orca>) that contains all commands (instructions) and arguments listed successively called Dockerfile in order to create an image; the documentation, scripts and Docker Hub (<http://hub.docker.com/r/bcgsc/orca/>) that makes ORCA available for download using Docker.  The git-like hash system is used for managing images version that allows a user to pull earlier versions of ORCA. Docker Hub has built-in integration with GitHub to automatically build and test a Docker image when change is committed to a GitHub repository.  An automated build and test allows deploying a new image available within a few hours. Moreover, each time a Dockerfile change is pushed to the repository, Travis CI integrates a node module that analyzes a Dockerfile and looks for common mistakes and traps.

The following open-source bioinformatics repository, [Linuxbrew](http://linuxbrew.sh/) is integrated with ORCA for easy installation of software. Linuxbrew allows users to easily install and manage packages, which are not packaged by the native distribution, without administrative privileges [@linuxbrewPoster]. Moreover, ORCA contains the following a package management systems as well: pip, apt-get, R and allows a user to install additional software.

ORCA can be expanded or adapted for a research or teaching environment. All ORCA environment configuration scripts are available in the Git Hub (<https://github.com/bcgsc/orca>).

# Case studies

Hackseq is a Vancouver-based hackathon focused on genomics that brings individuals with diverse backgrounds together to collaborate on scientific questions and problems in genomics [@Hackseq]. ORCA provides a comprehensive bioinformatics environment for Hackseq 2017. One major benefit of ORCA is the speed it provides to build and ship systems for Hackthon by leveraging the reusable architecture patterns of ORCA and simplified build and deployment processes.

The ORCA solution for Hackthon provided several benefits. The system allows a user to run graphical user interface application (e.g. igv), improves resource utilization, because of providing common services from a resilient and secure platform, participants would spend less time installing multiple tools and more time developing pipelines and workflows.

Another use case of ORCA is education. MICB405 is a course at UBC that introduces the concepts and applications of bioinformatics research.  Students have their own isolated container and access to the course folder.

# Conclusion 

ORCA provide access to more than 400 bioinformatics software ready to be used. Hackseq 2017 and MICB405 are major use cases that show that ORCA can easily deploy and sustainably managed software and their libraries that are essential for reproducibility.  Currently, ORCA’s developers are working on way to integrate Singularity, another container technology with more focus on security [@Kurtzer2017].

# Funding

????

# Acknowledgements

????


# References
