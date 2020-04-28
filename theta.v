module sha3_theta(input clk,
	input reset,
	input pushin,
	input  reg [63:0] matrix [4:0][4:0], 
	output reg [63:0] matrix_op[4:0] [4:0]);

	integer x, y, z;
	integer x_plus, x_minus, z_minus;

	reg [63:0] C [4:0];
	reg [63:0] D [4:0];

	always @(posedge clk or negedge reset) begin
		if(!reset)begin
			for(x=0; x<5; x=x+1) begin
				for(z=0; z<64;z=z+1) begin
					C[x][z]=0;
					D[x][z]=0;
				end
			end
			x=0; y=0; z=0;
		end else if(!pushin)  begin//check for the pushin
			for(x=0; x<5; x=x+1) begin
				for(z=0; z<64; z=z+1) begin
					C[x][z]=matrix[x][0][z] ^ matrix[x][1][z] ^ matrix[x][2][z] ^ matrix[x][3][z] ^ matrix[x][4][z];	
				end
			end
			for(x=0; x<5; x=x+1) begin
                                for(z=0; z<64; z=z+1) begin
					x_minus=mod((x-1),5);
					x_plus=mod((x+1), 5);
					z_minus=mod((z-1), 64);
					D[x][z]=C[x_minus][z] ^ C[x_plus][z_minus];

                                end
				
                        end
			for(x=0; x<5; x=x+1) begin
				for(y=0; y<5; y=y+1) begin
					for(z=0; z<64; z=z+1) begin
						matrix_op[x][y][z]=matrix[x][y][z] ^ D[x][z];
					end
				end
			end

		end
	end

/*	always @(posedge clk) begin
		$display("%h, %h, %h, %h, %h",matrix_op[0][0], matrix_op[1][0], matrix_op[2][0], matrix_op[3][0], matrix_op[4][0]);
		$display("%h, %h, %h, %h, %h",matrix_op[0][1], matrix_op[1][1], matrix_op[2][1], matrix_op[3][1], matrix_op[4][1]);
		$display("%h, %h, %h, %h, %h",matrix_op[0][2], matrix_op[1][2], matrix_op[2][2], matrix_op[3][2], matrix_op[4][2]);
		$display("%h, %h, %h, %h, %h",matrix_op[0][3], matrix_op[1][3], matrix_op[2][3], matrix_op[3][3], matrix_op[4][3]);
		$display("%h, %h, %h, %h, %h",matrix_op[0][4], matrix_op[1][4], matrix_op[2][4], matrix_op[3][4], matrix_op[4][4]); 
	end
*/
//	Moduleo function
	function integer mod(input integer data, input integer modulo);
		if(data<0) begin 
			mod = (data%modulo)+modulo;
		end else begin 
			mod = data%modulo; 
		end 
	endfunction 

endmodule

