// Driver

class driver;
 virtual diff_if vif;
 mailbox #(transaction) mbx;
 transaction trans;
 
 function new (mailbox #(transaction) mbx);
  this.mbx = mbx;
 endfunction
 
 task reset();
    vif.rst <= 1'b1;
	repeat(5) @(posedge vif.clk);  // wait for 5 clock cycles
	vif.rst <= 1'b0;
	@(posedge vif.clk);
	$display("[DRV] : Reset Done");
 endtask
 
 task main();
    forever begin
	mbx.get(trans);
	vif.D <= trans.D;
	@(posedge vif.clk);
	trans.display("DRV");
	vif.D <= 1'b0;
	@(posedge vif.clk);
	end
  endtask
  
endclass