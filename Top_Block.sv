// Top Block

module tb_D_FF;
diff_if vif();
environment env;
mailbox #(transaction) mbx;

D_FF DUT (.D(vif.D), .Q(vif.Q), .Qn(vif.Qn), .clk(vif.clk), .rst(vif.rst));

initial begin
 vif.clk = 1'b0;
end

always #10 vif.clk <= ~vif.clk;

initial begin
  env = new(vif);
  env.gen.count = 10;
  env.main();
end

initial begin
  $dumpfile("dump.vcd"); // Specify the VCD dump file
  $dumpvars; // Dump all variables
end
endmodule