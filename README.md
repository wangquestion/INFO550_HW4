# INFO 550 HOMEWORK 4 
### Wenhao Wang

This is a projects to analysis the pollen data measured by two different devices that used two different mthods for classifying pollen speciations and counts. The current projects have two major aims:

__Aim 1__ Match the raw datasets obtained from the two device with same names of the pollen speciation
__Aim 2__ Calcualte the weekly counts of total pollen and each speciations of two devices, respectivelu
__Aim 3__ Draw a stacked barplot to compared the dominant species of pollen measure by two device in pollen peak weeks in 2020

### Restore Package Environment
To restore the package environment for the present study, you may run the __R__ session from the root directory where the renv will automatically be active. If you need to run the R scrits respectively in some other place, you may use _renv::activate('path/to/renv')_ to activate the needed package from the given renv folder.

### How to make Report
__Aim 1__ You may execute 'make Reassign' in bash. The datasets with new names will be stored in 'processed_data'

__Aim 2__ You may execute 'make Weekly_average_tables'. The datasets by week will be stored in 'output'

__Aim 3__ You may execute 'make Make_plot'. The plot in png format will be in 'Rmd'

To generate the report, you may execute 'make report.html'. The report in html format will be generated in 'Rmd'
