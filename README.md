# 111321017Final-Project
# Final-Project
### Authors: 111321017

### 功能說明：
* 兩個玩家使用指撥開關輸入猜拳對戰，玩家1輸入為0001為剪刀、0010為石頭、0100為布顯示在8*8全彩矩陣上；玩家2輸入為0001為剪刀、0010為石頭、0100為布顯示在七段顯示器上：剪刀顯示數字1，石頭顯示數字2、布顯示數字3。

### 程式模組說明：
* module fp(output reg [7:0] DATA_R, DATA_G, DATA_B//8*8RGB, output reg [3:0] A_count//8*8enable, output reg a, b, c, d, e, f, g//七段顯示器,
input [3:0] punch_1//玩家1, punch_2//玩家2, input CLK//時脈, Clear);
