/*
 * Generated by Bluespec Compiler, version 2016.03.beta1 (build 34761, 2016-03-16)
 * 
 * On Thu Sep 29 17:14:31 IST 2016
 * 
 */

/* Generation options: keep-fires */
#ifndef __mkBBD_h__
#define __mkBBD_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"


/* Class declaration for the mkBBD module */
class MOD_mkBBD : public Module {
 
 /* Clock handles */
 private:
  tClock __clk_handle_0;
 
 /* Clock gate handles */
 public:
  tUInt8 *clk_gate[0];
 
 /* Instantiation parameters */
 public:
 
 /* Module state */
 public:
  MOD_Reg<tUInt32> INST_counter;
  MOD_Reg<tUInt32> INST_dataval;
  MOD_Fifo<tUInt32> INST_fifo_in;
  MOD_Reg<tUInt8> INST_matrix_vec_0;
  MOD_Reg<tUInt8> INST_matrix_vec_1;
  MOD_Reg<tUInt8> INST_matrix_vec_10;
  MOD_Reg<tUInt8> INST_matrix_vec_11;
  MOD_Reg<tUInt8> INST_matrix_vec_12;
  MOD_Reg<tUInt8> INST_matrix_vec_13;
  MOD_Reg<tUInt8> INST_matrix_vec_14;
  MOD_Reg<tUInt8> INST_matrix_vec_15;
  MOD_Reg<tUInt8> INST_matrix_vec_2;
  MOD_Reg<tUInt8> INST_matrix_vec_3;
  MOD_Reg<tUInt8> INST_matrix_vec_4;
  MOD_Reg<tUInt8> INST_matrix_vec_5;
  MOD_Reg<tUInt8> INST_matrix_vec_6;
  MOD_Reg<tUInt8> INST_matrix_vec_7;
  MOD_Reg<tUInt8> INST_matrix_vec_8;
  MOD_Reg<tUInt8> INST_matrix_vec_9;
  MOD_Reg<tUInt32> INST_row_select;
 
 /* Constructor */
 public:
  MOD_mkBBD(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
  tUInt8 PORT_EN_push_data;
  tUInt32 PORT_push_data_d1;
  tUInt8 PORT_RDY_push_data;
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_WILL_FIRE_push_data;
  tUInt8 DEF_WILL_FIRE_RL_matrix_in;
  tUInt8 DEF_CAN_FIRE_RL_matrix_in;
  tUInt8 DEF_CAN_FIRE_push_data;
 
 /* Local definitions */
 private:
 
 /* Rules */
 public:
  void RL_matrix_in();
 
 /* Methods */
 public:
  void METH_push_data(tUInt32 ARG_push_data_d1);
  tUInt8 METH_RDY_push_data();
 
 /* Reset routines */
 public:
  void reset_RST_N(tUInt8 ARG_rst_in);
 
 /* Static handles to reset routines */
 public:
 
 /* Pointers to reset fns in parent module for asserting output resets */
 private:
 
 /* Functions for the parent module to register its reset fns */
 public:
 
 /* Functions to set the elaborated clock id */
 public:
  void set_clk_0(char const *s);
 
 /* State dumping routine */
 public:
  void dump_state(unsigned int indent);
 
 /* VCD dumping routines */
 public:
  unsigned int dump_VCD_defs(unsigned int levels);
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkBBD &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkBBD &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkBBD &backing);
};

#endif /* ifndef __mkBBD_h__ */
