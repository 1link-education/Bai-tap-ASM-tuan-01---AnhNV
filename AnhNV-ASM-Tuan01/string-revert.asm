name "string-revert"            

org 100h        

.data

msg  db 'AnhNV - the string reverter $'
msg0 db 0x0D, 0x0A, '--------------------------- $'
msg1 db 0x0D, 0x0A, 'your string     : $'
msg2 db 0x0D, 0x0A, 'reverted string: $'


.code

    mov dx, offset msg
    mov ah, 9
    int 0x21         
    
    mov dx, offset msg0
    int 0x21
    
    mov dx, offset msg1
    int 0x21
    
    xor cx, cx
    mov ah, 1
    int 0x21
    
WHILE:
    cmp al, 0x0D
    je  END_WHILE
    
    push    ax
    inc cx
    
    int 0x21
    jmp WHILE
    
END_WHILE:
    ;mov ah, 2
    ;mov dl, 0x0D
    ;int 0x21
    ;mov dl, 0x0A
    ;int 0x21
    mov ah, 9
    mov dx, offset msg2
    int 0x21
    
    mov ah, 2
    jcxz    EXIT
    
TOP:
    pop dx
    int 0x21
    loop    top
    
EXIT:
    mov ah, 0x4C
    int 0x21

ret 