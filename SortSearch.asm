; Patrick Perkins ID: 38298454
; I promise this is my code and moy code alone
        segment .data
a       dd      14, 10, 23, 45, 17, 9, 54, 22, 1, 76
size    db      10
val     db      9
loc     db      -1
two     db      2
        segment .text
        global main
main:
        xor     eax, eax        ; array
        xor     ebx, ebx        ; size
        xor     ecx, ecx        ; counter
        xor     r8,  r8         ; a[i]
        xor     r9,  r9         ; a[i+1]
        
        lea     eax, [a]        ; address of array
        movzx   ebx, byte[size] ; store size
        dec     ebx             ; decrement size to n-1
do_while:
        mov     ecx, -1         ; move -1 into rcx so rcx can start at 0 in loop
        mov     dl, 0           ; swapped = false
for:    
        inc     ecx             ; increment ecx
        cmp     ecx, ebx        ; compare counter and size
        jz      end_for         ; if counter == size, jump to end_for
if:
        mov     r8d, [eax+(ecx*4)]     ; move a[i] into r8
        mov     r9d, [eax+((1+ecx)*4)] ; move a[i+1] into r9
        cmp     r8d, r9d               ; compare r8 and r9
        jle     for                    ; if a[i] < a[i+1] jump to for
        mov     [eax+(ecx*4)], r9d     ; move a[i+1] into r8
        mov     [eax+((1+ecx)*4)], r8d ; move a[i] into r9
        mov     dl, 1                  ; swapped == true
        jmp     for
end_for:
        cmp     dl, 0                  ; compare dl and 0
        jnz     do_while               ; if ZF = 0, algorithm is done
;---------------------------Binary Search------------------------------------------------------------------
        xor     eax, eax  ; quotient/index of middle
        xor     ebx, ebx  ; array
        xor     edx, edx  ; clear remainder register even tho you don't need it???????????????
        xor     r8, r8    ; lower
        xor     r9, r9    ; value of middle
        xor     r10, r10  ; upper
        
        lea     ebx, [a]
        mov     r10b, 9   ; upper starts at len 9
while:
        cmp     r8b, r10b ; compare upper and lower
        jg      end       ; if upper > low, jmp to end
        mov     al, r8b   ; move lower into middle
        add     al, r10b  ; (lower + upper)
        div     word[two] ; (lower + upper)/2
        mov     r9d, [rbx+(rax*4)] ; store value of middle
if_:
        cmp     [val], r9b ; if middle == val
        jz      end        ; return val
else_if:
        cmp     [val], r9b ; compare val and middle
        jg      else       ; if val > middle jump to else
        dec     al         ; middle-1
        mov     r10b, al   ; upper = middle-1
        xor     edx, edx   ; yo the rem register is whack. You gotta clear it every time??
        jmp     while      ; repeat binary search
else:
        inc     al         ; middle+1
        mov     r8b, al    ; lower = middle+1
        xor     edx, edx   ; clear dat rem register i guess......
        jmp     while      ; repeat while loop
end:
        mov     [loc], al  ; move the index of value search for into loc
ret
