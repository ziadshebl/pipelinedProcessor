vsim -gui work.main
# vsim -gui work.main 
# Start time: 02:32:17 on Jun 16,2021
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
# Loading work.controlunit(controlunitarch)
# Loading work.decodebuffer(decodebufferarch)
# Loading work.exec(execstagearch)
# Loading work.flaghandler(flaghandlerarch)
# Loading work.alu(arch)
# Loading work.execbuffer(execbufferarch)
# Loading work.memory(memoryarch)
# Loading work.datamem(asyncdatamem)
# Loading work.membuffer(membufferarch)
# Loading work.forwardingunit(forwardingunitarch)
# Loading work.hazarddetectionunit(asynchazarddetectionunit)
# Loading work.branchdetectionunit(branchdetectionunitarch)
add wave -position insertpoint  \
sim:/main/clk \
sim:/main/rst \
sim:/main/inport \
sim:/main/outPortRegister \
sim:/main/pcValueSignalFromFetch \
sim:/main/instrValueSignalFromFetch \
sim:/main/pcOutFromFetchBuffer \
sim:/main/pcOutFromDecode \
sim:/main/PCFromDecBuffer \
sim:/main/PCFromExec \
sim:/main/pcFromExecBuffer
add wave -position insertpoint  \
sim:/main/RdstDataFromExec
add wave -position insertpoint  \
sim:/main/decodeModule/spModule/outSP
add wave -position insertpoint  \
sim:/main/decodeModule/regOutModule/Registers
add wave -position insertpoint  \
sim:/main/controlSignalsCUFromDecode \
sim:/main/controlSignalsFromDecBuffer \
sim:/main/controlSignalsFromExec \
sim:/main/controlSignalsFromExecBuffer \
sim:/main/controlSignalsFromMem \
sim:/main/controlSignalsWB
add wave -position insertpoint  \
sim:/main/execModule/FUop1 \
sim:/main/execModule/FUop2 \
sim:/main/execModule/operand1Alu \
sim:/main/execModule/operand2Alu
add wave -position insertpoint  \
sim:/main/zeroFlagFromExec \
sim:/main/carryFlagFromExec \
sim:/main/negFlagFromExec
add wave -position insertpoint  \
sim:/main/zeroFlagOutFromDecode \
sim:/main/negFlagOutFromDecode \
sim:/main/carryFlagOutFromDecode
add wave -position insertpoint  \
sim:/main/ALUResultFromExec
add wave -position insertpoint  \
sim:/main/memDataWB \
sim:/main/aluResultWB \
sim:/main/writeBackAfterMux
add wave -position insertpoint  \
sim:/main/RDstDataFromDecBuffer
add wave -position insertpoint  \
sim:/main/addHold \
sim:/main/branchNop \
sim:/main/loadUseStall \
sim:/main/nopHazardDetectionToDecode \
sim:/main/branch
mem load -i {D:/8/Computer Arch/Project/Phase 2/branch.mem} /main/fetchModule/instr/ram
force -freeze sim:/main/rst 1 0
force -freeze sim:/main/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/inport 16#30 0
run
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/memoryModule/data
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/memoryModule/data
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/decodeModule/regOutModule
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/decodeModule/regOutModule
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/fetchModule/instr
# ** Warning: NUMERIC_STD.TO_INTEGER: metavalue detected, returning 0
#    Time: 0 ps  Iteration: 0  Instance: /main/fetchModule/instr
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 2  Instance: /main/execModule/alu
force -freeze sim:/main/rst 0 0
run
force -freeze sim:/main/inport 16#50 0
run
force -freeze sim:/main/inport 16#100 0
run
force -freeze sim:/main/inport 16#300 0
run
force -freeze sim:/main/inport 16#200 0
run
run
run
run
run
run
run
run
force -freeze sim:/main/zeroFlagFromExec 0 0
run
run
run
run
run
run
run
run
run
run
run




