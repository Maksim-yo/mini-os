all: iso

BUILD = build
SRC = src
ISO = $(BUILD)/os.iso
source = $(wildcard $(SRC)/*.asm)
OBJS = $(patsubst $(SRC)/%.asm, $(BUILD)/%.bin, $(source))
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
cur_dir = $(dir $(mkfile_path))

iso: $(ISO)

run: $(ISO)
	qemu-system-i386 -drive file=$<,format=raw

$(BUILD)/%.bin: $(SRC)/%.asm
	echo $(OBJS)
	nasm $< -fbin -o $@

$(ISO): $(BUILD)/os.bin
	dd if=/dev/null of=$@ bs=512 count=100
	cat $^ | dd of=$@ conv=notrunc

clean:
	rm -f $(BUILD)/*
	