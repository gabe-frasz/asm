.model small
.data
  enter db 0ah, 0dh, "$" ; newline, carriage return, end of string
  arr db "988967620$"
  n dw 9h  
  is_sorted db 1h
.code
  PRINTS MACRO str  ; prints a string
    LEA dx, str     ; load the address of the string into DX
    MOV ah, 09h     ; print string function
    INT 21h        
  ENDM

  MOV ax, @data ; set DS to point to the data segment
  MOV ds, ax    ; DS cannot be accessed directly    
  
  MOV bx, 0h
BUBBLE_LOOP:
  MOV si, 0h
SWAP_LOOP:   
  MOV ax, n
  SUB ax, bx
  SUB ax, 1h
  CMP si, ax
  JGE PRINT_AND_CHECK
  MOV cl, arr[si]
  CMP cl, arr[si+1]
  JLE SWAP_LOOP_END
  MOV ah, arr[si+1]
  MOV arr[si], ah
  MOV arr[si+1], cl
  MOV is_sorted, 0h
SWAP_LOOP_END:
  INC si
  JMP SWAP_LOOP

PRINT_AND_CHECK:
  PRINTS arr
  PRINTS enter
  CMP is_sorted, 1h     
  JE EXIT       
  MOV is_sorted, 1h
  INC bx
  CMP bx, n
  JGE EXIT
  JMP BUBBLE_LOOP     

EXIT:
  MOV ah, 4ch ; return control to OS
  INT 21h
end
