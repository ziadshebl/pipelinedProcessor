vcom dataMem.vhd
vcom memory.vhd
vsim -gui work.main
# vsim -gui work.main 
# Start time: 05:03:48 on Jun 14,2021
# Loading std.standard
# Loading std.textio(body)
# Loading ieee.std_logic_1164(body)
# Loading ieee.numeric_std(body)
# Loading work.main(mainarch)
# Loading work.fetch(fetcharch)
# Loading work.pc(pcarch)
# Loading work.instructionmem(asyncinstructionmem)
# Loading work.fetchbuffer(fetchbufferarch)
# Loading work.decode(decodearch)
# Loading work.sp(sparch)
# Loading work.registeroutput(registeroutputarch)
# Loading work.ccr(ccrarch)
add wave -position insertpoint  \
sim:/main/d \
sim:/main/clk \
sim:/main/rst \
sim:/main/addHold \
sim:/main/ret \
sim:/main/branch \
sim:/main/rdstBDecode \
sim:/main/rdstWB \
sim:/main/branchNop \
sim:/main/loadUseStall \
sim:/main/zeroFlagWB \
sim:/main/negFlagWB \
sim:/main/carryFlagWB \
sim:/main/controlSignalsWB \
sim:/main/writeRegisterWB \
sim:/main/writeDataWB \
sim:/main/nopOut \
sim:/main/pcOut \
sim:/main/controlSignalsCU \
sim:/main/zeroFlagOut \
sim:/main/negFlagOut \
sim:/main/carryFlagOut \
sim:/main/rscrDataOut \
sim:/main/rdstDataOut \
sim:/main/extendImmOut \
sim:/main/shamtOut \
sim:/main/rscrOut \
sim:/main/rdstOut \
sim:/main/spOut \
sim:/main/pcValueSignalFromFetch \
sim:/main/instrValueSignalFromFetch \
sim:/main/nopOutFromFetchBuffer \
sim:/main/pcOutFromFetchBuffer \
sim:/main/decodeModule/regOutModule/Registers \
sim:/main/instrOutFromFetchBuffer
mem load -i {D:/8/Computer Arch/Project/Phase 2/output.mem} -format binary /main/fetchModule/instr/ram
force -freeze sim:/main/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/rst 1 0
force -freeze sim:/main/addHold 0 0
force -freeze sim:/main/ret 0 0
force -freeze sim:/main/branch 0 0
force -freeze sim:/main/rdstBDecode 16#0F0F0F0F 0
force -freeze sim:/main/rdstWB 16#F0F0F0F0 0
force -freeze sim:/main/branchNop 0 0
force -freeze sim:/main/loadUseStall 0 0
force -freeze sim:/main/zeroFlagWB 1 0
force -freeze sim:/main/negFlagWB 0 0
force -freeze sim:/main/carryFlagWB 1 0
force -freeze sim:/main/controlSignalsWB 16#00000 0
force -freeze sim:/main/writeRegisterWB 001 0
force -freeze sim:/main/writeDataWB 16#5a5a5a5a 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/decodeModule/regOutModule
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/decodeModule/regOutModule
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/fetchModule/instr
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/fetchModule/instr
force -freeze sim:/main/rst 0 0
run
force -freeze sim:/main/writeRegisterWB 010 0
run
force -freeze sim:/main/writeRegisterWB 100 0
run
force -freeze sim:/main/rst 1 0
run
force -freeze sim:/main/rst 0 0
force -freeze sim:/main/addHold 1 0
force -freeze sim:/main/loadUseStall 1 0
run
force -freeze sim:/main/addHold 0 0
force -freeze sim:/main/loadUseStall 0 0
force -freeze sim:/main/writeRegisterWB 000 0
run
run