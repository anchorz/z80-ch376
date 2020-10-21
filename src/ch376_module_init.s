        .module ch376_module_init
;
;       imports
;
;
;       exports
;
        .globl  ch376_module_init
;
;       program code
;
        .area  _CODE
;
;
;
; IN : none
; OUT: CF on error
; Mod: ?
ch376_module_init:
        call    uart_init
        ret     c
        call    ch376_module_set_baud_rate
        ret     c
        xor     a,a
        ret
