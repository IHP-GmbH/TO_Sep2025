v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
T {This mix between shorting iovss and sub! as well as using a ptap makes no sense, but does to IHP IP I am required to do that for LVS.} 550 -220 0 0 0.4 0.4 {}
N 230 -70 230 -40 {lab=pad}
N 60 -200 60 -160 {lab=pad_guard}
N -160 -200 60 -200 {lab=pad_guard}
N 60 -100 190 -100 {lab=#net1}
N 230 -200 460 -200 {lab=pad_guard}
N 230 -200 230 -130 {lab=pad_guard}
N 60 -200 230 -200 {lab=pad_guard}
N 230 -40 460 -40 {lab=pad}
N -160 -40 230 -40 {lab=pad}
N 460 -110 460 -40 {lab=pad}
N 460 -200 460 -170 {lab=pad_guard}
N 400 -140 430 -140 {lab=iovss}
N 630 -180 630 -140 {lab=iovss}
N 630 -80 630 -60 {lab=sub!}
N 780 -180 780 -60 {lab=sub!}
N 320 -290 320 -100 {lab=iovdd}
N 230 -100 320 -100 {lab=iovdd}
C {iopin.sym} -160 120 2 0 {name=p5 lab=iovss}
C {iopin.sym} -160 -40 2 0 {name=p1 lab=pad
}
C {sg13g2_pr/sg13_hv_pmos.sym} 210 -100 0 0 {name=M7
l=600n
w=532.8u
ng=40
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} 60 -130 0 0 {name=R11
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/diodevdd_4kv.sym} 460 -140 0 0 {name=D1
model=diodevdd_4kv
m=2
spiceprefix=X
}
C {lab_pin.sym} 400 -140 0 0 {name=p3 sig_type=std_logic lab=iovss}
C {sg13g2_pr/ptap1.sym} 630 -110 0 0 {name=R1
model=ptap1
spiceprefix=X
w=1.968194e-4
l=3.4058835e-7
}
C {lab_pin.sym} 630 -180 0 0 {name=p4 sig_type=std_logic lab=iovss}
C {sg13g2_pr/sub.sym} 630 -60 0 0 {name=l1 lab=sub!}
C {sg13g2_pr/sub.sym} 780 -60 0 0 {name=l2 lab=sub!}
C {lab_pin.sym} 780 -180 0 0 {name=p6 sig_type=std_logic lab=iovss}
C {iopin.sym} -160 -200 2 0 {name=p2 lab=pad_guard}
C {iopin.sym} 320 -280 2 0 {name=p7 lab=iovdd}
