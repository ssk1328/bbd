package BBD_ifc;

	import Vector::*;

	typedef Int#(16) MemAddress;
	typedef Bit#(32) MemData;
	typedef Bit#(8) MatrixValue;
//	Integer vector_size = 16*8;
	typedef Bit#(128)  Matrix;
//	typedef Vector#(16, MatrixValue) MatrixVector;


	interface BBD_IFC;
//		method MemAddress address();
		method Action push_data (MemData d1);
	endinterface

	interface MATINV_IFC;
		method Action push_data (Matrix d1);
	endinterface

endpackage