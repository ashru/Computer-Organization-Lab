//Structural encoding of controllers

module FSM_divider(input reset,input  clr,input clk,input divide,output  TD,output  TR,output  ldDivor,output ldQuot,output  ldRem,output [2:0] fselect,input bor,output sel1,output over);

not no1(ndivide,divide);
DFF d0(q0,ndivide,clk,clr);
DFF d1(q1,dq1,clk,clr);
DFF d2(q2,dq2,clk,clr);
DFF d3(q3,dq3,clk,clr);
DFF d4(q4,dq4,clk,clr);
deMUX m1(w3,w2,w1,divide);
deMUX m2(w6,w5,w4,bor);
deMUX m3(w10,w9,w8,bor);
buf s1(dq1,w3);
or s2(dq2,w5,w11);
or s0(dq0,w7,w2);
or s3(dq3,w10,w6);
buf s4(dq4,w9);
buf e0(w1,q0);
buf e1(w4,q1);
buf e2(w8,q2);
buf e3(w7,q3);
buf e4(w11,q4);
or o1(ldRem,q0,q1,q4);
buf o2(sel1,q4);
or o3(ldDivor,q0,q1);
buf o4(TR,q4);
buf o5(TD,q4);
buf o6(over,q3);
buf o7(fselect[1],q4);
buf o8(fselect[0],0);
buf o9(fselect[2],0);
endmodule



module FSM_isP(output reset,output TSW,output TN,input  clr,input clk,output  TI,output  TS,output  ldN,output  ldI,output ldSum,output [2:0] fselect,input bor,output  divide,output  sel,output  display,input go,input over,output  over_main,input eq,input rflag);
not no1(ngo,go);
DFF d0(q0,ngo,clk,clr);
DFF d1(q1,dq1,clk,clr);
DFF d2(q2,dq2,clk,clr);
DFF d3(q3,dq3,clk,clr);
DFF d4(q4,dq4,clk,clr);
DFF d5(q5,dq5,clk,clr);
DFF d6(q6,dq6,clk,clr);
DFF d7(q7,dq7,clk,clr);
DFF d8(q8,dq8,clk,clr);
DFF d9(q9,dq9,clk,clr);
deMUX m1(w3,w2,w1,go);
or temp(inp,w4,w17);
deMUX m2(w5,w6,inp,bor);
deMUX m3(w8,w7,w6,eq);
deMUX m4(w12,w11,w10,over);
deMUX m5(w21,w22,w20,go);
deMUX m6(w15,w14,w13,rflag);
or s0(dq0,w2,w22);
buf s1(dq1,w3);
or s2(dq2,w9,w11);
buf s3(dq3,w5);
buf s4(dq4,w12);
buf s5(dq5,w15);
or s6(dq6,w14,w16);
and a55(dq72,w19,go);
and a56(dq82,w18,go);
or s7(dq7,w8,dq72);
or s8(dq8,w7,dq82);
or s9(dq9,w18,w19,w21);
buf(w1,q0);
buf e1(w4,q1);
buf e2(w10,q2);
buf e3(w9,q3);
buf e4(w13,q4);
buf e5(w16,q5);
buf e6(w17,q6);
buf e7(w19,q7);
buf e8(w18,q8);
buf e9(w20,q9);
or o1(sel,q5,q6);
buf o2(ldN,q0);
or o3(ldSum,q1,q5);
or o4(ldI,q1,q6);
buf o5(divide,q2);
buf o6(TS,q5);
or o7(TI,q5,q6);
buf o8(fselect[1],q6);
or o9(fselect[0],q5,q6);
buf o10(fselect[2],0);
buf(TN,1'b0);
buf(display,q7);
endmodule


