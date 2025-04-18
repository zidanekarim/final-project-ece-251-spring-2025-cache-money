# File: Makefile
#
#  make compile   – compile design + testbench
#  make simulate  – run the simulation
#  make display   – launch GTKWave on mux2.vcd
#  make clean     – remove generated files

COMPONENT   = mux2
SRC         = mux2.sv tb_mux2.sv ../clock/clock.sv

COMPILER    = iverilog
SIMULATOR   = vvp
VIEWER      = gtkwave

COFLAGS     = -g2012
SFLAGS      = -M .
TBOUTPUT    = $(COMPONENT).vcd

.PHONY: compile simulate display clean

compile: $(SRC)
	$(COMPILER) $(COFLAGS) -o $(COMPONENT).vvp $(SRC)

simulate: compile
	$(SIMULATOR) $(SFLAGS) $(COMPONENT).vvp

display: simulate
	$(VIEWER) $(TBOUTPUT) &

clean:
	rm -f $(COMPONENT).vvp $(TBOUTPUT)
