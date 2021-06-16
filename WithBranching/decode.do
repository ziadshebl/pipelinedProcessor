vsim -gui work.decode
add wave -position insertpoint  \
sim:/decode/d \
sim:/decode/clk \
sim:/decode/rst \
sim:/decode/nop \
sim:/decode/pc \
sim:/decode/instr \
sim:/decode/zeroFlagWB \
sim:/decode/negFlagWB \
sim:/decode/carryFlagWB \
sim:/decode/controlSignalsWB \
sim:/decode/writeRegisterWB \
sim:/decode/writeDataWB \
sim:/decode/nopOut \
sim:/decode/pcOut \
sim:/decode/controlSignalsCU \
sim:/decode/zeroFlagOut \
sim:/decode/negFlagOut \
sim:/decode/carryFlagOut \
sim:/decode/rscrDataOut \
sim:/decode/rdstDataOut \
sim:/decode/extendImmOut \
sim:/decode/shamtOut \
sim:/decode/rscrOut \
sim:/decode/rdstOut \
sim:/decode/spOut \
sim:/decode/inputSP \
sim:/decode/regOutModule/outPortRegister \
sim:/decode/outputSP
add wave -position insertpoint  \
sim:/decode/regOutModule/Registers
force -freeze sim:/decode/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/decode/rst 1 0
force -freeze sim:/decode/nop 0 0
force -freeze sim:/decode/pc 16#FFFFFFFF 0
force -freeze sim:/decode/pc 16#FFFFFFFE 0
force -freeze sim:/decode/instr 16#09090909 0
force -freeze sim:/decode/zeroFlagWB 1 0
force -freeze sim:/decode/negFlagWB 0 0
force -freeze sim:/decode/carryFlagWB 1 0
force -freeze sim:/decode/controlSignalsWB 16#00000 0
force -freeze sim:/decode/controlSignalsWB(5) 1 0
force -freeze sim:/decode/writeRegisterWB 001 0
force -freeze sim:/decode/writeDataWB 16#a0a0a0a0 0
run
force -freeze sim:/decode/rst 0 0
run
force -freeze sim:/decode/controlSignalsWB(7) 1 0
run
force -freeze sim:/decode/writeDataWB 16#0 0
run
force -freeze sim:/decode/controlSignalsWB(5) 0 0
force -freeze sim:/decode/writeDataWB 16#FFFFFFFF 0
run
force -freeze sim:/decode/zeroFlagWB 0 0
run
force -freeze sim:/decode/writeDataWB 16#0000FFFF 0
force -freeze sim:/decode/nop 1 0
run
force -freeze sim:/decode/controlSignalsWB(8) 1 0
force -freeze sim:/decode/writeDataWB 16#FFFF0000 0
run