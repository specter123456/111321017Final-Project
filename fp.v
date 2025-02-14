module fp(output reg [7:0] DATA_R, DATA_G, DATA_B, output reg [3:0] A_count, output reg a, b, c, d, e, f, g,
	  input [3:0] punch_1, punch_2, input CLK, Clear);
	divfreq F0(CLK, CLK_div);	//除頻器
	
	//玩家1出拳顯示在8*8全彩矩陣上
	always@(punch_1)
		case(punch_1)
			4'b0001: DATA_R = 8'b11011111;	//scissors
			4'b0010: DATA_B = 8'b10111111;	//stone
			4'b0100: DATA_G = 8'b01111111;	//paper
			//沒出拳不顯示
			default: 
				begin
					DATA_R = 8'b11111111;
					DATA_G = 8'b11111111;
					DATA_B = 8'b11111111;
				end
		endcase
	
	//玩家2出拳顯示在七段顯示器上
	always@(punch_2)
		case(punch_2)
			4'b0001: {a, b, c, d, e, f, g} = 7'b1001111;	//scissors
			4'b0010: {a, b, c, d, e, f, g} = 7'b0010010;	//stone
			4'b0100: {a, b, c, d, e, f, g} = 7'b0000110;	//paper
			default: {a, b, c, d, e, f, g} = 7'b1111111;	//沒出拳不顯示
		endcase
	
		
	//8*8 matrix enable
	always@(posedge CLK_div, posedge Clear)
		if(Clear) A_count <= 4'0000;
		else A_count <= A_count + 1'b1;
		
endmodule

//除頻器
module divfreq(input CLK, output reg CLK_div);
	reg [24:0] Count;
	always@(posedge CLK)
		begin
			if(Count > 25000)
				begin
					Count <= 25'b0;
					CLK_div <= ~CLK_div;
				end
			else
				Count <= Count + 1'b1;
			end
endmodule
