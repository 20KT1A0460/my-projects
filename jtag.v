module jtag (
    input clk,
    input reset,
    input tms,
    input tdi,
    output reg tdo,
    output reg [3:0] state
);

    // State encoding
    parameter TEST_LOGIC_RESET  = 4'b0000;
    parameter RUN_TEST_IDLE     = 4'b0001;
    parameter SELECT_DR_SCAN    = 4'b0010;
    parameter CAPTURE_DR        = 4'b0011;
    parameter SHIFT_DR          = 4'b0100;
    parameter EXIT1_DR          = 4'b0101;
    parameter PAUSE_DR          = 4'b0110;
    parameter EXIT2_DR          = 4'b0111;
    parameter UPDATE_DR         = 4'b1000;
    parameter SELECT_IR_SCAN    = 4'b1001;
    parameter CAPTURE_IR        = 4'b1010;
    parameter SHIFT_IR          = 4'b1011;
    parameter EXIT1_IR          = 4'b1100;
    parameter PAUSE_IR          = 4'b1101;
    parameter EXIT2_IR          = 4'b1110;
    parameter UPDATE_IR         = 4'b1111;

    reg [3:0] current_state, next_state;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= TEST_LOGIC_RESET;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            TEST_LOGIC_RESET: next_state = (tms) ? TEST_LOGIC_RESET : RUN_TEST_IDLE;
            RUN_TEST_IDLE:    next_state = (tms) ? SELECT_DR_SCAN : RUN_TEST_IDLE;
            SELECT_DR_SCAN:   next_state = (tms) ? SELECT_IR_SCAN : CAPTURE_DR;
            CAPTURE_DR:       next_state = (tms) ? EXIT1_DR : SHIFT_DR;
            SHIFT_DR:         next_state = (tms) ? EXIT1_DR : SHIFT_DR;
            EXIT1_DR:         next_state = (tms) ? UPDATE_DR : PAUSE_DR;
            PAUSE_DR:         next_state = (tms) ? EXIT2_DR : PAUSE_DR;
            EXIT2_DR:         next_state = (tms) ? UPDATE_DR : SHIFT_DR;
            UPDATE_DR:        next_state = (tms) ? SELECT_DR_SCAN : RUN_TEST_IDLE;
            SELECT_IR_SCAN:   next_state = (tms) ? TEST_LOGIC_RESET : CAPTURE_IR;
            CAPTURE_IR:       next_state = (tms) ? EXIT1_IR : SHIFT_IR;
            SHIFT_IR:         next_state = (tms) ? EXIT1_IR : SHIFT_IR;
            EXIT1_IR:         next_state = (tms) ? UPDATE_IR : PAUSE_IR;
            PAUSE_IR:         next_state = (tms) ? EXIT2_IR : PAUSE_IR;
            EXIT2_IR:         next_state = (tms) ? UPDATE_IR : SHIFT_IR;
            UPDATE_IR:        next_state = (tms) ? SELECT_DR_SCAN : RUN_TEST_IDLE;
            default:          next_state = TEST_LOGIC_RESET;
        endcase
    end

    // Output logic
    always @(*) begin
        tdo = tdi;
        state = current_state;
    end

endmodule


module jtagtb;

    reg clk, reset, tms, tdi;
    wire tdo;
    wire [3:0] state;

    jtag dut (
        .clk(clk),
        .reset(reset),
        .tms(tms),
        .tdi(tdi),
        .tdo(tdo),
        .state(state)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test vector
    reg [7:0] test_vector [0:15];
    initial begin
 test_vector[0]=0000000;
 test_vector[1]=0000001;
 test_vector[2]=0000001;
 test_vector[3]=0000000;
 test_vector[4]=0000001;
 test_vector[5]=0000001;
 test_vector[6]=0000000;
 test_vector[7]=0000001;
 test_vector[8]=0000001;
 test_vector[9]=0000000;
 test_vector[10]=0000001;
 test_vector[11]=0000001;
 test_vector[12]=000000;
 test_vector[13]=0000001;
 test_vector[14]=0000001;
 test_vector[15]=0000000;
    end

    integer i;
    initial begin
        clk = 0;
        reset = 1;
        tms = 0;
        tdi = 0;
        #10 reset = 0;

        for (i = 0; i < 16; i = i + 1) begin
            {tms, tdi} = test_vector[i];
            #10;
            $display("State: %b, TDO: %b", state, tdo);
        end

       #4000  $finish;
    end

endmodule
