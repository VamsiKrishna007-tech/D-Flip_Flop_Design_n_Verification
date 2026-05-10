// Scoreboard

class scoreboard;
transaction trans;
transaction trans_ref;
mailbox #(transaction) mbx;
mailbox #(transaction) mbxref;
event sconext;

function new( mailbox #(transaction) mbx, mailbox #(transaction) mbxref);
  this.mbx = mbx;
  this.mbxref = mbxref;
endfunction

task main();
forever begin
trans = new();
trans_ref = new();
mbx.get(trans);
mbxref.get(trans_ref);
trans.display("SOC");
trans_ref.display("REF");
if (trans.Q == trans_ref.D)
  $display("[SOC] : DATA MATCH");
else
  $display("[SOC] : DATA MISMATCH");
->sconext;
end
endtask

endclass