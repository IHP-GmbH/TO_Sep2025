v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
T {proper guarding of the pad to guard transistors is required} 120 10 0 0 0.2 0.2 {}
N 100 60 200 60 {lab=VSS}
N 200 60 200 180 {lab=VSS}
N 100 90 100 120 {lab=guard}
N 100 120 100 150 {lab=guard}
N 100 210 100 240 {lab=VSS}
N 100 180 200 180 {lab=VSS}
N 200 180 200 240 {lab=VSS}
N 100 -60 200 -60 {lab=VDD}
N -180 -240 100 -240 {lab=VDD}
N 100 -240 100 -210 {lab=VDD}
N 100 240 200 240 {lab=VSS}
N -180 240 100 240 {lab=VSS}
N -160 120 100 120 {lab=guard}
N -160 -120 -160 120 {lab=guard}
N 100 -180 200 -180 {lab=VDD}
N 200 -240 200 -180 {lab=VDD}
N 100 -240 200 -240 {lab=VDD}
N -160 -120 100 -120 {lab=guard}
N 100 -120 100 -90 {lab=guard}
N 100 -150 100 -120 {lab=guard}
N -180 120 -160 120 {lab=guard}
N 100 0 100 30 {lab=pad}
N -90 0 100 0 {lab=pad}
N 100 -30 100 0 {lab=pad}
N 200 -180 200 -60 {lab=VDD}
N -120 -180 60 -180 {lab=#net1}
N -120 -60 60 -60 {lab=#net2}
N -120 180 60 180 {lab=#net3}
N -120 60 60 60 {lab=#net4}
C {sg13g2_pr/sg13_hv_nmos.sym} 80 60 0 0 {name=M1
l=600n
w=176u
ng=20
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_nmos.sym} 80 180 0 0 {name=M3
l=600n
w=176u
ng=20
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} 80 -60 0 0 {name=M2
l=600n
w=532u
ng=40
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} -70 210 0 0 {name=R1
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} -70 90 0 0 {name=R2
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {iopin.sym} -180 240 2 0 {name=p1 lab=VSS}
C {iopin.sym} -180 -240 2 0 {name=p2 lab=VDD}
C {iopin.sym} -90 0 2 0 {name=p3 lab=pad
}
C {iopin.sym} -180 120 2 0 {name=p4 lab=guard}
C {sg13g2_pr/rppd.sym} -70 -90 0 0 {name=R3
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} -70 -210 0 0 {name=R4
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/sg13_hv_pmos.sym} 80 -180 0 0 {name=M4
l=600n
w=532u
ng=40
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} -120 -90 0 0 {name=R5
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} -120 -210 0 0 {name=R6
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} -120 90 0 0 {name=R7
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/rppd.sym} -120 210 0 0 {name=R8
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
