`include "subtratorcompleto.v"
`timescale 1ns/100ps 

module subtratorcompleto_tb;
reg A0, B0, Cin0;
wire S0, Cout0;

subtratorcompleto utt(.A(A0), .B(B0), .Cin(Cin0), .S(S0), .Cout(Cout0));

initial begin
    $dumpfile("subtratorcompleto.vcd");
    $dumpvars(0, subtratorcompleto_tb);
         A0 = 0; B0 = 0; Cin0 = 0;
    #10; A0 = 0; B0 = 0; Cin0 = 1;
    #10; A0 = 0; B0 = 1; Cin0 = 0;
    #10; A0 = 0; B0 = 1; Cin0 = 1;
    #10; A0 = 1; B0 = 0; Cin0 = 0;
    #10; A0 = 1; B0 = 0; Cin0 = 1;
    #10; A0 = 1; B0 = 1; Cin0 = 0;
    #10; A0 = 1; B0 = 1; Cin0 = 1;
    #10; $finish;
end

endmodule