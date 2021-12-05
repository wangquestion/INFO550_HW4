# rule for making the final report  
report.html: Reassign Weekly_average_tables Make_plot
	Rscript -e "rmarkdown::render('Rmd/report.Rmd', output_file='../output/report.html')"

# rule for cleanning data with new name
Reassign:
	Rscript R/Reassign_Speciation_Name.R

# rule for produce weekly counts of two method
Weekly_average_tables: Reassign
	Rscript R/Counts_By_Week.R

# rule for making the figure
Make_plot: Reassign Weekly_average_tables
	Rscript R/Weekly_Plot.R