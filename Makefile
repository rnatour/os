SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin
KERNEL_DIR = iso/boot
LD_DIR = ld
CONFIG_DIR = config

CC = gcc
CFLAGS = -m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector \
             -nostartfiles -nodefaultlibs -Wall -Wextra -Werror -c
LDFLAGS = -T $(LD_DIR)/link.ld -melf_i386
AS = nasm
ASFLAGS = -f elf

OBJECTS = loader.o sum_of_three.o
OBJ = $(patsubst %,$(OBJ_DIR)/%,$(OBJECTS))

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

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS)  $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f $(OBJ_DIR)/*.o $(BIN_DIR)/* $(KERNEL_DIR)/kernel.elf os.iso