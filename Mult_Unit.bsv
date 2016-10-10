package Mult_Unit;

module mkBlockMult (MATMULT_IFC);

	import BBD_ifc::*;
	import BRAM::*;
	import Vector::*;
	import FIFOF::*;

	FIFOF#(MatrixVector) matrix_in0 <- mkFIFOF();
	FIFOF#(MatrixVector) matrix_in1 <- mkFIFOF();
	FIFOF#(MatrixVector) matrix_out <- mkFIFOF();
//	Reg#(MatrixVector) m0 <- mkReg(unpack(0));
//	Reg#(MatrixVector) m1 <- mkReg(unpack(0));
	Vector#(16, Reg#(Bit#(8))) m0 <- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) m1 <- replicateM ( mkReg(0));

	Reg#(Bool) started <- mkReg(False);
	Reg#(Bool) finish <- mkReg(False);
//	Reg#(MatrixVector) ret_val <- mkReg(unpack(0));
	Vector#(16, Reg#(Bit#(8))) ret_val <- replicateM ( mkReg(0));

	rule start_computation (!started);

		let val0 = matrix_in0.first();
		matrix_in0.deq();
		writeVReg(m0, val0);

		let val1 = matrix_in1.first();
		matrix_in1.deq();
		writeVReg(m1, val1);

		started <= True;

	endrule

	rule do_computationl (started && !finish);
		for(Integer i=0; i<16; i=i+1) begin
//			ret_val[i] <= m0[i] + m1[i];
			let j = i%4;
			let k = i/4;

			ret_val[i] <= 	m0[k]*m1[j]+m0[k+1]*m1[j+4] + m0[k+2]*m1[j+8] + m0[k+3]*m1[j+12];
		end
		finish <= True;
	endrule
	
	rule finish_computation (finish);
		matrix_out.enq(readVReg(ret_val));
		started <= False;
		finish <= False;
	endrule

//--------------------------------------------------------------------------//
//---------Start Methods Definition here------------------------------------//
//--------------------------------------------------------------------------//

	method Action push_data_d0(MatrixVector d0);
		matrix_in0.enq(d0);
	endmethod

	method Action push_data_d1(MatrixVector d1);
		matrix_in1.enq(d1);
	endmethod
	
	method ActionValue#(MatrixVector) get_data();
		matrix_out.deq();
		return matrix_out.first();
	endmethod	
endmodule

endpackage
