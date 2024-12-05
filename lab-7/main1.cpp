#include <iostream>
#include <limits.h>
#include <ctime>
#include <cfloat>
#include <chrono>

using namespace std;

void CopyMatrix(float* Matrix1, float* Matrix2, int n){
    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++){
            Matrix2[i * n + j] = Matrix1[i * n + j];
        }
    }
}

void PrintMatrix(float* Matrix, int n){
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cout << Matrix[i * n + j] << "  ";
        }
        cout << "\n";
    }
}

void FillMatrix(float *Matrix, int n)
{
    srand(time(0));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            Matrix[i * n + j] = rand() % 5;
        }
    }
}

float* SumMatrix(float* Matrix1, float* Matrix2, int n){
    float *MatrixResult = new float[n * n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            MatrixResult[i * n + j] = Matrix1[i * n + j] + Matrix2[i * n + j];
        }
    }

    return MatrixResult;
}

float *SubMatrix(float *Matrix1, float *Matrix2, int n)
{
    float *MatrixResult = new float[n * n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            MatrixResult[i * n + j] = Matrix1[i * n + j] - Matrix2[i * n + j];
        }
    }

    return MatrixResult;
}

float *DivMatrix(float *Matrix1, float digit, int n)
{
    float *MatrixResult = new float[n * n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            MatrixResult[i * n + j] = Matrix1[i * n + j] / digit;
        }
    }

    return MatrixResult;
}

void MultMatrix(float *Matrix1, float *Matrix2, float* MatrixResult, int n){
    for (int i = 0; i < n; i++) {

        float *c = MatrixResult + i * n;

        for (int j = 0; j < n; j++) {
            c[j] = 0;
        }

        for (int k = 0; k < n; k++) {
            const float *b = Matrix2 + k * n;
            float a = Matrix1[i * n + k];

            for (int j = 0; j < n; j++) {
                c[j] += a * b[j];
            }
        }
    }
}

void InitializationMatrix(float* Matrix, int n){
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++){
            Matrix[i * n + j] = 0;
        }
    }
}

void FillIdentityMatrix(float *Matrix, int n){
    for (int i = 0; i < n; i++) {
       Matrix[i * n + i] = 1;
    }
}

float UnitRate(float* Matrix, int n) {
    float result = FLT_MIN, sum = 0;

    for (int j = 0; j < n; j++) {
        for (int i = 0; i < n; i++) {
            sum += abs(Matrix[i * n + j]);
        }

        if (sum > result) {
            result = sum;
        }

        sum = 0;
    }

    return result;
}

float InfiniteRate(float *Matrix, int n)
{
    float result = 0, sum = 0;

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            sum += abs(Matrix[i * n + j]);
        }

        if (sum > result) {
            result = sum;
        }

        sum = 0;
    }

    return result;
}

float* TranspositionMatrix(float* Matrix, int n){
    float* MatrixResult = new float[n * n];

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            MatrixResult[j * n + i] = Matrix[i * n + j];
            int a = j * n + i;
            int b = i * n + j;
        }
    }

    return MatrixResult;
}

void InversionMatrix(float *Matrix, float* MatrixResult, int n, int m) {
    float *MatrixIdentity = new float[n * n];
    FillIdentityMatrix(MatrixIdentity, n);

    float digit = UnitRate(Matrix, n) * InfiniteRate(Matrix, n);
    float *MatrixB = DivMatrix(TranspositionMatrix(Matrix, n), digit, n);

    float *Matrix1 = new float[n * n];
    MultMatrix(MatrixB, Matrix, Matrix1, n);

    float *MatrixC = new float[n * n];
    FillIdentityMatrix(MatrixC, n);

    float* MatrixR = new float[n * n];
    float *MatrixRFix = SubMatrix(MatrixIdentity, Matrix1, n);
    CopyMatrix(MatrixRFix, MatrixR, n);

    float *MatrixRCopy = new float[n * n];
    for (int i = 1; i < m; i++) {
        MatrixC = SumMatrix(MatrixC, MatrixR, n);
        CopyMatrix(MatrixR, MatrixRCopy, n);
        MultMatrix(MatrixRCopy,MatrixRFix, MatrixR, n);
    }

    MultMatrix(MatrixC, MatrixB, MatrixResult, n);

    delete[] MatrixRFix;
    delete[] MatrixB;
    delete[] MatrixIdentity;
    delete[] Matrix1;
    delete[] MatrixC;
    delete[] MatrixR;
    delete[] MatrixRCopy;
}

int main() {

    int n, m;
    cout << "Input N: " << endl;
    cin >> n;
    cout << "Input M: " << endl;
    cin >> m;
    float *Matrix = new float[n * n];
    float* Matrix1 = new float[n * n];

    FillMatrix(Matrix1, n);

    time_t start = time(nullptr), end;

    InversionMatrix(Matrix1, Matrix, n, m);

    end = time(nullptr);

    cout << "Time: " << end - start << " seconds" << endl;
    
    float *Matrix2 = new float[n * n];
    MultMatrix(Matrix1,Matrix, Matrix2, n);

    cout << endl << "First standart: "<< UnitRate(Matrix2, n);

    delete[] Matrix;
    delete[] Matrix1;
    delete[] Matrix2;

    return 0;
}