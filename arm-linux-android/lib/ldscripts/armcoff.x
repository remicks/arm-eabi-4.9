/* Default linker script, for normal executables */
/* Copyright (C) 2014-2015 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("coff-arm-little", "coff-arm-big", "coff-arm-little")
ENTRY (_start)
SECTIONS
{
  /* We start at 0x8000 because gdb assumes it (see FRAME_CHAIN).
     This is an artifact of the ARM Demon monitor using the bottom 32k
     as workspace (shared with the FP instruction emulator if
     present): */
  .text  0x8000 : {
    *(.init)
    *(.text*)
    *(.glue_7t)
    *(.glue_7)
    *(.rdata)
     ___CTOR_LIST__ = .; __CTOR_LIST__ = . ;
			LONG (-1); *(.ctors); *(.ctor); LONG (0);
     ___DTOR_LIST__ = .; __DTOR_LIST__ = . ;
			LONG (-1); *(.dtors); *(.dtor);  LONG (0);
    *(.fini)
     etext  =  .;
     _etext =  .;
  }
  .data 0x40000 + (ALIGN(0x8) & 0xfffc0fff) : {
      __data_start__ = . ;
    *(.data*)
    *(.gcc_exc*)
    ___EH_FRAME_BEGIN__ = . ;
    *(.eh_fram*)
    ___EH_FRAME_END__ = . ;
    LONG(0);
     __data_end__ = . ;
     edata  =  .;
     _edata  =  .;
  }
  .bss  ALIGN(0x8) :
  {
     __bss_start__ = . ;
    *(.bss)
    *(COMMON)
     __bss_end__ = . ;
  }
   end = .;
   _end = .;
   __end__ = .;
  .stab  0 (NOLOAD) :
  {
    [ .stab ]
  }
  .stabstr  0 (NOLOAD) :
  {
    [ .stabstr ]
  }
}
