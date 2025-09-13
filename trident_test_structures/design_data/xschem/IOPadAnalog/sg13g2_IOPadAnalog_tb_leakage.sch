v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -260 20 -210 20 {lab=GND}
N -920 -50 -920 -30 {lab=vdd}
N -260 0 -210 0 {lab=#net1}
N 90 -20 120 -20 {lab=vout}
N -210 20 -210 60 {lab=GND}
N -420 -0 -320 -0 {lab=#net2}
N -420 60 -380 60 {lab=GND}
C {gnd.sym} -260 20 0 0 {name=l1 lab=GND}
C {vsource.sym} -920 0 0 0 {name=V1 value=1.2 savecurrent=false}
C {gnd.sym} -920 30 0 0 {name=l2 lab=GND
value=1.2}
C {lab_pin.sym} -920 -50 0 0 {name=p1 sig_type=std_logic lab=vdd
value=1.2}
C {lab_pin.sym} -210 -20 0 0 {name=p2 sig_type=std_logic lab=vdd}
C {gnd.sym} -420 60 0 0 {name=Vin lab=GND
value=1}
C {simulator_commands_shown.sym} -950 -230 0 0 {
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
C {simulator_commands_shown.sym} -1010 160 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.include /foss/pdks/ihp-sg13g2/libs.ref/sg13g2_io/spice/sg13g2_io.spi
.OPTION ABSTOL=0.01f
.OPTION GMIN=10e-15
.param temp=27
.control
save all
op
dc Vin1 -0.2 1.4 0.001
plot ABS(I(Vd)) ylog
plot ABS(I(v.x1.Vpad_nclamp)+I(v.x1.Vpad_pclamp))
plot ABS(I(v.x1.Vpad_dcndiode)+ I(v.x1.Vpad_dcpdiode))
plot ABS(I(v.x1.Vpad_secprot))

write sg13g2_IOPadAnalog_tb.raw
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
"}
C {capa.sym} 120 10 0 0 {name=C1
m=1
value=1p
footprint=1206
device="ceramic capacitor"}
C {gnd.sym} 120 40 0 0 {name=l5 lab=GND
value=1.2}
C {lab_pin.sym} 120 -20 2 0 {name=p5 sig_type=std_logic lab=vout}
C {sg13g2_IOPadAnalog.sym} -60 20 0 0 {name=x1}
C {sg13g2_pr/sub.sym} -320 60 0 0 {name=l4 lab=sub!}
C {res.sym} -350 60 1 0 {name=R1
value=15
footprint=1206
device=resistor
m=1}
C {vsource.sym} -420 30 0 0 {name=Vin1 value=3 savecurrent=false}
