FROM rocker/tidyverse

# install R packages
<<<<<<< HEAD
RUN Rscript -e "install.packages(c('here','ggplot2','data.table','lubridate','dplyr','reshape2','plyr','viridis','RColorBrewer','stringr'))"

# make a project directory in the container
RUN mkdir /project
RUN mkdir /project/output
=======
RUN Rscript -e "install.packages(c('ggplot2','data.table','lubridate','dplyr','reshape2','plyr','viridis','RColorBrewer','stringr'))"

# make a project directory in the container
RUN mkdir /project
>>>>>>> 7d4b87df0a8844e1cf5db628bd3da43d9cc7b873

# copy contents of local folder to project folder in container
COPY ./ /project/

# make R scripts executable
RUN chmod +x /project/R/*.R

# make container entry point to make report
CMD make -C project report.html