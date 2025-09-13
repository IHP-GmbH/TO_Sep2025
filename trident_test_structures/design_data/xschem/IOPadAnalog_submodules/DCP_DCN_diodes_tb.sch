v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 400 -540 400 -520 {lab=vin}
N 750 -540 780 -540 {lab=vin}
N 660 -620 840 -620 {lab=#net1}
N 760 -460 840 -460 {lab=GND}
N 560 -540 560 -520 {lab=guard}
N 500 -510 520 -510 {lab=vin}
N 800 -520 840 -520 {lab=guard}
C {gnd.sym} 400 -460 0 0 {name=l3 lab=GND
value=1.2}
C {simulator_commands_shown.sym} 100 -790 0 0 {
name=Libs_Ngspice
simulator=ngspice
only_toplevel=false
value="
.lib cornerMOSlv.lib mos_tt
.lib cornerMOShv.lib mos_tt
.lib cornerHBT.lib hbt_typ
.lib cornerRES.lib res_typ
"
      }
C {simulator_commands_shown.sym} 40 -430 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.OPTION ABSTOL=0.01f
.param temp=27
.control
save all

dc vin 0.57 0.63 0.001
plot ABS(i(vd)) ylog

.endc
"}
C {lab_pin.sym} 400 -540 0 0 {name=p3 sig_type=std_logic lab=vin
value=1.2}
C {lab_pin.sym} 750 -540 0 0 {name=p4 sig_type=std_logic lab=vin}
C {devices/ammeter.sym} 810 -540 1 0 {name=Vd}
C {launcher.sym} 690 -750 0 0 {name=h3
descr=SimulateNGSPICE
tclcommand="
# Setup the default simulation commands if not already set up
# for example by already launched simulations.
set_sim_defaults
puts $sim(spice,1,cmd) 

# Change the Xyce command. In the spice category there are currently
# 5 commands (0, 1, 2, 3, 4). Command 3 is the Xyce batch
# you can get the number by querying $sim(spice,n)
set sim(spice,1,cmd) \{ngspice  \\"$N\\" -a\}

# change the simulator to be used (Xyce)
set sim(spice,default) 0

# Create FET and BIP .save file
mkdir -p $netlist_dir
write_data [save_params] $netlist_dir/[file rootname [file tail [xschem get current_name]]].save

# run netlist and simulation
xschem netlist
simulate
"}
C {devices/code_shown.sym} 80 -900 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include $::SG13G2_MODELS/diodes.lib
.include ../DCP_DCN_diodes.spice
"}
C {vsource.sym} 400 -490 0 0 {name=Vin value=0.6 savecurrent=false}
C {gnd.sym} 660 -560 0 0 {name=l2 lab=GND
value=1.2}
C {vsource.sym} 660 -590 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} 760 -460 0 0 {name=l1 lab=GND
value=1.2}
C {gnd.sym} 560 -460 0 0 {name=l4 lab=GND
value=1.2}
C {lab_pin.sym} 560 -540 0 0 {name=p1 sig_type=std_logic lab=guard
value=1.2}
C {vcvs.sym} 560 -490 0 0 {name=E1 value=1}
C {lab_pin.sym} 500 -510 3 0 {name=p2 sig_type=std_logic lab=vin
value=1.2}
C {gnd.sym} 520 -470 0 0 {name=l5 lab=GND
value=1.2}
C {lab_pin.sym} 800 -520 0 0 {name=p5 sig_type=std_logic lab=guard
value=1.2}
C {DCP_DCN_diodes.sym} 920 -540 0 0 {name=x1}
