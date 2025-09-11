# NOTE: PDK_ROOT, PDK and CACE_ROOT are set in the local environment by CACE
#
# This is an example script to drive LVS; because this is a simple
# example, there is no specific benefit of using this instead of the
# default handling in CACE.

set PDK_ROOT $::env(PDK_ROOT)
set PDK $::env(PDK)
set CACE_ROOT $::env(CACE_ROOT)

set circuit1 [readnet spice $CACE_ROOT/netlist/layout/ldo_1v2.spice]
set circuit2 [readnet spice $CACE_ROOT/netlist/schematic/ldo_1v2.spice]

lvs "$circuit1 ldo_1v2" "$circuit2 ldo_1v2" $PDK_ROOT/$PDK/libs.tech/netgen/${PDK}_setup.tcl ldo_1v2_comp.out -json
