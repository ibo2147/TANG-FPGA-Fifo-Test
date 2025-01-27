module gw_gao(
    \fifo_in[7] ,
    \fifo_in[6] ,
    \fifo_in[5] ,
    \fifo_in[4] ,
    \fifo_in[3] ,
    \fifo_in[2] ,
    \fifo_in[1] ,
    \fifo_in[0] ,
    \fifo_out[7] ,
    \fifo_out[6] ,
    \fifo_out[5] ,
    \fifo_out[4] ,
    \fifo_out[3] ,
    \fifo_out[2] ,
    \fifo_out[1] ,
    \fifo_out[0] ,
    \RSTATE[3] ,
    \RSTATE[2] ,
    \RSTATE[1] ,
    \RSTATE[0] ,
    \WSTATE[3] ,
    \WSTATE[2] ,
    \WSTATE[1] ,
    \WSTATE[0] ,
    \r_cnt[10] ,
    \r_cnt[9] ,
    \r_cnt[8] ,
    \r_cnt[7] ,
    \r_cnt[6] ,
    \r_cnt[5] ,
    \r_cnt[4] ,
    \r_cnt[3] ,
    \r_cnt[2] ,
    \r_cnt[1] ,
    \r_cnt[0] ,
    \w_cnt[10] ,
    \w_cnt[9] ,
    \w_cnt[8] ,
    \w_cnt[7] ,
    \w_cnt[6] ,
    \w_cnt[5] ,
    \w_cnt[4] ,
    \w_cnt[3] ,
    \w_cnt[2] ,
    \w_cnt[1] ,
    \w_cnt[0] ,
    button,
    Lbtn,
    fifo_read_enable,
    fifo_write_enable,
    fifo_empty,
    fifo_full,
    isStartR,
    isStartW,
    WrReset,
    RdReset,
    CLOCK,
    tms_pad_i,
    tck_pad_i,
    tdi_pad_i,
    tdo_pad_o
);

input \fifo_in[7] ;
input \fifo_in[6] ;
input \fifo_in[5] ;
input \fifo_in[4] ;
input \fifo_in[3] ;
input \fifo_in[2] ;
input \fifo_in[1] ;
input \fifo_in[0] ;
input \fifo_out[7] ;
input \fifo_out[6] ;
input \fifo_out[5] ;
input \fifo_out[4] ;
input \fifo_out[3] ;
input \fifo_out[2] ;
input \fifo_out[1] ;
input \fifo_out[0] ;
input \RSTATE[3] ;
input \RSTATE[2] ;
input \RSTATE[1] ;
input \RSTATE[0] ;
input \WSTATE[3] ;
input \WSTATE[2] ;
input \WSTATE[1] ;
input \WSTATE[0] ;
input \r_cnt[10] ;
input \r_cnt[9] ;
input \r_cnt[8] ;
input \r_cnt[7] ;
input \r_cnt[6] ;
input \r_cnt[5] ;
input \r_cnt[4] ;
input \r_cnt[3] ;
input \r_cnt[2] ;
input \r_cnt[1] ;
input \r_cnt[0] ;
input \w_cnt[10] ;
input \w_cnt[9] ;
input \w_cnt[8] ;
input \w_cnt[7] ;
input \w_cnt[6] ;
input \w_cnt[5] ;
input \w_cnt[4] ;
input \w_cnt[3] ;
input \w_cnt[2] ;
input \w_cnt[1] ;
input \w_cnt[0] ;
input button;
input Lbtn;
input fifo_read_enable;
input fifo_write_enable;
input fifo_empty;
input fifo_full;
input isStartR;
input isStartW;
input WrReset;
input RdReset;
input CLOCK;
input tms_pad_i;
input tck_pad_i;
input tdi_pad_i;
output tdo_pad_o;

wire \fifo_in[7] ;
wire \fifo_in[6] ;
wire \fifo_in[5] ;
wire \fifo_in[4] ;
wire \fifo_in[3] ;
wire \fifo_in[2] ;
wire \fifo_in[1] ;
wire \fifo_in[0] ;
wire \fifo_out[7] ;
wire \fifo_out[6] ;
wire \fifo_out[5] ;
wire \fifo_out[4] ;
wire \fifo_out[3] ;
wire \fifo_out[2] ;
wire \fifo_out[1] ;
wire \fifo_out[0] ;
wire \RSTATE[3] ;
wire \RSTATE[2] ;
wire \RSTATE[1] ;
wire \RSTATE[0] ;
wire \WSTATE[3] ;
wire \WSTATE[2] ;
wire \WSTATE[1] ;
wire \WSTATE[0] ;
wire \r_cnt[10] ;
wire \r_cnt[9] ;
wire \r_cnt[8] ;
wire \r_cnt[7] ;
wire \r_cnt[6] ;
wire \r_cnt[5] ;
wire \r_cnt[4] ;
wire \r_cnt[3] ;
wire \r_cnt[2] ;
wire \r_cnt[1] ;
wire \r_cnt[0] ;
wire \w_cnt[10] ;
wire \w_cnt[9] ;
wire \w_cnt[8] ;
wire \w_cnt[7] ;
wire \w_cnt[6] ;
wire \w_cnt[5] ;
wire \w_cnt[4] ;
wire \w_cnt[3] ;
wire \w_cnt[2] ;
wire \w_cnt[1] ;
wire \w_cnt[0] ;
wire button;
wire Lbtn;
wire fifo_read_enable;
wire fifo_write_enable;
wire fifo_empty;
wire fifo_full;
wire isStartR;
wire isStartW;
wire WrReset;
wire RdReset;
wire CLOCK;
wire tms_pad_i;
wire tck_pad_i;
wire tdi_pad_i;
wire tdo_pad_o;
wire tms_i_c;
wire tck_i_c;
wire tdi_i_c;
wire tdo_o_c;
wire [9:0] control0;
wire gao_jtag_tck;
wire gao_jtag_reset;
wire run_test_idle_er1;
wire run_test_idle_er2;
wire shift_dr_capture_dr;
wire update_dr;
wire pause_dr;
wire enable_er1;
wire enable_er2;
wire gao_jtag_tdi;
wire tdo_er1;

IBUF tms_ibuf (
    .I(tms_pad_i),
    .O(tms_i_c)
);

IBUF tck_ibuf (
    .I(tck_pad_i),
    .O(tck_i_c)
);

IBUF tdi_ibuf (
    .I(tdi_pad_i),
    .O(tdi_i_c)
);

OBUF tdo_obuf (
    .I(tdo_o_c),
    .O(tdo_pad_o)
);

GW_JTAG  u_gw_jtag(
    .tms_pad_i(tms_i_c),
    .tck_pad_i(tck_i_c),
    .tdi_pad_i(tdi_i_c),
    .tdo_pad_o(tdo_o_c),
    .tck_o(gao_jtag_tck),
    .test_logic_reset_o(gao_jtag_reset),
    .run_test_idle_er1_o(run_test_idle_er1),
    .run_test_idle_er2_o(run_test_idle_er2),
    .shift_dr_capture_dr_o(shift_dr_capture_dr),
    .update_dr_o(update_dr),
    .pause_dr_o(pause_dr),
    .enable_er1_o(enable_er1),
    .enable_er2_o(enable_er2),
    .tdi_o(gao_jtag_tdi),
    .tdo_er1_i(tdo_er1),
    .tdo_er2_i(1'b0)
);

gw_con_top  u_icon_top(
    .tck_i(gao_jtag_tck),
    .tdi_i(gao_jtag_tdi),
    .tdo_o(tdo_er1),
    .rst_i(gao_jtag_reset),
    .control0(control0[9:0]),
    .enable_i(enable_er1),
    .shift_dr_capture_dr_i(shift_dr_capture_dr),
    .update_dr_i(update_dr)
);

ao_top_0  u_la0_top(
    .control(control0[9:0]),
    .trig0_i({\RSTATE[3] ,\RSTATE[2] ,\RSTATE[1] ,\RSTATE[0] }),
    .trig1_i(button),
    .trig2_i(isStartW),
    .data_i({\fifo_in[7] ,\fifo_in[6] ,\fifo_in[5] ,\fifo_in[4] ,\fifo_in[3] ,\fifo_in[2] ,\fifo_in[1] ,\fifo_in[0] ,\fifo_out[7] ,\fifo_out[6] ,\fifo_out[5] ,\fifo_out[4] ,\fifo_out[3] ,\fifo_out[2] ,\fifo_out[1] ,\fifo_out[0] ,\RSTATE[3] ,\RSTATE[2] ,\RSTATE[1] ,\RSTATE[0] ,\WSTATE[3] ,\WSTATE[2] ,\WSTATE[1] ,\WSTATE[0] ,\r_cnt[10] ,\r_cnt[9] ,\r_cnt[8] ,\r_cnt[7] ,\r_cnt[6] ,\r_cnt[5] ,\r_cnt[4] ,\r_cnt[3] ,\r_cnt[2] ,\r_cnt[1] ,\r_cnt[0] ,\w_cnt[10] ,\w_cnt[9] ,\w_cnt[8] ,\w_cnt[7] ,\w_cnt[6] ,\w_cnt[5] ,\w_cnt[4] ,\w_cnt[3] ,\w_cnt[2] ,\w_cnt[1] ,\w_cnt[0] ,button,Lbtn,fifo_read_enable,fifo_write_enable,fifo_empty,fifo_full,isStartR,isStartW,WrReset,RdReset}),
    .clk_i(CLOCK)
);

endmodule
