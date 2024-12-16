#include <stdio.h>
#include <stdlib.h>
#include <immintrin.h>
#include <inttypes.h>
#include <limits.h>


const int N = 100000000 * 2;
const int COUNT = 10;


uint64_t tacts(int *arr) {
    uint64_t start, end, min_time = ULLONG_MAX;

    for(int j = 0; j < COUNT; j++) {
        start = __rdtsc();
        volatile int k = 0;

        for(int i = 0; i < N; i++) {
            k = arr[k];
        }

        end = __rdtsc();

        if(min_time > end - start) {
            min_time = end - start;
        }
    }

    return min_time / N;
}

void fill_array(int *arr, int fragments, int offset, int size) {
    for(int i = 0; i < size; i++) {
        for(int j = 1; j < fragments; j++) {
            arr[i + (j - 1) * offset] = i + j * offset;
        }

        arr[i + (fragments - 1) * offset] = i + 1;
    }

    arr[size - 1 + (fragments - 1) * offset] = 0;
}

const int FRAGMENT_SIZE = 1 * 1024 * 1024; //1 MB
const int OFFSET_SIZE = 1 * 1024 * 1024;   //1 MB

int main()
{
    int* arr = (int *)calloc(N, sizeof(int));

    if (arr == NULL) {
        fprintf(stderr, "Memory allocation failed for N: %d\n", N);
        exit(EXIT_FAILURE);
    }

    FILE *out = fopen("result.csv", "w");
    
    fprintf(out, "Fragments,Tacts\n");

    for(int n = 1; n <= 64; n++) {
        fill_array(arr, n, OFFSET_SIZE / sizeof(int), FRAGMENT_SIZE / sizeof(int));

        fprintf(out, "%d,%lu\n", n, tacts(arr));
    }

    fclose(out);

    free(arr);

    return 0;
}
