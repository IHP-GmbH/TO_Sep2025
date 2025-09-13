This is where the subcomponents are assembled to create a schematic view of the
full chip for lvs.
Due to the ptap management, the produced schematic cannot possibly yield an lvs match.
This is because:
1) ptaps in layout are merged and produce a single one rather than multiple like
   in the schematic
2) Even if the schematic is modified, some output values are truncated due to
   precision (especially area/perimeters based on w and l calculation. If the
   values are even slightly off (like 0.00001%), then lvs will say no match
