
module hs_ad_da(
    input                 sys_clk     ,  //ϵͳʱ��
    input                 sys_rst_n   ,  //ϵͳ��λ���͵�ƽ��Ч
    //DAоƬ�ӿ�
    output                da_clk      ,  //DA(AD9708)����ʱ��,���֧��125Mhzʱ��
    output    [7:0]       da_data     ,  //�����DA������
    //ADоƬ�ӿ�
    input     [7:0]       ad_data     ,  //AD��������
    //ģ�������ѹ�������̱�־(��������δ�õ�)
    input                 ad_otr      ,  //0:�����̷�Χ 1:��������
    output                ad_clk         //AD(AD9280)����ʱ��,���֧��32Mhzʱ�� 
);

//wire define 
wire      [7:0]    rd_addr;              //ROM����ַ
wire      [7:0]    rd_data;              //ROM����������
//*****************************************************
//**                    main code
//*****************************************************

//DA���ݷ���
da_wave_send u_da_wave_send(
    .clk         (sys_clk), 
    .rst_n       (sys_rst_n),
    .rd_data     (rd_data),
    .rd_addr     (rd_addr),
    .da_clk      (da_clk),  
    .da_data     (da_data)
    
    );

//ROM�洢����
rom_256x8b  u_rom_256x8b (
  .clka  (sys_clk),    // input wire clka
  .addra (rd_addr),    // input wire [7 : 0] addra
  .douta (rd_data)     // output wire [7 : 0] douta
);

//AD���ݽ���
ad_wave_rec u_ad_wave_rec(
    .clk         (sys_clk),
    .rst_n       (sys_rst_n),
    .ad_data     (ad_data),
    .ad_otr      (ad_otr),
    .ad_clk      (ad_clk)
    );    

//ILA�ɼ�AD����
ila_0  ila_0 (
    .clk         (ad_clk ), // input wire clk
    .probe0      (ad_otr ), // input wire [0:0]  probe0  
    .probe1      (ad_data)  // input wire [7:0]  probe0  
);

endmodule