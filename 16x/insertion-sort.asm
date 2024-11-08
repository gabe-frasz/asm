.model small
.data
  enter db 0ah, 0dh, "$"
  msg1 db "Enter the array elements: $"
  msg2 db "Sorted array: $"
  is_sorted db ?
  key db ?
  arr db ?
.code
  PRINTS MACRO str
    LEA dx, str
    MOV ah, 09h
    INT 21h
  ENDM

  PRINTC MACRO char
    MOV dl, char
    MOV ah, 02h
    INT 21h
  ENDM

  SCANC MACRO
    MOV ah, 01h
    INT 21h
  ENDM

  MOV ax, @data ; set DS to point to the data segment
  MOV ds, ax    ; DS cannot be accessed directly

  PRINTS msg1
  MOV si, 0h
GET_ARRAY_LOOP:
  SCANC
  MOV arr[si], al
  CMP al, "$"
  JE INSERTION_SORT
  INC si
  JMP GET_ARRAY_LOOP

INSERTION_LOOP:
  MOV is_sorted, 1h
  MOV si, 01h
INSERTION_SORT:
  MOV cl, arr[si]
  CMP cl, "$"
  JE CHECK_IF_SORTED
  MOV cl, arr[si]
  MOV key, cl
  MOV bx, si
COMPARE:
  MOV cl, key
  CMP cl, arr[bx-1]
  JL MAKE_ROOM
  JMP INSERT_KEY
END_INSERTION_LOOP:
  INC si
  JMP INSERTION_SORT

CHECK_IF_SORTED:
  CMP is_sorted, 1h
  JE PRINT_ARRAY
  JMP INSERTION_LOOP

MAKE_ROOM:
  MOV is_sorted, 0h
  MOV ah, arr[bx-1]
  MOV arr[bx], ah
  DEC bx
  CMP bx, 0h
  JE INSERT_KEY
  JMP COMPARE

INSERT_KEY:
  MOV cl, key
  MOV arr[bx], cl
  JMP END_INSERTION_LOOP

PRINT_ARRAY:
  PRINTS enter
  PRINTS msg2 
  MOV si, 0h
PRINT_ARRAY_LOOP:
  PRINTC arr[si]
  INC si
  CMP arr[si], "$"
  JNE PRINT_ARRAY_LOOP

EXIT:
  MOV ah, 4ch ; return control to OS
  INT 21h
end
