module perm(input clk, input reset, input [2:0] dix, input [199:0] din, input pushin, output [2:0] doutix, output [199:0] dout, output pushout);

integer cnt;

reg [1599:0] din_1600;
reg [63:0] sha3_matrix [4:0] [4:0];
integer x, y, z, s_index;
reg [2:0]cnt_b;

initial begin
	cnt=0;
	z=0;
	x=0;
	y=0;
	s_index=0;
end

assign din_1600=({1400'b0,din}<<(dix*200));

always@(posedge clk or posedge reset)
begin
	if(reset==1) begin
		while(y<5) begin 
			
			sha3_matrix[x][y][z]<=0;
			if(z>64) begin
				z=0;
				x=x+1;
				if(x>5) begin
					x=0;
					y=y+1;
				end
			end
			else z=z+1;
		end
		x=0;y=0;z=0;
	end else begin
	
		while( s_index<(((dix+1)*200)-1) ) begin
		
			s_index=((64*((5*y)+x))+z);
			sha3_matrix[x][y][z]<=din_1600[s_index];

			if(z>63) begin
				z=0;
				if(x>4)begin
					x=0;
					y=y+1;
				end else x=x+1;
				end	
			else z=z+1;
		end
	end
end

always@(posedge clk or posedge reset)
begin

	$display("dix:%d",dix,"\tx:%d, y:%d, z:%d",x,y,z);
	$display("%h",din);
	$display("%h, %h, %h, %h, %h",sha3_matrix[0][0], sha3_matrix[1][0], sha3_matrix[2][0], sha3_matrix[3][0], sha3_matrix[4][0]);
	$display("%h, %h, %h, %h, %h",sha3_matrix[0][1], sha3_matrix[1][1], sha3_matrix[2][1], sha3_matrix[3][1], sha3_matrix[4][1]);
	$display("%h, %h, %h, %h, %h",sha3_matrix[0][2], sha3_matrix[1][2], sha3_matrix[2][2], sha3_matrix[3][2], sha3_matrix[4][2]);
	$display("%h, %h, %h, %h, %h",sha3_matrix[0][3], sha3_matrix[1][3], sha3_matrix[2][3], sha3_matrix[3][3], sha3_matrix[4][3]);
	$display("%h, %h, %h, %h, %h",sha3_matrix[0][4], sha3_matrix[1][4], sha3_matrix[2][4], sha3_matrix[3][4], sha3_matrix[4][4]);
	
end
endmodule
