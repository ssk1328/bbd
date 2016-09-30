package BBD_tb;

// Add packages to be included here
import BBD::*;
import BBD_ifc::*;
import Vector::*;

(* synthesize *)
module mkBBDTb (Empty);

	Vector#(256, Reg#(MemData)) data_mem <- replicateM ( mkReg(2));	// TODO: Find a function to initilize with different values
	data_mem[  0] <- mkReg(108);
	data_mem[ 1] <- mkReg(116);
	data_mem[ 2] <- mkReg(132);
	data_mem[ 3] <- mkReg(164);
	data_mem[ 4] <- mkReg(228);

	BBD_IFC dut <- mkBBD;

	Reg#(MemData) x  <- mkReg(0);

	rule counter;
		x <= x + 1;
	endrule

/*	rule rule_add_in (x < 6);
		$display (" Address input from cycle number %d ", x);
		addr <= dut.address();
		$display (" Address value is %d ", addr);
	endrule */

	rule rule_data_out (x < 6);
		dut.push_data(data_mem[x]);
		$display (" Data Value is %d ", data_mem[x]);		
	endrule

	rule stop (x >= 6);
		 $finish(0);
	endrule

endmodule // mkBBDTb

endpackage