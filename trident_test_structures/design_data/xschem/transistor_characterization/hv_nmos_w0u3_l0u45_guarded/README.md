# HV NMOS minimum size W0u3_L0u45

## IHP Characterization

IHP has already made characterization for the minimum size HV NMOS.
The values of interest are the gate leakage and the drain to source leakage for Vd=0.1 and T=27°C

![Measured gate leakage](./images/hv_nmos_W0u3_L0u45_Vd_0.1_T27_meas_gate_leakage.png)
![Measured drain to source leakage](./images/hv_nmos_W0u3_L0u45_Vd_0.1_T27_meas_source_drain_leakage.png)

## SPICE Models

Provided spice models do not seem to take into account either the gate leakage.
The drain to source leakage in deep subthreshold regime shows large difference
to the measurements.


![Simulated gate leakage](images/hv_nmos_W0u3_L0u45_Vd_0.1_T27_sim_gate_leakage.svg)
![Simulated drain to source leakage](images/hv_nmos_W0u3_L0u45_Vd_0.1_T27_sim_source_drain_leakage.svg)
