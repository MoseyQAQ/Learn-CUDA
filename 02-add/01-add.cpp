#include <math.h>
#include <stdlib.h>
#include <stdio.h>

const double EPSILON = 1.0e-15;
const double a = 3.14;
const double b = 5.12;
const double c = 8.26;

void add(const double *x, const double *y, double *z, const int N);
void check(const double *z, const int N);

int main(void) {
    const int N = 100000000;
    const int M = sizeof(double) * N;
    double *x = (double *) malloc(M);
    double *y = (double *) malloc(M);
    double *z = (double *) malloc(M);
    
    for (int i = 0; i < N; i++) {
        x[i] = a;
        y[i] = b;
    }

    add(x, y, z, N);
    check(z, N);

    free(x);
    free(y);
    free(z);
    return 0;
}

void add(const double *x, const double *y, double *z, const int N) {
    for (int i = 0; i < N; i++) {
        z[i] = x[i] + y[i];
    }
}

void check(const double *z, const int N) {
    bool has_error = false;
    for (int i = 0; i < N; i++) {
        if (fabs(z[i] - c) > EPSILON) {
            has_error = true;
        }
    }
    if (!has_error) {
        printf("check ok\n");
    }
    else {
        printf("check error\n");
    }
}