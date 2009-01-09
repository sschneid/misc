--title=$HOSTNAME$ - $RRD_FILENAME$ resource utilization
--vertical-label=Kb
DEF:a=$RRD_FILENAME$:usedCPU:AVERAGE
DEF:b=$RRD_FILENAME$:usedRAM:AVERAGE
CDEF:cdefg=TIME,1229555708,GT,a,a,UN,0,a,IF,IF,TIME,1229555708,GT,b,b,UN,0,b,IF,IF,+
LINE2:a#756e5d:CPU
GPRINT:a:LAST:Current\:%8.2lf %s
LINE2:b#9c3554:RAM
GPRINT:b:LAST:Current\:%8.2lf %s
