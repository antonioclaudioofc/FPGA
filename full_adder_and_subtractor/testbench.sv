module tb_full_adder_and_subtractor;

    logic A, B, Te, M;
    logic S, Ts;

    full_adder_and_subtractor utt (
        .A(A),
        .B(B),
        .Te(Te),
        .M(M),
        .S(S),
        .Ts(Ts)
    );

    initial begin
        A = 0; B = 0; Te = 0; M = 0;
        #10;

        for (int i = 0; i < 16; i++) begin
          {M, A, B, Te} = i;
            #10;
          $display("M=%b, A=%b, B=%b, Te=%b => S=%b, Ts=%b", M, A, B, Te, S, Ts);
        end

        $finish;
    end

    initial begin
        $dumpfile("ondas.vcd");
        $dumpvars(0, tb_full_adder_and_subtractor);
    end
endmodule