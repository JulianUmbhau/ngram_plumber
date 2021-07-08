FROM rstudio/plumber

RUN mkdir -p /home/rstudio/data /home/rstudio/output 

COPY . /home/rstudio/ngram_plumber/

WORKDIR /home/rstudio/ngram_plumber/

RUN chmod 777 -R /home/

RUN install2.r --error \
  textcat

CMD ["/home/rstudio/ngram_plumber/api/ngram_plumber_script.R"]