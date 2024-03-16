# Memory_allocation_considerations
Memory allocation in C, C++, and ARM Assembly
<p align="center">
  <img src="https://github.com/2daeeun/Memory_allocation_considerations/blob/main/image.png?raw=true">
</p>

## Compile
**C++**
```
g++ -o allocate allocate.cpp
./allocate
```
**C**
```
gcc -o allocate allocate.c
./allocate
```
**ARM Assembly**  
Checked on Raspberry Pi 3.
```
as -o allocate.o allocate.s
gcc -o allocate allocate.o
./allocate
```
