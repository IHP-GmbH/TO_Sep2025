v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N -60 -0 -0 -0 {lab=pad}
N -20 60 -20 80 {lab=iovss}
N -20 60 -0 60 {lab=iovss}
N -60 -60 -0 -60 {lab=iovdd}
N -60 80 -20 80 {lab=iovss}
N 140 -0 200 0 {lab=padres}
C {sg13g2_SecondaryProtection.sym} 80 0 0 0 {name=x1}
C {iopin.sym} -60 -60 2 0 {name=p6 lab=iovdd}
C {iopin.sym} -60 0 2 0 {name=p7 lab=pad}
C {iopin.sym} -60 40 2 0 {name=p8 lab=pad_guard}
C {iopin.sym} -60 80 2 0 {name=p9 lab=iovss}
C {iopin.sym} 200 0 0 0 {name=p10 lab=padres}
