v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -270 70 -140 70 {lab=GND}
N -920 -50 -920 -30 {lab=vdd}
N -350 0 -320 -0 {lab=#net1}
N -260 0 -130 0 {lab=#net2}
N 160 -20 190 -20 {lab=vout}
N -620 -20 -350 -20 {lab=#net1}
N -350 -20 -350 -0 {lab=#net1}
N -210 -20 -140 -20 {lab=vdd}
N -480 40 -460 40 {lab=sub!}
N -620 40 -540 40 {lab=GND}
N -140 20 -140 70 {lab=GND}
C {gnd.sym} -270 70 0 0 {name=l1 lab=GND}
C {vsource.sym} -920 0 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} -920 30 0 0 {name=l2 lab=GND
value=1.2}
C {lab_pin.sym} -920 -50 0 0 {name=p1 sig_type=std_logic lab=vdd
value=1.2}
C {lab_pin.sym} -210 -20 0 0 {name=p2 sig_type=std_logic lab=vdd}
C {simulator_commands_shown.sym} -940 -230 0 0 {
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
C {simulator_commands_shown.sym} -1010 120 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_io/spice/sg13g2_io.spi
.OPTION ABSTOL=0.01f
.param temp=27
.control
save all
op
DC Iin 10n 10m 1u
*plot v(vc)
*plot v(vin)
plot v(vout) xlog

write IOPadAnalog_tb_overcurrent.raw
.endc
"}
C {devices/ammeter.sym} -290 0 1 0 {name=Vd}
C {launcher.sym} -360 -190 0 0 {name=h3
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
C {devices/code_shown.sym} -970 -340 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include $::SG13G2_MODELS/diodes.lib
.include $::SG13G2_MODELS/sg13g2_esd.lib
"}
C {capa.sym} 190 10 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 190 40 0 0 {name=l5 lab=GND
value=1.2}
C {lab_pin.sym} 190 -20 2 0 {name=p5 sig_type=std_logic lab=vout}
C {gnd.sym} -620 40 0 0 {name=l4 lab=GND
value=1.2}
C {res.sym} -510 40 3 0 {name=R3
value=15
footprint=1206
device=resistor
m=1}
C {sg13g2_pr/sub.sym} -460 40 0 0 {name=l3 lab=sub!}
C {isource.sym} -620 10 2 0 {name=Iin value=1m}
C {res.sym} -580 10 0 0 {name=R1
value=100T
footprint=1206
device=resistor
m=1}
C {sg13g2_IOPadAnalog.sym} 10 20 0 0 {name=x1}
