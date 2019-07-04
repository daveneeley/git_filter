FROM rikorose/gcc-cmake:latest
COPY . /srv/src/git_filter
WORKDIR /srv/src/git_filter
RUN make
