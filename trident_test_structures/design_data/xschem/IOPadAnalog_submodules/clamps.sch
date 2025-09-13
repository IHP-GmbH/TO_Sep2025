v {xschem version=3.4.8RC file_version=1.2}
G {}
K {}
V {}
S {}
F {}
E {}
N 40 0 40 120 {lab=pad}
N -100 -0 40 0 {lab=pad}
N 40 120 140 120 {lab=pad}
N -120 180 140 180 {lab=iovss}
N 120 60 140 60 {lab=iovdd}
N 120 -40 140 -40 {lab=iovss}
N -120 -160 140 -160 {lab=iovdd}
N 40 -100 40 -0 {lab=pad}
N 40 -100 140 -100 {lab=pad}
C {ipin.sym} -120 -160 0 0 {name=p1 lab=iovdd}
C {ipin.sym} -120 180 0 0 {name=p2 lab=iovss}
C {ipin.sym} -100 0 0 0 {name=p3 lab=pad}
C {ipin.sym} -100 40 0 0 {name=p4 lab=pad_guard
}
C {/run/host/mainData/cernbox/PhD/TO_Sep2025/trident_test_structures/design_data/xschem/IOPadAnalog_submodules/sg13g2_Clamp_N20N0D.sym} 220 120 0 0 {name=x1}
C {lab_pin.sym} 120 60 0 0 {name=p5 sig_type=std_logic lab=iovdd}
C {/run/host/mainData/cernbox/PhD/TO_Sep2025/trident_test_structures/design_data/xschem/IOPadAnalog_submodules/sg13g2_Clamp_P20N0D.sym} 220 -100 0 0 {name=x2}
C {lab_pin.sym} 120 -40 0 0 {name=p6 sig_type=std_logic lab=iovss}
