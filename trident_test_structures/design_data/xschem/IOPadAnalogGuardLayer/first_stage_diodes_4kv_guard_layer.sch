v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -180 240 0 240 {lab=VSS}
N 0 -200 0 -180 {lab=VDD}
N 0 0 -0 30 {lab=pad}
N -160 120 0 120 {lab=guard}
N 0 120 -0 150 {lab=guard}
N -180 120 -160 120 {lab=guard}
N -0 -100 0 -80 {lab=guard}
N -160 -100 -0 -100 {lab=guard}
N -0 -120 -0 -100 {lab=guard}
N -180 -200 0 -200 {lab=VDD}
N -70 60 -30 60 {lab=VDD}
N -70 180 -30 180 {lab=VDD}
N -70 -50 -30 -50 {lab=VSS}
N -70 -150 -30 -150 {lab=VSS}
N -0 210 0 240 {lab=VSS}
N -160 -100 -160 120 {lab=guard}
N -0 90 0 120 {lab=guard}
N -100 0 0 0 {lab=pad}
N 0 -20 0 0 {lab=pad}
C {iopin.sym} -180 240 2 0 {name=p1 lab=VSS}
C {iopin.sym} -180 -200 2 0 {name=p2 lab=VDD}
C {iopin.sym} -100 0 2 0 {name=p3 lab=pad
}
C {iopin.sym} -180 120 2 0 {name=p4 lab=guard}
C {lab_wire.sym} -70 60 0 0 {name=p5 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} -70 180 0 0 {name=p6 sig_type=std_logic lab=VDD
}
C {lab_wire.sym} -70 -50 0 0 {name=p7 sig_type=std_logic lab=VSS
}
C {lab_wire.sym} -70 -150 0 0 {name=p8 sig_type=std_logic lab=VSS
}
C {sg13g2_pr/diodevdd_4kv.sym} 0 -150 0 0 {name=D5
model=diodevdd_4kv
m=1
spiceprefix=X
}
C {sg13g2_pr/diodevdd_4kv.sym} 0 -50 0 0 {name=D3
model=diodevdd_4kv
m=1
spiceprefix=X
}
C {sg13g2_pr/diodevss_4kv.sym} 0 180 0 0 {name=D1
model=diodevss_4kv
spiceprefix=X
m=1
}
C {/run/host/mainData/cernbox/PhD/TO_Sep2025/trident_test_structures/design_data/xschem/idiodes/idiodevss_4kv.sym} 0 60 0 0 {name=D2
model=idiodevss_4kv
spiceprefix=X
m=1
}
