/*
 * SPDX-License-Identifier: BSD-3-Clause
 *
 * Copyright © 2019 Keith Packard
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials provided
 *    with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

ENTRY(_start)

/*
 * These values should be provided by the application. We'll include
 * some phony values here to make things link for testing
 */

/*
MEMORY
{
	rom (rxa!w) : ORIGIN = DEFINED(__rom) ? __rom : 0x10000000, LENGTH = DEFINED(__rom_size) ? __rom_size : 0x10000
	ram (wxa!r)   : ORIGIN = DEFINED(__ram  ) ? __ram   : 0x20000000, LENGTH = DEFINED(__ram_size  ) ? __ram_size   : 0x08000
}
*/

PHDRS
{
	text PT_LOAD;
	ram PT_LOAD;
	ram_init PT_LOAD;
	tls PT_TLS;
}

SECTIONS
{
	PROVIDE(__stack = ORIGIN(ram) + LENGTH(ram));

	.__llvm_mos_basic ALIGN(1) : {
		KEEP (*(.__llvm_mos_basic.*))
	} >REGION_LOAD_ADDRESS AT>REGION_LOAD_ADDRESS :text

	.init ALIGN(1): {
		KEEP (*(.text.init.enter))
		KEEP (*(.data.init.enter))
		KEEP (*(SORT_BY_NAME(.init) SORT_BY_NAME(.init.*)))
	} >REGION_INIT AT>REGION_INIT :text

	.text ALIGN(1) : {
		*(.text.unlikely .text.unlikely.*)
		*(.text.startup .text.startup.*)
		*(.text .text.*)
		*(.gnu.linkonce.t.*)
	} >REGION_TEXT AT>REGION_TEXT :text

	.fini ALIGN(1): {
		KEEP (*(.fini))
		__text_end = .;
	} >REGION_INIT AT>REGION_INIT :text

	PROVIDE (__etext = __text_end);
	PROVIDE (_etext = __text_end);
	PROVIDE (etext = __text_end);

	.rodata ALIGN(1): {
		*(.rdata)
		*(.rodata .rodata.*)
		*(.gnu.linkonce.r.*)
		*(.srodata.cst16)
		*(.srodata.cst8)
		*(.srodata.cst4)
		*(.srodata.cst2)
		*(.srodata .srodata.*)
		*(.data.rel.ro .data.rel.ro.*)
		*(.got .got.*)
	} >REGION_RODATA AT>REGION_RODATA :text

	.preinit_array : {
		PROVIDE_HIDDEN ( __preinit_array_start = . );
		KEEP (*(.preinit_array))
		PROVIDE_HIDDEN ( __preinit_array_end = . );
	} >REGION_INIT_ARRAY AT>REGION_INIT_ARRAY :text

	.init_array : {
		PROVIDE_HIDDEN ( __init_array_start = . );
		KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.*) SORT_BY_INIT_PRIORITY(.ctors.*)))
		KEEP (*(.init_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .ctors))
		PROVIDE_HIDDEN ( __init_array_end = . );
	} >REGION_INIT_ARRAY AT>REGION_INIT_ARRAY :text

	.fini_array : {
		PROVIDE_HIDDEN ( __fini_array_start = . );
		KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.*) SORT_BY_INIT_PRIORITY(.dtors.*)))
		KEEP (*(.fini_array EXCLUDE_FILE (*crtbegin.o *crtbegin?.o *crtend.o *crtend?.o ) .dtors))
		PROVIDE_HIDDEN ( __fini_array_end = . );
	} >REGION_INIT_ARRAY AT>REGION_INIT_ARRAY :text

	.ctors : {
		KEEP (*crtbegin.o(.ctors))
		KEEP (*crtbegin?.o(.ctors))
		KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .ctors))
		KEEP (*(SORT_BY_INIT_PRIORITY(.ctors.*)))
		KEEP (*(.ctors))
	} >REGION_CTORS AT>REGION_CTORS :text

	.dtors : {
		KEEP (*crtbegin.o(.dtors))
		KEEP (*crtbegin?.o(.dtors))
		KEEP (*(EXCLUDE_FILE (*crtend.o *crtend?.o ) .dtors))
		KEEP (*(SORT_BY_INIT_PRIORITY(.dtors.*)))
		KEEP (*(.dtors))
	} >REGION_CTORS AT>REGION_CTORS :text

	/*
	 * Data values which are preserved across reset
	 */
	.preserve (NOLOAD) : {
		PROVIDE(__preserve_start__ = .);
		KEEP(*(SORT_BY_NAME(.preserve.*)))
		KEEP(*(.preserve))
		PROVIDE(__preserve_end__ = .);
	} >REGION_DATA AT>REGION_DATA :ram

	.data : {
		PROVIDE(__data_start = .);
		*(.data .data.*)
		*(.gnu.linkonce.d.*)
		PROVIDE( __global_pointer$ = . + 0x800 );
		*(.sdata .sdata.* .sdata2.*)
		*(.gnu.linkonce.s.*)
	} >REGION_DATA AT>REGION_DATA :ram_init
	PROVIDE(__data_source = LOADADDR(.data));

	/* Thread local initialized data. This gets
	 * space allocated as it is expected to be placed
	 * in ram to be used as a template for TLS data blocks
	 * allocated at runtime. We're slightly abusing that
	 * by placing the data in flash where it will be copied
	 * into the allocate ram addresses by the existing
	 * data initialization code in crt0
	 */
	.tdata : {
		PROVIDE( __tls_base = .);
		*(.tdata .tdata.* .gnu.linkonce.td.*)
		PROVIDE(__data_end = .);
	} >REGION_TDATA AT>REGION_TDATA :tls :ram_init
	PROVIDE( __tdata_source = LOADADDR(.tdata) );
	PROVIDE( __tdata_size = SIZEOF(.tdata) );

	PROVIDE( __edata = __data_end );
	PROVIDE( _edata = __data_end );
	PROVIDE( edata = __data_end );
	PROVIDE( __data_size = __data_end - __data_start );

	.tbss (NOLOAD) : {
		PROVIDE( __bss_start = . );
		*(.tbss .tbss.* .gnu.linkonce.tb.*)
		*(.tcommon)
		PROVIDE( __tls_end = . );
	} >REGION_TDATA AT>REGION_TDATA :tls :ram
	PROVIDE( __tbss_size = SIZEOF(.tbss) );
	PROVIDE( __tls_size = __tls_end - __tls_base );

	/*
	 * The linker special cases .tbss segments which are
	 * identified as segments which are not loaded and are
	 * thread_local.
	 *
	 * For these segments, the linker does not advance 'dot'
	 * across them.  We actually need memory allocated for tbss,
	 * so we create a special segment here just to make room
	 */
	.tbss_space (NOLOAD) : {
		. = . + __tbss_size;
	} >REGION_BSS AT>REGION_BSS :ram

	.bss (NOLOAD) : {
		*(.sbss*)
		*(.gnu.linkonce.sb.*)
		*(.bss .bss.*)
		*(.gnu.linkonce.b.*)
		*(COMMON)
		__bss_end = .;
	} >REGION_BSS AT>REGION_BSS :ram
	PROVIDE( __end = __bss_end );
	PROVIDE( _end = __bss_end );
	PROVIDE( end = __bss_end );
	PROVIDE( __bss_size = __bss_end - __bss_start );

	/* Make the rest of memory available for heap storage */
	PROVIDE( __heap_start = __end );
	PROVIDE( __heap_end = __stack - (DEFINED(__stack_size) ? __stack_size : 0x800) );
	PROVIDE( __heap_size = __heap_end - __heap_start );

	/* Throw away C++ exception handling information */
	/DISCARD/ : {
		*(.eh_frame .eh_frame.*)
		*(.note .note.*)
	}
}