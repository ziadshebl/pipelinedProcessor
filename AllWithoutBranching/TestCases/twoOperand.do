vcom ControlUnit.vhd
vcom dataMem.vhd
vcom decodeBuffer.vhd
vcom execBuffer.vhd
vcom fetchBuffer.vhd
vcom flagHandler.vhd
vcom ForwardingUnit.vhd
vcom hazardDetectionUnit.vhd
vcom instructionMem.vhd
vcom memBuffer.vhd
vcom registersOutput.vhd
vcom fetch.vhd
vcom decode.vhd
vcom exec.vhd
vcom memory.vhd
vcom main.vhd
vsim -gui work.main
# vsim -gui work.main 
# Start time: 02:10:44 on Jun 15,2021
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
mem load -i {D:/8/Computer Arch/Project/Phase 2/twoOperand.mem} /main/fetchModule/instr/ram
add wave -position insertpoint  \
sim:/main/clk \
sim:/main/rst \
sim:/main/addHold \
sim:/main/branch \
sim:/main/branchNop \
sim:/main/loadUseStall \
sim:/main/nopHazardDetectionToDecode \
sim:/main/inport \

add wave -position insertpoint  \
sim:/main/writeBackAfterMux
add wave -position insertpoint  \
sim:/main/memDataWB
add wave -position insertpoint  \
sim:/main/aluResultWB
add wave -position insertpoint  \
sim:/main/rdstWB
add wave -position insertpoint  \
sim:/main/controlSignalsWB
add wave -position insertpoint  \
sim:/main/pcValueSignalFromFetch
add wave -position insertpoint  \
sim:/main/instrValueSignalFromFetch
add wave -position insertpoint  \
sim:/main/rscrOutFromDecode

add wave -position insertpoint  \
sim:/main/rdstOutFromDecode

add wave -position insertpoint  \
sim:/main/decodeModule/regOutModule/Registers

add wave -position insertpoint  \
sim:/main/decodeModule/ccrModule/zeroFlagOut \
sim:/main/decodeModule/ccrModule/negFlagOut \
sim:/main/decodeModule/ccrModule/carryFlagOut



add wave -position insertpoint  \
sim:/main/execModule/operand1Alu

add wave -position insertpoint  \
sim:/main/execModule/operand2Alu

add wave -position insertpoint  \
sim:/main/decodeModule/spModule/outSP

add wave -position insertpoint  \
sim:/main/memoryModule/addressSignal

add wave -position insertpoint  \
sim:/main/controlSignalsCUFromDecode

add wave -position insertpoint  \
sim:/main/controlSignalsFromDecBuffer

add wave -position insertpoint  \
sim:/main/controlSignalsFromExec

add wave -position insertpoint  \
sim:/main/controlSignalsFromExecBuffer

add wave -position insertpoint  \
sim:/main/controlSignalsFromMem

add wave -position insertpoint  \
sim:/main/controlSignalsWB


force -freeze sim:/main/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/rst 1 0
force -freeze sim:/main/addHold 0 0
force -freeze sim:/main/branch 0 0
force -freeze sim:/main/branchNop 0 0
force -freeze sim:/main/loadUseStall 0 0
force -freeze sim:/main/nopHazardDetectionToDecode 0 0
force -freeze sim:/main/inport 16#5 0
run
force -freeze sim:/main/rst 0 0
run
force -freeze sim:/main/inport 16#19 0
run
force -freeze sim:/main/inport 16#FFFFFFFF 0
run
force -freeze sim:/main/inport 16#FFFFF320 0
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
run
run
run


