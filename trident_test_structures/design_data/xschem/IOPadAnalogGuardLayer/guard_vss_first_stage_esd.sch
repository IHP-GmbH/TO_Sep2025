v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
P 4 1 160 210 {}
N 120 0 120 30 {lab=pad_guard}
N 120 90 120 120 {lab=iovss}
N 120 60 220 60 {lab=sub!}
N -160 120 120 120 {lab=iovss}
N -160 0 120 0 {lab=pad_guard}
N -50 60 80 60 {lab=#net1}
N 150 260 150 270 {lab=sub!}
N 150 180 150 200 {lab=iovss}
N 400 0 570 0 {lab=pad_guard}
N 400 0 400 30 {lab=pad_guard}
N 330 60 370 60 {lab=iovdd}
N 400 90 400 120 {lab=iovss}
N 120 0 400 0 {lab=pad_guard}
N 120 120 400 120 {lab=iovss}
C {sg13g2_pr/sg13_hv_nmos.sym} 100 60 0 0 {name=M6
l=600n
w=177.6u
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
C {iopin.sym} -160 120 2 0 {name=p5 lab=iovss}
C {iopin.sym} -160 0 2 0 {name=p8 lab=pad_guard}
C {iopin.sym} -160 -60 2 0 {name=p2 lab=iovdd}
C {iopin.sym} -160 -110 2 0 {name=p1 lab=pad
}
C {sg13g2_pr/sub.sym} 220 60 0 0 {name=l1 lab=sub!}
C {sg13g2_pr/ptap1.sym} 150 230 0 0 {name=R1
model=ptap1
spiceprefix=X
w=0.78e-6
l=0.78e-6
}
C {sg13g2_pr/sub.sym} 150 270 0 0 {name=l2 lab=sub!}
C {lab_wire.sym} 150 180 0 0 {name=p3 sig_type=std_logic lab=iovss}
C {lab_wire.sym} 330 60 0 0 {name=p6 sig_type=std_logic lab=iovdd
}
C {sg13g2_pr/diodevss_4kv.sym} 400 60 0 0 {name=D5
model=diodevss_4kv
spiceprefix=X
m=1
}
