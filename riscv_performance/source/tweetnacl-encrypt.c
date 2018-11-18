#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "randombytes.h"
#include "tools.h"
#include "tweetnacl.h"

static inline uint32_t rdcycle(void) {
    uint32_t cycle;
    asm volatile ("rdcycle %0" : "=r"(cycle));
    return cycle;
}

static inline uint32_t rdtime(void) {
    uint32_t time;
    asm volatile ("rdtime %0" : "=r"(time));
    return time;
}

static inline uint32_t rdinstret(void) {
    uint32_t instret;
    asm volatile ("rdinstret %0" : "=r"(instret));
    return instret;
}

int main(int argc, char *argv[]) {
    if (argc != 5) error(2,
        "Usage: tweetnacl-encrypt send-key.sec recv-key.pub text.txt text.enc");

    // This will also erroneously fail if the file "-" exists
    if (!file_exists(argv[4])) errorf(1, "File <%s> does not exist", argv[4]);

    // Alice is sending to Bob, not surprisingly
    unsigned char a_secret_key[crypto_box_SECRETKEYBYTES];
    unsigned char b_public_key[crypto_box_PUBLICKEYBYTES];

    read_key(argv[1], a_secret_key, crypto_box_SECRETKEYBYTES);
    read_key(argv[2], b_public_key, crypto_box_PUBLICKEYBYTES);

    unsigned char nonce[crypto_box_NONCEBYTES];
    randombytes(nonce, sizeof(nonce));

    FILE *out;
    if (strcmp(argv[4], "-") != 0) {
        out = create_file(argv[4]);
        fwrite(nonce, sizeof(nonce), 1, out);
    } else {
        out = stdout;
        fwrite(bytes_to_hex(nonce, sizeof(nonce)), sizeof(nonce) * 2, 1, out);
        fputs("\n", out);
    }

    // Input
    // unsigned char *message = read_file(argv[3]);
    Content c = read_file(argv[3]);
    long psize = crypto_box_ZEROBYTES + c.size;
    unsigned char *padded = malloc(psize);
    if (padded == NULL) error(1, "Malloc failed!");
    memset(padded, 0, crypto_box_ZEROBYTES);
    memcpy(padded + crypto_box_ZEROBYTES, c.bytes, c.size);
    free(c.bytes);

    // Output
    unsigned char *encrypted = calloc(psize, sizeof(unsigned char));
    if (encrypted == NULL) error(1, "Calloc failed!");

    // Encrypt
    crypto_box(encrypted, padded, psize, nonce, b_public_key, a_secret_key);
    free(padded);

    if (out != stdout) {
        fwrite(encrypted + crypto_box_BOXZEROBYTES,
               psize - crypto_box_BOXZEROBYTES, 1, out);
    } else {
        fwrite(bytes_to_hex(encrypted + crypto_box_BOXZEROBYTES,
                            psize - crypto_box_BOXZEROBYTES),
               (psize - crypto_box_BOXZEROBYTES) * 2, 1, out);
        fputs("\n", out);
    }
    free(encrypted);

    uint32_t cycles  = rdcycle();       
    uint32_t time    = rdtime();       
    uint32_t instret = rdinstret();       
    printf("No.cycles\t\t%d\nExec time\t\t%d\nInstructions retired\t%d\n", cycles,time,instret);
    return 0;
}
