package BBD_ifc;

	import Vector::*;

	typedef Int#(16) MemAddress;
	typedef Bit#(64) MemData;
	typedef Bit#(8) MatrixValue;
	typedef Vector#(16, MatrixValue) MatrixVector;


	interface BBD_IFC;
//		method MemAddress address();
		method Action push_data (MemData d0);
		method ActionValue#(MemData) get_data();
	endinterface

	interface MATINV_IFC;
		method Action push_data (MatrixVector d0);
		method ActionValue#(MatrixVector) get_data();
	endinterface

	interface MATMULT_IFC;
		method Action push_data_d0 (MatrixVector d0);
		method Action push_data_d1 (MatrixVector d1);
		method ActionValue#(MatrixVector) get_data();
	endinterface

	interface FUNIT_IFC;
		method Action push_A  (MatrixVector d0);
		method Action push_C  (MatrixVector d1);
		method Action push_B  (MatrixVector d2);
		method Action push_G  (MatrixVector d3);
		method MatrixVector get_sigma_B_test();
		method ActionValue#(MatrixVector) get_sigma_B();
		method ActionValue#(MatrixVector) get_sigma_G();
		method ActionValue#(MatrixVector) get_Ai();

	endinterface

endpackage
