# Sphinx Search
#
# @version 	2.2.11
# @author 	Tit Petric <tit.petric@monotek.net>
FROM debian:stretch

MAINTAINER Tit Petric, tit.petric@monotek.net

# build variables
ARG GITVERSION=development
ENV GITVERSION ${GITVERSION}

# environment variables
ENV SPHINX_VERSION=2.2.11-release RE2_VERSION=2017-12-01 SPHINX_INDEX_DIR=/var/idx/sphinx SPHINX_LOG_DIR=/var/log/sphinx SPHINX_LIB_DIR=/var/lib/sphinx SPHINX_RUN_DIR=/var/run/sphinx SPHINX_DIZ_DIR=/var/diz/sphinx

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential wget tar automake autoconf libtool libmysql++-dev libpq-dev libexpat1-dev make cpp

# download libstemmer source and extract it
RUN wget -nv -O - http://snowball.tartarus.org/dist/libstemmer_c.tgz | tar zx

# download re2 source and extract it
RUN wget -nv -O - https://github.com/google/re2/archive/${RE2_VERSION}.tar.gz | tar zx

# download sphinxsearch source and extract it
RUN wget -nv -O - http://sphinxsearch.com/files/sphinx-${SPHINX_VERSION}.tar.gz | tar zx

# copy libstemmer inside sphinxsearch source code
RUN cp -R libstemmer_c/* sphinx-${SPHINX_VERSION}/libstemmer_c/

# fix for libstemmer changes
RUN sed -i -e 's/stem_ISO_8859_1_hungarian/stem_ISO_8859_2_hungarian/g' sphinx-${SPHINX_VERSION}/libstemmer_c/Makefile.in

# copy re2 library inside sphinxsearch source code
RUN cp -R re2-${RE2_VERSION}/* sphinx-${SPHINX_VERSION}/libre2/

# compile and install sphinxsearch
RUN cd sphinx-${SPHINX_VERSION} && ./configure --enable-id64 --with-mysql --with-pgsql --with-libstemmer --with-libexpat --with-iconv --with-re2
RUN cd sphinx-${SPHINX_VERSION} && make
RUN cd sphinx-${SPHINX_VERSION} && make install

# remove sources
RUN rm -rf sphinx-${SPHINX_VERSION}/ && rm -rf libstemmer_c/ && rm -rf re2-${RE2_VERSION}/

# expose ports
EXPOSE 9312 9306

# prepare directories
RUN mkdir -p ${SPHINX_INDEX_DIR} && \
    mkdir -p ${SPHINX_LOG_DIR} && \
    mkdir -p ${SPHINX_LIB_DIR} && \
    mkdir -p ${SPHINX_RUN_DIR} && \
    mkdir -p ${SPHINX_DIZ_DIR}

# dicts
ADD dicts ${SPHINX_DIZ_DIR}

# expose directories
VOLUME ["${SPHINX_INDEX_DIR}", "${SPHINX_LOG_DIR}", "${SPHINX_LIB_DIR}", "${SPHINX_RUN_DIR}", "${SPHINX_DIZ_DIR}"]

# scripts
ADD scripts/searchd.sh /bin/
ADD scripts/indexall.sh /bin/

RUN chmod a+x /bin/searchd.sh && chmod a+x /bin/indexall.sh
