FROM bioconductor/bioconductor_docker

RUN apt-get update \
&& apt-get install -y \
curl \
wget \
libboost-all-dev \
libudunits2-dev \
gawk

# # Install miniconda
RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh \
&& bash Miniconda2-latest-Linux-x86_64.sh -b -p /opt/miniconda2 \
&& /opt/miniconda2/bin/conda config --add channels bioconda \
&& /opt/miniconda2/bin/conda config --add channels defaults \
&& /opt/miniconda2/bin/conda config --add channels conda-forge 


# # Install software required for chipseq pipeline with bioconda
# # Force version of samtools to avoid error https://github.com/bioconda/bioconda-recipes/issues/13958
RUN /opt/miniconda2/bin/conda install -c bioconda \
preseq \
samblaster \
wiggletools \
pysam \
bedops \
r-spp \
ucsc-bedgraphtobigwig \
fastqc \
picard 

# Install fastp manually because bioconda verison is not the latest

RUN wget http://opengene.org/fastp/fastp \
&& chmod a+x ./fastp \
&& mv ./fastp /usr/local/bin

RUN wget https://netcologne.dl.sourceforge.net/project/bowtie-bio/bowtie/1.3.0/bowtie-1.3.0-src.zip \
&& unzip bowtie-1.3.0-src.zip \
&& cd bowtie-1.3.0-src \
&& make \
&& make install 

RUN wget https://deac-ams.dl.sourceforge.net/project/samtools/samtools/1.9/samtools-1.9.tar.bz2 \
&& tar -xvjf samtools-1.9.tar.bz2 \
&& cd ./samtools-1.9 \
&& ./configure --prefix=/usr/local \
&& make \
&& make install 

RUN pip3 install MACS2

# RUN pip install macs2 \
# && pip install deepTools \
# && pip install multiqc \
# && pip install wigtools \
# && pip install pysam 


# cran
RUN R --slave -e 'install.packages(c( \
        "data.table", \
        "ggplot2", \
        "Rcpp", \
        "RColorBrewer", \
        "devtools", \
        "spp"), \
        repos="https://cloud.r-project.org/")'



# # bioconductor
RUN R --slave -e "BiocManager::install(c( \
        'org.Mm.eg.db', \
        'org.Hs.eg.db', \
        'TxDb.Mmusculus.UCSC.mm9.knownGene', \
        'TxDb.Mmusculus.UCSC.mm10.knownGene', \
        'TxDb.Hsapiens.UCSC.hg19.knownGene', \
        'TxDb.Hsapiens.UCSC.hg18.knownGene', \
        'ChIPseeker'))" 


# Update path
ENV PATH "/opt/miniconda2/bin:$PATH"
ENV PATH "/usr/local/bin:$PATH"
