# 
# Welcome to GDB Online.
# GDB online is an online compiler and debugger tool for C, C++, Python, Java, PHP, Ruby, Perl,
# C#, VB, Swift, Pascal, Fortran, Haskell, Objective-C, Assembly, HTML, CSS, JS, SQLite, Prolog.
# Code, Compile, Run and Debug online from anywhere in world.
# 
# 
.data
 primes:
 .zero 100
.text
    
.global main
main:
	xor	%rax, %rax
	call initPrimes
	call calculate
	call printAllPrimes
	ret


initPrimes:
    mov $0x64, %rbx
beginInit:    
    cmp $0x0, %rbx
    jle quit
    lea primes(,1), %rsi
    add %rbx, %rsi
    movb $0x01, (%rsi)  
    dec %rbx
    jmp beginInit
quitInit: 
    ret

/* Fill in the primes into memory 
   rbx contains curPrime
   rcx contains walker
   rsi used to find the memory location
*/	
calculate:
    lea primes(,1), %rsi
    /* 0 and 1 arent a prime */
    movb $0x00, (%rsi)   
    inc %rsi
    movb $0x00, (%rsi) /* 0 and 1 arent a prime */  
    mov $0x01, %rbx /* curprime = 1 */
whileCurPrime: /* While curprime < max */    
    inc %rbx /* curprime ++ */
    cmp $0x64, %rbx /* 0x64 ?= curprime  */
    jge quitCalc /* curPrime >= 64 then quitCalc */
    
    lea primes(,1), %rsi
    add %rbx, %rsi  /* rsi = *primes + curPrime*/ 
    
    cmp $0x0, (%rsi)
    je whileCurPrime /* if primes + walker == 0 continue */
    mov %rbx, %rcx /* Walker = curPrime */
    add %rcx, %rcx /* Walker += walker */
    lea primes(,1), %rsi

whileWalkerMax: 
    cmp $0x64, %rcx /* Walker > Max ? */
    jg whileCurPrime /* if yes, then go back to main loop */
    
    movb $0x0, (%rcx, %rsi)
    add %rbx, %rcx /* walker += curPrime */
    jmp whileWalkerMax
     
quitCalc:    
    ret
    
/* print all primes starting from 0 */
printAllPrimes: 
    xor %rbx, %rbx
beginloop:    
    cmp $0x64, %rbx
    jg quit
    lea primes(,1), %rsi
    mov (%rsi,%rbx), %rax  
    call convertChar
    call print
    inc %rbx
    jmp beginloop
quit: 
    ret

	
/* converts a rax register into ascii. */
convertChar:
	add $0x30, %rax
    ret

/* print whatever is in rax, overwrites rax, rdi, rsp, rsi, rdx */	
print:
	push    %rax       
    mov     $1, %rax    # sys_write call number 
    mov     $1, %rdi    # write to stdout (fd=1)
    mov     %rsp, %rsi  # use char on stack
    mov     $1, %rdx    # write 1 char
    syscall   
    add     $8, %rsp    # restore sp 
    ret
