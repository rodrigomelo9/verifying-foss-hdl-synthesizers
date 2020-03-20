(* blackbox *)
module LUT2 (O, I0, I1);
    parameter [3:0] INIT = 4'h0;
    output O;
    input I0;
    input I1;
endmodule

(* blackbox *)
module FDR (Q, C, D, R);
    parameter [0:0] INIT = 1'b0;
    output Q;
    input  C, D, R;
    wire Q;
endmodule

(* blackbox *)
module FDS (Q, C, D, S);
    parameter [0:0] INIT = 1'b1;
    output Q;
    input  C, D, S;
    wire Q;
endmodule

(* blackbox *)
module FD (Q, C, D);
    parameter [0:0] INIT = 1'b0;
    output Q;
    input  C, D;
    wire Q;
endmodule
