/*
 * Generated by Bluespec Compiler, version 2016.03.beta1 (build 34761, 2016-03-16)
 * 
 * On Fri Oct  7 22:57:30 IST 2016
 * 
 */

/* Generation options: keep-fires */
#ifndef __mkBBDTb_h__
#define __mkBBDTb_h__

#include "bluesim_types.h"
#include "bs_module.h"
#include "bluesim_primitives.h"
#include "bs_vcd.h"
#include "mkBBD.h"


/* Class declaration for the mkBBDTb module */
class MOD_mkBBDTb : public Module {
 
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
  MOD_Reg<tUInt32> INST_data_mem_0;
  MOD_Reg<tUInt32> INST_data_mem_0_1;
  MOD_Reg<tUInt32> INST_data_mem_1;
  MOD_Reg<tUInt32> INST_data_mem_10;
  MOD_Reg<tUInt32> INST_data_mem_100;
  MOD_Reg<tUInt32> INST_data_mem_101;
  MOD_Reg<tUInt32> INST_data_mem_102;
  MOD_Reg<tUInt32> INST_data_mem_103;
  MOD_Reg<tUInt32> INST_data_mem_104;
  MOD_Reg<tUInt32> INST_data_mem_105;
  MOD_Reg<tUInt32> INST_data_mem_106;
  MOD_Reg<tUInt32> INST_data_mem_107;
  MOD_Reg<tUInt32> INST_data_mem_108;
  MOD_Reg<tUInt32> INST_data_mem_109;
  MOD_Reg<tUInt32> INST_data_mem_11;
  MOD_Reg<tUInt32> INST_data_mem_110;
  MOD_Reg<tUInt32> INST_data_mem_111;
  MOD_Reg<tUInt32> INST_data_mem_112;
  MOD_Reg<tUInt32> INST_data_mem_113;
  MOD_Reg<tUInt32> INST_data_mem_114;
  MOD_Reg<tUInt32> INST_data_mem_115;
  MOD_Reg<tUInt32> INST_data_mem_116;
  MOD_Reg<tUInt32> INST_data_mem_117;
  MOD_Reg<tUInt32> INST_data_mem_118;
  MOD_Reg<tUInt32> INST_data_mem_119;
  MOD_Reg<tUInt32> INST_data_mem_12;
  MOD_Reg<tUInt32> INST_data_mem_120;
  MOD_Reg<tUInt32> INST_data_mem_121;
  MOD_Reg<tUInt32> INST_data_mem_122;
  MOD_Reg<tUInt32> INST_data_mem_123;
  MOD_Reg<tUInt32> INST_data_mem_124;
  MOD_Reg<tUInt32> INST_data_mem_125;
  MOD_Reg<tUInt32> INST_data_mem_126;
  MOD_Reg<tUInt32> INST_data_mem_127;
  MOD_Reg<tUInt32> INST_data_mem_128;
  MOD_Reg<tUInt32> INST_data_mem_129;
  MOD_Reg<tUInt32> INST_data_mem_13;
  MOD_Reg<tUInt32> INST_data_mem_130;
  MOD_Reg<tUInt32> INST_data_mem_131;
  MOD_Reg<tUInt32> INST_data_mem_132;
  MOD_Reg<tUInt32> INST_data_mem_133;
  MOD_Reg<tUInt32> INST_data_mem_134;
  MOD_Reg<tUInt32> INST_data_mem_135;
  MOD_Reg<tUInt32> INST_data_mem_136;
  MOD_Reg<tUInt32> INST_data_mem_137;
  MOD_Reg<tUInt32> INST_data_mem_138;
  MOD_Reg<tUInt32> INST_data_mem_139;
  MOD_Reg<tUInt32> INST_data_mem_14;
  MOD_Reg<tUInt32> INST_data_mem_140;
  MOD_Reg<tUInt32> INST_data_mem_141;
  MOD_Reg<tUInt32> INST_data_mem_142;
  MOD_Reg<tUInt32> INST_data_mem_143;
  MOD_Reg<tUInt32> INST_data_mem_144;
  MOD_Reg<tUInt32> INST_data_mem_145;
  MOD_Reg<tUInt32> INST_data_mem_146;
  MOD_Reg<tUInt32> INST_data_mem_147;
  MOD_Reg<tUInt32> INST_data_mem_148;
  MOD_Reg<tUInt32> INST_data_mem_149;
  MOD_Reg<tUInt32> INST_data_mem_15;
  MOD_Reg<tUInt32> INST_data_mem_150;
  MOD_Reg<tUInt32> INST_data_mem_151;
  MOD_Reg<tUInt32> INST_data_mem_152;
  MOD_Reg<tUInt32> INST_data_mem_153;
  MOD_Reg<tUInt32> INST_data_mem_154;
  MOD_Reg<tUInt32> INST_data_mem_155;
  MOD_Reg<tUInt32> INST_data_mem_156;
  MOD_Reg<tUInt32> INST_data_mem_157;
  MOD_Reg<tUInt32> INST_data_mem_158;
  MOD_Reg<tUInt32> INST_data_mem_159;
  MOD_Reg<tUInt32> INST_data_mem_16;
  MOD_Reg<tUInt32> INST_data_mem_160;
  MOD_Reg<tUInt32> INST_data_mem_161;
  MOD_Reg<tUInt32> INST_data_mem_162;
  MOD_Reg<tUInt32> INST_data_mem_163;
  MOD_Reg<tUInt32> INST_data_mem_164;
  MOD_Reg<tUInt32> INST_data_mem_165;
  MOD_Reg<tUInt32> INST_data_mem_166;
  MOD_Reg<tUInt32> INST_data_mem_167;
  MOD_Reg<tUInt32> INST_data_mem_168;
  MOD_Reg<tUInt32> INST_data_mem_169;
  MOD_Reg<tUInt32> INST_data_mem_17;
  MOD_Reg<tUInt32> INST_data_mem_170;
  MOD_Reg<tUInt32> INST_data_mem_171;
  MOD_Reg<tUInt32> INST_data_mem_172;
  MOD_Reg<tUInt32> INST_data_mem_173;
  MOD_Reg<tUInt32> INST_data_mem_174;
  MOD_Reg<tUInt32> INST_data_mem_175;
  MOD_Reg<tUInt32> INST_data_mem_176;
  MOD_Reg<tUInt32> INST_data_mem_177;
  MOD_Reg<tUInt32> INST_data_mem_178;
  MOD_Reg<tUInt32> INST_data_mem_179;
  MOD_Reg<tUInt32> INST_data_mem_18;
  MOD_Reg<tUInt32> INST_data_mem_180;
  MOD_Reg<tUInt32> INST_data_mem_181;
  MOD_Reg<tUInt32> INST_data_mem_182;
  MOD_Reg<tUInt32> INST_data_mem_183;
  MOD_Reg<tUInt32> INST_data_mem_184;
  MOD_Reg<tUInt32> INST_data_mem_185;
  MOD_Reg<tUInt32> INST_data_mem_186;
  MOD_Reg<tUInt32> INST_data_mem_187;
  MOD_Reg<tUInt32> INST_data_mem_188;
  MOD_Reg<tUInt32> INST_data_mem_189;
  MOD_Reg<tUInt32> INST_data_mem_19;
  MOD_Reg<tUInt32> INST_data_mem_190;
  MOD_Reg<tUInt32> INST_data_mem_191;
  MOD_Reg<tUInt32> INST_data_mem_192;
  MOD_Reg<tUInt32> INST_data_mem_193;
  MOD_Reg<tUInt32> INST_data_mem_194;
  MOD_Reg<tUInt32> INST_data_mem_195;
  MOD_Reg<tUInt32> INST_data_mem_196;
  MOD_Reg<tUInt32> INST_data_mem_197;
  MOD_Reg<tUInt32> INST_data_mem_198;
  MOD_Reg<tUInt32> INST_data_mem_199;
  MOD_Reg<tUInt32> INST_data_mem_1_1;
  MOD_Reg<tUInt32> INST_data_mem_2;
  MOD_Reg<tUInt32> INST_data_mem_20;
  MOD_Reg<tUInt32> INST_data_mem_200;
  MOD_Reg<tUInt32> INST_data_mem_201;
  MOD_Reg<tUInt32> INST_data_mem_202;
  MOD_Reg<tUInt32> INST_data_mem_203;
  MOD_Reg<tUInt32> INST_data_mem_204;
  MOD_Reg<tUInt32> INST_data_mem_205;
  MOD_Reg<tUInt32> INST_data_mem_206;
  MOD_Reg<tUInt32> INST_data_mem_207;
  MOD_Reg<tUInt32> INST_data_mem_208;
  MOD_Reg<tUInt32> INST_data_mem_209;
  MOD_Reg<tUInt32> INST_data_mem_21;
  MOD_Reg<tUInt32> INST_data_mem_210;
  MOD_Reg<tUInt32> INST_data_mem_211;
  MOD_Reg<tUInt32> INST_data_mem_212;
  MOD_Reg<tUInt32> INST_data_mem_213;
  MOD_Reg<tUInt32> INST_data_mem_214;
  MOD_Reg<tUInt32> INST_data_mem_215;
  MOD_Reg<tUInt32> INST_data_mem_216;
  MOD_Reg<tUInt32> INST_data_mem_217;
  MOD_Reg<tUInt32> INST_data_mem_218;
  MOD_Reg<tUInt32> INST_data_mem_219;
  MOD_Reg<tUInt32> INST_data_mem_22;
  MOD_Reg<tUInt32> INST_data_mem_220;
  MOD_Reg<tUInt32> INST_data_mem_221;
  MOD_Reg<tUInt32> INST_data_mem_222;
  MOD_Reg<tUInt32> INST_data_mem_223;
  MOD_Reg<tUInt32> INST_data_mem_224;
  MOD_Reg<tUInt32> INST_data_mem_225;
  MOD_Reg<tUInt32> INST_data_mem_226;
  MOD_Reg<tUInt32> INST_data_mem_227;
  MOD_Reg<tUInt32> INST_data_mem_228;
  MOD_Reg<tUInt32> INST_data_mem_229;
  MOD_Reg<tUInt32> INST_data_mem_23;
  MOD_Reg<tUInt32> INST_data_mem_230;
  MOD_Reg<tUInt32> INST_data_mem_231;
  MOD_Reg<tUInt32> INST_data_mem_232;
  MOD_Reg<tUInt32> INST_data_mem_233;
  MOD_Reg<tUInt32> INST_data_mem_234;
  MOD_Reg<tUInt32> INST_data_mem_235;
  MOD_Reg<tUInt32> INST_data_mem_236;
  MOD_Reg<tUInt32> INST_data_mem_237;
  MOD_Reg<tUInt32> INST_data_mem_238;
  MOD_Reg<tUInt32> INST_data_mem_239;
  MOD_Reg<tUInt32> INST_data_mem_24;
  MOD_Reg<tUInt32> INST_data_mem_240;
  MOD_Reg<tUInt32> INST_data_mem_241;
  MOD_Reg<tUInt32> INST_data_mem_242;
  MOD_Reg<tUInt32> INST_data_mem_243;
  MOD_Reg<tUInt32> INST_data_mem_244;
  MOD_Reg<tUInt32> INST_data_mem_245;
  MOD_Reg<tUInt32> INST_data_mem_246;
  MOD_Reg<tUInt32> INST_data_mem_247;
  MOD_Reg<tUInt32> INST_data_mem_248;
  MOD_Reg<tUInt32> INST_data_mem_249;
  MOD_Reg<tUInt32> INST_data_mem_25;
  MOD_Reg<tUInt32> INST_data_mem_250;
  MOD_Reg<tUInt32> INST_data_mem_251;
  MOD_Reg<tUInt32> INST_data_mem_252;
  MOD_Reg<tUInt32> INST_data_mem_253;
  MOD_Reg<tUInt32> INST_data_mem_254;
  MOD_Reg<tUInt32> INST_data_mem_255;
  MOD_Reg<tUInt32> INST_data_mem_26;
  MOD_Reg<tUInt32> INST_data_mem_27;
  MOD_Reg<tUInt32> INST_data_mem_28;
  MOD_Reg<tUInt32> INST_data_mem_29;
  MOD_Reg<tUInt32> INST_data_mem_2_1;
  MOD_Reg<tUInt32> INST_data_mem_3;
  MOD_Reg<tUInt32> INST_data_mem_30;
  MOD_Reg<tUInt32> INST_data_mem_31;
  MOD_Reg<tUInt32> INST_data_mem_32;
  MOD_Reg<tUInt32> INST_data_mem_33;
  MOD_Reg<tUInt32> INST_data_mem_34;
  MOD_Reg<tUInt32> INST_data_mem_35;
  MOD_Reg<tUInt32> INST_data_mem_36;
  MOD_Reg<tUInt32> INST_data_mem_37;
  MOD_Reg<tUInt32> INST_data_mem_38;
  MOD_Reg<tUInt32> INST_data_mem_39;
  MOD_Reg<tUInt32> INST_data_mem_3_1;
  MOD_Reg<tUInt32> INST_data_mem_4;
  MOD_Reg<tUInt32> INST_data_mem_40;
  MOD_Reg<tUInt32> INST_data_mem_41;
  MOD_Reg<tUInt32> INST_data_mem_42;
  MOD_Reg<tUInt32> INST_data_mem_43;
  MOD_Reg<tUInt32> INST_data_mem_44;
  MOD_Reg<tUInt32> INST_data_mem_45;
  MOD_Reg<tUInt32> INST_data_mem_46;
  MOD_Reg<tUInt32> INST_data_mem_47;
  MOD_Reg<tUInt32> INST_data_mem_48;
  MOD_Reg<tUInt32> INST_data_mem_49;
  MOD_Reg<tUInt32> INST_data_mem_4_1;
  MOD_Reg<tUInt32> INST_data_mem_5;
  MOD_Reg<tUInt32> INST_data_mem_50;
  MOD_Reg<tUInt32> INST_data_mem_51;
  MOD_Reg<tUInt32> INST_data_mem_52;
  MOD_Reg<tUInt32> INST_data_mem_53;
  MOD_Reg<tUInt32> INST_data_mem_54;
  MOD_Reg<tUInt32> INST_data_mem_55;
  MOD_Reg<tUInt32> INST_data_mem_56;
  MOD_Reg<tUInt32> INST_data_mem_57;
  MOD_Reg<tUInt32> INST_data_mem_58;
  MOD_Reg<tUInt32> INST_data_mem_59;
  MOD_Reg<tUInt32> INST_data_mem_6;
  MOD_Reg<tUInt32> INST_data_mem_60;
  MOD_Reg<tUInt32> INST_data_mem_61;
  MOD_Reg<tUInt32> INST_data_mem_62;
  MOD_Reg<tUInt32> INST_data_mem_63;
  MOD_Reg<tUInt32> INST_data_mem_64;
  MOD_Reg<tUInt32> INST_data_mem_65;
  MOD_Reg<tUInt32> INST_data_mem_66;
  MOD_Reg<tUInt32> INST_data_mem_67;
  MOD_Reg<tUInt32> INST_data_mem_68;
  MOD_Reg<tUInt32> INST_data_mem_69;
  MOD_Reg<tUInt32> INST_data_mem_7;
  MOD_Reg<tUInt32> INST_data_mem_70;
  MOD_Reg<tUInt32> INST_data_mem_71;
  MOD_Reg<tUInt32> INST_data_mem_72;
  MOD_Reg<tUInt32> INST_data_mem_73;
  MOD_Reg<tUInt32> INST_data_mem_74;
  MOD_Reg<tUInt32> INST_data_mem_75;
  MOD_Reg<tUInt32> INST_data_mem_76;
  MOD_Reg<tUInt32> INST_data_mem_77;
  MOD_Reg<tUInt32> INST_data_mem_78;
  MOD_Reg<tUInt32> INST_data_mem_79;
  MOD_Reg<tUInt32> INST_data_mem_8;
  MOD_Reg<tUInt32> INST_data_mem_80;
  MOD_Reg<tUInt32> INST_data_mem_81;
  MOD_Reg<tUInt32> INST_data_mem_82;
  MOD_Reg<tUInt32> INST_data_mem_83;
  MOD_Reg<tUInt32> INST_data_mem_84;
  MOD_Reg<tUInt32> INST_data_mem_85;
  MOD_Reg<tUInt32> INST_data_mem_86;
  MOD_Reg<tUInt32> INST_data_mem_87;
  MOD_Reg<tUInt32> INST_data_mem_88;
  MOD_Reg<tUInt32> INST_data_mem_89;
  MOD_Reg<tUInt32> INST_data_mem_9;
  MOD_Reg<tUInt32> INST_data_mem_90;
  MOD_Reg<tUInt32> INST_data_mem_91;
  MOD_Reg<tUInt32> INST_data_mem_92;
  MOD_Reg<tUInt32> INST_data_mem_93;
  MOD_Reg<tUInt32> INST_data_mem_94;
  MOD_Reg<tUInt32> INST_data_mem_95;
  MOD_Reg<tUInt32> INST_data_mem_96;
  MOD_Reg<tUInt32> INST_data_mem_97;
  MOD_Reg<tUInt32> INST_data_mem_98;
  MOD_Reg<tUInt32> INST_data_mem_99;
  MOD_mkBBD INST_dut;
  MOD_Reg<tUInt32> INST_x;
 
 /* Constructor */
 public:
  MOD_mkBBDTb(tSimStateHdl simHdl, char const *name, Module *parent);
 
 /* Symbol init methods */
 private:
  void init_symbols_0();
 
 /* Reset signal definitions */
 private:
  tUInt8 PORT_RST_N;
 
 /* Port definitions */
 public:
 
 /* Publicly accessible definitions */
 public:
  tUInt8 DEF_WILL_FIRE_RL_stop;
  tUInt8 DEF_CAN_FIRE_RL_stop;
  tUInt8 DEF_WILL_FIRE_RL_rule_data_out;
  tUInt8 DEF_CAN_FIRE_RL_rule_data_out;
  tUInt8 DEF_WILL_FIRE_RL_counter;
  tUInt8 DEF_CAN_FIRE_RL_counter;
  tUInt32 DEF_x__h24043;
 
 /* Local definitions */
 private:
 
 /* Rules */
 public:
  void RL_counter();
  void RL_rule_data_out();
  void RL_stop();
 
 /* Methods */
 public:
 
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
  void dump_VCD(tVCDDumpType dt, unsigned int levels, MOD_mkBBDTb &backing);
  void vcd_defs(tVCDDumpType dt, MOD_mkBBDTb &backing);
  void vcd_prims(tVCDDumpType dt, MOD_mkBBDTb &backing);
  void vcd_submodules(tVCDDumpType dt, unsigned int levels, MOD_mkBBDTb &backing);
};

#endif /* ifndef __mkBBDTb_h__ */
