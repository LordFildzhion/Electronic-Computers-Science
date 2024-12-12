#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>
#include <time.h>
#include <immintrin.h>

const int K = 100;
const int N_MIN = 256;
const int N_MAX = 32 * 1024 * 1024;

void forward(int *arr, int N) {
    for (int i = 0; i < N - 1; i++)
        arr[i] = i + 1;
    arr[N - 1] = 0;
}

void reverse(int *arr, int N) {
    for (int i = N - 1; i > 0; i--)
        arr[i] = i - 1;
    arr[0] = N - 1;
}

void swap(int *a, int *b) {
    int c = *a;
    *a = *b;
    *b = c;
}

void random(int *arr, int N) {

    for (int i = 0; i < N; i++)
        arr[i] = i;


    for (int i = N - 1; i > 0; i--) {
        swap(&arr[i], &arr[rand() % (i + 1)]);
    }

    int current = arr[0];

    for (int i = 1; i < N; i++) {
        int next = arr[i];
        arr[current] = next;
        current = next;
    }

    arr[current] = arr[0];
}

long double tacts(int *arr, int N) {
    volatile int x = 0;
    uint64_t start, end;

    for (int i = 0; i < N; i++) {
        x = arr[x];
    }

    start = __rdtsc();
    
    for (int i = 0; i < N * K; i++) {
        x = arr[x];
    }

    end = __rdtsc();

    return (long double)(end - start) / (N * K);
}

int main() {
    srand(time(NULL));

    FILE *out = freopen("resultO1.csv", "w", stdout);

    fprintf(out, "Size,Forward,Reverse,Random\n");
    for (int N = N_MIN; N <= N_MAX; N *= 2) {
        int *arr = (int *)malloc(N * sizeof(int));

        if (arr == NULL) {
            fprintf(stderr, "Memory allocation failed for N: %d\n", N);
            exit(EXIT_FAILURE);
        }

        forward(arr, N);
        long double time_forward = tacts(arr, N);
        
        reverse(arr, N);
        long double time_reverse = tacts(arr, N);

        random(arr, N);
        long double time_random = tacts(arr, N);

        fprintf(out, "%d,%.2Lf,%.2Lf,%.2Lf\n", N * (int)sizeof(int), time_forward, time_reverse, time_random);

        free(arr);
    }

    return 0;
}