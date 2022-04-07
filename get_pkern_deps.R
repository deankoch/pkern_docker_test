# once pkern is on CRAN, the code below can be replaced by:
# `install.packages('pkern')`

# packages required by pkern
reqs = c('devtools', 'RcppHungarian', 'Matrix')

# install them
install.packages(reqs)

# install development version of pkern from github repo
library(devtools)
devtools::install_github('deankoch/pkern')