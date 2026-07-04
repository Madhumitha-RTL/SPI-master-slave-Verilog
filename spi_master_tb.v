module spi_master_tb;
reg clk;
reg rst;
reg start;
reg [7:0] data_in;

wire mosi;
wire sclk;
wire cs;
wire done;

spi_master uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .mosi(mosi),
    .sclk(sclk),
    .cs(cs),
    .done(done)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1;
    start = 0;
    data_in = 8'b10101010;

    #20 rst = 0;

    #10 start = 1;
    #10 start = 0;

    wait(done);

    #20;
    $stop;
end

endmodule