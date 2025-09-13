v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -100 0 -60 0 {lab=padres}
N -440 0 -420 -0 {lab=pad}
N -440 -240 -440 0 {lab=pad}
N -440 -240 -420 -240 {lab=pad}
N -440 240 -420 240 {lab=pad}
N -360 240 -320 240 {lab=#net1}
N -600 -0 -440 0 {lab=pad}
N -440 -0 -440 240 {lab=pad}
N -360 -240 -320 -240 {lab=#net2}
N -360 0 -320 -0 {lab=#net3}
C {iopin.sym} -600 80 2 0 {name=p1 lab=VSS}
C {iopin.sym} -600 -80 2 0 {name=p2 lab=VDD}
C {iopin.sym} -600 0 2 0 {name=p3 lab=pad
}
C {iopin.sym} -600 40 2 0 {name=p4 lab=guard}
C {iopin.sym} -60 0 0 0 {name=p5 lab=padres}
C {lab_pin.sym} -320 -320 0 0 {name=p6 sig_type=std_logic lab=VDD
}
C {lab_pin.sym} -320 180 0 0 {name=p7 sig_type=std_logic lab=VDD
}
C {lab_pin.sym} -380 -80 0 0 {name=p8 sig_type=std_logic lab=VDD
}
C {lab_pin.sym} -320 -160 0 0 {name=p9 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} -380 80 0 0 {name=p10 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} -320 300 0 0 {name=p11 sig_type=std_logic lab=VSS
}
C {lab_pin.sym} -320 -220 0 0 {name=p12 sig_type=std_logic lab=guard

}
C {lab_pin.sym} -320 30 0 0 {name=p13 sig_type=std_logic lab=guard

}
C {lab_pin.sym} -320 260 0 0 {name=p14 sig_type=std_logic lab=guard

}
C {ammeter.sym} -390 -240 3 0 {name=Vfirstdiodes savecurrent=true spice_ignore=0}
C {ammeter.sym} -390 0 3 0 {name=Vsec savecurrent=true spice_ignore=0}
C {ammeter.sym} -390 240 3 0 {name=Vclamps savecurrent=true spice_ignore=0}
C {ammeter.sym} -350 -80 1 0 {name=Vsec_vdd savecurrent=true spice_ignore=0}
C {ammeter.sym} -350 80 3 0 {name=Vsec_vss savecurrent=true spice_ignore=0}
C {secondary_protection_guard_layer.sym} -200 0 0 0 {name=x1}
C {clamps_guard_layer_x2_what.sym} -240 240 0 0 {name=x3}
C {first_stage_diodes_8kv_guard_layer.sym} -240 -240 0 0 {name=x2}
