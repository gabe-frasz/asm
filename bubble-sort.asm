.model small
.data
  enter db 0ah, 0dh, "$"
  msg1 db "Enter the array elements: $"
  msg2 db "Sorted array: $"
  is_sorted db ?
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
      mov ah, 01h
      int 21h
  ENDM

  MOV ax, @data ; set DS to point to the data segment
  MOV ds, ax    ; DS cannot be accessed directly

  PRINTS msg1
  MOV si, 0h
GET_ARRAY_LOOP:
  SCANC
  MOV arr[si], al
  CMP al, "$"
  JE SORT
  INC si
  JMP GET_ARRAY_LOOP

SORT:
  MOV si, 0h
  MOV is_sorted, 1h
SORT_LOOP:
  MOV bh, arr[si+1]
  CMP bh, "$"
  JE CHECK_IF_SORTED
  MOV bh, arr[si+1]
  CMP arr[si], bh
  JG SORT_SWAP
END_SORT_LOOP:
  INC si
  JMP SORT_LOOP

CHECK_IF_SORTED:
  CMP is_sorted, 1h
  JE PRINT_ARRAY
  JNE SORT

SORT_SWAP:
  MOV cl, arr[si]
  MOV bh, arr[si+1]
  MOV arr[si], bh
  MOV arr[si+1], cl
  MOV is_sorted, 0h
  JMP END_SORT_LOOP

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
  MOV ah, 4ch
  INT 21h
end
