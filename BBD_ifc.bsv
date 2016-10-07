package BBD_ifc;

	import Vector::*;

	typedef Int#(16) MemAddress;
	typedef Bit#(32) MemData;
	typedef Bit#(8) MatrixValue;
//	Integer vector_size = 16*8;
	typedef Bit#(128)  Matrix;
	typedef Vector#(16, MatrixValue) MatrixVector;


	interface BBD_IFC;
//		method MemAddress address();
		method Action push_data (MemData d0);
		method ActionValue#(MemData) get_data();
	endinterface

	interface MATINV_IFC;
		method Action push_data (MatrixVector d1);
	endinterface

	interface MATMULT_IFC;
		method Action push_data_d0 (MatrixVector d0);
		method Action push_data_d1 (MatrixVector d1);
		method ActionValue#(MatrixVector) get_data();
	endinterface

endpackage
