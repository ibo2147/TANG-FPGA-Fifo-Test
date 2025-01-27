module TOP (CLOCK,button,LED_R,LED_G,LED_B);           // I/O from the constraints file

    input CLOCK;                                // inputs are naturally regs
    input button;
    output LED_R,LED_G,LED_B;                   // outputs are naturally wires

    reg rR=1'b0;                                // create some regs for our LEDS
    reg rG=1'b0;
    reg rB=1'b0;

    assign LED_R = !rR;                         // assign LED wire's to the above reg's, inverted.
    assign LED_G = !rG;
    assign LED_B = !rB;

    reg [7:0] fifo_in;                         // all our FIFO requirements
    wire [7:0] fifo_out;
    reg fifo_read_enable;
    reg fifo_write_enable;
    wire fifo_empty;
    wire fifo_full;
    reg Reset;

    fifo_top my_fifo (               // instantiate the FIFO IP from Gowin
        .RdClk(CLOCK),
        .WrClk(CLOCK),
        .RdEn(fifo_read_enable),
        .WrEn(fifo_write_enable),
        .Data(fifo_in),
        .Full(fifo_full),
        .Empty(fifo_empty),
        .Q(fifo_out)
//        .Reset(Reset) //input Reset
    );

/*
    Gowin_rPLL my_pll(
        .clkout(clk2), //output clkout
        .clkin(CLOCK) //input clkin
    );
*/


    reg [3:0] RSTATE;                       // Counter for the Read state machine below
    reg [3:0] WSTATE;                       // Counter for the Write state machine below

    parameter NDATA = 4; // 3
    
    reg [10:0] r_cnt,w_cnt;
    reg isStartR,isStartW;
     
    initial                                 // Init the fifo registers and state machines
    begin
        fifo_write_enable <= 1'b0;
        fifo_read_enable <= 1'b0;
        WSTATE <= 0;
        RSTATE <= 0;
        w_cnt <= 0;
        r_cnt <= 0;
        isStartR <= 0;
        isStartW <= 0;
    end

    reg Lbtn;

    always @ (posedge CLOCK)      // On every clock edge start the Write state machine
    begin
      Lbtn <= button;
      if (~button && Lbtn)
      begin
         /*
            fifo_write_enable <= 1'b0;
            fifo_read_enable <= 1'b0;
            WSTATE <= 0;
            RSTATE <= 0;
            w_cnt <= 0;
            r_cnt <= 0;
            rR<=1'b0;                                // create some regs for our LEDS
            rG<=1'b0;
            rB<=1'b0;
            Reset<=1'b1;
          */
            isStartW<=1;
            isStartR<=0;
            fifo_in <= 5;
      end
      else
      if (isStartW)
      begin
        Reset<=1'b0;
        case (WSTATE)                       // Each tick only does one of the following cases
            0:
            begin
                fifo_write_enable = 1'b1;   // Enable writing
                //fifo_in <= 8'h65;           // Write first byte
                fifo_in <= w_cnt+8'd65;          // Write first byte
                w_cnt <= 1;
                WSTATE <= 1;
            end
            1:
            begin        
                // fifo_in <= 8'h66;           // 
                fifo_in <= w_cnt+8'd65;        // son data yazılıyor...
                if (w_cnt==NDATA-1)  
                begin
                    // fifo_write_enable = 1'b0;
                    WSTATE <= 2;
                end
                else w_cnt <= w_cnt+1;
            end
            2:                              // Third tick 
            begin 
               fifo_write_enable = 1'b0;    // *** End the write proccess after 3 ticks
               WSTATE <= 3;                 // 6 does't exist so the state machine stops
            end
            3: WSTATE <= 4;
            4: isStartR<=1;
        endcase
 
        if (isStartR)
        if(!fifo_empty)          // if the fifo isn't empty run the Read state machine, one case per tick
            begin
            case (RSTATE)
                0:
                begin
                    fifo_read_enable = 1'b1;   // start the read proccess
                    RSTATE <= 3;               // NOTE: Wait 3 ticks before reading each byte // 1
                end                            
                1:                             // First wait tick
                begin                          
                    RSTATE <= 3;               
                end                            
                2:                             // Second wait tick
                begin                          
                    RSTATE <= 3;               
                end                            
                3:                             // Third tick to start reading
                begin                     
                    if(fifo_out == r_cnt+8'd65)      // First byte read
                    begin	                   
                        rR = 1'b1;             // Turn the red LED on if the value is correct
                    end	                       
                    RSTATE <= 4;	           
                    r_cnt <= r_cnt + 1;
                end	                           
                4:                             // Second byte read
                begin	                       
                    /*
                    if (fifo_out != r_cnt+8'd65)
                    begin	                   
                      RSTATE <= 6;  // Hata varsa stop yapacak...
                    end	                      
                    */
                    if (r_cnt==NDATA-1)
                    begin
                       RSTATE <= 5;
                       fifo_read_enable = 1'b0;   // *** End the read proccess (3 ticks behind and 2 more bytes to read)
                    end
                    else r_cnt <= r_cnt+1;
                end	                           
                5:                             // Third byte read
                begin	                       
                    //if(fifo_out == x_cnt+8'd65)      
                    begin	                   
                        rB = 1'b1;
                        rG = 1'b1;
                    end	                       
                    RSTATE <= 6;               // 6 doesn't exist so the state machine stops
                end
            endcase
        end
      end
    end // always


endmodule

