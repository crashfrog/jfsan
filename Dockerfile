FROM crashfrog/snp-pipeline:latest
MAINTAINER Justin Payne, justin.payne@fda.hhs.gov

#Install FASTX-Toolkit
RUN apt-get install -y pkg-config zip tcsh
WORKDIR /downloads/
RUN wget http://cancan.cshl.edu/labmembers/gordon/files/libgtextutils-0.7.tar.bz2 \
	&& tar -xjf libgtextutils-0.7.tar.bz2 \
	&& cd libgtextutils-0.7.tar.bz2 \
	&& ./configure \
	&& make \
	&& make install \
	&& cd /downloads/	
RUN wget http://cancan.cshl.edu/labmembers/gordon/files/fastx_toolkit-0.0.14.tar.bz \
	&& tar -xjf fastx_toolkit-0.0.14.tar.bz2 \
	&& cd fastx_toolkit-0.0.14 \
	&& ./configure \
	&& make \
	&& make install \
	&& ldconfig \
	&& cd /downloads/
RUN fastx_uncollapser -h || exit 1

#Install SPAdes
RUN wget http://spades.bioinf.spbau.ru/release3.5.0/SPAdes-3.5.0-Linux.tar.gz \
	&& tar -xzf SPAdes-3.5.0-Linux.tar.gz \
	&& cd SPAdes-3.5.0-Linux \
	&& mv bin/* /usr/local/bin/ \
	&& mv share/* /usr/local/share/ \
	&& cd /downloads/
RUN spades.py -h || exit 1
	
#Install kSNP
RUN wget http://downloads.sourceforge.net/project/ksnp/kSNP3_Linux_package.zip \
	&& unzip kSNP3_Linux_package.zip \
	&& cp kSNP3_Linux_package/kSNP3 /usr/local/
ENV PATH /usr/local/kSNP3:$PATH
RUN kSNP || exit 1

#Install GARLI
RUN wget http://downloads.sourceforge.net/project/ncl/NCL/ncl-2.1.18/ncl-2.1.18.tar.gz \
	&& tar -xzf ncl-2.1.18.tar.gz \
	&& cd ncl-2.1.18 \
	&& ./configure --prefix=/usr/lib \
	&& make \
	&& make install \
	&& cd /downloads/

RUN wget http://www.bio.utexas.edu/faculty/antisense/garli/garli-96b8.tar.gz \
	&& tar -xzf garli-96b8.tar.gz \
	&& cd garli-96b8 \
	&& ./configure \
	&& make \
	&& make install \
	&& cd /downloads/
	

	
	