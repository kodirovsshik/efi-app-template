
ESP := ./ESP
override OUTDIR := $(ESP)/EFI/BOOT
override OUT := $(OUTDIR)/BOOTX64.efi
override SOURCES := $(wildcard *.cpp)

clangxx := clang++
override clangxx-efi := "$(clangxx)" $(CLANG_ARGS) --target=x86_64-windows-efi -std=c++17 -fuse-ld=lld-link -ffreestanding -mgeneral-regs-only -nostdlib -Wl,-entry:efi_main -Wl,-subsystem:efi_application -Wl,-largeaddressaware -Wall -Wextra -Werror -I/usr/include/efi

.PHONY: all
all: $(OUT)
	$(MAKE) run

.PHONY: run
run:
	qemu-system-x86_64 -bios /usr/share/ovmf/OVMF.fd -drive if=virtio,format=raw,file=fat:rw:./ESP

$(OUT): $(wildcard *.h) $(wildcard *.hpp)
	mkdir -p $(OUTDIR)
	$(clangxx-efi) $(SOURCES) -o $@
