
module hs_ad_da(
    input                 sys_clk     ,  //系统时钟
    input                 sys_rst_n   ,  //系统复位，低电平有效
    //DA芯片接口
    output                da_clk      ,  //DA(AD9708)驱动时钟,最大支持125Mhz时钟
    output    [7:0]       da_data     ,  //输出给DA的数据
    //AD芯片接口
    input     [7:0]       ad_data     ,  //AD输入数据
    //模拟输入电压超出量程标志(本次试验未用到)
    input                 ad_otr      ,  //0:在量程范围 1:超出量程
    output                ad_clk         //AD(AD9280)驱动时钟,最大支持32Mhz时钟 
);

//wire define 
wire      [7:0]    rd_addr;              //ROM读地址
wire      [7:0]    rd_data;              //ROM读出的数据
//*****************************************************
//**                    main code
//*****************************************************

//DA数据发送
da_wave_send u_da_wave_send(
    .clk         (sys_clk), 
    .rst_n       (sys_rst_n),
    .rd_data     (rd_data),
    .rd_addr     (rd_addr),
    .da_clk      (da_clk),  
    .da_data     (da_data)
    
    );

//ROM存储波形
rom_256x8b  u_rom_256x8b (
  .clka  (sys_clk),    // input wire clka
  .addra (rd_addr),    // input wire [7 : 0] addra
  .douta (rd_data)     // output wire [7 : 0] douta
);

//AD数据接收
ad_wave_rec u_ad_wave_rec(
    .clk         (sys_clk),
    .rst_n       (sys_rst_n),
    .ad_data     (ad_data),
    .ad_otr      (ad_otr),
    .ad_clk      (ad_clk)
    );    

//ILA采集AD数据
ila_0  ila_0 (
    .clk         (ad_clk ), // input wire clk
    .probe0      (ad_otr ), // input wire [0:0]  probe0  
    .probe1      (ad_data)  // input wire [7:0]  probe0  
);

endmodule