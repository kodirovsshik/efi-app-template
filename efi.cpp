#include "efi.h"

EFI_STATUS efi_main(EFI_HANDLE, EFI_SYSTEM_TABLE* ST)
{
	eficheck(println("Hello world"), "failed to print");
	wait_kb();
  
	return 0;
}
