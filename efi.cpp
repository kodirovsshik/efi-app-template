#include <efi.h>
#define efistr(x) (unsigned short*)(L ## x)

EFI_STATUS efi_main(EFI_HANDLE, EFI_SYSTEM_TABLE* ST)
{
  EFI_STATUS Status;
  EFI_INPUT_KEY Key;

  Status = ST->ConOut->OutputString(ST->ConOut, efistr("Hello World\r\n"));
  if (EFI_ERROR(Status))
    return Status;

  Status = ST->ConIn->Reset(ST->ConIn, FALSE);
  if (EFI_ERROR(Status))
    return Status;

  while ((Status = ST->ConIn->ReadKeyStroke(ST->ConIn, &Key)) == EFI_NOT_READY);

  return Status;
}
