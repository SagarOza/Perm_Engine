#	DUT file	::	lane.v
rm -r csrc ucli.key test_mod.out* ;
vcs +v2k lane.v module_tb.sv -sverilog -o test_mod.out; ./test_mod.out;
