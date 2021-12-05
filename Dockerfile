FROM rocker/tidyverse

# install R packages
RUN Rscript -e "install.packages(c('ggplot2','data.table','lubridate','dplyr','reshape2','plyr','viridis','RColorBrewer','stringr'))"

# make a project directory in the container
RUN mkdir /project

# copy contents of local folder to project folder in container
COPY ./ /project/

# make R scripts executable
RUN chmod +x /project/R/*.R

# make container entry point to make report
CMD make -C project report.html