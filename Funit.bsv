package Funit;

import BBD_ifc::*;
import BRAM::*;
import Vector::*;
import FIFOF::*;
import Mult_Unit::*;
import Inv_Unit::*;

module mkFunit( FUNIT_IFC );

	FIFOF#(MatrixVector) fifo_A  <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_Ai <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_Ai_out <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_C  <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_CAi <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_B  <- mkFIFOF();
	FIFOF#(MatrixVector) fifo_G  <- mkFIFOF();

	FIFOF#(MatrixVector) fifo_sG <- mkFIFOF();	//sum of B individual terms
	FIFOF#(MatrixVector) fifo_sB <- mkFIFOF();	//sum of G individual terms

	// Define a data structure for 4x4 matrix
	Vector#(16, Reg#(Bit#(8))) sigma_G 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) sigma_B 	<- replicateM ( mkReg(0));

	MATMULT_IFC mult0 <- mkBlockMult;
	MATMULT_IFC mult1 <- mkBlockMult;
	MATMULT_IFC mult2 <- mkBlockMult;
	MATINV_IFC inv0 <- mkBlockInverse;

	rule inv0_in ;
		inv0.push_data(fifo_A.first());
		fifo_A.deq();
	endrule

	rule inv0_out ;
		let m_inv <- inv0.get_data();
		fifo_Ai.enq(m_inv);
		fifo_Ai_out.enq(m_inv);
	endrule

	rule m0_in0 ;
		mult0.push_data_d0(fifo_C.first());
		fifo_C.deq();
	endrule

	rule m0_in1 ;
		mult0.push_data_d1(fifo_Ai.first());
		fifo_Ai.deq();
	endrule

	rule m0_out ;
		let m0_out <- mult0.get_data;
		fifo_CAi.enq(m0_out);
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
		let m1_out <- mult1.get_data;
		fifo_sG.enq(m1_out);
	endrule

	rule m2_out ;
		let m2_out <- mult2.get_data;
		fifo_sB.enq(m2_out);
	endrule

//------------------------------------------------------------------------//
//-----------Sigma of individual terms------------------------------------//
//------------------------------------------------------------------------//

	rule add_sG;	
		for(Integer i=0; i<16; i=i+1) begin
			sigma_G[i] <= sigma_G[i]+fifo_sG.first[i];
		end
		fifo_sG.deq();
	endrule

	rule add_sB;	
		for(Integer i=0; i<16; i=i+1) begin
			sigma_B[i] <= sigma_B[i]+fifo_sB.first[i];
		end
		fifo_sB.deq();
	endrule

//--------------------------------------------------------------------------//
//---------Start Methods Definition here------------------------------------//
//--------------------------------------------------------------------------//

	method Action push_A(MatrixVector d0);
		fifo_A.enq(d0);
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

	method MatrixVector get_sigma_B_test();
		return readVReg(sigma_G);
	endmethod

	method ActionValue#(MatrixVector) get_sigma_G();
		return readVReg(sigma_B);
		// Also make the regs zero
	endmethod

	method ActionValue#(MatrixVector) get_Ai();
		let x = fifo_Ai.first();
		fifo_Ai_out.deq();
		return x;
	endmethod

endmodule // mkBBD

endpackage : Funit
