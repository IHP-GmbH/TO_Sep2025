v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 90 40 120 {lab=guard}
N 40 120 40 150 {lab=guard}
N 40 210 40 240 {lab=VSS}
N 40 0 200 -0 {lab=padres}
N 40 0 40 30 {lab=padres}
N -390 -120 -390 120 {lab=guard}
N 40 -120 40 -90 {lab=guard}
N 40 -30 40 -0 {lab=padres}
N 40 -150 40 -120 {lab=guard}
N 40 -240 40 -210 {lab=VDD}
N -410 120 -390 120 {lab=guard}
N -30 -120 40 -120 {lab=guard}
N -260 -180 -130 -180 {lab=#net1}
N -90 -240 -90 -210 {lab=VDD}
N -30 -240 -30 -180 {lab=VDD}
N -90 -150 -90 -120 {lab=guard}
N -30 -240 40 -240 {lab=VDD}
N -90 -180 -30 -180 {lab=VDD}
N -310 -240 -90 -240 {lab=VDD}
N -30 180 -30 240 {lab=VSS}
N -260 180 -130 180 {lab=#net2}
N -90 120 -90 150 {lab=guard}
N -390 120 -90 120 {lab=guard}
N -90 210 -90 240 {lab=VSS}
N -380 240 -90 240 {lab=VSS}
N -320 0 -290 -0 {lab=pad}
N -30 60 -30 120 {lab=guard}
N -260 60 -130 60 {lab=#net3}
N -30 120 40 120 {lab=guard}
N -90 90 -90 120 {lab=guard}
N -230 -0 -90 0 {lab=padres}
N -90 0 40 0 {lab=padres}
N -260 -60 -130 -60 {lab=#net4}
N -90 -120 -90 -90 {lab=guard}
N -30 -120 -30 -60 {lab=guard}
N -90 -120 -30 -120 {lab=guard}
N -90 -60 -30 -60 {lab=guard}
N -390 -120 -90 -120 {lab=guard}
N -90 0 -90 30 {lab=padres}
N -90 -30 -90 0 {lab=padres}
N -90 -240 -30 -240 {lab=VDD}
N -30 240 40 240 {lab=VSS}
N -90 60 -30 60 {lab=guard}
N -90 120 -30 120 {lab=guard}
N -90 180 -30 180 {lab=VSS}
N -90 240 -30 240 {lab=VSS}
C {iopin.sym} -380 240 2 0 {name=p1 lab=VSS}
C {iopin.sym} -310 -240 2 0 {name=p2 lab=VDD}
C {iopin.sym} -320 0 2 0 {name=p3 lab=pad
}
C {iopin.sym} -410 120 2 0 {name=p4 lab=guard}
C {sg13g2_pr/rppd.sym} -260 0 1 0 {name=R1
w=1e-6
l=2e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {iopin.sym} 200 0 0 0 {name=p5 lab=padres
}
C {sg13g2_pr/dantenna.sym} 40 60 0 0 {name=D7
model=dantenna
l=3.1u
w=0.64u
spiceprefix=X
}
C {sg13g2_pr/dantenna.sym} 40 180 0 0 {name=D1
model=dantenna
l=3.1u
w=0.64u
spiceprefix=X
}
C {sg13g2_pr/dpantenna.sym} 40 -60 0 0 {name=D2
model=dpantenna
l=0.64u
w=4.98u
spiceprefix=X
}
C {sg13g2_pr/dpantenna.sym} 40 -180 0 0 {name=D3
model=dpantenna
l=0.64u
w=4.98u
spiceprefix=X
}
C {sg13g2_pr/sg13_hv_pmos.sym} -110 -180 0 0 {name=M2
l=0.6u
w=10u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} -260 -210 0 0 {name=R3
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/sg13_hv_nmos.sym} -110 180 0 0 {name=M3
l=0.6u
w=10u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} -260 210 0 0 {name=R2
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/sg13_hv_nmos.sym} -110 60 0 0 {name=M1
l=0.6u
w=10u
ng=1
m=1
model=sg13_hv_nmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} -260 90 0 0 {name=R4
w=0.5e-6
l=0.5e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
C {sg13g2_pr/sg13_hv_pmos.sym} -110 -60 0 0 {name=M4
l=0.6u
w=10u
ng=1
m=1
model=sg13_hv_pmos
spiceprefix=X
}
C {sg13g2_pr/rppd.sym} -260 -90 0 0 {name=R5
w=0.5e-6
l=3.54e-6
model=rppd
body=sub!
spiceprefix=X
b=0
m=1
}
