module BOOTH (
    ldA,
    ldQ,
    ldM,
    clrA,
    clrQ,
    clrff,
    sftA,
    sftQ,
    addsub,
    decr,
    ldcnt,
    data_in,
    clk,
    qm1,
    eqz
);

    input ldA, ldQ, ldM;
    input clrA, clrQ, clrff;
    input sftA, sftQ;
    input addsub;
    input decr, ldcnt;
    input clk;
    input [15:0] data_in;

    output qm1, eqz;

    wire [15:0] A, M, Q, Z;
    wire [4:0] count;

    assign eqz = ~&count;

    // Accumulator Register
    shiftreg AR (
        A,
        Z,
        A[15],
        clk,
        ldA,
        clrA,
        sftA
    );

    // Multiplier Register
    shiftreg QR (
        Q,
        data_in,
        A[0],
        clk,
        ldQ,
        clrQ,
        sftQ
    );

    // Q(-1) Flip-Flop
    dff QM1 (
        Q[0],
        qm1,
        clk,
        clrff
    );

    // Multiplicand Register
    PIPO MR (
        data_in,
        M,
        clk,
        ldM
    );

    // Adder/Subtractor
    ALU AS (
        Z,
        A,
        M,
        addsub
    );

    // Counter
    counter CN (
        count,
        decr,
        ldcnt,
        clk
    );

endmodule
module shiftreg (
    data_out,
    data_in,
    s_in,
    clk,
    ld,
    clr,
    sft
);
    input s_in, clk, ld, clr, sft;
    input [15:0] data_in;
    output reg [15:0] data_out;

    always @(posedge clk)
    begin
        if (clr)
            data_out <= 16'b0;
        else if (ld)
            data_out <= data_in;
        else if (sft)
            data_out <= {s_in, data_out[15:1]};
    end
endmodule

module PIPO (
    data_out,
    data_in,
    clk,
    load
);

    input [15:0] data_in;
    input load, clk;
    output reg [15:0] data_out;

    always @(posedge clk)
    begin
        if (load)
            data_out <= data_in;
    end

endmodule

module dff (
    d,
    q,
    clk,
    clr
);

    input d, clk, clr;
    output reg q;

    always @(posedge clk)
    begin
        if (clr)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule

module ALU (
    out,
    in1,
    in2,
    addsub
);

    input [15:0] in1, in2;
    input addsub;
    output reg [15:0] out;

    always @(*)
    begin
        if (addsub == 0)
            out = in1 - in2;
        else
            out = in1 + in2;
    end

endmodule

module counter (
    data_out,
    decr,
    ldcnt,
    clk
);

    input decr, clk, ldcnt;
    output reg [4:0] data_out;

    always @(posedge clk)
    begin
        if (ldcnt)
            data_out <= 5'b10000;
        else if (decr)
            data_out <= data_out - 1;
    end

endmodule
