/*
Hello Word in CUDA using multiple threads and multiple dimension
*/
#include <stdio.h>

__global__ void helloFromGPU()
{   
    const int bid = blockIdx.x;
    const int tidx = threadIdx.x;
    const int tidy = threadIdx.y;
    printf("Hello World from GPU! Block ID: %d, Thread ID: (%d, %d)\n", bid, tidx, tidy);
}

int main() {
    const dim3 block_size(4, 2); // 4, 2, 1
    helloFromGPU<<<1, block_size>>>();
    cudaDeviceSynchronize();
    return 0;
}