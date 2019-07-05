FROM rikorose/gcc-cmake:latest
RUN apt-get update && apt-get install -y valgrind && apt-get clean
COPY . /srv/src/git_filter
WORKDIR /srv/src/git_filter
RUN make
