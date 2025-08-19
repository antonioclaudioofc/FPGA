// DigitalJS 
// Link https://digitaljs.tilk.eu/#9713b34c5b56bd02da438b584cabd5ef1c32703a5f22f8398bd652b7eae50222

module digital_alarm(input A, input B, input C, output Y);
  wire BC, AC, AB;
  
  assign BC = B & C;
  assign AC = A & C;
  assign AB = A & B;
  
  assign Y = BC | AC | AB;
endmodule