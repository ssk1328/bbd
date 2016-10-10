package Inv_Unit;

	import BBD_ifc::*;
	import BRAM::*;
	import Vector::*;
	import FIFOF::*;

module mkBlockInverse (MATINV_IFC);	

	FIFOF#(MatrixVector) matrix_in1 <- mkFIFOF();
	FIFOF#(MatrixVector) matrix_out <- mkFIFOF();

	Vector#(16, Reg#(Bit#(8))) m0 <- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) m1 <- replicateM ( mkReg(0));

	rule matrix_solve;
		for (Integer i =0; i < 16; i=i+1) begin
//			matrix_vec[8*(i+1):8*i] <= matrix_vec[8*(i+1):8*i] + fifo_in.first[8*(i+1):8*i];
//			matrix_vec[i] = matrix_vec[i] + fifo_in.first[(8*i+8): 8*i];
		end
		fifo_in.deq;
	endrule

	method Action push_data(MatrixVector m1);
		fifo_in.enq(m1);
	endmethod

endmodule // mkBlockInverse

endpackage : Inv_Unit
