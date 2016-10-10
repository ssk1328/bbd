package BBD;

import BBD_ifc::*;
import BRAM::*;
import Vector::*;
import FIFOF::*;
import Funit::*;

(* synthesize *)
module mkBBD( BBD_IFC );

	Integer N = 16;

	FIFOF#(MemData) fifo_in <- mkFIFOF();
	FIFOF#(MemData) fifo_out <- mkFIFOF();

	Reg#(MemData)	dataval		<- mkReg(0);
	Reg#(MemData)	counter		<- mkReg(0);
	Reg#(MemData)	row_select 	<- mkReg(0);

// Define a data structure for 4x4 matrix
	Vector#(16, Reg#(Bit#(8))) matC 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) matA 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) matB 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) matG 	<- replicateM ( mkReg(0));

	Vector#(16, Reg#(Bit#(8))) matAn 	<- replicateM ( mkReg(0));
	Vector#(16, Reg#(Bit#(8))) matGn 	<- replicateM ( mkReg(0));

	FUNIT_IFC f0 <- mkFunit;
	FUNIT_IFC f1 <- mkFunit;
	FUNIT_IFC f2 <- mkFunit;
	FUNIT_IFC f3 <- mkFunit;

//--------------------------------------------------------------------------//
//--------- Copy matrix C to each FUNIT ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_C_in ( (counter%32)>=0 && (counter%32)<16 && (counter%4)<2 );
		for(Integer i=0; i<8; i=i+1) begin
			matC  [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_C_push ( (counter%32)>=0 && (counter%32)<16 && (counter%4)==2);
		case ((counter%32-2)/4)
			0: f0.push_C(readVReg(matC));
			1: f1.push_C(readVReg(matC));
			2: f2.push_C(readVReg(matC));
			3: f3.push_C(readVReg(matC));
		endcase // (counter%16-2)/4
	endrule

//--------------------------------------------------------------------------//
//--------- Copy matrix A to each FUNIT ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_A_in ( (counter%32)>=0 && (counter%32)<16 && (counter%4)>1 );
		for(Integer i=0; i<8; i=i+1) begin
			matA  [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_A_push ( (counter%32)>=0 && (counter%32)<16 && (counter%4)==2);
		case ((counter%32-4)/4)
			0: f0.push_Ai(readVReg(matA));
			1: f1.push_Ai(readVReg(matA));
			2: f2.push_Ai(readVReg(matA));
			3: f3.push_Ai(readVReg(matA));
		endcase // (counter%16-2)/4
	endrule

//--------------------------------------------------------------------------//
//--------- Copy matrix B to each FUNIT ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_B_in ( (counter%32)>=16 && (counter%32)<32 && (counter%4)<2 );
		for(Integer i=0; i<8; i=i+1) begin
			matB  [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_B_push ( (counter%32)>=16 && (counter%32)<32 && (counter%4)==2);
		case ((counter%32-2)/4)
			0: f0.push_Ai(readVReg(matB));
			1: f1.push_Ai(readVReg(matB));
			2: f2.push_Ai(readVReg(matB));
			3: f3.push_Ai(readVReg(matB));
		endcase // (counter%16-2)/4
	endrule

//--------------------------------------------------------------------------//
//--------- Copy matrix G to each FUNIT ------------------------------------//
//--------------------------------------------------------------------------//

	rule matrix_G_in ( (counter%32)>=16 && (counter%32)<32 && (counter%4)>1 );
		for(Integer i=0; i<8; i=i+1) begin
			matG  [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_G_push ( (counter%32)>=16 && (counter%32)<32 && (counter%4)==2);
		case ((counter%32-4)/4)
			0: f0.push_G(readVReg(matA));
			1: f1.push_G(readVReg(matA));
			2: f2.push_G(readVReg(matA));
			3: f3.push_G(readVReg(matA));
		endcase // (counter%16-2)/4
	endrule

// _______________________________________________________________________________//
//
//	N Blocks are completed now, copy the value of An and Gn
// _______________________________________________________________________________//

	rule matrix_An_in ( counter>=(8*N) && counter%32 >=0 && counter%32 <2 ) ; //TODO: Specify this cleanly
		for(Integer i=0; i<8; i=i+1) begin
			matAn [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_Gn_in ( counter>=(8*N) && counter%32 >=2 && counter%32 <4 ) ; //TODO: Specify this cleanly
		for(Integer i=0; i<8; i=i+1) begin
			matGn [8*(counter%2)+i]	<= fifo_in.first[8*i+7 : 8*i];
		end
		fifo_in.deq();
	endrule

	rule matrix_An_up(); // TODO: Fire this at the explicit correct time sigma_B is ready
		case (cvar)
			0: let sigma_B = f0.get_sigma_B(); 
			1: let sigma_B = f1.get_sigma_B(); 
			2: let sigma_B = f2.get_sigma_B(); 
			3: let sigma_B = f3.get_sigma_B(); 
		endcase
		for(Integer i=0; i<16; i=i+1) begin
			matAn[i] = matAn[i] - sigma_B[i]; 
		end
	endrule

	rule matrix_Gn_up();
		case (cvar)
			0: let sigma_G = f0.get_sigma_G(); 
			1: let sigma_G = f1.get_sigma_G(); 
			2: let sigma_G = f2.get_sigma_G(); 
			3: let sigma_G = f3.get_sigma_G(); 
		endcase
		for(Integer i=0; i<16; i=i+1) begin
			matAn[i] = matAn[i] - sigma_G[i]; 
		end
	endrule

	rule matrix_inverse();
		
	endrule

//--------------------------------------------------------------------------//
//---------Start Methods Definition here------------------------------------//
//--------------------------------------------------------------------------//

	method Action push_data(MemData d0);
		fifo_in.enq(d0);
		counter = counter+1;
	endmethod

	method ActionValue#(MemData) get_data();
		fifo_out.deq();
		return fifo_out.first();
	endmethod	

endmodule // mkBBD


endpackage : BBD
