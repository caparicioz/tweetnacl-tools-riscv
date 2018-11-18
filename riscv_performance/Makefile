CC=riscv64-unknown-elf-gcc
CFLAGS=-O3 -D_POSIX_C_SOURCE=1 
TWEETNACLC=source/randombytes.c source/tools.c source/tweetnacl.c
TWEETNACL=$(TWEETNACLC) source/randombytes.h source/tools.h source/tweetnacl.h

all: clean bin tweetnacl-decrypt tweetnacl-encrypt tweetnacl-keypair \
     tweetnacl-sigpair tweetnacl-sign tweetnacl-verify \
	 tweetnacl-decrypt-asm tweetnacl-encrypt-asm save-asm \
	 dump-files

bin: ;
	mkdir bin asm dump

clean: ;
	rm -rf bin asm dump

tweetnacl-decrypt: bin $(TWEETNACL) source/tweetnacl-decrypt.c
	$(CC) $(CFLAGS) $(TWEETNACLC) source/tweetnacl-decrypt.c \
		-o bin/tweetnacl-decrypt

tweetnacl-encrypt: bin $(TWEETNACL) source/tweetnacl-encrypt.c
	$(CC) $(CFLAGS) $(TWEETNACLC) source/tweetnacl-encrypt.c \
		-o bin/tweetnacl-encrypt

tweetnacl-keypair: bin $(TWEETNACL) source/tweetnacl-keypair.c
	$(CC) $(CFLAGS) $(TWEETNACLC) source/tweetnacl-keypair.c \
		-o bin/tweetnacl-keypair

tweetnacl-sigpair: bin $(TWEETNACL) source/tweetnacl-sigpair.c
	$(CC) $(CFLAGS) $(TWEETNACLC) source/tweetnacl-sigpair.c \
		-o bin/tweetnacl-sigpair

tweetnacl-sign: bin $(TWEETNACL) source/tweetnacl-sign.c
	$(CC) $(CFLAGS) $(TWEETNACLC) source/tweetnacl-sign.c \
		-o bin/tweetnacl-sign

tweetnacl-verify: bin $(TWEETNACL) source/tweetnacl-verify.c
	$(CC) $(CFLAGS) $(TWEETNACLC) source/tweetnacl-verify.c \
		-o bin/tweetnacl-verify

tweetnacl-decrypt-asm: bin $(TWEETNACL) source/tweetnacl-decrypt.c
	$(CC) $(CFLAGS) -S $(TWEETNACLC) source/tweetnacl-decrypt.c   

tweetnacl-encrypt-asm: bin $(TWEETNACL) source/tweetnacl-encrypt.c
	$(CC) $(CFLAGS) -S $(TWEETNACLC) source/tweetnacl-encrypt.c 

save-asm: ;
	mv *.s asm/.

dump-files: ;
	./dump_files.sh
test: ;
	mkdir tmp
	bin/tweetnacl-keypair tmp/a.pub tmp/a.sec
	bin/tweetnacl-keypair tmp/b.pub tmp/b.sec
	echo 'Secret message!' > tmp/msg01
	bin/tweetnacl-encrypt tmp/a.sec tmp/b.pub tmp/msg01 tmp/encrypted
	bin/tweetnacl-decrypt tmp/a.pub tmp/b.sec tmp/encrypted -
	bin/tweetnacl-sigpair tmp/s.pub tmp/s.sec
	echo 'Verified message!' > tmp/msg02
	bin/tweetnacl-sign tmp/s.sec tmp/msg02 tmp/signed
	bin/tweetnacl-verify tmp/s.pub tmp/signed -
