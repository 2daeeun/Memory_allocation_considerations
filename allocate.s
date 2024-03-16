.section .data

format_str:
	.asciz "Dynamic number : %d\n"

format_str_fail:
	.asciz "Allocation failed\n"

	.section .text

	.global main

main:
	push {lr} // Save the return address

	// Allocate space for the number
	bl  allocate   // Call the allocate function
	cmp r0, #-1    // Check if allocation failed
	beq print_fail // If allocation failed, jump to print_fail

	push {r0}     // Save the allocated memory address in the stack
	ldr  r1, [r0] // Load the value from the allocated memory (pointer is inside r0)

	// Print to the console
	ldr r0, =format_str // Load the address of format_str into r0
	bl  printf          // Call printf to print the formatted string

	// Deallocate the Memory
	pop {r0}      // Restore the allocated memory address from the stack
	mov r1, #4096 // Set the length to 4096

	// munmap syscall
	mov r7, #215 // Set the syscall number for munmap
	svc #0       // Execute the syscall
	pop {pc}     // Return from the main function

allocate:
	push {lr}         // Save the return address
	mov  r0, #0       // addr : NULL, let the kernel choose the memory address
	mov  r1, #4096    // length : size of memory to map (e.g. one page of 4096 bytes)
	mov  r2, #3       // prot : PROT_READ | PROT_WRITE
	mov  r3, #0x22    // flags : MAP_PRIVATE | MAP ANNONYMOUS
	mov  r4, #-1      // fd : -1 because we are not mapping a file
	mov  r5, #0       // offset : 0
	mov  r7, #192     // Set the syscall number for mmap
	svc  #0           // Execute the syscall
	cmp  r0, #-1      // Check if allocation failed
	beq  alloc_failed // If allocation failed, jump to alloc_failed
	mov  r1, #42      // Set the value to be stored in the allocated memory
	str  r1, [r0]     // Store the value in the allocated memory
	b    alloc_exit   // Jump to alloc_exit

alloc_failed:
	mov r0, #-1    // Set r0 to -1 to indicate allocation failure
	b   alloc_exit // Jump to alloc_exit

alloc_exit:
	pop {pc} // Return from the allocate function

print_fail:
	ldr r0, =format_str_fail // Load the address of format_str_fail into r0
	bl  printf               // Call printf to print the allocation failed message
	b   exit                 // Jump to exit

exit:
	mov r7, #1 // Set the syscall number for exit
	svc #0     // Execute the syscall
