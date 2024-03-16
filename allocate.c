#include <stdio.h>
#include <stdlib.h>

int main() {
  int *num_ptr =
      (int *)malloc(sizeof(int)); // Attempt to allocate memory for an integer

  if (num_ptr == NULL) {
    return 1;
  }

  *num_ptr = 100; // Assign a value to the allocated memory
  printf("Dynamic number : %d\n", *num_ptr);

  free(num_ptr);

  return 0;
}
