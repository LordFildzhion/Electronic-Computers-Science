#include <iostream>
#include <intrin.h>
#include <inttypes.h>
using namespace std;    

void BubbleSort(int64_t data[], size_t n) 
{
    for (size_t i = 0; i < n - 1; ++i) 
    {
        for (size_t j = 0; j < n - i - 1; ++j) {
            if (data[j] > data[j + 1]) 
            {
                swap(data[j], data[j + 1]);
            }
        }
    }
}

int main()
{
    freopen("test.txt", "r", stdin);
    size_t n;
    cin >> n;

    auto* data = new int64_t[n];
    for (size_t i = 0; i < n; ++i) 
        cin >> data[i];

    unsigned long long f =__rdtsc(), l;
    const long long frequency = 2500000000;

    BubbleSort(data, n);
    delete[] data;

    l = __rdtsc();

    cout << (long double)(l - f) / frequency << endl;

    return 0;
}
