#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

// Set a large number of steps for a noticeable execution time
#define NUM_STEPS 1000000000

int main()
{
    long i;
    double x, pi;
    double sum = 0.0;
    double step = 1.0 / (double)NUM_STEPS;

    // Record the start time
    double start_time = omp_get_wtime();

    // TODO: Parallelize this loop using OpenMP.
    // You will need to use a pragma to create a parallel region
    // and distribute the loop iterations among threads.
    // Crucially, you must also handle the 'sum' variable correctly
    // to avoid a race condition where multiple threads try to update it at once.
    // Hint: Look into the 'reduction' clause.
    for (i = 0; i < NUM_STEPS; i++)
    {
        x = (i + 0.5) * step;
        sum = sum + 4.0 / (1.0 + x * x);
    }

    pi = step * sum;

    // Record the end time
    double end_time = omp_get_wtime();
    double execution_time = end_time - start_time;

    printf("Calculated Pi = %1.15f\n", pi);
    printf("Execution time: %f seconds\n", execution_time);

    return 0;
}