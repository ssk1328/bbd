package Funit;

import BBD_ifc::*;
import BRAM::*;
import Vector::*;
import FIFOF::*;
import Mult_Unit::*;

module mkFunit( FUNIT_IFC );

	FIFOF#(MatrixVector) fifo_Ai <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_B  <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_C  <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_G  <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_CAi <- mkFIFOF();

	FIFOF#(MatrixVector) fifo_sG <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_sB <- mkFIFOF();

	// Define a data structure for 4x4 matrix
	Vector#(16, Reg#(Bit#(8))) sigma_G 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) sigma_B 	<- replicateM ( mkReg(0));

	MATMULT_IFC mult0 <- mkBlockMult;
	MATMULT_IFC mult1 <- mkBlockMult;
	MATMULT_IFC mult2 <- mkBlockMult;

	rule m0_in0 ;
		mult0.push_data_d0(fifo_C.first());
		fifo_C.deq();
	endrule

	rule m0_in1 ;
		mult0.push_data_d1(fifo_Ai.first());
		fifo_Ai.deq();
	endrule

	rule m0_out ;
		fifo_CAi.enq(mult0.get_data());
	endrule

	rule m1_m2_in0;
		mult1.push_data_d0(fifo_CAi.first());
		mult2.push_data_d0(fifo_CAi.first());
		fifo_CAi.deq();
	endrule

	rule m1_in1;
		mult1.push_data_d1(fifo_G.first());
		fifo_G.deq();
	endrule

	rule m2_in1;
		mult2.push_data_d1(fifo_B.first());
		fifo_B.deq();
	endrule

	rule m1_out ;
		fifo_sG.enq(mult1.get_data());
	endrule

	rule m2_out ;
		fifo_sB.enq(mult2.get_data());
	endrule

//------------------------------------------------------------------------//
//-----------Sigma of individual terms------------------------------------//
//------------------------------------------------------------------------//

	rule add_sG;	
		for(Integer i=0; i<16; i=i+1) begin
			sigma_G[i] = sigma_G[i]+fifo_sG.first[i];
		end
		fifo_sG.deq();
	endrule

	rule add_sB;	
		for(Integer i=0; i<16; i=i+1) begin
			sigma_B[i] = sigma_B[i]+fifo_sB.first[i];
		end
		fifo_sB.deq();
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
		return readVReg(sigma_G);
		// Also make the regs zero
	endmethod

	method ActionValue#(MatrixVector) get_sigma_G();
		return readVReg(sigma_B);
		// Also make the regs zero
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

endpackage : Funit
