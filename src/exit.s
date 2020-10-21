        .module exit
;
;       imports
;
;
;       exports
;
        .globl  exit
;
;       program code
;
        .area  _CODE
; exit to OS
; IN:   none
; OUT:  none
; Mod:  not specified
exit:
        rst 0x38
