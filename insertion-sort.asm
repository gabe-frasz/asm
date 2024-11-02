.model small
.data
  enter db 0ah, 0dh, "$"
  is_sorted db 1h
  count db 0h
  key db ?
  arr db 39h, 37h, 36h, 34h, 33h, 31h, 30h, 24h
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

INSERTION_LOOP:
  MOV is_sorted, 1h
  MOV si, 01h
INSERTION_SORT:
  MOV cl, arr[si]
  CMP cl, "$"
  JE CHECK_IF_SORTED
  MOV bp, si
  MOV cl, arr[si]
  MOV key, cl
COMPARE:
  MOV cl, key
  CMP cl, arr[si-1]
  JL MAKE_ROOM
  JMP INSERT_KEY
END_INSERTION_LOOP:
  INC si
  JMP INSERTION_SORT

INSERT_KEY:
  MOV cl, key
  MOV arr[si], cl
  JMP END_INSERTION_LOOP

CHECK_IF_SORTED:
  MOV cl, is_sorted
  CMP cl, 1h
  JE PRINT_ARRAY
  JMP INSERTION_LOOP

MAKE_ROOM:
  MOV bh, arr[si-1]
  MOV arr[si], bh
  MOV is_sorted, 0h
  DEC si
  CMP si, 0h
  JE INSERT_KEY_AND_BREAK
  JMP COMPARE
INSERT_KEY_AND_BREAK:
  MOV cl, key
  MOV arr[si], cl
  MOV si, bp
  JMP END_INSERTION_LOOP

PRINT_ARRAY:
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
