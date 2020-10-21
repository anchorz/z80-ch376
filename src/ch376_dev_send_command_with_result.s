        .module ch376_dev_send_command_with_result
        .include 'ch376_internal.s'
;
;       imports
;
;
        .globl  uart_recv
        .globl  uart_send
;
;       exports
;
        .globl  ch376_dev_send_command_with_result
        .globl  ch376_dev_send_command
        .globl  ch376_dev_send_arg
        .globl  ch376_dev_get_result
;
;       program code
;
        .area  _CODE
;
;
;
; IN : D CH376 command value
; OUT: E result
; Mod: A,E
ch376_dev_send_command_with_result:
        ld      e,#0x57
        call    uart_send
        ld      e,#0xAB
        call    uart_send
        ld      e,d
        call    uart_send
        call    uart_recv; response is 0xff-0x01=0xfe
        ret

ch376_dev_send_command:
        ld      e,#0x57
        call    uart_send
        ld      e,#0xAB
        call    uart_send
        ld      e,d
        call    uart_send
        ret

ch376_dev_send_arg:
        ld      e,d
        jp      uart_send

ch376_dev_get_result:
        jp      uart_recv
