v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 160 100 160 {lab=iovss}
N -90 -0 -0 -0 {lab=pad}
N -0 -0 0 100 {lab=pad}
N -0 100 100 100 {lab=pad}
N 0 -100 -0 -0 {lab=pad}
N 0 -100 100 -100 {lab=pad}
N 60 -160 100 -160 {lab=iovdd}
N 60 -160 60 40 {lab=iovdd}
N -80 -160 60 -160 {lab=iovdd}
N 60 40 100 40 {lab=iovdd}
N 40 -40 40 160 {lab=iovss}
N -80 160 40 160 {lab=iovss}
N 40 -40 100 -40 {lab=iovss}
C {ipin.sym} -80 -160 0 0 {name=p1 lab=iovdd}
C {ipin.sym} -80 160 0 0 {name=p2 lab=iovss}
C {ipin.sym} -80 0 0 0 {name=p3 lab=pad}
C {ipin.sym} -80 240 0 0 {name=p4 lab=pad_guard}
C {sg13g2_DCNDiode.sym} 180 100 0 0 {name=x1}
C {sg13g2_DCPDiode.sym} 180 -100 0 0 {name=x2}
