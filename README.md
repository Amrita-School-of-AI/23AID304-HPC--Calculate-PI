# Assignment: Parallel Pi Calculation with OpenMP 🥧

Welcome to your OpenMP assignment! You'll be parallelizing a program to calculate $\pi$.

## 🎯 Objective

Your goal is to modify the provided C code in `pi_calculator.c` to use OpenMP, speeding up the calculation of $\pi$ by parallelizing the main computational `for` loop.

## 🧠 Background

The program calculates $\pi$ by approximating the integral $\int_{0}^{1} \frac{4}{1 + x^2} dx$. It does this by summing the areas of millions of tiny rectangles under the function's curve. The core of the work happens inside a `for` loop that iterates `NUM_STEPS` times. This loop is a perfect candidate for parallelization.

## ✅ Your Task

1.  **Clone the Repository**: Start by cloning this repository to your local machine.

2.  **Inspect the Code**: Open `pi_calculator.c`. Understand how the serial version works. It calculates a `sum` over many iterations and then computes `pi`.

3.  **Modify the Code**:

    - Find the `for` loop indicated by the `// TODO:` comment.
    - Add a single OpenMP `#pragma` directive just before this loop to parallelize it.
    - **Crucial Hint**: When multiple threads add to a single shared variable like `sum`, it creates a "race condition". You must tell OpenMP how to handle this. The `reduction(+:sum)` clause is designed for exactly this situation. It gives each thread a private copy of `sum`, and at the end, it safely adds all the private copies together.

4.  **Compile and Run**:

    - Compile your modified code using a C compiler with OpenMP support (like `gcc`). You **must** include the `-fopenmp` flag.
      ```bash
      gcc -o pi_calculator pi_calculator.c -fopenmp -lm
      ```
      _(The `-lm` flag links the math library, which might be needed on some systems)_.
    - Run your compiled program:
      ```bash
      ./pi_calculator
      ```

5.  **Commit and Push**:
    - Once you are confident your code is correct and faster, commit your changes to `pi_calculator.c`.
    - Push the commit to your GitHub repository to be graded.

## Grading

Your submission will be automatically graded by GitHub Classroom based on the following criteria:

- **Compilation**: Your code must compile successfully with the `-fopenmp` flag.
- **Correctness**: Your program must output a value for $\pi$ that is numerically correct (approximately 3.14159).
- **Parallelism**: Your code must contain an OpenMP pragma (`#pragma omp parallel`).
- **Performance**: Your parallel code must run measurably faster than the original serial version.

Good luck!
