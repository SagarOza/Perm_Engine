`timescale 1ns/1ps
module perm_tb;

reg clk, reset, pushin;
reg pushout;
reg [2:0] doutix;
reg [199:0] dout;
reg [2:0] dix;
reg [199:0] din;


perm p0(.clk(clk), .reset(reset), .dix(dix), .din(din), .pushin(pushin), .doutix(doutix), .dout(dout), .pushout(pushout));

initial begin
	clk=0;
	reset=1;
//	dix=0;
	forever #4 clk=~clk;
end

initial begin

	#1 reset=0;
	#1 reset=1;
/*	#1 pushin=1; dix=0; din=200'h60a636261;
	#8 dix=1; din=200'h0;
	#8 dix=2; din=200'h0;
	#8 dix=3; din=200'h0;
	#8 dix=4; din=200'h0;
	#8 dix=5; din=200'h8000000000000000000000;
	#8 dix=6; din=200'h0;
	#8 dix=7; din=200'h0;  
	#16 pushin=0;
*/
 
//	#1 reset=0;
//	#1 reset=1;
	#1 pushin=1;
	   dix=0; din=200'h5ffc9799a707e36d6008f0ebd4950cddd9c735df5ef7697fb9;
	#8 dix=1; din=200'h95921de9ea6670d3da1f3ff4bb8cf703c9ff175e99412607ad;
	#8 dix=2; din=200'h872756b6a20bb02edf0743040e1e30c9ed0248b16e2d5cabeb;
	#8 dix=3; din=200'h5899495319322fed157cf9c617346b4501eaf614aad1426810;
	#8 dix=4; din=200'h42e935b870e98d7c358a84c15cd868c2cf1d4a2b12a5f80a0a;
	#8 dix=5; din=200'h17b703be0e667bf78a4d9f8f5ffb5ac96628c4381836f149f5;
	#8 dix=6; din=200'h762a223c9f90c9ce97b5bdf073eed1118dc10e774520d780ca;
	#8 dix=7; din=200'hacd51e6699f9823ce16682717c9bbfae76ab14759da618fd04;
	#16 pushin=0;
	
/*	#1 pushin=1;
	#8 dix=0; din=200'h7caa58695187b8a518d9a54a0d7b25331f83d9fca716c40a33;
	#8 dix=1; din=200'hf3e00bc4621b9439852037106d208ead31c8a8486261790b2f;
	#8 dix=2; din=200'hed49b12ac7e1da6099d795f1048aa604f0d0f2443658625af0;
	#8 dix=3; din=200'h8212f7c6a7cda6c23fc86ee6d30aad4b45038e2206f1e77124;
	#8 dix=4; din=200'he58e725d5758a295d4eff35b61138411eb0dde6d08121213ca;
	#8 dix=5; din=200'hf9fe966844aa5560eaba017ad05133354fc7eefadf231025db;
	#8 dix=6; din=200'h65e3eb74113cb04d6bfd8fa506bfc51c63373ac55ef1867f1f;
	#8 dix=7; din=200'h879951fff4f991a81348486129fc1d9db5c36ec124ce01e1e0;
	#8 pushin=0;
*/	#200 $finish;
end

initial begin
	$dumpvars(0);
	$dumpfile("wave.vcd");
end

endmodule
