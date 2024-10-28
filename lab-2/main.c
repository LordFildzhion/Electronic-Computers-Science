#include <stdio.h>
#include <immintrin.h>

void swap(long long *a, long long *b) {
    long long c = *a;
    *a = *b;
    *b = c;
}

void BubbleSort(long long data[], size_t n) 
{
    for (size_t i = 0; i < n - 1; ++i) 
    {
        for (size_t j = 0; j < n - i - 1; ++j) {
            if (data[j] > data[j + 1]) 
            {
                swap(&data[j], &data[j + 1]);
            }
        }
    }
}

int main(int agrc, char *argv[])
{
    if (agrc < 2) {
        printf("Cannot run programm: need more arguments\n");
        fflush(stdout);
        return 0;
    }

    FILE *in = freopen(argv[1], "r", stdin);
    size_t n;
    fscanf(in, "%lld", &n);

    long long *data = (long long *) malloc(sizeof(long long) * n);
    for (size_t i = 0; i < n; i++) {
        fscanf(in, "%lld", &data[i]);
    }
    fclose(in);

    unsigned long long f =__rdtsc(), l;
    const long long frequency = 2500000000;

    BubbleSort(data, n);
    free(data);

    l = __rdtsc();
    printf("%lld\n", ((l - f) / frequency));
    
    return 0;
}
