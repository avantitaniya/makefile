SHELL	 	:= /bin/bash
SOURCE	 	:= ./src
OUTFILE	 	:= ./out
SRC_FILE	:= $(wildcard $(SOURCE)/*.c)
OUT_FILE	:= $(OUTFILE)/$(notdir $(SRC_FILE))
OUT_FILE	:= $(OUT_FILE:.c=.elf)
VERBOSE		?=0

P_FILE		:= $(addprefix $(OUTFILE)/,$(SRC_FILE:.c=.pre.c))
OBJ_FILE	:= $(addprefix $(OUTFILE)/,$(SRC_FILE:.c=.o))

default: $(OUT_FILE)
	@echo "Fin"
clean:
	rm -rf $(dir $(OUT_FILE))
%/:
	mkdir -p $@

.SECONDEXPANSION:
$(OUT_FILE): $(OBJ_FILE) | $$(@D)/
	@echo " Linking $@"
	gcc $^ -o $@

$(OBJ_FILE): $(OUTFILE)/%.o: $(OUTFILE)/%.pre.c | $$(@D)/
	@echo " Compliling $^ "
	gcc -c $^ -o $@

$(P_FILE): $(OUTFILE)/%.pre.c: %.c | $$(@D)/
	@echo " Processing $^"
	gcc -E -p $^ -o $@

ifeq ($(VERBOSE),0)
.SILENT:
endif


