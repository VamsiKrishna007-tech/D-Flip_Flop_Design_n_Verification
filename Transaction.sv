// Transaction

class transaction;
rand bit D;
bit Q;
bit Qn;

function void display( input string tag);
 $display("[%s] D = %0d \t Q = %0d \t Qn = %0d", tag, D, Q, Qn);
endfunction

function transaction copy();
 copy = new();
 copy.D = this.D;
 copy.Q = this.Q;
 copy.Qn = this.Qn;
endfunction

endclass
