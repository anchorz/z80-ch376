        .module ch376-ccp
        .include 'z1013.s'

ERR_INIT_FAILED                 = 0x01
ERR_MOUNT_FAILED                = 0x02
;
;       imports
;
        .globl  ch376_module_init
        .globl  ch376_module_mount
;
;       exports
;
        .globl  main
;
;       program code
;
        .area  _CODE
main:
        ld      a,#0x0c
        UP_OUTCH
        UP_PRST7 ^/Hobi's CH376-CCP@19.2K (C) 2020\r/
        call    ch376_module_init
        ld      l,a
        ld      a,#ERR_INIT_FAILED
        jp      c,err_handler
        call    ch376_module_mount
        ld      l,a
        ld      a,#ERR_MOUNT_FAILED
        jp      c,err_handler
        UP_PRST7 ^/Module OK.\r/
        ret

err_handler:
        push    af
        UP_PRST7 ^/Error:/
        pop     af
        UP_OUTHX
        ld      a,l
        UP_OUTHX
        jp      exit
