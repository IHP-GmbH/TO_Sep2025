v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 -30 -60 -30 {lab=GND}
N 40 60 40 80 {lab=GND}
N 120 0 140 0 {lab=GND}
N -220 0 -150 0 {lab=#net1}
N -90 0 -60 -0 {lab=#net2}
N 40 -110 40 -60 {lab=#net3}
N -80 -170 40 -170 {lab=drain}
C {simulator_commands_shown.sym} -740 -50 0 0 {
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
C {simulator_commands_shown.sym} -740 110 0 0 {name=SimulatorNGSPICE
simulator=ngspice
only_toplevel=false 
value="
.OPTION ABSTOL=0.01f
.param temp=27
.control
save all
op
DC Vgs -1 1 1m
plot I(Vdrain_to_source) ylog

write lv_nmos_min_size_guarded_tb_leakage_drain_to_source.raw
.endc
"}
C {vsource.sym} -80 -140 0 0 {name=Vdrain value=0.05 savecurrent=false}
C {gnd.sym} -80 -110 0 0 {name=Vgate1 lab=GND}
C {gnd.sym} -100 -30 0 0 {name=l2 lab=GND}
C {gnd.sym} 40 80 0 0 {name=Vgate2 lab=GND}
C {lab_pin.sym} -60 -170 1 0 {name=p1 sig_type=std_logic lab=drain
}
C {launcher.sym} -380 190 0 0 {name=h3
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
C {gnd.sym} 140 0 0 0 {name=Vgate3 lab=GND}
C {ammeter.sym} 40 -140 0 0 {name=Vdrain_to_source savecurrent=true spice_ignore=0}
C {vsource.sym} -220 30 0 0 {name=Vgs value=0.1 savecurrent=false}
C {gnd.sym} -220 60 0 0 {name=Vgate4 lab=GND}
C {ammeter.sym} -120 0 3 0 {name=Vmeasgate savecurrent=true spice_ignore=0}
C {lv_nmos_min_size_guarded.sym} 20 0 0 0 {name=x1}
