        .module ch376-ccp
        .include 'z1013.s'
;
;       imports
;
        .globl  uart_init
        .globl  uart_send9600
        .globl  uart_recv9600
        ;.globl  uart_putstr
        ;.globl  putchar
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
        UP_PRST7 ^/Hobi's CH376-CCP (C) 2020 @19.2K\r/
        call    uart_init
        call    ch376_set_baud_rate
        ret


CMD_SET_BAUDRATE = 0x02
CMD_CHECK_EXIST  = 0x06

CMD_RET_SUCCESS  = 0x51

ch376_set_baud_rate:
        ld      e,#0x57
        call    uart_send9600
        ld      e,#0xAB
        call    uart_send9600
        ld      e,#CMD_CHECK_EXIST
        call    uart_send9600
        ld      e,#0x01
        call    uart_send9600
        call    uart_recv9600 ; response is 0xff-0x01=0xfe
        ld      a,e
        UP_OUTHX
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
        ld      a,e
        UP_OUTHX

        ret
