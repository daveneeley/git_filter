PROGS = git_filter
CFLAGS = -O2 -Wall -Werror
CFLAGS += -ggdb
LIBGIT2_DIR = libgit2-0.28.2
CFLAGS += -I$(LIBGIT2_DIR)/include
LDLIBS = -L $(LIBGIT2_DIR) -lgit2
UNAME = $(shell uname)
ifneq ($(UNAME), Darwin)
LDLIBS += -lrt
endif

LIBGIT2_SRC = https://github.com/libgit2/libgit2/archive/v0.28.2.tar.gz
LIBGIT2_LOCAL = $(LIBGIT2_DIR).tar.gz

all: $(PROGS)
 
$(LIBGIT2_LOCAL):
	wget -O $@ $(LIBGIT2_SRC) || curl -L $(LIBGIT2_SRC) --insecure -o $@

$(LIBGIT2_DIR)/.unpacked: $(LIBGIT2_LOCAL)
	tar -xvf $(LIBGIT2_LOCAL)
	touch $@

$(LIBGIT2_DIR)/.built: $(LIBGIT2_DIR)/.unpacked
	cmake $(LIBGIT2_DIR) -DCMAKE_INSTALL_PREFIX=/usr
	cmake --build . --target install
	touch $@

$(LIBGIT2_DIR)/.tested: $(LIBGIT2_DIR)/.built
	./libgit2_clar

git_filter.o: $(LIBGIT2_DIR)/.tested

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@

git_filter: dict.o
$(PROGS): %: %.o
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

clean:
	rm -f *.o
	rm -f $(PROGS)
	#rm -fr $(LIBGIT2_DIR)

reallyclean: clean
	rm -f $(LIBGIT2_LOCAL)
