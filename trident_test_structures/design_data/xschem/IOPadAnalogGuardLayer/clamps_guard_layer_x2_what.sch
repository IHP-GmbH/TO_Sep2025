v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
T {proper guarding of the pad to guard transistors is required} 140 10 0 0 0.2 0.2 {}
N 120 60 220 60 {lab=VSS}
N 220 60 220 180 {lab=VSS}
N 120 90 120 120 {lab=guard}
N 120 120 120 150 {lab=guard}
N 120 210 120 240 {lab=VSS}
N 120 180 220 180 {lab=VSS}
N 220 180 220 240 {lab=VSS}
N 120 -60 220 -60 {lab=VDD}
N -160 -240 120 -240 {lab=VDD}
N 120 -240 120 -210 {lab=VDD}
N 120 240 220 240 {lab=VSS}
N -160 240 120 240 {lab=VSS}
N -140 120 120 120 {lab=guard}
N -140 -120 -140 120 {lab=guard}
N 120 -180 220 -180 {lab=VDD}
N 220 -240 220 -180 {lab=VDD}
N 120 -240 220 -240 {lab=VDD}
N -140 -120 120 -120 {lab=guard}
N 120 -120 120 -90 {lab=guard}
N 120 -150 120 -120 {lab=guard}
N -160 120 -140 120 {lab=guard}
N 120 0 120 30 {lab=pad}
N -70 0 120 0 {lab=pad}
N 120 -30 120 0 {lab=pad}
N 220 -180 220 -60 {lab=VDD}
N -50 -180 80 -180 {lab=#net1}
N -50 -60 80 -60 {lab=#net2}
N -50 60 80 60 {lab=#net3}
N -50 180 80 180 {lab=#net4}
C {sg13g2_pr/sg13_hv_nmos.sym} 100 60 0 0 {name=M5
l=600n
w=177.6u
ng=40
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 100 180 0 0 {name=M6
l=600n
w=177.6u
ng=40
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 100 -60 0 0 {name=M7
l=600n
w=266.4u
ng=40
m=2
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} -50 210 0 0 {name=R9
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} -50 90 0 0 {name=R10
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {iopin.sym} -160 240 2 0 {name=p5 lab=VSS}
C {iopin.sym} -160 -240 2 0 {name=p6 lab=VDD}
C {iopin.sym} -70 0 2 0 {name=p7 lab=pad
}
C {iopin.sym} -160 120 2 0 {name=p8 lab=guard}
C {sg13g2_pr/rppd.sym} -50 -90 0 0 {name=R11
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} -50 -210 0 0 {name=R12
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/sg13_hv_pmos.sym} 100 -180 0 0 {name=M8
l=600n
w=266.4u
ng=40
m=2
model=sg13_hv_pmos
spiceprefix=X
}
