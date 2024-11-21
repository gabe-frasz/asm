.model small
.data
  enter db 0ah, 0dh, "$"
  arr db "87253445$"
.code
  PRINTS MACRO str
    LEA dx, str
    MOV ah, 09h
    INT 21h
  ENDM
 
  MOV ax, @data ; set DS to point to the data segment
  MOV ds, ax    ; DS cannot be accessed directly
 
  MOV si, 01h
INSERTION_LOOP:
  MOV cl, arr[si]
  CMP cl, "$"
  JE EXIT
  MOV bx, si
COMPARE:
  CMP cl, arr[bx-1]
  JGE INSERTION_LOOP_END
  MOV ah, arr[bx-1]
  MOV arr[bx], ah
  DEC bx
  CMP bx, 0h
  JNE COMPARE
INSERTION_LOOP_END:
  MOV arr[bx], cl
  PRINTS arr
  PRINTS enter
  INC si
  JMP INSERTION_LOOP
 
EXIT:
  MOV ah, 4ch ; return control to OS
  INT 21h
end
