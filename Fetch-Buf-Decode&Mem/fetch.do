vcom PC.vhd
vcom instructionMem.vhd
vcom fetch.vhd
vsim -gui work.fetch
add wave -position insertpoint  \
sim:/fetch/d \
sim:/fetch/clk \
sim:/fetch/addHold \
sim:/fetch/ret \
sim:/fetch/branch \
sim:/fetch/rdstDecode \
sim:/fetch/rdstWB \
sim:/fetch/pcValue \
sim:/fetch/instrValue \
sim:/fetch/inputPC \
sim:/fetch/outputPC \
sim:/fetch/resetValue \
sim:/fetch/outputAdder \
sim:/fetch/inputAdder1 \
sim:/fetch/rst \
sim:/fetch/outputInstr
mem load -i {D:/8/Computer Arch/Project/Phase 2/output.mem} -format binary /fetch/instr/ram
force -freeze sim:/fetch/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fetch/addHold 0 0
force -freeze sim:/fetch/ret 0 0
force -freeze sim:/fetch/branch 0 0
force -freeze sim:/fetch/rdstDecode 16#01010101 0
force -freeze sim:/fetch/rdstWB 16#10101010 0
force -freeze sim:/fetch/rst 1 0
run
force -freeze sim:/fetch/rst 0 0
run
run
run
force -freeze sim:/fetch/rdstDecode 16#00000001 0
force -freeze sim:/fetch/branch 1 0
run
force -freeze sim:/fetch/branch 0 0
force -freeze sim:/fetch/ret 1 0
force -freeze sim:/fetch/rdstWB 16#00000004 0
run