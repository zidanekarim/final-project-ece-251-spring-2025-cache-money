# Makefile for adder
COMPONENT = adder
SRC       = adder.sv tb_adder.sv

IVERILOG  = iverilog
VVP       = vvp
GTK       = gtkwave
COFLAGS   = -g2012
VCDFILE   = adder.vcd

.PHONY: compile simulate view clean

compile:
	$(IVERILOG) $(COFLAGS) -o $(COMPONENT).vvp $(SRC)

simulate: compile
	$(VVP) $(COMPONENT).vvp

view: simulate
	$(GTK) $(VCDFILE) &

clean:
	rm -f $(COMPONENT).vvp $(VCDFILE)
