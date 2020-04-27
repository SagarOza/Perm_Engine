rm -r csrc ucli.key test_perm.out*
vcs +v2k perm.v tb_perm.sv -sverilog -o test_perm.out; ./test_perm.out;
