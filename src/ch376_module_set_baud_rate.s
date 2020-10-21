        .module ch376_module_set_baud_rate
        .include 'ch376_internal.s'
;
;       imports
;
;
;       exports
;
        .globl  ch376_module_set_baud_rate
;
;       program code
;
        .area  _CODE
;
; ch376_module_set_baud_rate switch speed from 9600 baud to 2nd registered value
;
;
; IN : none
; OUT: CF on error
; Mod: ?
ch376_module_set_baud_rate:
        ld      e,#0x57
        call    uart_send
        ld      e,#0xAB
        call    uart_send
        ld      e,#CMD_RESET_ALL
        call    uart_send
        ; call    uart_recv9600 omit result - we dont know the baudrate yet
        ; try again with different baud rate
        ld      e,#0x57
        call    uart_send9600
        ld      e,#0xAB
        call    uart_send9600
        ld      e,#CMD_RESET_ALL
        call    uart_send9600
        ;call    uart_recv9600 omit result - we dont know the baudrate yet
        ; wait for much more than 35ms to continue
        ld      c,#100
        call    mdelay
        ld      e,#0x57
        call    uart_send9600
        ld      e,#0xAB
        call    uart_send9600
        ld      e,#CMD_CHECK_EXIST
        call    uart_send9600
        ld      e,#0x01
        call    uart_send9600
        call    uart_recv9600 ; response is 0xff-0x01=0xfe
        ld      a,#0xfe
        cp      e
        scf
        ret     nz
        ld      e,#0x57
        call    uart_send9600
        ld      e,#0xAB
        call    uart_send9600
        ld      e,#CMD_SET_BAUDRATE
        call    uart_send9600
        ld      e,#0x02
        call    uart_send9600
        ld      e,#0xd9
        call    uart_send9600
        call    uart_recv ; response is 0x51 CMD_RET_SUCCESS
        ld      a,#CMD_RET_SUCCESS
        cp      e
        scf
        ret     nz
        xor     a,a     ; reset CF
        ret
