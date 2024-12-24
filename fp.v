module fp(output reg [7:0] DATA_R, DATA_G, DATA_B, lfsr, output reg [3:0] A_count, output reg [1:0] cc,
output reg a, b, c, d, e, f, g,
input [3:0] punch, input CLK, Clear);
	divfreq F0(CLK, CLK_div);	//除頻器
	
	//玩家出拳
	always@(punch)
		case(punch)
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
	
	//電腦隨機取數
	always@(punch)
		begin
        if(punch != 4'b0001 || punch != 4'b0010 || punch != 4'b0100) 
			begin
				lfsr <= 8'b1; // LFSR 初始值，不能為 0
			end 
		  else
			begin
				lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3]};	//LFSR邏輯（x^8 + x^6 + x^5 + x^4 + 1）
			end
		end
	
	//將隨機取數轉換為三種拳種
	always@(punch)
		begin
        if(punch != 4'b0001 || punch != 4'b0010 || punch != 4'b0100) 
			begin
				cc <= 2'b00;	//initialized to scissors
			end 
		  else 
			begin
				cc <= lfsr[1:0] % 3;	//mod 3 to geneate 2'b00, 2'b01, 2'b10, correspond to scissors, stone, and paper
			end
    end
	
	//將電腦的拳種顯示於7段顯示器上
	always@(cc)
		case(cc)
			2'b00: {a, b, c, d, e, f, g} = 7'b1001111;	//scissors
			2'b01: {a, b, c, d, e, f, g} = 7'b1101101;	//stone
			2'b10: {a, b, c, d, e, f, g} = 7'b1111001;	//paper
			//沒出拳不顯示
			default: 
				begin
					{a, b, c, d, e, f, g} = 7'b1111111;
				end
		endcase
		
	//8*8 matrix enable
	always@(posedge CLK_div, posedge Clear)
		if(Clear) A_count <= 4'b0000;
		else A_count <= A_count + 1'b1;
		
endmodule

//除頻器
module divfreq(input CLK, output reg CLK_div);
	reg [24:0] Count;
	always@(posedge CLK)
		begin
			if(Count > 250000)
				begin
					Count <= 25'b0;
					CLK_div <= ~CLK_div;
				end
			else
				Count <= Count + 1'b1;
			end
endmodule
