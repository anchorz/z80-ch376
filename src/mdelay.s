        .module mdelay
;
;       imports
;
;
;       exports
;
        .globl  mdelay
;
;       program code
;
        .area  _CODE
; IN: C delay in ms
; OUT: none
; modified: none
mdelay:
        push    bc
loop:
        ld      b,#0x99; 2MHz ~2000 clock cycles + call
1$:     djnz    1$
        dec     c
        jr      nz,loop
        pop     bc
        ret
