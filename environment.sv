// Environment 
 
class environment;

generator gen;
driver drv;
monitor mon;
scoreboard sco;

event next;   //gen to sco

mailbox #(transaction) gmbx;  // generator to driver
mailbox #(transaction) mmbx;  // monitor to scoreboard
mailbox #(transaction) smbx;  // generator to scoreboard
virtual diff_if vif;          // Interface 

function new( virtual diff_if vif);
	// Mailbox instantiation
	gmbx = new();
	mmbx = new();
	smbx = new();
	// Conecting mailbox with components
    gen = new(gmbx, smbx);
	drv = new(gmbx);
	mon = new(mmbx);
	sco = new(smbx, mmbx);
    // Connecting Event
	gen.sconext = next;
	sco.sconext = next;
	// Connecting Interfaces
	this.vif = vif;
	drv.vif = this.vif;
	mon.vif = this.vif;
endfunction

task pre_test();
   drv.reset();
endtask

task test();
fork
  gen.main();
  drv.main();
  mon.main();
  sco.main();
join_none
endtask

task post_test();
  wait(gen.done.triggered);
  $finish();
endtask

task main();
  pre_test();
  test();
  post_test();
endtask

endclass
