; Listing generated by Microsoft (R) Optimizing Compiler Version 19.22.27905.0 

include listing.inc

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	__local_stdio_printf_options
PUBLIC	_vfprintf_l
PUBLIC	printf
PUBLIC	get_imp
PUBLIC	main
EXTRN	__imp_GetProcAddress:PROC
EXTRN	__imp_LoadLibraryA:PROC
EXTRN	__acrt_iob_func:PROC
EXTRN	__stdio_common_vfprintf:PROC
_DATA	SEGMENT
COMM	?_OptionsStorage@?1??__local_stdio_printf_options@@9@9:QWORD							; `__local_stdio_printf_options'::`2'::_OptionsStorage
_DATA	ENDS
;	COMDAT pdata
pdata	SEGMENT
$pdata$_vfprintf_l DD imagerel $LN3
	DD	imagerel $LN3+67
	DD	imagerel $unwind$_vfprintf_l
pdata	ENDS
;	COMDAT pdata
pdata	SEGMENT
$pdata$printf DD imagerel $LN3
	DD	imagerel $LN3+87
	DD	imagerel $unwind$printf
pdata	ENDS
pdata	SEGMENT
$pdata$get_imp DD imagerel $LN9
	DD	imagerel $LN9+299
	DD	imagerel $unwind$get_imp
$pdata$main DD	imagerel $LN7
	DD	imagerel $LN7+419
	DD	imagerel $unwind$main
pdata	ENDS
_DATA	SEGMENT
$SG97373 DB	'LoadLibraryA', 00H
	ORG $+3
$SG97374 DB	'GetProcAddress', 00H
	ORG $+1
$SG97375 DB	0aH, 'GetProcAddress : %p', 0aH, 'LoadLibraryA   : %p', 0aH
	DB	00H
	ORG $+6
$SG97376 DB	'LoadLibraryA', 00H
	ORG $+3
$SG97377 DB	'kernel32', 00H
	ORG $+7
$SG97378 DB	'GetProcAddress', 00H
	ORG $+1
$SG97379 DB	'kernel32', 00H
	ORG $+7
$SG97380 DB	0aH, 'GetProcAddress : %p', 0aH, 'LoadLibraryA   : %p', 0aH
	DB	00H
_DATA	ENDS
xdata	SEGMENT
$unwind$get_imp DD 011301H
	DD	06213H
$unwind$main DD	020701H
	DD	0110107H
xdata	ENDS
;	COMDAT xdata
xdata	SEGMENT
$unwind$printf DD 011801H
	DD	06218H
xdata	ENDS
;	COMDAT xdata
xdata	SEGMENT
$unwind$_vfprintf_l DD 011801H
	DD	06218H
xdata	ENDS
; Function compile flags: /Odsp
; File C:\hub\shellcode\os\win\getapi\image\llagpa.c
_TEXT	SEGMENT
base$ = 32
imp$ = 40
rva$ = 48
dll$ = 56
peb$ = 64
dos$ = 72
nt$ = 80
dir$ = 88
lla$ = 96
gpa$ = 104
tv134 = 112
main	PROC

; 68   : {

$LN7:
	sub	rsp, 136				; 00000088H

; 69   :   DWORD                    rva;
; 70   :   PIMAGE_IMPORT_DESCRIPTOR imp;
; 71   :   PIMAGE_DOS_HEADER        dos;
; 72   :   PIMAGE_NT_HEADERS        nt;
; 73   :   PIMAGE_DATA_DIRECTORY    dir;
; 74   :   LPVOID                   base, lla, gpa;
; 75   :   PDWORD                   dll;
; 76   :   PPEB                     peb;
; 77   : 
; 78   : #if defined(_WIN64)
; 79   :   peb = (PPEB) __readgsqword(0x60);

	mov	rax, QWORD PTR gs:96
	mov	QWORD PTR peb$[rsp], rax

; 80   : #else
; 81   :   peb = (PPEB) __readfsdword(0x30);
; 82   : #endif
; 83   : 
; 84   :   base = peb->ImageBaseAddress;

	mov	rax, QWORD PTR peb$[rsp]
	mov	rax, QWORD PTR [rax+16]
	mov	QWORD PTR base$[rsp], rax

; 85   :   dos  = (PIMAGE_DOS_HEADER)base;

	mov	rax, QWORD PTR base$[rsp]
	mov	QWORD PTR dos$[rsp], rax

; 86   :   nt   = RVA2VA(PIMAGE_NT_HEADERS, base, dos->e_lfanew);

	mov	rax, QWORD PTR dos$[rsp]
	movsxd	rax, DWORD PTR [rax+60]
	mov	rcx, QWORD PTR base$[rsp]
	add	rcx, rax
	mov	rax, rcx
	mov	QWORD PTR nt$[rsp], rax

; 87   :   dir  = (PIMAGE_DATA_DIRECTORY)nt->OptionalHeader.DataDirectory;

	mov	rax, QWORD PTR nt$[rsp]
	add	rax, 136				; 00000088H
	mov	QWORD PTR dir$[rsp], rax

; 88   :   rva  = dir[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;  

	mov	eax, 8
	imul	rax, rax, 1
	mov	rcx, QWORD PTR dir$[rsp]
	mov	eax, DWORD PTR [rcx+rax]
	mov	DWORD PTR rva$[rsp], eax

; 89   :   imp  = (PIMAGE_IMPORT_DESCRIPTOR) RVA2VA(ULONG_PTR, base, rva);

	mov	eax, DWORD PTR rva$[rsp]
	mov	rcx, QWORD PTR base$[rsp]
	add	rcx, rax
	mov	rax, rcx
	mov	QWORD PTR imp$[rsp], rax

; 90   :   
; 91   :   // locate kernel32.dll
; 92   :   for (;imp->Name!=0;imp++) 

	jmp	SHORT $LN4@main
$LN2@main:
	mov	rax, QWORD PTR imp$[rsp]
	add	rax, 20
	mov	QWORD PTR imp$[rsp], rax
$LN4@main:
	mov	rax, QWORD PTR imp$[rsp]
	cmp	DWORD PTR [rax+12], 0
	je	$LN3@main

; 93   :   {
; 94   :     dll = RVA2VA(PDWORD, base, imp->Name);

	mov	rax, QWORD PTR imp$[rsp]
	mov	eax, DWORD PTR [rax+12]
	mov	rcx, QWORD PTR base$[rsp]
	add	rcx, rax
	mov	rax, rcx
	mov	QWORD PTR dll$[rsp], rax

; 95   :     if ((dll[0] | 0x20202020) == 'nrek' && 

	mov	eax, 4
	imul	rax, rax, 0
	mov	rcx, QWORD PTR dll$[rsp]
	mov	eax, DWORD PTR [rcx+rax]
	or	eax, 538976288				; 20202020H
	cmp	eax, 1852990827				; 6e72656bH
	jne	SHORT $LN5@main
	mov	eax, 4
	imul	rax, rax, 1
	mov	rcx, QWORD PTR dll$[rsp]
	mov	eax, DWORD PTR [rcx+rax]
	or	eax, 538976288				; 20202020H
	cmp	eax, 842230885				; 32336c65H
	jne	SHORT $LN5@main

; 96   :         (dll[1] | 0x20202020) == '23le')
; 97   :     { 
; 98   :       // now locate GetProcAddress and LoadLibraryA
; 99   :       lla = get_imp(imp, base, (PDWORD)"LoadLibraryA");

	lea	r8, OFFSET FLAT:$SG97373
	mov	rdx, QWORD PTR base$[rsp]
	mov	rcx, QWORD PTR imp$[rsp]
	call	get_imp
	mov	QWORD PTR lla$[rsp], rax

; 100  :       gpa = get_imp(imp, base, (PDWORD)"GetProcAddress");

	lea	r8, OFFSET FLAT:$SG97374
	mov	rdx, QWORD PTR base$[rsp]
	mov	rcx, QWORD PTR imp$[rsp]
	call	get_imp
	mov	QWORD PTR gpa$[rsp], rax

; 101  :       break;

	jmp	SHORT $LN3@main
$LN5@main:

; 102  :     }
; 103  :   }

	jmp	$LN2@main
$LN3@main:

; 104  :   
; 105  :   printf ("\nGetProcAddress : %p"

	mov	r8, QWORD PTR lla$[rsp]
	mov	rdx, QWORD PTR gpa$[rsp]
	lea	rcx, OFFSET FLAT:$SG97375
	call	printf

; 106  :           "\nLoadLibraryA   : %p\n", gpa, lla);
; 107  :           
; 108  :   printf ("\nGetProcAddress : %p"

	lea	rcx, OFFSET FLAT:$SG97377
	call	QWORD PTR __imp_LoadLibraryA
	lea	rdx, OFFSET FLAT:$SG97376
	mov	rcx, rax
	call	QWORD PTR __imp_GetProcAddress
	mov	QWORD PTR tv134[rsp], rax
	lea	rcx, OFFSET FLAT:$SG97379
	call	QWORD PTR __imp_LoadLibraryA
	lea	rdx, OFFSET FLAT:$SG97378
	mov	rcx, rax
	call	QWORD PTR __imp_GetProcAddress
	mov	rcx, QWORD PTR tv134[rsp]
	mov	r8, rcx
	mov	rdx, rax
	lea	rcx, OFFSET FLAT:$SG97380
	call	printf

; 109  :           "\nLoadLibraryA   : %p\n", 
; 110  :           GetProcAddress(LoadLibraryA("kernel32"), 
; 111  :               "GetProcAddress"), 
; 112  :               
; 113  :           GetProcAddress(LoadLibraryA("kernel32"), 
; 114  :              "LoadLibraryA"));          
; 115  :   return 0;

	xor	eax, eax

; 116  : }

	add	rsp, 136				; 00000088H
	ret	0
main	ENDP
_TEXT	ENDS
; Function compile flags: /Odsp
; File C:\hub\shellcode\os\win\getapi\image\llagpa.c
_TEXT	SEGMENT
rva$ = 0
oft$ = 8
ft$ = 16
name$ = 24
ibn$ = 32
api_adr$ = 40
imp$ = 64
base$ = 72
api$ = 80
get_imp	PROC

; 34   : {

$LN9:
	mov	QWORD PTR [rsp+24], r8
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+8], rcx
	sub	rsp, 56					; 00000038H

; 35   :   PDWORD                   name;
; 36   :   LPVOID                   api_adr;
; 37   :   PIMAGE_THUNK_DATA        oft, ft;
; 38   :   PIMAGE_IMPORT_BY_NAME    ibn;
; 39   :   DWORD                    rva;
; 40   :   
; 41   :   rva   = imp->OriginalFirstThunk;

	mov	rax, QWORD PTR imp$[rsp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR rva$[rsp], eax

; 42   :   oft   = (PIMAGE_THUNK_DATA)RVA2VA(ULONG_PTR, base, rva);

	mov	eax, DWORD PTR rva$[rsp]
	mov	rcx, QWORD PTR base$[rsp]
	add	rcx, rax
	mov	rax, rcx
	mov	QWORD PTR oft$[rsp], rax

; 43   :   
; 44   :   rva   = imp->FirstThunk;

	mov	rax, QWORD PTR imp$[rsp]
	mov	eax, DWORD PTR [rax+16]
	mov	DWORD PTR rva$[rsp], eax

; 45   :   ft    = (PIMAGE_THUNK_DATA)RVA2VA(ULONG_PTR, base, rva);

	mov	eax, DWORD PTR rva$[rsp]
	mov	rcx, QWORD PTR base$[rsp]
	add	rcx, rax
	mov	rax, rcx
	mov	QWORD PTR ft$[rsp], rax
	jmp	SHORT $LN4@get_imp
$LN2@get_imp:

; 46   :     
; 47   :   for (;; oft++, ft++) 

	mov	rax, QWORD PTR oft$[rsp]
	add	rax, 8
	mov	QWORD PTR oft$[rsp], rax
	mov	rax, QWORD PTR ft$[rsp]
	add	rax, 8
	mov	QWORD PTR ft$[rsp], rax
$LN4@get_imp:

; 48   :   {
; 49   :     // no API left?
; 50   :     if (oft->u1.AddressOfData==0) break;

	mov	rax, QWORD PTR oft$[rsp]
	cmp	QWORD PTR [rax], 0
	jne	SHORT $LN5@get_imp
	jmp	$LN3@get_imp
$LN5@get_imp:

; 51   :     // skip ordinals
; 52   :     if (IMAGE_SNAP_BY_ORDINAL(oft->u1.Ordinal)) continue;

	mov	rax, QWORD PTR oft$[rsp]
	mov	rcx, -9223372036854775808		; 8000000000000000H
	mov	rax, QWORD PTR [rax]
	and	rax, rcx
	test	rax, rax
	je	SHORT $LN6@get_imp
	jmp	SHORT $LN2@get_imp
$LN6@get_imp:

; 53   :     
; 54   :     rva  = oft->u1.AddressOfData;

	mov	rax, QWORD PTR oft$[rsp]
	mov	eax, DWORD PTR [rax]
	mov	DWORD PTR rva$[rsp], eax

; 55   :     ibn  = (PIMAGE_IMPORT_BY_NAME)RVA2VA(ULONG_PTR, base, rva);

	mov	eax, DWORD PTR rva$[rsp]
	mov	rcx, QWORD PTR base$[rsp]
	add	rcx, rax
	mov	rax, rcx
	mov	QWORD PTR ibn$[rsp], rax

; 56   :     name = (PDWORD)ibn->Name;

	mov	rax, QWORD PTR ibn$[rsp]
	add	rax, 2
	mov	QWORD PTR name$[rsp], rax

; 57   :     
; 58   :     // have we a match?
; 59   :     if (name[0] == api[0] && name[1] == api[1]) {

	mov	eax, 4
	imul	rax, rax, 0
	mov	ecx, 4
	imul	rcx, rcx, 0
	mov	rdx, QWORD PTR name$[rsp]
	mov	r8, QWORD PTR api$[rsp]
	mov	ecx, DWORD PTR [r8+rcx]
	cmp	DWORD PTR [rdx+rax], ecx
	jne	SHORT $LN7@get_imp
	mov	eax, 4
	imul	rax, rax, 1
	mov	ecx, 4
	imul	rcx, rcx, 1
	mov	rdx, QWORD PTR name$[rsp]
	mov	r8, QWORD PTR api$[rsp]
	mov	ecx, DWORD PTR [r8+rcx]
	cmp	DWORD PTR [rdx+rax], ecx
	jne	SHORT $LN7@get_imp

; 60   :       api_adr = (LPVOID)ft->u1.Function;

	mov	rax, QWORD PTR ft$[rsp]
	mov	rax, QWORD PTR [rax]
	mov	QWORD PTR api_adr$[rsp], rax

; 61   :       break;

	jmp	SHORT $LN3@get_imp
$LN7@get_imp:

; 62   :     }
; 63   :   }

	jmp	$LN2@get_imp
$LN3@get_imp:

; 64   :   return api_adr;  

	mov	rax, QWORD PTR api_adr$[rsp]

; 65   : }

	add	rsp, 56					; 00000038H
	ret	0
get_imp	ENDP
_TEXT	ENDS
; Function compile flags: /Odsp
; File C:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\ucrt\stdio.h
;	COMDAT printf
_TEXT	SEGMENT
_Result$ = 32
_ArgList$ = 40
_Format$ = 64
printf	PROC						; COMDAT

; 954  :     {

$LN3:
	mov	QWORD PTR [rsp+8], rcx
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+24], r8
	mov	QWORD PTR [rsp+32], r9
	sub	rsp, 56					; 00000038H

; 955  :         int _Result;
; 956  :         va_list _ArgList;
; 957  :         __crt_va_start(_ArgList, _Format);

	lea	rax, QWORD PTR _Format$[rsp+8]
	mov	QWORD PTR _ArgList$[rsp], rax

; 958  :         _Result = _vfprintf_l(stdout, _Format, NULL, _ArgList);

	mov	ecx, 1
	call	__acrt_iob_func
	mov	r9, QWORD PTR _ArgList$[rsp]
	xor	r8d, r8d
	mov	rdx, QWORD PTR _Format$[rsp]
	mov	rcx, rax
	call	_vfprintf_l
	mov	DWORD PTR _Result$[rsp], eax

; 959  :         __crt_va_end(_ArgList);

	mov	QWORD PTR _ArgList$[rsp], 0

; 960  :         return _Result;

	mov	eax, DWORD PTR _Result$[rsp]

; 961  :     }

	add	rsp, 56					; 00000038H
	ret	0
printf	ENDP
_TEXT	ENDS
; Function compile flags: /Odsp
; File C:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\ucrt\stdio.h
;	COMDAT _vfprintf_l
_TEXT	SEGMENT
_Stream$ = 64
_Format$ = 72
_Locale$ = 80
_ArgList$ = 88
_vfprintf_l PROC					; COMDAT

; 642  :     {

$LN3:
	mov	QWORD PTR [rsp+32], r9
	mov	QWORD PTR [rsp+24], r8
	mov	QWORD PTR [rsp+16], rdx
	mov	QWORD PTR [rsp+8], rcx
	sub	rsp, 56					; 00000038H

; 643  :         return __stdio_common_vfprintf(_CRT_INTERNAL_LOCAL_PRINTF_OPTIONS, _Stream, _Format, _Locale, _ArgList);

	call	__local_stdio_printf_options
	mov	rcx, QWORD PTR _ArgList$[rsp]
	mov	QWORD PTR [rsp+32], rcx
	mov	r9, QWORD PTR _Locale$[rsp]
	mov	r8, QWORD PTR _Format$[rsp]
	mov	rdx, QWORD PTR _Stream$[rsp]
	mov	rcx, QWORD PTR [rax]
	call	__stdio_common_vfprintf

; 644  :     }

	add	rsp, 56					; 00000038H
	ret	0
_vfprintf_l ENDP
_TEXT	ENDS
; Function compile flags: /Odsp
; File C:\Program Files (x86)\Windows Kits\10\include\10.0.18362.0\ucrt\corecrt_stdio_config.h
;	COMDAT __local_stdio_printf_options
_TEXT	SEGMENT
__local_stdio_printf_options PROC			; COMDAT

; 87   :         static unsigned __int64 _OptionsStorage;
; 88   :         return &_OptionsStorage;

	lea	rax, OFFSET FLAT:?_OptionsStorage@?1??__local_stdio_printf_options@@9@9 ; `__local_stdio_printf_options'::`2'::_OptionsStorage

; 89   :     }

	ret	0
__local_stdio_printf_options ENDP
_TEXT	ENDS
END
