Here are files necessary for running the lvs.
Two things to note:
1) As the sg13g2_io.spi file uses spiceprefixes, and because other missmatches with the klayout extraction of the gds files,
   I am using a custom, modified file.
2) The top.spice also has custom modifications compared to the xschem one, mainly because of the ptap situation, but also because it may truncate important precision in calculated values that throw off klayout's LVS
