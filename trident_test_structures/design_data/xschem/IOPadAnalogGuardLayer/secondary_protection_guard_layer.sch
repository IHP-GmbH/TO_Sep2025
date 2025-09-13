v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
T {Shorting ptap1 to allow lvs to do its job
Note: LVS may fail as xschem truncates its numbers output and klayout expects a perfect match} -250 300 0 0 0.2 0.2 {}
N 40 90 40 120 {lab=pad_guard}
N 40 120 40 150 {lab=pad_guard}
N 40 210 40 240 {lab=iovss}
N 40 0 200 -0 {lab=padres}
N 40 0 40 30 {lab=padres}
N -50 -0 40 0 {lab=padres}
N -180 -0 -110 0 {lab=pad}
N -270 -120 -270 120 {lab=pad_guard}
N 40 -120 40 -90 {lab=pad_guard}
N 40 -30 40 -0 {lab=padres}
N 40 -150 40 -120 {lab=pad_guard}
N 40 -240 40 -210 {lab=iovdd}
N -290 120 -270 120 {lab=pad_guard}
N -270 -120 40 -120 {lab=pad_guard}
N -310 -240 40 -240 {lab=iovdd}
N -270 120 40 120 {lab=pad_guard}
N -340 240 40 240 {lab=iovss}
N -300 300 -300 320 {lab=iovss}
N -340 320 -300 320 {lab=iovss}
N -340 240 -340 320 {lab=iovss}
N -380 240 -340 240 {lab=iovss}
C {iopin.sym} -380 240 2 0 {name=p1 lab=iovss
}
C {iopin.sym} -310 -240 2 0 {name=p2 lab=iovdd
}
C {iopin.sym} -180 0 2 0 {name=p3 lab=pad
}
C {iopin.sym} -290 120 2 0 {name=p4 lab=pad_guard
}
C {sg13g2_pr/rppd.sym} -80 0 1 0 {name=R1
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
C {sg13g2_pr/ptap1.sym} -300 270 0 0 {name=R2
model=ptap1
spiceprefix=X
w=1.3531236606282617e-5
l=3.4876339371738226173e-7
}
C {sg13g2_pr/sub.sym} -300 320 0 0 {name=l1 lab=sub!}
