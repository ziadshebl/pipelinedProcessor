vcom alu.vhd
vcom exec.vhd
vsim -gui work.exec
add wave -position insertpoint  \
sim:/exec/n \
sim:/exec/clk \
sim:/exec/rst \
sim:/exec/Rdst \
sim:/exec/shamtBuffer \
sim:/exec/controlSignalsBuffer \
sim:/exec/PCBuffer \
sim:/exec/SPBuffer \
sim:/exec/RDstDataBuffer \
sim:/exec/RSrcDataBuffer \
sim:/exec/ExtendedImmBuffer \
sim:/exec/inport \
sim:/exec/ALUResultFU \
sim:/exec/MemoryResultFU \
sim:/exec/FUop1 \
sim:/exec/FUop2 \
sim:/exec/controlSignalsOut \
sim:/exec/ALUResultOut \
sim:/exec/PCOut \
sim:/exec/SPOut \
sim:/exec/RdstDataOut \
sim:/exec/RdstOut \
sim:/exec/zeroFlag \
sim:/exec/carryFlag \
sim:/exec/negFlag \
sim:/exec/operand1Alu \
sim:/exec/operand2Alu \
sim:/exec/shamtSignalConcat \
sim:/exec/coutFlagAlu \
sim:/exec/zeroFlagAlu \
sim:/exec/negFlagAlu
force -freeze sim:/exec/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/exec/rst 1 0
force -freeze sim:/exec/Rdst 001 0
force -freeze sim:/exec/shamtBuffer 11100 0
force -freeze sim:/exec/controlSignalsBuffer 16#0 0
force -freeze sim:/exec/PCBuffer 16#1 0
force -freeze sim:/exec/SPBuffer 16#4 0
force -freeze sim:/exec/RDstDataBuffer 16#a 0
force -freeze sim:/exec/RSrcDataBuffer 16#1 0
force -freeze sim:/exec/ExtendedImmBuffer 16#3333 0
force -freeze sim:/exec/inport 16#0F0F0F0F 0
force -freeze sim:/exec/ALUResultFU 16#FFFFFFFF 0
force -freeze sim:/exec/MemoryResultFU 16#FFFF0000 0
force -freeze sim:/exec/FUop1 00 0
force -freeze sim:/exec/FUop2 00 0
run
# ** Warning: NUMERIC_STD."=": metavalue detected, returning FALSE
#    Time: 0 ps  Iteration: 1  Instance: /exec/alu
force -freeze sim:/exec/rst 0 0
run
force -freeze sim:/exec/controlSignalsBuffer(3) 1 0
force -freeze sim:/exec/controlSignalsBuffer(1) 1 0
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(1) 0 0
force -freeze sim:/exec/controlSignalsBuffer(0) 0 0
force -freeze sim:/exec/controlSignalsBuffer(2) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(2) 0 0
force -freeze sim:/exec/controlSignalsBuffer(3) 0 0
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(0) 0 0
force -freeze sim:/exec/controlSignalsBuffer(1) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(2) 1 0
force -freeze sim:/exec/controlSignalsBuffer(1) 0 0
force -freeze sim:/exec/controlSignalsBuffer(0) 0 0
run
force -freeze sim:/exec/controlSignalsBuffer(17) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(17) 0 0
force -freeze sim:/exec/controlSignalsBuffer(7) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(7) 0 0
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
force -freeze sim:/exec/RDstDataBuffer 16#FFFFFFFF 0
force -freeze sim:/exec/RSrcDataBuffer 16#5 0
run
force -freeze sim:/exec/controlSignalsBuffer(15) 1 0
force -freeze sim:/exec/RDstDataBuffer 16#1 0
force -freeze sim:/exec/ExtendedImmBuffer 16#6 0
run
force -freeze sim:/exec/controlSignalsBuffer(15) 0 0
force -freeze sim:/exec/controlSignalsBuffer(1) 1 0
force -freeze sim:/exec/controlSignalsBuffer(0) 0 0
force -freeze sim:/exec/RDstDataBuffer 16#5 0
run
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(3) 1 0
force -freeze sim:/exec/controlSignalsBuffer(2) 0 0
force -freeze sim:/exec/controlSignalsBuffer(1) 0 0
force -freeze sim:/exec/controlSignalsBuffer(0) 0 0
force -freeze sim:/exec/RDstDataBuffer 00000000000000000000000000000111 0
run
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
force -freeze sim:/exec/controlSignalsBuffer(16) 1 0
force -freeze sim:/exec/controlSignalsBuffer(15) 1 0
force -freeze sim:/exec/shamtBuffer 00010 0
run
force -freeze sim:/exec/controlSignalsBuffer(1) 1 0
force -freeze sim:/exec/controlSignalsBuffer(0) 0 0
run
force -freeze sim:/exec/controlSignalsBuffer(2) 1 0
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
force -freeze sim:/exec/controlSignalsBuffer(16) 0 0
force -freeze sim:/exec/controlSignalsBuffer(11) 1 0
force -freeze sim:/exec/controlSignalsBuffer(9) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(1) 0 0
run
force -freeze sim:/exec/controlSignalsBuffer(11) 0 0
force -freeze sim:/exec/controlSignalsBuffer(10) 1 0
force -freeze sim:/exec/controlSignalsBuffer(9) 0 0
force -freeze sim:/exec/ExtendedImmBuffer 16#0 0
force -freeze sim:/exec/RSrcDataBuffer 00000000000000000000000000000000 0
run
force -freeze sim:/exec/controlSignalsBuffer(1) 1 0
force -freeze sim:/exec/controlSignalsBuffer(0) 0 0
force -freeze sim:/exec/controlSignalsBuffer(15) 0 0
force -freeze sim:/exec/controlSignalsBuffer(16) 1 0
force -freeze sim:/exec/controlSignalsBuffer(6) 1 0
force -freeze sim:/exec/controlSignalsBuffer(5) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
force -freeze sim:/exec/controlSignalsBuffer(10) 0 0
force -freeze sim:/exec/controlSignalsBuffer(9) 1 0
force -freeze sim:/exec/controlSignalsBuffer(6) 0 0
run
force -freeze sim:/exec/controlSignalsBuffer(4) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(14) 1 0
force -freeze sim:/exec/controlSignalsBuffer(10) 1 0
force -freeze sim:/exec/controlSignalsBuffer(9) 0 0
force -freeze sim:/exec/controlSignalsBuffer(6) 1 0
force -freeze sim:/exec/controlSignalsBuffer(4) 0 0
force -freeze sim:/exec/controlSignalsBuffer(0) 0 0
run
force -freeze sim:/exec/FUop1 01 0
run
force -freeze sim:/exec/FUop2 01 0
run
force -freeze sim:/exec/FUop1 10 0
force -freeze sim:/exec/FUop2 10 0
run
force -freeze sim:/exec/FUop2 00 0
force -freeze sim:/exec/RDstDataBuffer 00000000000000000000000000000010 0
run
force -freeze sim:/exec/FUop2 10 0
force -freeze sim:/exec/ALUResultFU 16#2 0
run
force -freeze sim:/exec/controlSignalsBuffer(8) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(3) 0 0
force -freeze sim:/exec/controlSignalsBuffer(1) 0 0
force -freeze sim:/exec/controlSignalsBuffer(0) 1 0
run
force -freeze sim:/exec/controlSignalsBuffer(16) 0 0
force -freeze sim:/exec/controlSignalsBuffer(14) 0 0
force -freeze sim:/exec/controlSignalsBuffer(10) 0 0
force -freeze sim:/exec/controlSignalsBuffer(6) 0 0
force -freeze sim:/exec/controlSignalsBuffer(5) 0 0
run
force -freeze sim:/exec/RDstDataBuffer 00000000000000000000000000000000 0
run
force -freeze sim:/exec/FUop2 00 0
force -freeze sim:/exec/FUop1 00 0
run


