#include <stdio.h>
#include <iostream>
__global__ void helloFromGPU()
{
    printf("Hello World from GPU!\n");
    // std::cout << "Hello World from GPU!" << std::endl;
}

int main(void)
{
    helloFromGPU<<<2,4>>>();
    // cudaDeviceSynchronize();
    return 0;
}