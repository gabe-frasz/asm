.model small
.data
  enter db 0ah, 0dh, "$" ; newline, carriage return, end of string
.code
  PRINTS MACRO str  ; prints a string
    LEA dx, str     ; load the address of the string into DX
    MOV ah, 09h     ; print string function
    INT 21h        
  ENDM

  PRINTL MACRO str  ; prints a string with newline
    PRINTS str
    PRINTS enter
  ENDM

  PRINTC MACRO char ; prints a character
    MOV dl, char    ; load the character into DL
    MOV ah, 02h     ; print character function
    INT 21h
  ENDM

  SCANC MACRO       ; scans a character
    MOV ah, 01h     ; scan character function (save character in AL)
    INT 21h
  ENDM

  MOV ax, @data ; set DS to point to the data segment
  MOV ds, ax    ; DS cannot be accessed directly

EXIT:
  MOV ah, 4ch ; return control to OS
  INT 21h
end
