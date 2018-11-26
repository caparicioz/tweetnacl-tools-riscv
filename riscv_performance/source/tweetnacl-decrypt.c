#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

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
    uint32_t init_cycles  = rdcycle();       
    uint32_t init_time    = rdtime();       
    uint32_t init_instret = rdinstret();       
    if (argc != 5) error(2,
        "Usage: tweetnacl-decrypt send-key.pub recv-key.sec text.enc text.txt");

    // This will also erroneously fail if the file "-" exists
    if (!file_exists(argv[4])) errorf(1, "File <%s> does not exist", argv[4]);

    // Alice has sent to Bob, not surprisingly
    unsigned char a_public_key[crypto_box_PUBLICKEYBYTES];
    unsigned char b_secret_key[crypto_box_SECRETKEYBYTES];

    read_key(argv[1], a_public_key, crypto_box_PUBLICKEYBYTES);
    read_key(argv[2], b_secret_key, crypto_box_SECRETKEYBYTES);

    unsigned char nonce[crypto_box_NONCEBYTES];

    // Input
    Content c = read_file(argv[3]);
    memcpy(nonce, c.bytes, crypto_box_NONCEBYTES);

    long esize = c.size - crypto_box_NONCEBYTES + crypto_box_BOXZEROBYTES;
    unsigned char *encrypted = malloc(esize);
    if (encrypted == NULL) error(1, "Malloc failed!");
    memset(encrypted, 0, crypto_box_BOXZEROBYTES);
    memcpy(encrypted + crypto_box_BOXZEROBYTES,
        c.bytes + crypto_box_NONCEBYTES, c.size - crypto_box_NONCEBYTES);
    // Equivalently, esize - crypto_box_BOXZEROBYTES
    free(c.bytes);

    // Output
    unsigned char *message = calloc(esize, sizeof(unsigned char));
    if (message == NULL) error(1, "Calloc failed!");

    // Encrypt
    crypto_box_open(message, encrypted, esize,
        nonce, a_public_key, b_secret_key);
    free(encrypted);

    if (strcmp(argv[4], "-") != 0) {
        FILE *out = create_file(argv[4]);
        fwrite(message + crypto_box_ZEROBYTES,
               esize - crypto_box_ZEROBYTES, 1, out);
        fclose(out);
    } else {
        fwrite(message + crypto_box_ZEROBYTES,
               esize - crypto_box_ZEROBYTES, 1, stdout);
    }
    free(message);

    uint32_t cycles  = rdcycle();       
    uint32_t time    = rdtime();       
    uint32_t instret = rdinstret();       
    printf("TweetNacl encryption with enhanced results\n\nNo.cycles\t\t\t\t%d\t-\t%d\t=\t%d\nExec time\t\t\t\t%d\t\t-\t%d\t=\t%d\nInstructions retired\t%d\t-\t%d\t=\t%d\n", \
            cycles, init_cycles, cycles-init_cycles,\
            time, init_time, time - init_cycles,\
            instret, init_instret, instret - init_instret);
    return 0;
}
