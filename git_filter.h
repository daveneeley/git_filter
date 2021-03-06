#ifndef GIT_FILTER_H
#define GIT_FILTER_H

#include <stdlib.h>
#include <stdio.h>

#define log(...) fprintf(stderr, __VA_ARGS__)

#if DEBUG
#define dlog(...) fprintf(stderr, __VA_ARGS__)
#else
#define dlog(...)
#endif

#define die(...) do { \
        log(__VA_ARGS__); \
        log("\n"); \
        exit(1); \
    } while(0)

#define A(cond, ...) \
    do { \
        if (cond) { \
            log("error in %s at %d\n", __FILE__, __LINE__); \
            die(__VA_ARGS__); \
        } \
    } while(0)

#endif
