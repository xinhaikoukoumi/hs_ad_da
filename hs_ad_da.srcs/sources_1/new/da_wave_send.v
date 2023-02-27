
module da_wave_send(
    input                 clk    ,  //ʱ��
    input                 rst_n  ,  //��λ�źţ��͵�ƽ��Ч
    input        [7:0]    rd_data,  //ROM����������
    output  reg  [7:0]    rd_addr,  //��ROM��ַ
    //DAоƬ�ӿ�
    output                da_clk ,  //DA(AD9708)����ʱ��,���֧��125Mhzʱ��
    output       [7:0]    da_data   //�����DA������  
    );

//parameter
//Ƶ�ʵ��ڿ���
parameter  FREQ_ADJ=4'd2 ;  //Ƶ�ʵ���,FREQ_ADJ��Խ��,���������Ƶ��Խ��,��Χ0~15

//reg define
reg    [7:0]    freq_cnt  ;  //Ƶ�ʵ��ڼ�����

//*****************************************************
//**                    main code
//*****************************************************

//����rd_data����clk�������ظ��µģ�����DAоƬ��clk���½��������������ȶ���ʱ��
//��DAʵ������da_clk����������������,����ʱ��ȡ��,����clk���½����൱��da_clk��������
assign  da_clk = ~clk;       
assign  da_data = rd_data;   //��������ROM���ݸ�ֵ��DA���ݶ˿�


//Ƶ�ʵ��ڼ�����
always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        freq_cnt <= 8'd0;
    else if(freq_cnt == FREQ_ADJ)    
        freq_cnt <= 8'd0;
    else         
        freq_cnt <= freq_cnt + 8'd1;
end

//��ROM��ַ
always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)
        rd_addr <= 8'd0;
    else begin
        if(freq_cnt == FREQ_ADJ) begin
            rd_addr <= rd_addr + 8'd1;
        end    
    end            
end
endmodule