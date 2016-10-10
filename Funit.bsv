package Funit;

import BBD_ifc::*;
import BRAM::*;
import Vector::*;
import FIFOF::*;
import Mult_Unit::*;

module mkBBD( Funit_IFC );
//	Integer fifo_depth = 64;

	FIFOF#(MatrixVector) fifo_Ai <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_B  <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_C  <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_G  <- mkFIFOF();

	Reg#(MatrixVector) sigma_G <- mkReg(unpack(0));
	Reg#(MatrixVector) sigma_B <- mkReg(unpack(0));

// Define a data structure for 4x4 matrix
	Vector#(16, Reg#(Bit#(8))) matC 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) matA 	<- replicateM ( mkReg(0));

//	MATINV_IFC matinv <- mkBlockInverse;
	MATMULT_IFC matmult0 <- mkBlockMult;
	MATMULT_IFC matmult1 <- mkBlockMult;
	MATMULT_IFC matmult2 <- mkBlockMult;

	rule countup ;
		counter <= counter +1;
	endrule

	rule matrix_mult (counter%16 == 0);
			matmult.push_data_d0(readVReg(matrix_vec));
			matmult.push_data_d1(readVReg(matrix_vec));
	endrule

	rule matrix_in ( 0<= counter%16 && counter%16 <2);
		matC  [8*counter  ]	<= fifo_in.first[ 7: 0];
		matC  [8*counter+1]	<= fifo_in.first[15: 8];
		matC  [8*counter+2]	<= fifo_in.first[23:16];
		matC  [8*counter+3] <= fifo_in.first[31:24];
		matC  [8*counter+4]	<= fifo_in.first[39:32];
		matC  [8*counter+5]	<= fifo_in.first[47:40];
		matC  [8*counter+6]	<= fifo_in.first[55:48];
		matC  [8*counter+7] <= fifo_in.first[63:56];
	endrule

	rule matrix_in ( 2 <= counter%16 && counter%16 <4);
		matA  [8*counter   -16]	<= fifo_in.first[ 7: 0];
		matA  [8*counter+1 -16]	<= fifo_in.first[15: 8];
		matA  [8*counter+2 -16]	<= fifo_in.first[23:16];
		matA  [8*counter+3 -16] <= fifo_in.first[31:24];
		matA  [8*counter+4 -16]	<= fifo_in.first[39:32];
		matA  [8*counter+5 -16]	<= fifo_in.first[47:40];
		matA  [8*counter+6 -16]	<= fifo_in.first[55:48];
		matA  [8*counter+7 -16] <= fifo_in.first[63:56];
	endrule

//--------------------------------------------------------------------------//
//---------Start Methods Definition here------------------------------------//
//--------------------------------------------------------------------------//

	method Action push_Ai(MatrixVector d0);
		fifo_Ai.enq(d0);
	endmethod

	method Action push_B(MatrixVector d1);
		fifo_B.enq(d1);
	endmethod

	method Action push_C(MatrixVector d2);
		fifo_C.enq(d2);
	endmethod

	method Action push_G(MatrixVector d3);
		fifo_G.enq(d3);
	endmethod

	method ActionValue#(MatrixVector) get_sigma_B();
		return sigma_B;
	endmethod	

	method ActionValue#(MatrixVector) get_sigma_G();
		return sigma_G;
	endmethod

endmodule // mkBBD


/*
module mkBlockInverse (MATINV_IFC);	

	Integer fifo_depth = 4;
	FIFOF#(MatrixVector) fifo_in <- mkSizedFIFOF(fifo_depth);

	Reg#(MatrixVector) matrix_vec <- mkReg(unpack(0));

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
*/

module mkBlockMult (MATMULT_IFC);

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

endpackage : Funit
