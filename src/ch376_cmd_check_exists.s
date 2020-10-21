        .module ch376_cmd_check_exists
        .include 'ch376_internal.s'
;
;       imports
;
;
;       exports
;
        .globl  ch376_cmd_check_exists
        .globl  ch376_cmd_disk_connect
        .globl  ch376_cmd_set_usb_mode
        .globl  ch376_cmd_disk_mount
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
ch376_cmd_check_exists:
        ld      d,#CMD_CHECK_EXIST
        call    ch376_dev_send_command
        ld      d,#01
        call    ch376_dev_send_arg
        call    ch376_dev_get_result
        ld      a,#0xfe ;
        cp      e
        scf
        ret     nz
        xor     a,a
        ret

; IN : none
; OUT: CF on error
; Mod: ?
ch376_cmd_disk_connect:
        ld      d,#CMD_DISK_CONNECT
        call    ch376_dev_send_command_with_result
        ld      a,#USB_INT_SUCCESS
        cp      e
        scf
        ret     nz
        xor     a,a
        ret

; IN : none
; OUT: CF on error
; Mod: ?
ch376_cmd_set_usb_mode:
        ld      d,#CMD_SET_USB_MODE
        call    ch376_dev_send_command
        ld      d,#06
        call    ch376_dev_send_arg
        call    ch376_dev_get_result
        ld      a,#CMD_RET_SUCCESS
        cp      e
        scf
        ret     nz
        call    ch376_dev_get_result
        ld      a,e
        ld      a,#USB_INT_CONNECT
        cp      e
        scf
        ret     nz
        xor     a,a
        ret

ch376_cmd_disk_mount:
        ld      d,#CMD_DISK_MOUNT
        call    ch376_dev_send_command_with_result
        ld      a,#USB_INT_SUCCESS
        cp      e
        scf
        ret     nz
        xor     a,a
        ret
