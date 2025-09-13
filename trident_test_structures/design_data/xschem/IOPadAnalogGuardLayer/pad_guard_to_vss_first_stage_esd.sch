v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 120 0 120 30 {lab=pad}
N 120 90 120 120 {lab=pad_guard}
N -160 120 120 120 {lab=pad_guard}
N -160 0 120 0 {lab=pad}
N -50 60 80 60 {lab=#net1}
N 400 0 400 30 {lab=pad}
N 120 0 400 0 {lab=pad}
N 330 60 370 60 {lab=iovdd}
N 400 90 400 120 {lab=pad_guard}
N 120 120 400 120 {lab=pad_guard}
N 120 60 200 60 {lab=iovss}
C {sg13g2_pr/sg13_hv_nmos.sym} 100 60 0 0 {name=M6
l=600n
w=176u
ng=40
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} -50 90 0 0 {name=R9
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {iopin.sym} -160 220 2 0 {name=p5 lab=iovss
}
C {iopin.sym} -160 120 2 0 {name=p8 lab=pad_guard}
C {iopin.sym} -160 -60 2 0 {name=p2 lab=iovdd}
C {iopin.sym} -160 0 2 0 {name=p1 lab=pad
}
C {lab_wire.sym} 200 60 2 0 {name=p3 sig_type=std_logic lab=iovss
}
C {lab_wire.sym} 330 60 0 0 {name=p6 sig_type=std_logic lab=iovdd
}
C {/run/host/mainData/cernbox/PhD/TO_Sep2025/trident_test_structures/design_data/xschem/idiodes/idiodevss_4kv.sym} 400 60 0 0 {name=D1
model=idiodevss_4kv
spiceprefix=X
m=2
}
