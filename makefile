## Main build rule

all: plot_Antwerp.pdf plot_all.pdf

## Sub rules		
listings.csv reviews.csv: download.R
		R --vanilla < download.R

aggregated_df.csv: clean.R listings.csv reviews.csv
		R --vanilla < clean.R
		
pivot_table.csv: aggregated_df.csv pivot_table.R
		R --vanilla < pivot_table.R
		
plot_Antwerp.pdf: plot_Antwerp.R pivot_table.csv
		R --vanilla < plot_Antwerp.R
		
plot_all.pdf: aggregated_df.csv plot_all.R
		 R --vanilla < plot_all.R
clean:
	R -e "unlink('*.pdf')"
	R -e "unlink('*.csv')"