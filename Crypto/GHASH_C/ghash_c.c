// ghash_core.c 

#include <stdint.h>
#include <stdio.h>

// 128-bit type
typedef struct {
    uint64_t hi;
    uint64_t lo;
} u128;

// 256-bit type
typedef struct {
    u128 hi;
    u128 lo;
} u256;

// Helpers
static inline unsigned __int128 to_u128(u128 a) {
    return ((unsigned __int128)a.hi << 64) | (unsigned __int128)a.lo;
}

static inline u128 from_u128(unsigned __int128 v) {
    u128 r;
    r.hi = (uint64_t)(v >> 64);
    r.lo = (uint64_t)v;
    return r;
}

static void print_u128(const char *name, u128 v) {
    printf("%s = %016llx%016llx\n",
           name,
           (unsigned long long)v.hi,
           (unsigned long long)v.lo);
}

static void print_u256(const char *name, u256 v) {
    printf("%s = %016llx%016llx%016llx%016llx\n",
           name,
           (unsigned long long)v.hi.hi,
           (unsigned long long)v.hi.lo,
           (unsigned long long)v.lo.hi,
           (unsigned long long)v.lo.lo);
}

// ---------------------------------------------------------
// carry-less multiply (C89 compatible)
// ---------------------------------------------------------
u256 carry_less_mul_128(u128 X, u128 Y)
{
    unsigned __int128 x = to_u128(X);
    unsigned __int128 y = to_u128(Y);

    unsigned __int128 z_hi = 0;
    unsigned __int128 z_lo = 0;

    int i;   // moved outside for C89

    for (i = 0; i < 128; i++) {
        if ((y >> i) & 1) {
            if (i == 0) {
                z_lo ^= x;
            } else {
                unsigned __int128 s_lo = x << i;
                unsigned __int128 s_hi = x >> (128 - i);
                z_lo ^= s_lo;
                z_hi ^= s_hi;
            }
        }
    }

    u256 res;
    res.hi = from_u128(z_hi);
    res.lo = from_u128(z_lo);
    return res;
}

// ---------------------------------------------------------
// reduction (C89 compatible)
// ---------------------------------------------------------
unsigned __int128 gf128_reduce(unsigned __int128 high,
                               unsigned __int128 low)
{
    int i;   // moved outside
    for (i = 127; i >= 0; i--) {

        if ((high >> i) & 1) {
            int e;
            high ^= ((unsigned __int128)1 << i);

            e = i;       low ^= ((unsigned __int128)1 << e);
            e = i + 1;   if (e < 128) low ^= ((unsigned __int128)1 << e);
            e = i + 2;   if (e < 128) low ^= ((unsigned __int128)1 << e);
            e = i + 7;   if (e < 128) low ^= ((unsigned __int128)1 << e);
        }
    }
    return low;
}

// wrapper
u128 reduction_256_to_128(u256 in)
{
    unsigned __int128 low  = to_u128(in.lo);
    unsigned __int128 high = to_u128(in.hi);
    unsigned __int128 r = gf128_reduce(high, low);
    return from_u128(r);
}

// top
u128 ghash_mul_top(u128 X, u128 Y)
{
    u256 prod = carry_less_mul_128(X, Y);
    u128 res = reduction_256_to_128(prod);
    return res;
}

// ---------------------------------------------------------
// TESTBENCH
// ---------------------------------------------------------
int main(void)
{
    printf("==============================\n");
    printf("    128-bit Carry-less MUL TB \n");
    printf("==============================\n");

    // TEST 1
    u128 x1 = {0x0, 0x000000000000000FULL};
    u128 y1 = {0x0, 0x000000000000000BULL};

    u256 p1 = carry_less_mul_128(x1, y1);
    u128 r1 = reduction_256_to_128(p1);

    printf("\nTEST 1\n");
    print_u128("x", x1);
    print_u128("y", y1);
    print_u256("reduction_in", p1);
    print_u128("reduction_out", r1);

    // TEST 2
    u128 x2 = {0x8000000000000000ULL, 0x0};
    u128 y2 = {0x0000000000000001ULL, 0x0};

    u256 p2 = carry_less_mul_128(x2, y2);
    u128 r2 = reduction_256_to_128(p2);

    printf("\nTEST 2\n");
    print_u128("x", x2);
    print_u128("y", y2);
    print_u256("reduction_in", p2);
    print_u128("reduction_out", r2);

    // TEST 3
    u128 x3 = {0x123456789ABCDEF0ULL, 0x1122334455667788ULL};
    u128 y3 = {0x0F0E0D0C0B0A0908ULL, 0x0706050403020100ULL};

    u256 p3 = carry_less_mul_128(x3, y3);
    u128 r3 = reduction_256_to_128(p3);

    printf("\nTEST 3\n");
    print_u128("x", x3);
    print_u128("y", y3);
    print_u256("reduction_in", p3);
    print_u128("reduction_out", r3);

    return 0;
}

