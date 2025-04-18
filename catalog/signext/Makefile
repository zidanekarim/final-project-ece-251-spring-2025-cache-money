# File: Makefile
# Targets:
#   make compile   – build the simulation
#   make simulate  – run it (prints monitor output)
#   make view      – open GTKWave on signext.vcd
#   make clean     – erase generated files

COMPONENT  = signext
SRC        = signext.sv tb_signext.sv

IVERILOG   = iverilog
VVP        = vvp
GTKWAVE    = gtkwave
COFLAGS    = -g2012
VCDFILE    = $(COMPONENT).vcd

.PHONY: compile simulate view clean

compile:
	$(IVERILOG) $(COFLAGS) -o $(COMPONENT).vvp $(SRC)

simulate: compile
	$(VVP) $(COMPONENT).vvp

view: simulate
	$(GTKWAVE) $(VCDFILE) &

clean:
	rm -f $(COMPONENT).vvp $(VCDFILE)
