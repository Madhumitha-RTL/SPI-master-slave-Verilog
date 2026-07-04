module spi_slave_tb;
    reg clk;        // 50MHz system clock
    reg reset_n;
    reg sck;        // SPI clock from master
    reg mosi;
    reg ss_n;
    wire miso;
    wire [7:0] rx_data;
    wire rx_done;

    // Instantiate DUT
    spi_slave uut (
        .clk(clk),
        .reset_n(reset_n),
        .sck(sck),
        .mosi(mosi),
        .ss_n(ss_n),
        .miso(miso),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    // System clock 50MHz = 20ns period
    always #10 clk = ~clk;

    // SPI Master task: 8-bit send
    task spi_send;
        input [7:0] data_in;
        integer i;
        begin
            ss_n = 0; // Select slave
            #20;
            for(i = 7; i >= 0; i = i - 1) begin
                mosi = data_in[i];  // Put data on MOSI
                #10;
                sck = 1;            // Rising edge - slave samples
                #10;
                sck = 0;            // Falling edge - slave shifts out
                #10;
            end
            ss_n = 1; // Deselect slave
            #20;
        end
    endtask

    initial begin
        // Initialize
        clk = 0;
        reset_n = 0;
        sck = 0;
        mosi = 0;
        ss_n = 1;

        // Reset
        #50;
        reset_n = 1;
        #50;

        // Test 1: Send 8'h3C
        $display("Sending 8'h3C");
        spi_send(8'h3C);
        #50;
        if(rx_done) $display("Received: %h", rx_data);

        // Test 2: Send 8'hA5
        $display("Sending 8'hA5");
        spi_send(8'hA5);
        #50;
        if(rx_done) $display("Received: %h", rx_data);

        // Test 3: Send 8'hFF
        $display("Sending 8'hFF");
        spi_send(8'hFF);
        #50;
        if(rx_done) $display("Received: %h", rx_data);

        #100;
        $stop;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t | SS=%b SCK=%b MOSI=%b MISO=%b | RX=%h Done=%b", 
                  $time, ss_n, sck, mosi, miso, rx_data, rx_done);
    end

endmodule
