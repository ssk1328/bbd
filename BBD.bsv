package BBD;

import BBD_ifc::*;
import BRAM::*;
import Vector::*;
import FIFOF::*;

(* synthesize *)
module mkBBD( BBD_IFC );
	Integer fifo_depth = 64;

	FIFOF#(MemData) fifo_in <- mkSizedFIFOF(fifo_depth);

	Reg#(MemData)	dataval		<- mkReg(0);
	Reg#(MemData)	counter		<- mkReg(0);
	Reg#(MemData)	row_select 	<- mkReg(0);


	// Define a data structure for 4x4 matrix
//	Vector#(16, Reg#(MatrixValue)) matrix_vec <- replicateM ( mkReg(0));
//	Reg#(MatrixVector) matrix_vec <- mkReg(0);
	Reg#(Matrix) matrix_vec <- mkReg(0);

	MATINV_IFC matinv <- mkBlockInverse;

	rule matrix_inv (counter%4 == 0)	;
			matinv.push_data(matrix_vec);
	endrule


	rule matrix_in (fifo_in.notEmpty);
		counter <= counter+1;
		matrix_vec[(counter+1)*32:counter*32]   <= fifo_in.first; 
//		matrix_vec[4*counter+1] <= fifo_in.first[15:8] ;
//		matrix_vec[4*counter+2] <= fifo_in.first[23:16];
//		matrix_vec[4*counter+3] <= fifo_in.first[31:24];
		fifo_in.deq;

	endrule

	method Action push_data(MemData m1);
		fifo_in.enq(m1);
	endmethod

/*	method MemAddress address() ;
		case (counter)
			0: return add0;
			1: return add1;
			2: return add2;
			3: return add3;
			4: return add4;
		endcase // counter
	endmethod
*/

endmodule // mkBBD



module mkBlockInverse (MATINV_IFC);	

	Integer fifo_depth = 4;
	FIFOF#(Matrix) fifo_in <- mkSizedFIFOF(fifo_depth);

	Reg#(Matrix) matrix_vec <- mkReg(0);

	rule matrix_solve;
		for (Integer i =0; i < 16; i=i+1) begin
//			matrix_vec[8*(i+1):8*i] <= matrix_vec[8*(i+1):8*i] + fifo_in.first[8*(i+1):8*i];
		end
		fifo_in.deq;
	endrule

	method Action push_data(Matrix m1);
		fifo_in.enq(m1);
	endmethod

endmodule // mkBlockInverse

endpackage : BBD
