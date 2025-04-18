# File: Makefile
# Targets:
#   make compile   – build sl2.vvp
#   make simulate  – run it (console monitor)
#   make view      – open GTKWave on sl2.vcd
#   make clean     – remove generated files

COMPONENT = sl2
SRC       = sl2.sv tb_sl2.sv

IVERILOG  = iverilog
VVP       = vvp
GTKWAVE   = gtkwave

COFLAGS   = -g2012
VCDFILE   = $(COMPONENT).vcd

.PHONY: compile simulate view clean

compile:
	$(IVERILOG) $(COFLAGS) -o $(COMPONENT).vvp $(SRC)

simulate: compile
	$(VVP) $(COMPONENT).vvp

view: simulate
	$(GTKWAVE) $(VCDFILE) &

clean:
	rm -f $(COMPONENT).vvp $(VCDFILE)
