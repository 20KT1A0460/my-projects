`timescale 1ns/1ns

module apb_master (
    input wire PCLK,         // APB Clock
    input wire PRESETn,      // Active Low Reset
    output reg PSEL1,PSEL2,PSEL3,PSEL4, // Select Signals
    output reg PENABLE,      // Enable Signal
    output reg PWRITE,       // Write Control Signal
    output reg [31:0] PADDR, // Address Bus
    output reg [31:0] PWDATA,// Write Data Bus
    input wire [31:0] PRDATA,// Read Data Bus
    input wire PREADY,       // Ready Signal from Slave
    output reg PSLVERR,      // Slave Error Signal
    input wire [31:0] data,  // Data to Write
    input wire [31:0] addr,  // Address to Write to
    input wire write,enable,sel1,sel2,sel3,sel4 // Write Enable and Slave Select
);

    // State Definitions
    localparam IDLE   = 2'b00;
    localparam SETUP  = 2'b01;
    localparam ACCESS = 2'b10;

    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        PSEL1 = 0;
        PSEL2 = 0;
        PSEL3 = 0;
        PSEL4 = 0;
        PENABLE = 1'b0;
        PWRITE = 1'b0;
        PADDR = 32'd0;
        PWDATA = 32'd0;
        PSLVERR = 1'b0;

        case (state)
            IDLE: begin
                if (write&&!enable&&{sel1,sel2,sel3,sel4}&&PRESETn) begin
                    next_state = SETUP;
                    PSEL1 = sel1;
                    PSEL2 = sel2;
                    PSEL3 = sel3;
                    PSEL4 = sel4;
                    PADDR = addr;
                    PWRITE = write;
                    PENABLE=enable;
                end else begin
                    next_state = IDLE;
                end
            end

            SETUP: begin
                   if(enable&&{sel1,sel2,sel3,sel4})begin
                      next_state = ACCESS;
                    end
                    else begin
                      next_state = SETUP;
                    end
                PSEL1 = sel1;
                PSEL2 = sel2;
                PSEL3 = sel3;
                PSEL4 = sel4;
                PENABLE = enable;
                PADDR = addr;
                PWDATA = data;
                PWRITE = write;
            end

            ACCESS: begin
                if (PREADY) begin
                    next_state = ACCESS;
                end else begin
                    next_state = SETUP;
                end
                PSEL1 = sel1;
                PSEL2 = sel2;
                PSEL3 = sel3;
                PSEL4 = sel4;
                PENABLE = enable;
                PADDR = addr;
                PWDATA = data;
                PWRITE = write;

            end

            default: next_state = IDLE;
        endcase
    end

endmodule
/////////////////////////////////////////////////

module apb_slave1 (
    input wire PCLK,          // APB Clock
    input wire PRESETn,       // Active Low Reset
    input wire PSEL1,         // Select Signal
    input wire PENABLE,       // Enable Signal
    input wire PWRITE,        // Write Control Signal
    input wire [31:0] PADDR,  // Address Bus
    input wire [31:0] PWDATA, // Write Data Bus
    output reg [31:0] PRDATA, // Read Data Bus
    output reg PREADY,        // Ready Signal
    output reg PSLVERR        // Slave Error Signal
);

    reg [31:0] mem [0:255]; // Memory Array
    
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PREADY <= 1'b0;
            PSLVERR <= 1'b0;
            PRDATA <= 32'd0;
        end else if (PSEL1 && PENABLE) begin
            PREADY <= 1'b1;
            PSLVERR <= 1'b0; // Set error signal as required
            
            if (PWRITE) begin
                mem[PADDR] <= PWDATA; // Write operation
            end else begin
                PRDATA <= mem[PADDR]; // Read operation
            end
        end else begin
            PREADY <= 1'b0;
        end
    end

endmodule
////////////////////////////////////////////////////////////
module apb_slave2 (
    input wire PCLK,          // APB Clock
    input wire PRESETn,       // Active Low Reset
    input wire PSEL2,         // Select Signal
    input wire PENABLE,       // Enable Signal
    input wire PWRITE,        // Write Control Signal
    input wire [31:0] PADDR,  // Address Bus
    input wire [31:0] PWDATA, // Write Data Bus
    output reg [31:0] PRDATA, // Read Data Bus
    output reg PREADY,        // Ready Signal
    output reg PSLVERR        // Slave Error Signal
);

    reg [31:0] mem [0:255]; // Memory Array
    
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PREADY <= 1'b0;
            PSLVERR <= 1'b0;
            PRDATA <= 32'd0;
        end else if (PSEL2 && PENABLE) begin
            PREADY <= 1'b1;
            PSLVERR <= 1'b0; // Set error signal as required
            
            if (PWRITE) begin
                mem[PADDR] <= PWDATA; // Write operation
            end else begin
                PRDATA <= mem[PADDR]; // Read operation
            end
        end else begin
            PREADY <= 1'b0;
        end
    end

endmodule


////////////////////////////////////////////////////////////
module apb_slave3 (
    input wire PCLK,          // APB Clock
    input wire PRESETn,       // Active Low Reset
    input wire PSEL3,         // Select Signal
    input wire PENABLE,       // Enable Signal
    input wire PWRITE,        // Write Control Signal
    input wire [31:0] PADDR,  // Address Bus
    input wire [31:0] PWDATA, // Write Data Bus
    output reg [31:0] PRDATA, // Read Data Bus
    output reg PREADY,        // Ready Signal
    output reg PSLVERR        // Slave Error Signal
);

    reg [31:0] mem [0:255]; // Memory Array
    
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PREADY <= 1'b0;
            PSLVERR <= 1'b0;
            PRDATA <= 32'd0;
        end else if (PSEL3 && PENABLE) begin
            PREADY <= 1'b1;
            PSLVERR <= 1'b0; // Set error signal as required
            
            if (PWRITE) begin
                mem[PADDR] <= PWDATA; // Write operation
            end else begin
                PRDATA <= mem[PADDR]; // Read operation
            end
        end else begin
            PREADY <= 1'b0;
        end
    end

endmodule
///////////////////////////////////////////////////////////////
module apb_slave4 (
    input wire PCLK,          // APB Clock
    input wire PRESETn,       // Active Low Reset
    input wire PSEL4,         // Select Signal
    input wire PENABLE,       // Enable Signal
    input wire PWRITE,        // Write Control Signal
    input wire [31:0] PADDR,  // Address Bus
    input wire [31:0] PWDATA, // Write Data Bus
    output reg [31:0] PRDATA, // Read Data Bus
    output reg PREADY,        // Ready Signal
    output reg PSLVERR        // Slave Error Signal
);

    reg [31:0] mem [0:255]; // Memory Array
    
    always @(posedge PCLK or negedge PRESETn) begin
        if (!PRESETn) begin
            PREADY <= 1'b0;
            PSLVERR <= 1'b0;
            PRDATA <= 32'd0;
        end else if (PSEL4 && PENABLE) begin
            PREADY <= 1'b1;
            PSLVERR <= 1'b0; // Set error signal as required
            
            if (PWRITE) begin
                mem[PADDR] <= PWDATA; // Write operation
            end else begin
                PRDATA <= mem[PADDR]; // Read operation
            end
        end else begin
            PREADY <= 1'b0;
        end
    end

endmodule
//////////////////////////////////////////////////////////////////
module apb_bridge(
    input PCLK,
    input PRESETn,
    input [31:0] data,
    input [31:0] addr,
    input write, enable, sel1, sel2, sel3, sel4,
    output [31:0] PRDATA,
    output PREADY,
    output PSLVERR
);

    wire [31:0] PRDATA1, PRDATA2, PRDATA3, PRDATA4;
    wire PSEL1, PSEL2, PSEL3, PSEL4;
    wire PREADY1, PREADY2, PREADY3, PREADY4;
    wire PSLVERR1, PSLVERR2, PSLVERR3, PSLVERR4;
    wire PENABLE, PWRITE;
    wire [31:0] PADDR, PWDATA;

    // for only one slave can respond at tine 
      assign  PSEL1 = !sel4 && sel1 && !sel2 && !sel3;   // 1000
      assign   PSEL2 = !sel4 && !sel1 && sel2 && !sel3;  //0100
      assign  PSEL3 = !sel4 && !sel1 && !sel2 && sel3; //0010
      assign  PSEL4 = sel4 && !sel1 && !sel2 && !sel3; //0001
   

    apb_master master_inst(
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL1(PSEL1),
        .PSEL2(PSEL2),
        .PSEL3(PSEL3),
        .PSEL4(PSEL4),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA),
        .PREADY(PREADY),
        .PSLVERR(PSLVERR),
        .data(data),
        .addr(addr),
        .write(write),
        .enable(enable),
        .sel1(sel1),
        .sel2(sel2),
        .sel3(sel3),
        .sel4(sel4)
    );

    apb_slave1 slave1_inst(
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL1(PSEL1),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA1),
        .PREADY(PREADY1),
        .PSLVERR(PSLVERR1)
    );

    apb_slave2 slave2_inst(
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL2(PSEL2),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA2),
        .PREADY(PREADY2),
        .PSLVERR(PSLVERR2)
    );

    apb_slave3 slave3_inst(
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL3(PSEL3),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA3),
        .PREADY(PREADY3),
        .PSLVERR(PSLVERR3)
    );

    apb_slave4 slave4_inst(
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .PSEL4(PSEL4),
        .PENABLE(PENABLE),
        .PWRITE(PWRITE),
        .PADDR(PADDR),
        .PWDATA(PWDATA),
        .PRDATA(PRDATA4),
        .PREADY(PREADY4),
        .PSLVERR(PSLVERR4)
    );
 
    assign PRDATA = PRDATA1 | PRDATA2 | PRDATA3 | PRDATA4;
    assign PREADY = PREADY1 | PREADY2 | PREADY3 | PREADY4;
    assign PSLVERR = PSLVERR1 | PSLVERR2 | PSLVERR3 | PSLVERR4;

endmodule

///////////////////////////////////////////////////////////////

