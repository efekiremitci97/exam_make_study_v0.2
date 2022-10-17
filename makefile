## Main build rule

all: gen/output/plot_Antwerp.pdf gen/output/plot_all.pdf 

## Sub rules		
data/listings.csv data/reviews.csv: src/data-preparation/download.R
		R --vanilla < src/data-preparation/download.R

gen/temp/aggregated_df.csv: src/data-preparation/clean.R data/listings.csv data/reviews.csv
		R --vanilla < src/data-preparation/clean.R
		
gen/temp/pivot_table.csv: gen/temp/aggregated_df.csv src/analysis/pivot_table.R
		R --vanilla < src/analysis/pivot_table.R
		
gen/output/plot_Antwerp.pdf: src/analysis/plot_Antwerp.R gen/temp/pivot_table.csv
		R --vanilla < src/analysis/plot_Antwerp.R
		
gen/output/plot_all.pdf: gen/temp/aggregated_df.csv src/analysis/plot_all.R
		 R --vanilla < src/analysis/plot_all.R
clean:
	R -e "unlink('*.pdf')"
	R -e "unlink('*.csv')"