v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -280 100 -150 100 {lab=GND}
N -920 -50 -920 -30 {lab=vdd}
N -350 0 -320 -0 {lab=#net1}
N -260 0 -130 0 {lab=vin}
N 90 0 120 0 {lab=vout}
N -620 -20 -350 -20 {lab=#net1}
N -350 -20 -350 -0 {lab=#net1}
N -200 -80 -130 -80 {lab=vdd}
N -180 40 -160 40 {lab=#net2}
N -160 30 -160 40 {lab=#net2}
N -150 80 -150 100 {lab=GND}
N -150 80 -130 80 {lab=GND}
N -280 40 -240 40 {lab=guard}
N -160 30 -130 30 {lab=#net2}
N -480 40 -460 40 {lab=sub!}
N -620 40 -540 40 {lab=GND}
N -820 -50 -820 -30 {lab=vss}
C {gnd.sym} -280 100 0 0 {name=l1 lab=GND}
C {vsource.sym} -920 0 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} -920 30 0 0 {name=l2 lab=GND
value=1.2}
C {lab_pin.sym} -920 -50 0 0 {name=p1 sig_type=std_logic lab=vdd
value=1.2}
C {lab_pin.sym} -200 -80 0 0 {name=p2 sig_type=std_logic lab=vdd}
C {simulator_commands_shown.sym} -1000 -220 0 0 {
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
C {simulator_commands_shown.sym} -1000 130 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.OPTION ABSTOL=0.01f
.param temp=27
.control
save all
op
DC Iin 10n 10m 0.01m
*plot v(vc)
plot v(vin)
plot v(guard)
plot v(vout) xlog
plot v(guard)
plot I(v.x1.vsec_vdd)+I(v.x1.vsec_vss)
plot ABS(I(Vd)) ylog
*plot ABS(I(v.x1.vfirstdiodes)) ylog
*plot ABS(I(v.x1.vclamps)) ylog
*plot ABS(I(v.x1.vsec)) ylog

write IOPadAnalogGuardLayer_tb_overcurrent.raw
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
C {devices/code_shown.sym} -1000 -350 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value="
.include $::SG13G2_MODELS/diodes.lib
.include $::SG13G2_MODELS/sg13g2_esd.lib
.include ../../idiodes/sg13g2_esd_idiodes.lib
"}
C {capa.sym} 120 30 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 120 60 0 0 {name=l5 lab=GND
value=1.2}
C {lab_pin.sym} 120 0 2 0 {name=p5 sig_type=std_logic lab=vout}
C {gnd.sym} -620 40 0 0 {name=l4 lab=GND
value=1.2}
C {res.sym} -210 40 3 0 {name=R2
value=100
footprint=1206
device=resistor
m=1}
C {res.sym} -510 40 3 0 {name=R3
value=15
footprint=1206
device=resistor
m=1}
C {sg13g2_pr/sub.sym} -460 40 0 0 {name=l3 lab=sub!}
C {IOPadAnalogGuardLayer.sym} -10 0 0 0 {name=x1}
C {lab_pin.sym} -280 40 0 0 {name=p3 sig_type=std_logic lab=guard}
C {isource.sym} -620 10 2 0 {name=Iin value=1m}
C {res.sym} -580 10 0 0 {name=R1
value=100G
footprint=1206
device=resistor
m=1}
C {vsource.sym} -820 0 0 0 {name=V2 value=0 savecurrent=false}
C {gnd.sym} -820 30 0 0 {name=l6 lab=GND
value=1.2}
C {lab_pin.sym} -820 -50 0 0 {name=p4 sig_type=std_logic lab=vss
value=1.2}
C {bsource.sym} -280 70 0 0 {name=B1 VAR=V FUNC="\{ max( min( V(vout), V(vdd) ), V(vss) ) \}" m=1}
C {lab_pin.sym} -230 0 1 0 {name=p6 sig_type=std_logic lab=vin}
