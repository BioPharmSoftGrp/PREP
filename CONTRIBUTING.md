# BaSS Contribution Guidelines

**This page is under development. We'd love your help making it better!**

# Overview 

Hello! Thank you for your interest in contributing to the BaSS pacakge. This page provides guidelines for technical contributors to this project. . If you can't find what you need on this page, don't hesitate to [email Kyle](mailto:KyleWathen@gmail.com?subject=BaSS%20Technical%20Question) with questions. 

# Approach

The [ASA Biopharm](https://community.amstat.org/biop/home) software group creates open source software that seeks to improve and standardize statistical computing in Biopharmaceutical research. The rest of this document provides details about our technical approach. 

# Prerequisites

This guide assumes a basic understanding of GitHub. If you've never used GitHub, I strongly recommend reading through their [help pages](https://help.github.com/en/github) and/or doing some [online learning](https://www.coursera.org/learn/introduction-git-github).

# Contributing Code 

## User Access

To gain access, [send Kyle your GitHub user name](mailto:KyleWathen@gmail.com?subject=safetyGraphics%20Access%20Request), and he will grant you access to the organization and add you to the appropriate teams. 

## Issue Tracking

All repos have active issue trackers. All issues should, at a minimum contain a name, description, assignee and release version (tracked using a GitHub "Milestone").

## Project Boards

Each release has it's own [GitHub project board](https://help.github.com/en/github/managing-your-work-on-github/managing-project-boards) containing all issues being resolved in the release. We typically use columns for 'To Do', 'In Progress', 'Ready for review' and 'Done'. Developers should update the project board as they go. 

## Branches

 We typically use three types of branches: 

- **`master`** - The production version of the repository. Commits directly to the `master` branch are not permitted, so all code development must be done in development and feature branches as described below.
- **Development Branches** - Development branches contain all code for a given release, and should be named `vX.X.X-dev`. When the work on the release is complete, the development branch will be merged to `master` via a pull request. 
- **Feature Branches** - Feature branches resolve one or more issues and should be named to reflect the new features added  (e.g. `add-participant-filter`). Once all issues are resolved, the feature branch should be merged into a development branch. 

For a large release, there will likely be several feature branches merged to the development branch before the development branch is merged to `master`. Commits directly to development branches are discouraged since we generally recommend making a feature branch/PR instead. However, for a small release that only resolves a few features, a single development branch may be sufficient. Following this Branch structure is important since our quality control is built using this framework. 

All merging should be done via pull requests. More details of our merge/PR process are provided in the Quality Control section below. 

## Commit Messages

Please reference issue numbers in commit messages whenever possible. 

## Quality Control

We pay great attention to the quality of our tools, and all repos are subject to significant testing and quality control and have detailed documentation. More detail is provided in the links below. That said, none of our repositories are currently validated per the [21 CFR Part 11](https://www.accessdata.fda.gov/scripts/cdrh/cfdocs/cfcfr/CFRSearch.cfm?CFRPart=11) guidelines.  We also have several team members who are actively involved in the [R Validation Hub effort](https://www.pharmar.org/).

For R packages, we follow the guidelines in Hadley Wickham's [R Packages](http://r-pkgs.had.co.nz/) book. And include tests via the `testthat` package. 

This page was adapted from [these guidelines](https://github.com/SafetyGraphics/SafetyGraphics.github.io/blob/master/CONTRIBUTING.md).