// Generator 

class generator;
transaction trans;
mailbox #(transaction) mbx;   //Mailbox to driver
mailbox #(transaction) mbxref;   //Mailbox to scoreboard
event sconext;  //To determine scoreboard work is complete
event done;     //To determine required number od stimulus is completed
int count;

function new( mailbox #(transaction) mbx, mailbox #(transaction) mbxref);
	this.mbx = mbx;
	this.mbxref = mbxref;
	trans = new();
endfunction

task main();
	repeat(count) begin
	assert(trans.randomize()) else $display("Randomization Failed");
	mbx.put(trans.copy());
	mbxref.put(trans.copy());
	trans.display("GEN");
	@(sconext);            // wait till scoreboard completes its process
	end
-> done;
endtask

endclass
