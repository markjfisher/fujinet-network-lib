        .export         _fn_io_get_adapter_config_extended
        .import         fn_io_copy_cmd_data, _fn_io_do_bus

        .include        "zp.inc"
        .include        "macros.inc"
        .include        "fn_data.inc"
        .include        "fujinet-io.inc"

; void fn_io_get_adapter_config_extended(AdapterConfigExtended *adapter_config)
;
.proc _fn_io_get_adapter_config_extended
        ; store the memory location of the adapter config
        axinto  tmp7

        setax   #t_io_get_adapter_config_ext
        jsr     fn_io_copy_cmd_data

        ; set the memory address, new size, and aux1 for DCB
        mwa     tmp7, IO_DCB::dbuflo
        jmp     _fn_io_do_bus

.endproc

.rodata
.define ACEsz .sizeof(AdapterConfigExtended)

t_io_get_adapter_config_ext:
        .byte $e8, $40, <ACEsz, >ACEsz, $01, $00