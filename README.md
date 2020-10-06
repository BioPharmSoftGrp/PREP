# Biopharm pAckage for Shared Software (PREP) <img src="logo.png" align="right" alt="" width="120" />

The PREP package allows users to create shells for R Packages and Shiny applications with minimal configuration. By expanding upon [many](https://r-pkgs.org/) [useful](https://usethis.r-lib.org/) [resources](https://thinkr-open.github.io/golem/) dedicated to this topic, PREP is designed to be both accessible to new users and highly customizable by expert users. 

# Creating Apps

For example, the code below creates a an R package containing a Shiny Application and then opens it in a new R session. 

```
remotes::install_github("BioPharmSoftGrp/PREP")
library(PREP)
PREP::CreateApp(strName="MyNewApp") 
usethis::proj_activate("myNewApp")
```

In the new session, the package can be built with `usethis::build()` and then the app can be run with `RunApp()`. Similar workflows for creating standalone shiny apps and standard R packages are described in the getting started vignette. 

# Advanced Use

While creating an project with PREP is simple, there are several advanced features that help to streamline the Shiny development lifecycle in complex projects.

- *Flexible Templates* - PREP is built on top of {{usethis}} and {{whisker}} to facilitate highly flexible and reuable app templates. 
- *Minimal Dependencies* - Once a new PREP project is created, PREP generally isn't a required dependency.
- *Modularity* - PREP encourages a modular design. The default shiny app is built with Shiny Modules, and helper functions are available to extending packages and modules with testable functions. Combined with the templating functionality, the framework makes it easy to reuse components across projects. 
