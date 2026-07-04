module spi_master (
    input clk,
    input rst,
    input start,
    input [7:0] data_in,
    output reg mosi,
    output reg sclk,
    output reg cs,
    output reg done
);

reg [7:0] shift_reg;
reg [2:0] bit_count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        cs <= 1;
        sclk <= 0;
        mosi <= 0;
        done <= 0;
        bit_count <= 0;
    end
    else begin
        if (start) begin
            cs <= 0;
            shift_reg <= data_in;
            bit_count <= 7;
            done <= 0;
        end
        else if (!cs) begin
            sclk <= ~sclk;

            if (sclk == 0) begin
                mosi <= shift_reg[bit_count];

                if (bit_count == 0) begin
                    cs <= 1;
                    done <= 1;
                end
                else
                    bit_count <= bit_count - 1;
            end
        end
    end
end

endmodule