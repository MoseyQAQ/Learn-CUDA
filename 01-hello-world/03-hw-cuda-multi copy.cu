/*
Hello Word in CUDA using multiple threads
*/
#include <stdio.h>

__global__ void helloFromGPU()
{   
    const int bid = blockIdx.x;
    const int tid = threadIdx.x;
    printf("Hello World from GPU! Block ID: %d, Thread ID: %d\n", bid, tid);
}

int main() {
    helloFromGPU<<<4, 4>>>();
    cudaDeviceSynchronize();
    return 0;
}