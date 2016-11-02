name "bin-sum"            

org 100h        

.data

msg  db 'AnhNV - the binary calculator $'
msg0 db 0x0D, 0x0A, '----------------------------- $'
msg1 db 0x0D, 0x0A, 'the first binary number  : $'
msg2 db 0x0D, 0x0A, 'the second binary number: $'
msg3 db 0x0D, 0x0A, 'the sum is               : $'
msg4 db 0x0D, 0x0A, 0x0A, 'one of two binary number you have entered is too large to calculate, $'
msg5 db 0x0D, 0x0A, 'press any key... $'  

; buffer for int 21h/0ah
; fist byte is buffer size,
; second byte is number of chars actually read (set by int 21h/0ah).
num1 db 9,?, 5 dup (0), 0, 0

num2 db 9,?, 5 dup (0), 0, 0

sum db  10,?, 5 dup (0), 0, 0

.code

    mov dx, offset msg
    mov ah, 9
    int 0x21         
    
    mov dx, offset msg0
    ;mov ah, 9
    int 0x21
    
    mov dx, offset msg1
    ;mov ah, 9
    int 0x21 
    
    mov dx, offset num1
    mov ah, 0x0A
    int 0x21
    
    
    mov dx, offset msg2
    mov ah, 9
    int 0x21
    
    mov dx, offset num2
    mov ah, 0x0A
    int 0x21

    
    mov dl, num1+9
    mov dh, num2+9    
    ;mov ah, 2
    add dl, dh
    sub dl, 48
    cmp dl, 50
    je  cmpdl9
retdl9:
    mov al, dl
    push    ax
    ;int 0x21    
    jmp cont8 
    
cmpdl9:
    mov bl, 1
    mov dl, 48 
    jmp retdl9          
      
  
cont8:    
    xor dl, dl
    xor dh, dh
    mov dl, num1+8
    mov dh, num2+8
    ;mov ah, 2
    add dl, dh  
    sub dl, 48
    cmp bl, 1
    je  cmpbl8
retbl8:
    cmp dl, 50
    je  cmpdl8 
retdl8:
    mov al, dl
    push    ax
    ;int 0x21
    jmp cont7
    
cmpbl8:
    add dl, bl
    mov bl, 0
    jmp retbl8
    
cmpdl8:
    mov bl, 1
    mov dl, 48 
    jmp retdl8
    

cont7:    
    xor dl, dl
    xor dh, dh
    mov dl, num1+7
    mov dh, num2+7
    ;mov ah, 2
    add dl, dh
    sub dl, 48
    cmp bl, 1
    je  cmpbl7
retbl7:
    cmp dl, 50
    je  cmpdl7
retdl7:   
    mov al, dl
    push    ax
    ;int 0x21
    jmp cont6
    
cmpbl7:
    add dl, bl
    mov bl, 0
    jmp retbl7
    
cmpdl7:
    mov bl, 1
    mov dl, 48 
    jmp retdl7

    
cont6:
    xor dl, dl
    xor dh, dh
    mov dl, num1+6
    mov dh, num2+6
    ;mov ah, 2
    add dl, dh
    sub dl, 48
    cmp bl, 1
    je  cmpbl6
retbl6:
    cmp dl, 50
    je  cmpdl6
retdl6:   
    mov al, dl
    push    ax
    ;int 0x21
    jmp cont5      
      
cmpbl6:
    add dl, bl
    mov bl, 0
    jmp retbl6
    
cmpdl6:
    mov bl, 1
    mov dl, 48 
    jmp retdl6 


cont5:     
    xor dl, dl
    xor dh, dh
    mov dl, num1+5
    mov dh, num2+5
    ;mov ah, 2
    add dl, dh
    sub dl, 48
    cmp bl, 1
    je  cmpbl5
retbl5:
    cmp dl, 50
    je  cmpdl5
retdl5:   
    mov al, dl
    push    ax
    ;int 0x21
    jmp cont4      
    
cmpbl5:
    add dl, bl
    mov bl, 0
    jmp retbl5
    
cmpdl5:
    mov bl, 1
    mov dl, 48 
    jmp retdl5


cont4:    
    xor dl, dl
    xor dh, dh
    mov dl, num1+4
    mov dh, num2+4
    ;mov ah, 2
    add dl, dh
    sub dl, 48
    cmp bl, 1
    je  cmpbl4
retbl4:
    cmp dl, 50
    je  cmpdl4
retdl4:   
    mov al, dl
    push    ax
    ;int 0x21
    jmp cont3       
    
cmpbl4:
    add dl, bl
    mov bl, 0
    jmp retbl4
    
cmpdl4:
    mov bl, 1
    mov dl, 48 
    jmp retdl4


cont3:    
    xor dl, dl
    xor dh, dh
    mov dl, num1+3
    mov dh, num2+3
    ;mov ah, 2
    add dl, dh
    sub dl, 48
    cmp bl, 1
    je  cmpbl3
retbl3:
    cmp dl, 50
    je  cmpdl3
retdl3:   
    mov al, dl
    push    ax
    ;int 0x21
    jmp cont2      
    
cmpbl3:
    add dl, bl
    mov bl, 0
    jmp retbl3
    
cmpdl3:
    mov bl, 1
    mov dl, 48 
    jmp retdl3


cont2:    
    xor dl, dl
    xor dh, dh
    mov dl, num1+2
    mov dh, num2+2
    ;mov ah, 2
    add dl, dh
    sub dl, 48
    cmp bl, 1
    je  cmpbl2
retbl2:
    cmp dl, 50
    je  cmpdl2
    jge overflow
retdl2:   
    mov al, dl
    push    ax
    
    mov dx, offset msg3
    mov ah, 9
    int 0x21
    
    ;int 0x21
    jmp popstack   
    
cmpbl2:
    add dl, bl
    mov bl, 0
    jmp retbl2
    
cmpdl2:
    mov bl, 1
    mov dl, 48 
    jmp retdl2 
    
overflow:
    mov dx, offset msg4
    mov ah, 9
    int 0x21
    mov dx, offset msg5
    ;mov ah, 9
    int 0x21
    jmp exit
    
    
popstack:
    mov ah, 2
    pop dx
    int 0x21
    pop dx
    int 0x21
    pop dx
    int 0x21
    pop dx
    int 0x21
    pop dx
    int 0x21
    pop dx
    int 0x21
    pop dx
    int 0x21
    pop dx
    int 0x21
    jmp exit
     
exit:                  
    mov ah, 0
    int 0x16
            
ret