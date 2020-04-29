// DUT: sha3_rho

module theta_tb;

reg clk, reset, pushin;
reg [63:0] sha3_m [4:0] [4:0];
reg [63:0] sha3_m_op [4:0] [4:0];

//	DUT
sha3_rho rho3(clk, reset, pushin, sha3_m, sha3_m_op);

initial begin
	clk=0;
	reset=1;
	forever #1 clk=~clk;
end



initial begin
	#1 reset=0;
	#1 reset=1;	pushin=0;

	#8;
//	Test case for theta.
	sha3_m[0][0]= 64'h83d9fca716c40a33; sha3_m[1][0]= 64'hd9a54a0d7b25331f; sha3_m[2][0]= 64'haa58695187b8a518; sha3_m[3][0]= 64'ha8486261790b2f7c; sha3_m[4][0]= 64'h37106d208ead31c8;
	sha3_m[0][1]= 64'h0bc4621b94398520; sha3_m[1][1]= 64'h443658625af0f3e0; sha3_m[2][1]= 64'hf1048aa604f0d0f2; sha3_m[3][1]= 64'h2ac7e1da6099d795; sha3_m[4][1]= 64'h06f1e77124ed49b1;
	sha3_m[0][2]= 64'hd30aad4b45038e22; sha3_m[1][2]= 64'ha7cda6c23fc86ee6; sha3_m[2][2]= 64'h121213ca8212f7c6; sha3_m[3][2]= 64'h138411eb0dde6d08; sha3_m[4][2]= 64'h58a295d4eff35b61;
	sha3_m[0][3]= 64'h1025dbe58e725d57; sha3_m[1][3]= 64'h33354fc7eefadf23; sha3_m[2][3]= 64'h5560eaba017ad051; sha3_m[3][3]= 64'h7f1ff9fe966844aa; sha3_m[4][3]= 64'h1c63373ac55ef186;
	sha3_m[0][4]= 64'h4d6bfd8fa506bfc5; sha3_m[1][4]= 64'he065e3eb74113cb0; sha3_m[2][4]= 64'hb5c36ec124ce01e1; sha3_m[3][4]= 64'h1348486129fc1d9d; sha3_m[4][4]= 64'h879951fff4f991a8;

	#200 $finish;
end

initial begin

	#100

	$display("-----------------------------input--------------------------------------------------");
	$display("# %h %h %h %h %h", sha3_m[0][0], sha3_m[1][0], sha3_m[2][0], sha3_m[3][0], sha3_m[4][0]);
	$display("# %h %h %h %h %h", sha3_m[0][1], sha3_m[1][1], sha3_m[2][1], sha3_m[3][1], sha3_m[4][1]);
	$display("# %h %h %h %h %h", sha3_m[0][2], sha3_m[1][2], sha3_m[2][2], sha3_m[3][2], sha3_m[4][2]);
	$display("# %h %h %h %h %h", sha3_m[0][3], sha3_m[1][3], sha3_m[2][3], sha3_m[3][3], sha3_m[4][3]);
	$display("# %h %h %h %h %h", sha3_m[0][4], sha3_m[1][4], sha3_m[2][4], sha3_m[3][4], sha3_m[4][4]);

	$display("-----------------------------output-------------------------------------------------");

	#2
        $display("# %h %h %h %h %h", sha3_m_op[0][0], sha3_m_op[1][0], sha3_m_op[2][0], sha3_m_op[3][0], sha3_m_op[4][0]);
        $display("# %h %h %h %h %h", sha3_m_op[0][1], sha3_m_op[1][1], sha3_m_op[2][1], sha3_m_op[3][1], sha3_m_op[4][1]);
        $display("# %h %h %h %h %h", sha3_m_op[0][2], sha3_m_op[1][2], sha3_m_op[2][2], sha3_m_op[3][2], sha3_m_op[4][2]);
        $display("# %h %h %h %h %h", sha3_m_op[0][3], sha3_m_op[1][3], sha3_m_op[2][3], sha3_m_op[3][3], sha3_m_op[4][3]);
        $display("# %h %h %h %h %h", sha3_m_op[0][4], sha3_m_op[1][4], sha3_m_op[2][4], sha3_m_op[3][4], sha3_m_op[4][4]);

        $display("------------------------------------------------------------------------------------");	

end

endmodule
