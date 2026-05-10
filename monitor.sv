// Monitor

class monitor;
 transaction trans;
 virtual diff_if vif;
 mailbox #(transaction) mbx;
 
 function new( mailbox #(transaction) mbx);
   this.mbx = mbx;
 endfunction
 
 task main();
   trans = new();
   forever begin
   repeat(2) @(posedge vif.clk);   //Wait for 2 clock cycles, since we are waiting for 2 clock cycles in driver
   trans.D = vif.D;
   trans.Q = vif.Q;
   trans.Qn = vif.Qn;
   trans.display("MON");
   mbx.put(trans);
   end
 endtask
 
endclass