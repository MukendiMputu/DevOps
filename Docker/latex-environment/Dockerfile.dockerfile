# Dockerfile for latex environment
FROM ubuntu:20.04

# install package and configure timezone (to avoid interactive prompts)
ENV TZ="Europe/Berlin"
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    apt-get update -y && \
    apt-get install -y -o Acquire::Retries=10 --no-install-recommends \
            texlive-latex-recommended \
            texlive-latex-extra \
            texlive-fonts-recommended \
            texlive-lang-german \
            texlive-pstricks \
            texlive-fonts-extra \
            imagemagick \
            unzip \
            python3 \
            ghostscript \
            locales \
            joe \
            vim \
            curl \
            wget \
            ca-certificates \
            less && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install Pandoc
RUN curl -L https://github.com/jgm/pandoc/releases/download/2.18/pandoc-2.18-6.amd64.deb \
    -o /tmp/pandoc.deb && \
    dpkg -i /tmp/pandoc.deb && \
    rm /tmp/pandoc.deb

# install fonts
# ADD myfonts.tgz /usr/local/share/texmf
RUN texhash

# just as docker run --volume $(pwd):/data
VOLUME [ "/data" ]

# start command
ENTRYPOINT [ "/bin/bash" ]