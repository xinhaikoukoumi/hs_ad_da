# hs_ad_da
校赛选题6
基于 FPGA 的波形产生、采集、显示装置
赛题内容：
使用 FPGA 制作一个波形产生、采集、显示装置。题目要求如下：
1. 产生如下参数的正弦波、方波、三角波，通过 DA 模块输出；
1) 正弦波：输出频率 100Hz~1000Hz 可调，步进值为 100Hz，幅值要
求可以设置为原波形的 1 倍、1/2 倍、1/4 倍、1/8 倍，其他参数不作
要求;
2) 方波：输出频率 100Hz~1000Hz 可调，步进值为 100Hz，幅值要求
可以设置为原波形的 1 倍、1/2 倍、1/4 倍、1/8 倍，占空比设置可切
换 10%、50%、80%，其他参数不作要求；
3) 三角波参数不作要求；
2．采集 AD 数据，并将采集到的数据叠加到波形显示窗口进行显示；
3．波形显示：基础部分要求通过 ILA 抓取信号显示，提高部分要求通过
HDMI\MIPI\VGA 在显示器上显示出来（要求有时间栅格，可以判断信号频率）。
