package BBD;

import BBD_ifc::*;
import BRAM::*;
import Vector::*;
import FIFOF::*;
import Funit::*;
import Inv_Unit::*;
import Mult_Unit::*;

module mkBBD( BBD_IFC );

	FIFOF#(MemData) fifo_in 	<- mkFIFOF();
	FIFOF#(MemData) fifo_out 	<- mkFIFOF();
	FIFOF#(MatrixVector) xn 	<- mkFIFOF();

	Reg#(MemData)	dataval		<- mkReg(0);
//	Reg#(Integer)	counter0	<- mkReg(valueOf(0));
	Reg#(Int#(32))	counter		<- mkReg(unpack(0));
	Reg#(Int#(32))	cvar		<- mkReg(unpack(0));
	Reg#(Int#(32))  n 			<- mkReg(unpack(16));
	Reg#(Int#(32))  avar		<- mkReg(unpack(0));

	// Define a data structure for 4x4 matrix
	Vector#(16, Reg#(MatrixValue)) matC 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(MatrixValue)) matA 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(MatrixValue)) matB 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(MatrixValue)) matG 	<- replicateM ( mkReg(0));

	Vector#(16, Reg#(MatrixValue)) matAn 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(MatrixValue)) matGn 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(MatrixValue)) matXn 	<- replicateM ( mkReg(0));

	Vector#(16, Reg#(MatrixValue)) sigma_An	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(MatrixValue)) sigma_Gn	<- replicateM ( mkReg(0));

	FUNIT_IFC  f0   <- mkFunit;
	FUNIT_IFC  f1   <- mkFunit;
	FUNIT_IFC  f2   <- mkFunit;
	FUNIT_IFC  f3   <- mkFunit;
	MATINV_IFC inv0 <- mkBlockInverse;
	MATMULT_IFC m0 <- mkBlockMult;

//--------------------------------------------------------------------------//
//--------- Copy matrix A to each FUNIT ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_A_in( (counter%32)<8 && counter < 8*n);
		for(Integer j=0; j<8; j=j+1) begin
			let i = fromInteger(j);
			matA  [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_A_push ((counter%32)>0 && (counter%32)<9 && (counter%2==0) && counter < 8*n);
		case (((counter%32)-2)/2)
			0: f0.push_A(readVReg(matA));
			1: f1.push_A(readVReg(matA));
			2: f2.push_A(readVReg(matA));
			3: f3.push_A(readVReg(matA));
		endcase // (counter%16-2)/4
	endrule

//--------------------------------------------------------------------------//
//--------- Copy matrix C to each FUNIT ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_C_in ( (counter%32)>=8 && (counter%32)<16 && counter < 8*n);
		for(Integer j=0; j<8; j=j+1) begin
			let i = fromInteger(j);
			matC  [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_C_push ( (counter%32)>=8 && (counter%32)<16 && (counter%4)==2 && counter < 8*n);
		case ((counter%32-10)/2)
			0: f0.push_C(readVReg(matC));
			1: f1.push_C(readVReg(matC));
			2: f2.push_C(readVReg(matC));
			3: f3.push_C(readVReg(matC));
		endcase // (counter%16-2)/4
	endrule

//--------------------------------------------------------------------------//
//--------- Copy matrix B to each FUNIT ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_B_in ( (counter%32)>=16 && (counter%32)<32 && (counter%4)<2 && counter < 8*n);
		for(Integer j=0; j<8; j=j+1) begin
			let i = fromInteger(j);
			matB  [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_B_push ( (counter%32)>=16 && (counter%32)<32 && (counter%4)==2 && counter < 8*n);
		case ((counter%32-18)/4)
			0: f0.push_B(readVReg(matB));
			1: f1.push_B(readVReg(matB));
			2: f2.push_B(readVReg(matB));
			3: f3.push_B(readVReg(matB));
		endcase // (counter%16-2)/4
	endrule

//--------------------------------------------------------------------------//
//--------- Copy matrix G to each FUNIT ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_G_in ( (counter%32)>=16 && (counter%32)<32 && (counter%4)>=2 && counter < 8*n );
		for(Integer j=0; j<8; j=j+1) begin
			let i = fromInteger(j);
			matG  [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_G_push ( (counter%32)>=16 && (counter%32)<32 && (counter%4)==0  && counter <= 8*n);
		case ((counter%32-20)/4)
			0: f0.push_G(readVReg(matA));
			1: f1.push_G(readVReg(matA));
			2: f2.push_G(readVReg(matA));
			3: f3.push_G(readVReg(matA));
		endcase // (counter%16-2)/4
	endrule

// -------------------------------------------------------------------------------//
//	N Blocks are completed now, copy the value of An and Gn
// -------------------------------------------------------------------------------//

	rule matrix_An_in ( counter>=(8*n) && counter%32 >=0 && counter%32 <2 ) ; //TODO: Specify this cleanly
		for(Integer j=0; j<8; j=j+1) begin
			let i = fromInteger(j);
			matAn [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_Gn_in ( counter>=(8*n) && counter%32 >=2 && counter%32 <4 ) ; //TODO: Specify this cleanly
		for(Integer j=0; j<8; j=j+1) begin
			let i = fromInteger(j);
			matGn [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

// -------------------------------------------------------------------------------//
//	Update value of Gn and An by decrementing the values from sigma_B and sigma_G
// -------------------------------------------------------------------------------//

	rule matrix_rule0 ( counter > (8*n+8) && cvar==0);

		let sigma_B <- f0.get_sigma_B(); 
		let sigma_G <- f0.get_sigma_G(); 
		cvar <= cvar+1;

		for(Integer i=0; i<16; i=i+1) begin
			matAn[i] <= matAn[i] - sigma_B[i];
			matGn[i] <= matGn[i] - sigma_G[i];
		end
	endrule

	rule matrix_rule1 ( counter > (8*n+8) && cvar==1);

		let sigma_B <- f1.get_sigma_B(); 
		let sigma_G <- f1.get_sigma_G(); 
		cvar <= cvar+1;

		for(Integer i=0; i<16; i=i+1) begin
			matAn[i] <= matAn[i] - sigma_B[i];
			matGn[i] <= matGn[i] - sigma_G[i];
		end
	endrule

	rule matrix_rule2 ( counter > (8*n+8) && cvar==2);

		let sigma_B <- f2.get_sigma_B(); 
		let sigma_G <- f2.get_sigma_G(); 
		cvar <= cvar+1;

		for(Integer i=0; i<16; i=i+1) begin
			matAn[i] <= matAn[i] - sigma_B[i];
			matGn[i] <= matGn[i] - sigma_G[i];
		end
	endrule

	rule matrix_rule3 ( counter > (8*n+8) && cvar==3);

		let sigma_B <- f3.get_sigma_B(); 
		let sigma_G <- f3.get_sigma_G(); 
		cvar <= cvar+1;

		for(Integer i=0; i<16; i=i+1) begin
			matAn[i] <= matAn[i] - sigma_B[i];
			matGn[i] <= matGn[i] - sigma_G[i];
		end
	endrule

//--------------------------------------------------------------------------//
//---------Calculate Xn Value ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_Xn(cvar==4); // Fire this at explicit time
		inv0.push_data(readVReg(matAn));
		cvar<=0;
	endrule

	rule matrix_Xn_inv;
		m0.push_data_d0(readVReg(matGn));
		let sAin <- inv0.get_data;
		m0.push_data_d1(sAin);
	endrule

	rule matrix_Xn_final;
		let xn_final <- m0.get_data;
		xn.enq(xn_final);
//		$display("Done Matrix");
	endrule

//--------------------------------------------------------------------------//
//---------Push Ai Values back to Memory------------------------------------//
//--------------------------------------------------------------------------//

/*	rule (avar%2<2);
		display("Done Matrix");
	endrule

	rule (avar>0 && avar%2==0)
		display("Done Matrix");
	endrule
*/

//--------------------------------------------------------------------------//
//---------Start Methods Definition here------------------------------------//
//--------------------------------------------------------------------------//

	method Action push_data(MemData d0);
		fifo_in.enq(d0);
		counter <= counter+1;
	endmethod

	method ActionValue#(MemData) get_data();
		fifo_out.deq();
		return fifo_out.first();
	endmethod

endmodule // mkBBD

endpackage : BBD
