# File: Makefile
#  Usage:
#    make compile   # build simulation
#    make simulate  # run it (prints monitor output)
#    make view      # pop up GTKWave on clock.vcd
#    make clean     # wipe generated files

COMPONENT = clock
SRC       = clock.sv tb_clock.sv

IVERILOG  = iverilog
VVP       = vvp
GTK       = gtkwave

COFLAGS   = -g2012
VCDFILE   = $(COMPONENT).vcd

.PHONY: compile simulate view clean

compile:
	$(IVERILOG) $(COFLAGS) -o $(COMPONENT).vvp $(SRC)

simulate: compile
	$(VVP) $(COMPONENT).vvp

view: simulate
	$(GTK) $(VCDFILE) &

clean:
	rm -f $(COMPONENT).vvp $(VCDFILE)
