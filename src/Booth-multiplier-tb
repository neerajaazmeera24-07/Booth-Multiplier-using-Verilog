`timescale 1ns/1ps

module tb_booth_multiplier;

    //-----------------------------
    // Controller Outputs
    //-----------------------------
    wire ldA;
    wire ldQ;
    wire ldM;
    wire clrA;
    wire clrQ;
    wire clrff;
    wire sftA;
    wire sftQ;
    wire addsub;
    wire decr;
    wire ldcnt;
    wire done;

    //-----------------------------
    // Datapath Outputs
    //-----------------------------
    wire qm1;
    wire eqz;

    //-----------------------------
    // Inputs
    //-----------------------------
    reg clk;
    reg start;
    reg [15:0] data_in;

    //-----------------------------
    // q0 Connection
    //-----------------------------
    wire q0;

    assign q0 = uut_dp.Q[0];

    //-----------------------------
    // Datapath
    //-----------------------------
    BOOTH uut_dp(
        .ldA(ldA),
        .ldQ(ldQ),
        .ldM(ldM),
        .clrA(clrA),
        .clrQ(clrQ),
        .clrff(clrff),
        .sftA(sftA),
        .sftQ(sftQ),
        .addsub(addsub),
        .decr(decr),
        .ldcnt(ldcnt),
        .data_in(data_in),
        .clk(clk),
        .qm1(qm1),
        .eqz(eqz)
    );

    //-----------------------------
    // Controller
    //-----------------------------
    controller uut_ctrl(
        .ldA(ldA),
        .clrA(clrA),
        .sftA(sftA),

        .ldQ(ldQ),
        .clrQ(clrQ),
        .sftQ(sftQ),

        .ldM(ldM),
        .clrff(clrff),

        .addsub(addsub),

        .start(start),

        .decr(decr),
        .ldcnt(ldcnt),

        .done(done),

        .clk(clk),

        .q0(q0),
        .qm1(qm1),
        .eqz(eqz)
    );

    //-----------------------------
    // Clock Generation
    //-----------------------------
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //-----------------------------
    // Monitor
    //-----------------------------
    initial begin

        $monitor(
        "Time=%0t State=%b A=%d Q=%d QM1=%b Count=%d Done=%b",
        $time,
        uut_ctrl.state,
        uut_dp.A,
        uut_dp.Q,
        qm1,
        uut_dp.count,
        done);

    end

    //-----------------------------
    // Test Sequence
    //-----------------------------
    initial begin

        //-------------------------
        // Initialize
        //-------------------------
        start = 0;
        data_in = 0;

        #20;

        //-------------------------------------------------
        // Load Multiplicand
        //-------------------------------------------------
        // M = 7
        //-------------------------------------------------
        data_in = 16'd7;

        start = 1;

        #10;
        start = 0;

        //-------------------------------------------------
        // Wait for completion
        //-------------------------------------------------
        wait(done);

        #20;

        //-------------------------------------------------
        // Display Result
        //-------------------------------------------------
        $display("---------------------------------------");
        $display("Multiplicand = %d", uut_dp.M);
        $display("Multiplier   = %d", uut_dp.Q);
        $display("Accumulator  = %d", uut_dp.A);
        $display("Product      = %b%b", uut_dp.A, uut_dp.Q);
        $display("---------------------------------------");

        #20;
        $finish;

    end

endmodule
