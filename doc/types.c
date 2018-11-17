#include <stdio.h>
#include <stdint.h>
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
int main(){ 
asm volatile ( "sb a6, -24(s0)\n\t" );
 uint32_t cycles  = rdcycle();       
 uint32_t time    = rdtime();       
 uint32_t instret = rdinstret();       
 printf("No.cycles\t\t%d\nExec time\t\t%d\nInstructions retired\t%d\n", cycles,time,instret);
return 0; 
}
