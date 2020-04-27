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
	forever #1 clk=~clk;
end

initial begin
	reset=1;
	#1 reset=0;
	#2 dix=0; din=200'h60a636261;
	#2 dix=1; din=200'h0;
	#2 dix=2; din=200'h0;
	#2 dix=3; din=200'h0;
	#2 dix=4; din=200'h0;
	#2 dix=5; din=200'h8000000000000000000000;
	#2 dix=6; din=200'h0;
	#2 dix=7; din=200'h0;
	#3 $finish;
end
endmodule
