module full_adder_and_subtractor(
    input logic  A, B, Te, M,
    output logic S, Ts
);
    assign S = A ^ B ^ Te; 
    assign Ts = (B & Te) | ((M ^ A) & (B | Te));  
       
endmodule