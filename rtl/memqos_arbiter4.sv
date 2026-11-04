module memqos_arbiter4 (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [3:0]  req_valid,
    input  wire [7:0]  req_priority,
    input  wire [7:0]  cfg_age_limit,
    input  wire        service_ready,
    output reg         grant_valid,
    output reg  [1:0]  grant_id,
    output reg  [3:0]  req_ready,
    output reg  [31:0] grant_count
);
    reg [7:0] age [0:3];
    reg [1:0] rr_start;
    reg locked;
    reg [1:0] locked_id;
    reg chosen_valid;
    reg [1:0] chosen_id;
    reg aged_exists;
    reg [7:0] best_age;
    reg [1:0] best_priority;
    integer i,k,candidate;
    wire [7:0] age_limit = cfg_age_limit==0 ? 8'd1 : cfg_age_limit;

    always @* begin
        aged_exists=0;
        for(i=0;i<4;i=i+1)
            if(req_valid[i] && age[i]>=age_limit) aged_exists=1;
        chosen_valid=0;
        chosen_id=0;
        best_age=0;
        best_priority=0;
        for(k=0;k<4;k=k+1) begin
            candidate=rr_start+k;
            if(candidate>=4) candidate=candidate-4;
            if(req_valid[candidate] &&
               (aged_exists ? age[candidate]>=age_limit : 1'b1)) begin
                if(!chosen_valid ||
                   (aged_exists && age[candidate]>best_age) ||
                   (!aged_exists && req_priority[candidate*2 +:2]>best_priority)) begin
                    chosen_valid=1;
                    chosen_id=candidate[1:0];
                    best_age=age[candidate];
                    best_priority=req_priority[candidate*2 +:2];
                end
            end
        end
        grant_id = locked ? locked_id : chosen_id;
        grant_valid = locked ? req_valid[locked_id] : chosen_valid;
        req_ready=0;
        if(grant_valid) req_ready[grant_id]=service_ready;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            rr_start<=0;
            locked<=0;
            locked_id<=0;
            grant_count<=0;
            for(integer j=0;j<4;j=j+1) age[j]<=0;
        end else begin
            if(grant_valid && !service_ready && !locked) begin
                locked<=1;
                locked_id<=grant_id;
            end
            if(grant_valid && service_ready) begin
                locked<=0;
                rr_start<=grant_id+1'b1;
                grant_count<=grant_count+1'b1;
            end
            for(integer j=0;j<4;j=j+1) begin
                if(!req_valid[j] || (grant_valid && service_ready && grant_id==j[1:0]))
                    age[j]<=0;
                else if(age[j]!=8'hff) age[j]<=age[j]+1'b1;
            end
        end
    end
endmodule
