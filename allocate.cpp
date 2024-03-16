#include <iostream>
#include <new>

int main() {
  int *num_ptr = nullptr;

  try {
    num_ptr = new int; // Attempt to allocate memory for an integer
    *num_ptr = 100;    // Assign a value to the allocated memory
    std::cout << "Dynamic number : " << *num_ptr << std::endl;
  } catch (const std::bad_alloc &e) {
    return 1;
  }

  delete num_ptr;

  return 0;
}
