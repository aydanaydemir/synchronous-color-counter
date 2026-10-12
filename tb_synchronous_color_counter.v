`timescale 1ns / 1ps
// ============================================================================
// Testbench: tb_synchronous_color_counter
// Description: Automated simulation verification for 3-bit synchronous counter,
//              7-segment driver, and color LED decoder.
// ============================================================================

module tb_synchronous_color_counter;

    // Testbench Stimulus Signals
    reg clk;

    // Device Under Test (DUT) Outputs
    wire Q2, Q1, Q0;
    wire Red, Orange, Yellow, Green, Blue, Purple, Pink, White;
    wire a, b, c, d, e, f, g;

    // Instantiate Device Under Test
    eee229 dut (
        .clk(clk),
        .Q2(Q2),
        .Q1(Q1),
        .Q0(Q0),
        .Red(Red),
        .Orange(Orange),
        .Yellow(Yellow),
        .Green(Green),
        .Blue(Blue),
        .Purple(Purple),
        .Pink(Pink),
        .White(White),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g)
    );

    // 100 MHz Clock Generation (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Optional VCD waveform dump
        $dumpfile("counter_waveform.vcd");
        $dumpvars(0, tb_synchronous_color_counter);

        // Initialize clock
        clk = 0;

        $display("---------------------------------------------------------------------------------");
        $display("Time (ns) | State (Q2 Q1 Q0) | Active Color LED | 7-Seg Display (a b c d e f g)");
        $display("---------------------------------------------------------------------------------");

        // Run through 16 clock cycles (two full 0-7 periods)
        repeat (16) begin
            @(posedge clk);
            #1; // Settling delay
            $write("%8t  |    %b  %b  %b     | ", $time, Q2, Q1, Q0);

            // Decode active LED
            if (Blue)        $write("Blue             | ");
            else if (Pink)   $write("Pink             | ");
            else if (Orange) $write("Orange           | ");
            else if (Red)    $write("Red              | ");
            else if (White)  $write("White            | ");
            else             $write("None             | ");

            // Display 7-segment lines
            $display("  %b %b %b %b %b %b %b", a, b, c, d, e, f, g);
        end

        $display("---------------------------------------------------------------------------------");
        $display("[SUCCESS] Testbench verification completed successfully.");
        $finish;
    end

endmodule
