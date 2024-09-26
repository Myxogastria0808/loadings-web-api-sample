FROM rstudio/plumber:latest

COPY . .

RUN R -e "install.packages("loadings")"

EXPOSE 7860

CMD ["Rscript", "pr.R"]
