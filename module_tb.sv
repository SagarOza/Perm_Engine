// DUT: sha3_chi

module theta_tb;

reg clk, reset, pushin;
reg [63:0] sha3_m [4:0] [4:0];
reg [63:0] sha3_m_op [4:0] [4:0];

//	DUT
sha3_chi chi0(clk, reset, pushin, sha3_m, sha3_m_op);

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
//	sha3_m[0][0]= 64'h83d9fca716c40a33; sha3_m[1][0]= 64'hd9a54a0d7b25331f; sha3_m[2][0]= 64'haa58695187b8a518; sha3_m[3][0]= 64'ha8486261790b2f7c; sha3_m[4][0]= 64'h37106d208ead31c8;
//	sha3_m[0][1]= 64'h0bc4621b94398520; sha3_m[1][1]= 64'h443658625af0f3e0; sha3_m[2][1]= 64'hf1048aa604f0d0f2; sha3_m[3][1]= 64'h2ac7e1da6099d795; sha3_m[4][1]= 64'h06f1e77124ed49b1;
//	sha3_m[0][2]= 64'hd30aad4b45038e22; sha3_m[1][2]= 64'ha7cda6c23fc86ee6; sha3_m[2][2]= 64'h121213ca8212f7c6; sha3_m[3][2]= 64'h138411eb0dde6d08; sha3_m[4][2]= 64'h58a295d4eff35b61;
//	sha3_m[0][3]= 64'h1025dbe58e725d57; sha3_m[1][3]= 64'h33354fc7eefadf23; sha3_m[2][3]= 64'h5560eaba017ad051; sha3_m[3][3]= 64'h7f1ff9fe966844aa; sha3_m[4][3]= 64'h1c63373ac55ef186;
//	sha3_m[0][4]= 64'h4d6bfd8fa506bfc5; sha3_m[1][4]= 64'he065e3eb74113cb0; sha3_m[2][4]= 64'hb5c36ec124ce01e1; sha3_m[3][4]= 64'h1348486129fc1d9d; sha3_m[4][4]= 64'h879951fff4f991a8;

//	Test case for chi
	sha3_m[0][0]= 64'hfae2cf38d2ad8042; sha3_m[1][0]= 64'h1527be32214951d8; sha3_m[2][0]= 64'h588d6b5cd124aaf6; sha3_m[3][0]= 64'h2c320f2ea4ca62f6; sha3_m[4][0]= 64'h79a6f358ae375420;
	sha3_m[0][1]= 64'h7b5c0d61fc4833f9; sha3_m[1][1]= 64'ha95441c1db75685b; sha3_m[2][1]= 64'h571bd91921704f79; sha3_m[3][1]= 64'h5bfbe110abfc2e4a; sha3_m[4][1]= 64'h7719275d537e8800;
	sha3_m[0][2]= 64'hb579a43a46cc3460; sha3_m[1][2]= 64'h9b0c2bf3efd6adb2; sha3_m[2][2]= 64'h331d1aa0a4176ac8; sha3_m[3][2]= 64'hd939f323de1a36ed; sha3_m[4][2]= 64'h976f56dc44abcd02;
	sha3_m[0][3]= 64'h8d1cc798f61d021b; sha3_m[1][3]= 64'h51725e4203efa005; sha3_m[2][3]= 64'hf858928c58f8bd2d; sha3_m[3][3]= 64'hd2694cee8382daca; sha3_m[4][3]= 64'hee32bb24a7ef5cc4;
	sha3_m[0][4]= 64'h8cbd6dce006c4d67; sha3_m[1][4]= 64'h01b2bfd6b35e8c3e; sha3_m[2][4]= 64'h0ffdde8aecc2646f; sha3_m[3][4]= 64'he28f17993dca4999; sha3_m[4][4]= 64'h58e84fae2bd55c81;

	#200 $finish;
//	$finish;
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
