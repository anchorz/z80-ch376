        .module ch376_module_mount
;
;       imports
;
        .globl  ch376_cmd_check_exists
        .globl  ch376_cmd_disk_connect
        .globl  ch376_cmd_set_usb_mode
        .globl  ch376_cmd_disk_mount
;
;       exports
;
        .globl  ch376_module_mount
;
;       program code
;
        .area  _CODE
;
;
;
; IN : none
; OUT: CF on error
;       else A=0x00
; Mod: ?
ch376_module_mount:
        call    ch376_cmd_check_exists
        ld      a,#1
        ret     c
        call    ch376_cmd_disk_connect
        ld      a,#2
        ret     c
        call    ch376_cmd_set_usb_mode
        ld      a,#3
        ret     c
        call    ch376_cmd_disk_mount
        ld      a,#4
        ret     c
        xor     a,a
        ret
