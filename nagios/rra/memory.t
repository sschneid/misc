-s 300 # 5minutes
DS:ram_used:GAUGE:600:0:U
DS:swap_used:GAUGE:600:0:U
RRA:AVERAGE:0.5:1:1440   #day
RRA:AVERAGE:0.5:30:336   #week
RRA:AVERAGE:0.5:120:360  #month
RRA:AVERAGE:0.5:1440:365 #year
RRA:MAX:0.5:1:1440   #day
RRA:MAX:0.5:30:336   #week
RRA:MAX:0.5:120:360  #month
RRA:MAX:0.5:1440:365 #year
RRA:MIN:0.5:1:1440   #day
RRA:MIN:0.5:30:336   #week
RRA:MIN:0.5:120:360  #month
RRA:MIN:0.5:1440:365 #year
