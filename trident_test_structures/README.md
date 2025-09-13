# Trident ESD test structures

The trident ASIC is a joint collaboration between CERN and JKU. It will be a
fully open charge sensing chip with wide current dynamic range (from femto to
micro ampere) for use in ionization chamber frontend.

One critical aspect of the design is to manage leakage currents to ensure
proper reading at the lower end of the range. This leakage is most usually
dominated by the contribution of the ESD protection circuitry, but drain
to source and gate leakage of transistors of the input circuitry may
also contribute.

The goal of this tapeout is to characterize IHP's pdk potential
for use in a DC ultra low current application.

The first test structure is the standard IOPadAnalog, which contains multiple
layers of ESD protection (diodes and transistor clamps).
Its subcomponents are also included individually.

A second test structure is a similar structure to the standard IOPadAnalog, but
using a guard layer between the input and the power rails. This trades off
ESD protection and/or area against lower leakage (provided idiodes' gds is
available).

Minimal size NMOS HV and LV transistors with guard traces will also be included,
as they are the ones with smallest leakage (drain to source and gate), and are
likely to be the input of the final design.

