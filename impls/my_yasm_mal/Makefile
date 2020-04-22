
step0_repl: step0_repl.o
	ld -g -o $@ $@.o

step0_repl.o: step0_repl.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst

step1_read_print.o:
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst

string_test: string.o print.o string_test.o
	ld -g -o $@ $^

string.o: string.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst

print.o: print.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst

string_test.o: string_test.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst

memory_management.o: memory_management.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst

memory_test.o: memory_test.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst

memory_test: memory_test.o print.o string.o memory_management.o
	ld -g -o $@ $^

linked_list.o: linked_list.asm
	yasm -Worphan-labels -g dwarf2 -f elf64 $(basename $@).asm -l $(basename $@).lst



clean:
	rm -f *.o *.lst
