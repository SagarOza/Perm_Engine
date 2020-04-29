`timescale 1ns/1ps

`include "theta.v"

module perm(input clk, input reset, input [2:0] dix, input [199:0] din, input pushin, output [2:0] doutix, output [199:0] dout, output pushout);

	integer cnt;
	
	reg [1599:0] din_1600,din_buf;
	reg [63:0] sha3_matrix [4:0] [4:0];

	reg [63:0] sha3_theta_m [4:0] [4:0];
	integer x, y, z, s_index;
	reg [2:0]cnt_b;
	
	initial begin
		cnt<=0;	z<=0;	x<=0;	y<=0;	s_index<=0;
	end
	
	assign din_1600=({1400'b0,din}<<(dix*200));
	assign din_buf=(din_1600||din_buf);	
	always@(posedge clk or negedge reset)
	begin
		if(!reset) begin
			while(y<5) begin 
				
				sha3_matrix[x][y][z]=0;

				if(z>63) begin
					z=0;
					if(x>4) begin
						x=0;	y=y+1;
					end else x=x+1;
				end else z=z+1;
			end

			x=0;y=0;z=0;
			s_index=0;

		end else if(pushin) begin
			while( s_index<(((dix+1)*200)-1) ) begin
			
				s_index=((64*((5*y)+x))+z);
				sha3_matrix[x][y][z]=din_1600[s_index];

				if(z>63) begin
					z=0;
					if(x>3)begin
						x=0;	y=y+1;
						if(y>4) begin y=0; end
					end else x=x+1;
				end else z=z+1;
			end
		end
	end

	sha3_theta 	theta3(clk, reset, pushin, sha3_matrix, sha3_theta_m);
	
	always@(posedge clk)
	begin
		bit view_flag;
		cnt=cnt+1;
/*
		$display("Clock cnt:%d\t\t\t ",cnt);
		$monitor("dix:%d\t|",dix," x:%d\t| y:%d\t| z:%d\t",x,y,z);
		$display("%h",din_buf); 
*/
	//	if(cnt==20 || cnt==3 ) begin
		$display("#  0");
		$display("# %h %h %h %h %h",sha3_matrix[0][0], sha3_matrix[1][0], sha3_matrix[2][0], sha3_matrix[3][0], sha3_matrix[4][0]); 
		$display("# %h %h %h %h %h",sha3_matrix[0][1], sha3_matrix[1][1], sha3_matrix[2][1], sha3_matrix[3][1], sha3_matrix[4][1]); 
		$display("# %h %h %h %h %h",sha3_matrix[0][2], sha3_matrix[1][2], sha3_matrix[2][2], sha3_matrix[3][2], sha3_matrix[4][2]); 
		$display("# %h %h %h %h %h",sha3_matrix[0][3], sha3_matrix[1][3], sha3_matrix[2][3], sha3_matrix[3][3], sha3_matrix[4][3]); 
		$display("# %h %h %h %h %h",sha3_matrix[0][4], sha3_matrix[1][4], sha3_matrix[2][4], sha3_matrix[3][4], sha3_matrix[4][4]); 

		$display("# after theta 0");
		$display("# %h, %h, %h, %h, %h",sha3_theta_m[0][0], sha3_theta_m[1][0], sha3_theta_m[2][0], sha3_theta_m[3][0], sha3_theta_m[4][0]);
		$display("# %h, %h, %h, %h, %h",sha3_theta_m[0][1], sha3_theta_m[1][1], sha3_theta_m[2][1], sha3_theta_m[3][1], sha3_theta_m[4][1]);
		$display("# %h, %h, %h, %h, %h",sha3_theta_m[0][2], sha3_theta_m[1][2], sha3_theta_m[2][2], sha3_theta_m[3][2], sha3_theta_m[4][2]);
		$display("# %h, %h, %h, %h, %h",sha3_theta_m[0][3], sha3_theta_m[1][3], sha3_theta_m[2][3], sha3_theta_m[3][3], sha3_theta_m[4][3]);
		$display("# %h, %h, %h, %h, %h",sha3_theta_m[0][4], sha3_theta_m[1][4], sha3_theta_m[2][4], sha3_theta_m[3][4], sha3_theta_m[4][4]);
	//	end	
	end
endmodule
