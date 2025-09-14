#include <math.h>
#include <stdio.h>

const double EPSILON = 1.0e-15;
const double a = 1.23;
const double b = 4.56;
const double c = 5.79;

void __global__ add(const double *x, const double *y, double *z);
void check(const double *z, const int N);

int main(void){
    const int N = 100000000;
    const int M = sizeof(double) * N;
    double *cpu_x = (double*) malloc(M);
    double *cpu_y = (double*) malloc(M);
    double *cpu_z = (double*) malloc(M);

    for (int i = 0; i < N; i++) {
        cpu_x[i] = a;
        cpu_y[i] = b;
    }

    double *gpu_x, *gpu_y, *gpu_z;
    cudaMalloc((void**)&gpu_x, M);
    cudaMalloc((void**)&gpu_y, M);
    cudaMalloc((void**)&gpu_z, M);
    // cudaMemcpy(gpu_x, cpu_x, M, cudaMemcpyHostToDevice);
    cudaMemcpy(gpu_x, cpu_x, M, cudaMemcpyDeviceToHost); // error
    cudaMemcpy(gpu_y, cpu_y, M, cudaMemcpyHostToDevice);

    const int block_size = 128;
    const int grid_size = N / block_size;
    add<<<grid_size, block_size>>>(gpu_x, gpu_y, gpu_z);
    cudaMemcpy(cpu_z, gpu_z, M, cudaMemcpyDeviceToHost);
    check(cpu_z, N);

    free(cpu_x);
    free(cpu_y);
    free(cpu_z);
    cudaFree(gpu_x);
    cudaFree(gpu_y);
    cudaFree(gpu_z);
    return 0;
}

void __global__ add(const double *x, const double *y, double *z){
    const int n = blockDim.x * blockIdx.x + threadIdx.x;
    z[n] = x[n] + y[n];
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