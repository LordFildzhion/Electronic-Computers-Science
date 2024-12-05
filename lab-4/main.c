#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

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

int main()
{
    FILE *in = freopen("test.txt", "r", stdin);
    size_t n;
    fscanf(in, "%llu", &n);

    long long *data = (long long *) malloc(sizeof(long long) * n);
    for (size_t i = 0; i < n; i++) 
        fscanf(in, "%llu", &data[i]);

    BubbleSort(data, n);
    free(data);

    return 0;
}
