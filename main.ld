ENTRY(reset_handler)

_estack = ORIGIN(RAM) + LENGTH(RAM);

MEMORY
{
    FLASH (rx)        : ORIGIN = 0x08000000, LENGTH = 246K
	RAM (xrw)         : ORIGIN = 0x20000000, LENGTH = 64K
	RAM2 (xrw)        : ORIGIN = 0x10000000, LENGTH = 16K
}


SECTIONS
{
	.text : {
	      *(.text)
	      *(.text.*)
	      *(.rodata)
	      *(.rodata.*)
	      . = ALIGN(4);
	      _etext = .;
	}>FLASH

	_flash_dstart = .;

	.data :  {
	      _dstart = .;
	      *(.data)
	      *(.data.*)
	      . = ALIGN(4);
	      _dend = .;
	}>RAM AT> FLASH  /* Load into FLASH, but live in RAM */

} /* SECTIONS END */ 
