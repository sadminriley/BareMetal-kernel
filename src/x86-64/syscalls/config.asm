; =============================================================================
; BareMetal -- a 64-bit OS written in Assembly for x86-64 systems
; Copyright (C) 2008-2017 Return Infinity -- see LICENSE.TXT
;
; Config Functions
; =============================================================================


; -----------------------------------------------------------------------------
; b_system_config - View or modify system configuration options
; IN:	RCX = Function
;	RAX = Variable 1
;	RDX = Variable 2
; OUT:	RAX = Result
;	All other registers preserved
b_system_config:
	cmp rcx, 0
	je b_system_config_timecounter
	cmp rcx, 3
	je b_system_config_networkcallback_get
	cmp rcx, 4
	je b_system_config_networkcallback_set
	cmp rcx, 5
	je b_system_config_clockcallback_get
	cmp rcx, 6
	je b_system_config_clockcallback_set
	cmp rcx, 30
	je b_system_config_mac
	; PCI
	cmp rcx, 0x40
	je b_system_config_pci_read
	cmp rcx, 0x41
	je b_system_config_pci_write
	; Standard Output
	cmp rcx, 0x42
	je b_system_config_stdout_set
	cmp rcx, 0x43
	je b_system_config_stdout_get
	ret

b_system_config_timecounter:
	mov rax, [os_ClockCounter]	; Grab the timer counter value. It increments 8 times a second
	ret

b_system_config_networkcallback_get:
	mov rax, [os_NetworkCallback]
	ret

b_system_config_networkcallback_set:
	mov qword [os_NetworkCallback], rax
	ret

b_system_config_clockcallback_get:
	mov rax, [os_ClockCallback]
	ret

b_system_config_clockcallback_set:
	mov qword [os_ClockCallback], rax
	ret

b_system_config_mac:
	call b_net_status
	ret

b_system_config_pci_read:
	call os_pci_read
	ret

b_system_config_pci_write:
	call os_pci_write
	ret

b_system_config_stdout_get:
	mov rax, qword [0x100018]
	ret

b_system_config_stdout_set:
	mov qword [0x100018], rax
	ret

; -----------------------------------------------------------------------------


; =============================================================================
; EOF
