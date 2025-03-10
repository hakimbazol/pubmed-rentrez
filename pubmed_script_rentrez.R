
#Install package
install.packages("rentrez")
library(rentrez)
library(ggplot2)

#Find paper that is related to your term
search_year <- function(year, term){
  query <- paste(term, "AND (", year, "[PDAT])")
  entrez_search(db="pubmed", term=query, retmax=0)$count
}

year <- 2014:2024 #Add year
papers <- sapply(year, search_year, term="synthetic biology", USE.NAMES=FALSE) #Just edit the term
df_papers_year <- data.frame(papers, year) #making it as dataframe

#Plot published paper based on PubMed database using ggplot
ggplot(df_papers_year, aes(x=year, y=papers)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks = round(seq(min(df_papers_year$year), 
                                        max(df_papers_year$year), by = 1),1)) +
  theme_bw() +
  ggtitle("Synthetic Biology from PubMed in Last 10 Years") + #Edit title as you want
  xlab("Year") + 
  ylab("Published Papers") +
  theme(
    plot.title = element_text(color="black", size=18, family="serif", hjust = 0.5),
    axis.title.x = element_text(color="black", size=16, family = "serif"),
    axis.title.y = element_text(color="black", size=16, family = "serif"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text.x.bottom = element_text(color="black", size=14, family = "serif"),
    axis.text.y.left = element_text(color="black", size=14, family = "serif"),
    axis.ticks.length = unit(5, "pt"),
    axis.minor.ticks.length = rel(1)
  ) 

