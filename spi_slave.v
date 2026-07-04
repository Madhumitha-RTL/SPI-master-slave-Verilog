module spi_slave (
    input  wire clk,        // System clock
    input  wire reset_n,    // Active low reset
    input  wire sck,        // SPI Clock from Master
    input  wire mosi,       // Master Out Slave In
    input  wire ss_n,       // Slave Select, Active Low
    output reg  miso,       // Master In Slave Out
    output reg  [7:0] rx_data,  // Received data
    output reg  rx_done     // Data received flag
);

reg [7:0] tx_data = 8'hA5;  // Data to send back to master
reg [2:0] bit_cnt;
reg [7:0] shift_reg;

// Detect falling and rising edge of SCK
reg sck_d1, sck_d2;
always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        sck_d1 <= 1'b0;
        sck_d2 <= 1'b0;
    end else begin
        sck_d1 <= sck;
        sck_d2 <= sck_d1;
    end
end

wire sck_rising  =  sck_d1 & ~sck_d2;
wire sck_falling = ~sck_d1 &  sck_d2;

// SPI Slave Logic
always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        bit_cnt   <= 3'd0;
        rx_data   <= 8'd0;
        shift_reg <= 8'd0;
        miso      <= 1'b0;
        rx_done   <= 1'b0;
    end 
    else if(ss_n) begin  // SS high = not selected
        bit_cnt <= 3'd0;
        rx_done <= 1'b0;
    end 
    else begin
        rx_done <= 1'b0;
        
        // Sample MOSI on rising edge, Shift out MISO on falling edge - Mode 0
        if(sck_rising) begin
            shift_reg <= {shift_reg[6:0], mosi};  // Shift in
            bit_cnt <= bit_cnt + 1'b1;
            
            if(bit_cnt == 3'd7) begin
                rx_data <= {shift_reg[6:0], mosi};  // Complete 8 bits
                rx_done <= 1'b1;
            end
        end
        
        if(sck_falling) begin
            miso <= tx_data[7 - bit_cnt];  // Shift out
        end
    end
end

endmodule
