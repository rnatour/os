SRC_DIR = src
OBJ_DIR = obj
INC_DIR = include
KERNEL_DIR = iso/boot
LD_DIR = ld
CONFIG_DIR = config

CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
             -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFLAGS = -T $(LD_DIR)/link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf


OBJECTS = loader.o kmain.o utils.o
OBJ = $(patsubst %,$(OBJ_DIR)/%,$(OBJECTS))

DEPENDENCIES = utils.h
DEP = $(patsubst %,$(INC_DIR)/%,$(DEPENDENCIES))

all: $(KERNEL_DIR)/kernel.elf

$(KERNEL_DIR)/kernel.elf: $(OBJ)
	ld $(LDFLAGS) $^ -o $(KERNEL_DIR)/kernel.elf

os.iso: $(KERNEL_DIR)/kernel.elf
	genisoimage -R                              \
                -b boot/grub/stage2_eltorito    \
                -no-emul-boot                   \
                -boot-load-size 4               \
                -A os                           \
                -input-charset utf8             \
                -quiet                          \
                -boot-info-table                \
                -o os.iso                       \
                iso

run: os.iso
	bochs -f $(CONFIG_DIR)/bochs_config.txt -q

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(DEP)
	$(CC) $(CFLAGS) -I$(INC_DIR) $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	$(AS) $(ASFLAGS) $< -o $@

.PHONY: clean

clean:
	rm -f $(OBJ_DIR)/*.o $(KERNEL_DIR)/kernel.elf os.iso