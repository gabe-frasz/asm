section .data
  hello: db "Hello, world!", 10
  hello_len: equ $ - hello
section .text
  global_start

  _start:
    mov rax, 1
    mov rdi, 1
    mov rsi, hello
    mov rdx, hello_len
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

