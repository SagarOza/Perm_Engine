`timescale 1ns/1ps

`include "theta.v"
`include "pi.v"
`include "chi.v"
`include "rho.v"
`include "lane.v"

/*`include "rho_cmb.v"
`include "pi_cmb.v"
`include "chi_cmb.v"
`include "lane_cmb.v"*/
`include "functions.v"

module perm(input clk, input reset, input [2:0] dix, input [199:0] din, input pushin, output [2:0] doutix, output [199:0] dout, output reg pushout);

	integer cnt, i, i_b, dox_up, dox_down;

	reg [2:0] doutix_b;
	reg [1599:0] dout_1600_b;
	
	reg [1599:0] din_1600, din_buf;
	reg [1599:0] dout_1600; 
	reg [63:0] sha3_matrix [4:0] [4:0];

	reg [63:0] sha3_matrix_d [4:0] [4:0];
	reg [63:0] sha3_matrix_b [4:0] [4:0];
	reg [63:0] sha3_theta_m [4:0] [4:0];

	reg [63:0] sha3_rho_m [4:0] [4:0];
	reg [63:0] sha3_pi_m [4:0] [4:0];
	reg [63:0] sha3_chi_m [4:0] [4:0];
	reg [63:0] sha3_matrix_op [4:0] [4:0];

	integer x, y, z, s_index;
	reg [2:0]cnt_b;

	// Theta comb variables
	integer ittr, x_theta, x_theta_minus, x_theta_plus, y_theta, z_theta, z_theta_minus;	// Theta Variables
	reg [63:0] C [4:0];						//	Theta Variable.
	reg [63:0] D [4:0];						//	Theta Variable.
	reg [63:0] sha3_matrix_cmb [4:0] [4:0];		// Theta Variable.
	reg [63:0] sha3_theta_op [4:0] [4:0];	//	Theta variable.

	// Rho comb variables
	integer t_rho, x_rho, y_rho, y_rho_buf, z_rho, z_rho_new;
	reg [63:0] sha3_rho_op [4:0] [4:0];

	// Pi comb Variables
	integer x_pi, x_pi_new, y_pi;
	reg [63:0] sha3_pi_op [4:0] [4:0];

	// chi comb Variables
	integer x_chi, x_chi_1, x_chi_2, y_chi, z_chi;
	reg [63:0] sha3_chi_op [4:0] [4:0];

	// lane comb Variables
	integer j_lane, ir;
	reg [63:0] RC;
	reg [63:0] sha3_lane_op [4:0] [4:0];
	reg [63:0] sha3_lane_opb [4:0] [4:0];
	reg pushout_cmb;

	// O/p Block
	reg [319:0] plane[4:0];
	reg [1599:0] S_out;

	initial begin
		cnt<=0;	z<=0;	x<=0;	y<=0;	s_index<=0; i<=0; ir<=0; pushout_cmb=0;
	end
	
	assign din_1600=({1400'b0,din}<<(dix*200));
	assign din_buf=(din_1600||din_buf);	
	always@(posedge clk or negedge reset)
	begin
		if(!reset) begin
			while(y<5) begin 
				
				sha3_matrix[x][y][z]<= 0;
				sha3_theta_op[x][y][z]=0;
				sha3_rho_op[x][y][z]=0;
				sha3_pi_op[x][y][z]=0;
				sha3_chi_op[x][y][z]=0;
				sha3_lane_op[x][y][z]=0;
				C[x][z]=0;
				D[x][z]=0;	
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
				sha3_matrix[x][y][z]<= #1 din_1600[s_index];

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
/*
	sha3_theta 	theta3(clk, reset, pushin, sha3_matrix, sha3_theta_m);
	sha3_rho 	rho3(clk, reset, pushin, sha3_theta_m, sha3_rho_m);
	sha3_pi		pi3(clk, reset, pushin, sha3_rho_m, sha3_pi_m);
	sha3_chi	chi3(clk, reset, pushin, sha3_pi_m, sha3_chi_m);
	sha3_lane	lane3(clk, reset, pushin, sha3_chi_m, sha3_matrix_op, i, pushout, dout_1600);	

	assign dout=dout_1600_b[199:0];
	assign doutix=doutix_b-1;
	*/
	always@(posedge clk) begin
		if(!pushin) begin

			for(ittr=0; ittr<3; ittr=ittr+1) begin
				if(ir==1)begin
					sha3_matrix_cmb=sha3_matrix;
				end else begin
					sha3_matrix_cmb=sha3_lane_opb;
				end


			$display("# %h %h %h %h %h",sha3_matrix_cmb[0][0], sha3_matrix_cmb[1][0], sha3_matrix_cmb[2][0], sha3_matrix_cmb[3][0], sha3_matrix_cmb[4][0]); 
			$display("# %h %h %h %h %h",sha3_matrix_cmb[0][1], sha3_matrix_cmb[1][1], sha3_matrix_cmb[2][1], sha3_matrix_cmb[3][1], sha3_matrix_cmb[4][1]); 
			$display("# %h %h %h %h %h",sha3_matrix_cmb[0][2], sha3_matrix_cmb[1][2], sha3_matrix_cmb[2][2], sha3_matrix_cmb[3][2], sha3_matrix_cmb[4][2]); 
			$display("# %h %h %h %h %h",sha3_matrix_cmb[0][3], sha3_matrix_cmb[1][3], sha3_matrix_cmb[2][3], sha3_matrix_cmb[3][3], sha3_matrix_cmb[4][3]); 
			$display("# %h %h %h %h %h",sha3_matrix_cmb[0][4], sha3_matrix_cmb[1][4], sha3_matrix_cmb[2][4], sha3_matrix_cmb[3][4], sha3_matrix_cmb[4][4]); 

				//	Theta Algo
				C[0]=sha3_matrix_cmb[0][0] ^ sha3_matrix_cmb[0][1] ^ sha3_matrix_cmb[0][2] ^ sha3_matrix_cmb[0][3] ^ sha3_matrix_cmb[0][4];	
				C[1]=sha3_matrix_cmb[1][0] ^ sha3_matrix_cmb[1][1] ^ sha3_matrix_cmb[1][2] ^ sha3_matrix_cmb[1][3] ^ sha3_matrix_cmb[1][4];
				C[2]=sha3_matrix_cmb[2][0] ^ sha3_matrix_cmb[2][1] ^ sha3_matrix_cmb[2][2] ^ sha3_matrix_cmb[2][3] ^ sha3_matrix_cmb[2][4];
				C[3]=sha3_matrix_cmb[3][0] ^ sha3_matrix_cmb[3][1] ^ sha3_matrix_cmb[3][2] ^ sha3_matrix_cmb[3][3] ^ sha3_matrix_cmb[3][4];
				C[4]=sha3_matrix_cmb[4][0] ^ sha3_matrix_cmb[4][1] ^ sha3_matrix_cmb[4][2] ^ sha3_matrix_cmb[4][3] ^ sha3_matrix_cmb[4][4];

				for(x_theta=0; x_theta<5; x_theta=x_theta+1) begin
					for(z_theta=0; z_theta<64; z_theta=z_theta+1) begin
						x_theta_minus=mod((x_theta-1), 5);
						x_theta_plus=mod((x_theta+1),5);
						z_theta_minus=mod((z_theta-1),64);
						D[x_theta][z_theta]=C[x_theta_minus][z_theta] ^ C[x_theta_plus][z_theta_minus];
					end
				end
				
				for(x_theta=0; x_theta<5; x_theta=x_theta+1) begin
					for(y_theta=0; y_theta<5; y_theta=y_theta+1) begin
						for(z_theta=0; z_theta<64; z_theta=z_theta+1) begin
							sha3_theta_op[x_theta][y_theta][z_theta] = sha3_matrix_cmb[x_theta][y_theta][z_theta] ^ D[x_theta][z_theta];
						end
					end
				end

				$display("# after theta ", ir, $time);
				$display("# %h %h %h %h %h",sha3_theta_op[0][0], sha3_theta_op[1][0], sha3_theta_op[2][0], sha3_theta_op[3][0], sha3_theta_op[4][0]);
				$display("# %h %h %h %h %h",sha3_theta_op[0][1], sha3_theta_op[1][1], sha3_theta_op[2][1], sha3_theta_op[3][1], sha3_theta_op[4][1]);
				$display("# %h %h %h %h %h",sha3_theta_op[0][2], sha3_theta_op[1][2], sha3_theta_op[2][2], sha3_theta_op[3][2], sha3_theta_op[4][2]);
				$display("# %h %h %h %h %h",sha3_theta_op[0][3], sha3_theta_op[1][3], sha3_theta_op[2][3], sha3_theta_op[3][3], sha3_theta_op[4][3]);
				$display("# %h %h %h %h %h",sha3_theta_op[0][4], sha3_theta_op[1][4], sha3_theta_op[2][4], sha3_theta_op[3][4], sha3_theta_op[4][4]);

				//	Rho algo
				sha3_rho_op[0][0]=sha3_theta_op[0][0];
				x_rho=1; y_rho=0; t_rho=0;

				while(t_rho<24) begin
					for(z_rho=0; z_rho<64; z_rho=z_rho+1) begin
						z_rho_new=mod((z_rho-(((t_rho+1)*(t_rho+2))/2)),64);
						sha3_rho_op[x_rho][y_rho][z_rho] = sha3_theta_op[x_rho][y_rho][z_rho_new];
					end

					y_rho_buf=y_rho;
					y_rho=((2*x_rho)+(3*y_rho));
					y_rho=mod(y_rho,5);
					x_rho=y_rho_buf;

					t_rho=t_rho+1;
				end

				// Pi algo
				for(x_pi=0; x_pi<5; x_pi=x_pi+1) begin
					for(y_pi=0; y_pi<5; y_pi=y_pi+1) begin
						x_pi_new=mod((x_pi + (3 * y_pi)), 5);
						sha3_pi_op[x_pi][y_pi]=sha3_rho_op[x_pi_new][x_pi];
					end
				end

				// Chi algo
				for(x_chi=0; x_chi<5; x_chi=x_chi+1) begin
					for(y_chi=0; y_chi<5; y_chi=y_chi+1) begin
						for(z_chi=0; z_chi<64; z_chi=z_chi+1) begin
							x_chi_1=mod((x_chi+1),5);
							x_chi_2=mod((x_chi+2),5);
							sha3_chi_op[x_chi][y_chi][z_chi] = sha3_pi_op [x_chi][y_chi][z_chi] ^ ( ( sha3_pi_op[x_chi_1][y_chi][z_chi] ^ 1 ) & sha3_pi_op[x_chi_2][y_chi][z_chi] );
						end
					end
				end

				// lane algo
				sha3_lane_op=sha3_chi_op;
				RC=64'b0;
				for(j_lane=0; j_lane<7; j_lane=j_lane+1) begin
					RC[(1<<j_lane)-1]=rc(j_lane+(7*(ir-1)));
				end

				sha3_lane_op[0][0]=sha3_lane_op[0][0] ^ RC;
				sha3_lane_opb=sha3_lane_op;
				ir=ir+1;
				$display("# Round end ", ir);
				$display("# %h %h %h %h %h",sha3_lane_op[0][0], sha3_lane_op[1][0], sha3_lane_op[2][0], sha3_lane_op[3][0], sha3_lane_op[4][0]);
				$display("# %h %h %h %h %h",sha3_lane_op[0][1], sha3_lane_op[1][1], sha3_lane_op[2][1], sha3_lane_op[3][1], sha3_lane_op[4][1]);
				$display("# %h %h %h %h %h",sha3_lane_op[0][2], sha3_lane_op[1][2], sha3_lane_op[2][2], sha3_lane_op[3][2], sha3_lane_op[4][2]);
				$display("# %h %h %h %h %h",sha3_lane_op[0][3], sha3_lane_op[1][3], sha3_lane_op[2][3], sha3_lane_op[3][3], sha3_lane_op[4][3]);
				$display("# %h %h %h %h %h",sha3_lane_op[0][4], sha3_lane_op[1][4], sha3_lane_op[2][4], sha3_lane_op[3][4], sha3_lane_op[4][4]);

				$display(ir, ittr, $time);
				if(ir>24) begin
					$display(ir, $time);
					pushout_cmb=1;
					ir=0;
					break;
				end
			end

			if(pushout_cmb) begin

				plane[0] = {sha3_lane_op[4][0], sha3_lane_op[3][0], sha3_lane_op[2][0], sha3_lane_op[1][0], sha3_lane_op[0][0]};
				plane[1] = {sha3_lane_op[4][1], sha3_lane_op[3][1], sha3_lane_op[2][1], sha3_lane_op[1][1], sha3_lane_op[0][1]};
				plane[2] = {sha3_lane_op[4][2], sha3_lane_op[3][2], sha3_lane_op[2][2], sha3_lane_op[1][2], sha3_lane_op[0][2]};
				plane[3] = {sha3_lane_op[4][3], sha3_lane_op[3][3], sha3_lane_op[2][3], sha3_lane_op[1][3], sha3_lane_op[0][3]};
				plane[4] = {sha3_lane_op[4][4], sha3_lane_op[3][4], sha3_lane_op[2][4], sha3_lane_op[1][4], sha3_lane_op[0][4]};

				S_out={plane[4], plane[3], plane[2], plane[1], plane[0]};				

			end
		end
	end



	always@(posedge clk or negedge reset) begin
		if(!reset) begin
			dout_1600_b=0;
			doutix_b=0;
		end else begin
			if(!pushout) begin
		 		doutix_b =0;
			end else begin
				if(doutix_b==0) begin
						dout_1600_b=dout_1600;	
				end else begin
						dout_1600_b=(dout_1600_b>>200);
				end
				doutix_b=doutix_b +1;
			end		
		end
	end

	// Debug always block
	always@(posedge clk)
	begin
		bit view_flag;

/*		if( ir <25 ) begin
			$display("# ", ir);
			$display("# %h %h %h %h %h",sha3_matrix[0][0], sha3_matrix[1][0], sha3_matrix[2][0], sha3_matrix[3][0], sha3_matrix[4][0]); 
			$display("# %h %h %h %h %h",sha3_matrix[0][1], sha3_matrix[1][1], sha3_matrix[2][1], sha3_matrix[3][1], sha3_matrix[4][1]); 
			$display("# %h %h %h %h %h",sha3_matrix[0][2], sha3_matrix[1][2], sha3_matrix[2][2], sha3_matrix[3][2], sha3_matrix[4][2]); 
			$display("# %h %h %h %h %h",sha3_matrix[0][3], sha3_matrix[1][3], sha3_matrix[2][3], sha3_matrix[3][3], sha3_matrix[4][3]); 
			$display("# %h %h %h %h %h",sha3_matrix[0][4], sha3_matrix[1][4], sha3_matrix[2][4], sha3_matrix[3][4], sha3_matrix[4][4]); 

			$display("# after theta ", ir);
			$display("# %h %h %h %h %h",sha3_theta_op[0][0], sha3_theta_op[1][0], sha3_theta_op[2][0], sha3_theta_op[3][0], sha3_theta_op[4][0]);
			$display("# %h %h %h %h %h",sha3_theta_op[0][1], sha3_theta_op[1][1], sha3_theta_op[2][1], sha3_theta_op[3][1], sha3_theta_op[4][1]);
			$display("# %h %h %h %h %h",sha3_theta_op[0][2], sha3_theta_op[1][2], sha3_theta_op[2][2], sha3_theta_op[3][2], sha3_theta_op[4][2]);
			$display("# %h %h %h %h %h",sha3_theta_op[0][3], sha3_theta_op[1][3], sha3_theta_op[2][3], sha3_theta_op[3][3], sha3_theta_op[4][3]);
			$display("# %h %h %h %h %h",sha3_theta_op[0][4], sha3_theta_op[1][4], sha3_theta_op[2][4], sha3_theta_op[3][4], sha3_theta_op[4][4]);

			$display("# after rho ", ir);
			$display("# %h %h %h %h %h",sha3_rho_op[0][0], sha3_rho_op[1][0], sha3_rho_op[2][0], sha3_rho_op[3][0], sha3_rho_op[4][0]);
			$display("# %h %h %h %h %h",sha3_rho_op[0][1], sha3_rho_op[1][1], sha3_rho_op[2][1], sha3_rho_op[3][1], sha3_rho_op[4][1]);
			$display("# %h %h %h %h %h",sha3_rho_op[0][2], sha3_rho_op[1][2], sha3_rho_op[2][2], sha3_rho_op[3][2], sha3_rho_op[4][2]);
			$display("# %h %h %h %h %h",sha3_rho_op[0][3], sha3_rho_op[1][3], sha3_rho_op[2][3], sha3_rho_op[3][3], sha3_rho_op[4][3]);
			$display("# %h %h %h %h %h",sha3_rho_op[0][4], sha3_rho_op[1][4], sha3_rho_op[2][4], sha3_rho_op[3][4], sha3_rho_op[4][4]); 

			$display("# After rho-pi ", ir);
			$display("# %h %h %h %h %h",sha3_pi_op[0][0], sha3_pi_op[1][0], sha3_pi_op[2][0], sha3_pi_op[3][0], sha3_pi_op[4][0]);	
			$display("# %h %h %h %h %h",sha3_pi_op[0][1], sha3_pi_op[1][1], sha3_pi_op[2][1], sha3_pi_op[3][1], sha3_pi_op[4][1]);
			$display("# %h %h %h %h %h",sha3_pi_op[0][2], sha3_pi_op[1][2], sha3_pi_op[2][2], sha3_pi_op[3][2], sha3_pi_op[4][2]);
			$display("# %h %h %h %h %h",sha3_pi_op[0][3], sha3_pi_op[1][3], sha3_pi_op[2][3], sha3_pi_op[3][3], sha3_pi_op[4][3]);
			$display("# %h %h %h %h %h",sha3_pi_op[0][4], sha3_pi_op[1][4], sha3_pi_op[2][4], sha3_pi_op[3][4], sha3_pi_op[4][4]); 

			$display("# After chi ", ir);
			$display("# %h %h %h %h %h",sha3_chi_op[0][0], sha3_chi_op[1][0], sha3_chi_op[2][0], sha3_chi_op[3][0], sha3_chi_op[4][0]);
			$display("# %h %h %h %h %h",sha3_chi_op[0][1], sha3_chi_op[1][1], sha3_chi_op[2][1], sha3_chi_op[3][1], sha3_chi_op[4][1]);
			$display("# %h %h %h %h %h",sha3_chi_op[0][2], sha3_chi_op[1][2], sha3_chi_op[2][2], sha3_chi_op[3][2], sha3_chi_op[4][2]);
			$display("# %h %h %h %h %h",sha3_chi_op[0][3], sha3_chi_op[1][3], sha3_chi_op[2][3], sha3_chi_op[3][3], sha3_chi_op[4][3]);
			$display("# %h %h %h %h %h",sha3_chi_op[0][4], sha3_chi_op[1][4], sha3_chi_op[2][4], sha3_chi_op[3][4], sha3_chi_op[4][4]); 

			$display("# Round end ", ir);
			$display("# %h %h %h %h %h",sha3_lane_op[0][0], sha3_lane_op[1][0], sha3_lane_op[2][0], sha3_lane_op[3][0], sha3_lane_op[4][0]);
			$display("# %h %h %h %h %h",sha3_lane_op[0][1], sha3_lane_op[1][1], sha3_lane_op[2][1], sha3_lane_op[3][1], sha3_lane_op[4][1]);
			$display("# %h %h %h %h %h",sha3_lane_op[0][2], sha3_lane_op[1][2], sha3_lane_op[2][2], sha3_lane_op[3][2], sha3_lane_op[4][2]);
			$display("# %h %h %h %h %h",sha3_lane_op[0][3], sha3_lane_op[1][3], sha3_lane_op[2][3], sha3_lane_op[3][3], sha3_lane_op[4][3]);
			$display("# %h %h %h %h %h",sha3_lane_op[0][4], sha3_lane_op[1][4], sha3_lane_op[2][4], sha3_lane_op[3][4], sha3_lane_op[4][4]);
			$display(" ");
		end
*/		//if(pushout) begin
//			$display(S_out, " ", reset, " %h ", dout, $time);
		//end
		cnt=cnt+1;
	end
endmodule
