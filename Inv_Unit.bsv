package Inv_Unit;

	import BBD_ifc::*;
	import BRAM::*;
	import Vector::*;
	import FIFOF::*;

function MatrixVector row_red( MatrixVector m0, Integer k1, Integer k2);
	for(Integer i=0; i<4; i=i+1) begin
		m0[k1*4 + i] = m0[k1*4 + i] -(m0[k1*4 + k2])*m0[k2*4+i];
	end
	return m0;
endfunction : row_red

function MatrixVector row_div( MatrixVector m0, Integer k);
	for(Integer i=0; i<4; i=i+1) begin
		m0[k*4 + i] = m0[k*4 + i]/m0[k*4+k]; 	
	end
	return m0;
endfunction : row_div

module mkBlockInverse (MATINV_IFC);	

	FIFOF#(MatrixVector) matrix_in <- mkFIFOF();

	Vector#(16, Reg#(Bit#(8))) m0 <- {	mkReg(1), mkReg(0),mkReg(0),mkReg(0),
										mkReg(0), mkReg(1),mkReg(0),mkReg(0),
										mkReg(0), mkReg(0),mkReg(1),mkReg(0),
									  	mkReg(0), mkReg(0),mkReg(0),mkReg(1) };

	Integer n = 16;

	FIFOF#(MatrixVector) stage_m[n];	// start this with given matrix
	FIFOF#(MatrixVector) stage_i[n];	// start this with identity matrix
	for(Integer i=0; i<n; i=i+1) begin
		stage_m[i] <- mkFIFOF();
		stage_i[i] <- mkFIFOF();
	end

	rule stage0;	// r0 = r0/a00
		stage_m[0].enq(row_div(matrix_in.first,0));
		matrix_in.deq;
		stage_i[0].enq(row_div(readVReg(m0),0));
	end rule

	rule stage1;	// r1 = r1 - a10*r0
		stage_m[1].enq(row_red(stage_m[0].first,1, 0));
		stage_i[1].enq(row_red(stage_m[0].first,1, 0));
		stage_m[0].deq;		stage_i[0].deq;
	end rule

	rule stage2;	// r2 = r2 - a20*r0
		stage_m[2].enq(row_red(stage_m[2].first,2, 0));
		stage_i[2].enq(row_red(stage_i[2].first,2, 0));
		stage_m[1].deq;		stage_i[1].deq;
	end rule

	rule stage3;	// r3 = r3 -a30*r0
		stage_m[3].enq(row_red(stage_m[2].first,3, 0));
		stage_i[3].enq(row_red(stage_i[2].first,3, 0));
		stage_m[2].deq;		stage_i[2].deq;
	end rule
	// first column setup complete
	//-----------------------------

	rule stage4;	// r1 =r1/a11
		stage_m[4].enq(row_div(stage_m[3].first,1));
		stage_i[4].enq(row_div(stage_m[3].first,1));
		stage_m[3].deq;		stage_i[3].deq;
	end rule

	rule stage5;	// r0 = r0 - a01*r1
		stage_m[5].enq(row_red(stage_m[4].first,0, 1));
		stage_i[5].enq(row_red(stage_m[4].first,0, 1));
		stage_m[4].deq;		stage_i[4].deq;
	end rule

	rule stage6;	// r2 = r2 - a21*r1
		stage_m[6].enq(row_red(stage_m[5].first,2, 1));
		stage_i[6].enq(row_red(stage_m[5].first,2, 1));
		stage_m[5].deq;		stage_i[5].deq;
	end rule

	rule stage7;	// r3 = r3 - a31*r1
		stage_m[7].enq(row_red(stage_m[7].first,3, 1));
		stage_i[7].enq(row_red(stage_i[7].first,3, 1));
		stage_m[6].deq;		stage_i[6].deq;
	end rule
	// second column setup complete
	//-----------------------------

	rule stage8;	// r2 =r2/a22
		stage_m[8].enq(row_div(stage_m[7].first, 2));
		stage_i[8].enq(row_div(stage_m[7].first, 2));
		stage_m[7].deq;		stage_i[7].deq;
	end rule

	rule stage9;	// r0 = r0 - a02*r2
		stage_m[9].enq(row_red(stage_m[8].first, 0, 2));
		stage_i[9].enq(row_red(stage_m[8].first, 0, 2));
		stage_m[8].deq;		stage_i[8].deq;
	end rule

	rule stage10;	// r1 = r1 - a12*r2
		stage_m[10].enq(row_red(stage_m[9].first, 1, 2));
		stage_i[10].enq(row_red(stage_m[9].first, 1, 2));
		stage_m[9].deq;		stage_i[9].deq;
	end rule

	rule stage11;	// r3 = r3 - a32*r2
		stage_m[11].enq(row_red(stage_m[11].first, 3, 2));
		stage_i[11].enq(row_red(stage_i[11].first, 3, 2));
		stage_m[10].deq;		stage_i[10].deq;
	end rule
	// third column setup complete
	//-----------------------------

	rule stage12;	// r3 =r3/a33
		stage_m[12].enq(row_div(stage_m[11].first, 3));
		stage_i[12].enq(row_div(stage_m[11].first, 3));
		stage_m[11].deq;		stage_i[11].deq;
	end rule

	rule stage13;	// r0 = r0 - a03*r3
		stage_m[13].enq(row_red(stage_m[12].first, 0, 3));
		stage_i[13].enq(row_red(stage_m[12].first, 0, 3));
		stage_m[12].deq;		stage_i[12].deq;
	end rule

	rule stage14;	// r1 = r1 - a13*r3
		stage_m[14].enq(row_red(stage_m[13].first, 1, 3));
		stage_i[14].enq(row_red(stage_m[13].first, 1, 3));
		stage_m[13].deq;		stage_i[13].deq;
	end rule

	rule stage15;	// r2 = r2 - a23*r3
		stage_m[15].enq(row_red(stage_m[14].first, 2, 3));
		stage_i[15].enq(row_red(stage_i[14].first, 2, 3));
		stage_m[14].deq;		stage_i[14].deq;
	end rule
	// fourth column setup complete
	//-----------------------------

//--------------------------------------------------------------------------//
//---------Start Interface Methods Definition here--------------------------//
//--------------------------------------------------------------------------//

	method Action push_data(MatrixVector d0);
		matrix_in.enq(d0);
	endmethod
	
	method ActionValue#(MatrixVector) get_data();
		stage_i[15].deq();
		stage_m[15].deq();
		return stage_i[15].first();
	endmethod

endmodule // mkBlockInverse

endpackage : Inv_Unit
