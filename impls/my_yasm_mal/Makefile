
step0_repl: $@.o
	ld -g -o $@ $@.o

step0_repl.o:
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst
