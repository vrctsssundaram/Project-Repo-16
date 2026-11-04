module tb_memqos_arbiter4;
    reg clk=0; always #5 clk=~clk;
    reg rst_n=0,service_ready=1;
    reg [3:0] req_valid=0;
    reg [7:0] req_priority=0,cfg_age_limit=8'd4;
    wire grant_valid;
    wire [1:0] grant_id;
    wire [3:0] req_ready;
    wire [31:0] grant_count;
    integer low_priority_served=0;
    memqos_arbiter4 dut(.*);
    initial begin
        repeat(3) @(negedge clk);rst_n=1;
        @(negedge clk);
        req_valid=4'b0011;
        req_priority=8'b00001100; // Port 1 priority 3; port 0 priority 0.
        #1;
        if(!grant_valid || grant_id!==1 || req_ready!==4'b0010)
            $fatal(1,"Priority selection");
        @(negedge clk);req_valid=0;

        @(negedge clk);
        service_ready=0;
        req_valid=4'b0100;
        req_priority=8'b00000000;
        @(negedge clk); // Port 2 is now locked under downstream stall.
        req_valid=4'b1100;
        req_priority=8'b11000000; // Port 3 has higher priority.
        repeat(5) begin
            @(negedge clk);
            if(!grant_valid || grant_id!==2 || req_ready!==0)
                $fatal(1,"Grant changed while stalled");
        end
        service_ready=1;
        @(negedge clk);req_valid=0;

        rst_n=0;
        repeat(2) @(negedge clk);
        rst_n=1;
        cfg_age_limit=3;
        req_valid=4'b0011;
        req_priority=8'b00001100;
        repeat(12) begin
            @(posedge clk);
            if(grant_valid && service_ready && grant_id==0) low_priority_served=low_priority_served+1;
        end
        @(negedge clk);
        if(low_priority_served==0 || grant_count!==12)
            $fatal(1,"Aging service guarantee count=%d grants=%d",low_priority_served,grant_count);
        $display("PASS: QoS priority, locked stall, aging fairness and grant accounting");
        $finish;
    end
    initial begin #100000;$fatal(1,"Watchdog");end
endmodule
