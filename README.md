# 111321017Final-Project
# Final-Project
### Authors: 111321017

### 功能說明：
* 玩家使用指撥開關輸入猜拳與電腦對戰，若輸入為0001為剪刀、0010為石頭、0100為布顯示在8*8全彩矩陣上；電腦使用Linear feedback shift register生成隨機拳種：00為剪刀、01為石頭、10為布顯示在七段顯示器上；觸發Clear時清空。

### 程式模組說明：
* module fp(output reg [7:0] DATA_R, DATA_G, DATA_B//8*8全彩矩陣, lfsr//隨機取數, output reg [3:0] A_count//全彩矩陣enable, output reg [1:0] cc//電腦選擇拳種,
output reg a, b, c, d, e, f, g,//七段顯示器
input [3:0] punch//玩家輸入拳種, input CLK, Clear);
