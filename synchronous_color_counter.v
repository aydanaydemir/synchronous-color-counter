// ============================================================================
// Course: Digital System Design (EEE/EEM 229)
// Description: 3-Bit Synchronous Color Counter and 7-Segment Driver
// Top-Level Entity Match: eee229
// ============================================================================

module eee229 (
    input clk,          // Shared Clock Signal
    output Q2, Q1, Q0,  // 3-bit Counter Outputs
    output Red, Orange, Yellow, Green, Blue, Purple, Pink, White, // LED Array
    output a, b, c, d, e, f, g // 7-Segment Display Line Array
);

    // Internal State Registers for D Flip-Flops
    reg q2_reg = 0;
    reg q1_reg = 0;
    reg q0_reg = 0;

    // Excitation Wiring Nets
    wire d2, d1, d0;

    // ------------------------------------------------------------------------
    // 1. Counter Next-State Logic Realization
    // ------------------------------------------------------------------------
    assign d0 = ~q0_reg;
    assign d1 = q1_reg ^ q0_reg;
    assign d2 = q2_reg ^ (q1_reg & q0_reg);

    // Synchronous State Transition Edge-Triggered Block
    always @(posedge clk) begin
        q0_reg <= d0;
        q1_reg <= d1;
        q2_reg <= d2;
    end

    // Direct Port Boundary Mapping
    assign Q2 = q2_reg;
    assign Q1 = q1_reg;
    assign Q0 = q0_reg;

    // ------------------------------------------------------------------------
    // 2. Color Mapping Combinational Logic
    // ------------------------------------------------------------------------
    assign Blue   = (~Q1 & ~Q0);
    assign Pink   = (~Q2 & ~Q1 & Q0);
    assign Orange = (~Q2 & Q1 & ~Q0);
    assign Red    = (~Q2 & Q1 & Q0) | (Q2 & ~Q1 & Q0) | (Q2 & Q1 & ~Q0);
    assign White  = (Q2 & Q1 & Q0);
    
    // Unused Color Channels Grounded
    assign Yellow = 1'b0;
    assign Green  = 1'b0;
    assign Purple = 1'b0;

    // ------------------------------------------------------------------------
    // 3. 7-Segment Custom Combinational Driver
    // ------------------------------------------------------------------------
    assign a = Q1 | (Q2 & Q0) | (~Q2 & ~Q0);
    assign b = ~Q2 | (~Q1 & ~Q0) | (Q1 & Q0);
    assign c = Q2 | ~Q1 | Q0;
    assign d = (~Q2 & ~Q0) | (~Q2 & Q1) | (Q1 & ~Q0) | (Q2 & ~Q1 & Q0);
    assign e = (~Q2 & ~Q0) | (Q1 & ~Q0);
    assign f = (Q2 & ~Q1) | (~Q1 & ~Q0) | (Q2 & ~Q0);
    assign g = (Q2 & ~Q1) | (~Q2 & Q1) | (Q2 & ~Q0);

endmodule