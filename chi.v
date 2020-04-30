module sha3_chi(input clk, input reset, input pushin, input  reg [63:0] matrix [4:0][4:0], output reg [63:0] matrix_op[4:0] [4:0]);
	integer x, x_1, x_2, y, z;
	
	always@(posedge clk, negedge reset) begin
		if(!reset) begin
	
			for(x=0; x<5; x=x+1) begin
				for(y=0; y<5; y=y+1) begin
					matrix_op[x][y]=0;
				end
			end
			x=0; y=0;
	
		end else if(!pushin) begin
			for(x=0; x<5; x=x+1) begin
				for(y=0; y<5; y=y+1) begin
					for(z=0; z<64; z=z+1) begin
						x_1=mod((x+1),5);
						x_2=mod((x+2),5);
						matrix_op[x][y][z] = matrix[x][y][z] ^ ( ( matrix[x_1][y][z] ^ 1 ) & matrix[x_2][y][z] );
					end
				end
			end
		end
	end

        function integer mod(input integer data, input integer modulo);
                if((data%modulo)<0) begin
                        mod = (data%modulo)+modulo;
                end else begin
                        mod = data%modulo;
                end
        endfunction

endmodule
