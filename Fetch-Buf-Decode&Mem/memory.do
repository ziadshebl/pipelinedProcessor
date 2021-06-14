vcom dataMem.vhd
vcom memory.vhd
vsim -gui work.memory
add wave -position insertpoint  \
sim:/memory/d \
sim:/memory/clk \
sim:/memory/rst \
sim:/memory/zeroFlag \
sim:/memory/negFlag \
sim:/memory/carryFlag \
sim:/memory/rdst \
sim:/memory/rdstData \
sim:/memory/sp \
sim:/memory/pc \
sim:/memory/aluResult \
sim:/memory/controlSignals \
sim:/memory/zeroFlagOut \
sim:/memory/negFlagOut \
sim:/memory/carryFlagOut \
sim:/memory/rdstOut \
sim:/memory/aluResultOut \
sim:/memory/controlSignalsOut \
sim:/memory/memoryDataOut \
sim:/memory/addressSignal \
sim:/memory/writeDataSignal \
sim:/memory/memoryDataSignal
force -freeze sim:/memory/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/memory/zeroFlag 1 0
force -freeze sim:/memory/negFlag 0 0
force -freeze sim:/memory/carryFlag 1 0
force -freeze sim:/memory/rdst 101 0
force -freeze sim:/memory/rdstData 16#00001111 0
force -freeze sim:/memory/sp 16#00000001 0
force -freeze sim:/memory/pc 16#01010101 0
force -freeze sim:/memory/aluResult 16#00000004 0
force -freeze sim:/memory/controlSignals 16#00000 0
run
run
mem load -i {D:/8/Computer Arch/Project/Phase 2/output.mem} -format binary /memory/data/dataram
run
force -freeze sim:/memory/controlSignalsOut 000000000001000000 0
run
noforce sim:/memory/controlSignalsOut
force -freeze sim:/memory/controlSignals 000000000001000000 0
run
force -freeze sim:/memory/controlSignals 000000010001000000 0
run
force -freeze sim:/memory/controlSignals 000000010000000000 0
run
force -freeze sim:/memory/controlSignals(14) 1 0
run
force -freeze sim:/memory/controlSignals(6) 1 0
run

