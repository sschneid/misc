--title=$HOSTNAME$ - ethernet traffic
--vertical-label=Bytes per second
DEF:a=$RRD_FILENAME$:in_Bps:AVERAGE
DEF:b=$RRD_FILENAME$:out_Bps:AVERAGE
CDEF:cdefg=TIME,1229555708,GT,a,a,UN,0,a,IF,IF,TIME,1229555708,GT,b,b,UN,0,a,IF,IF,+
AREA:a#9c3554:in
GPRINT:a:AVERAGE:Average\:%8.2lf %s
AREA:b#9c7d35:out:STACK
GPRINT:b:AVERAGE:Average\:%8.2lf %s
LINE1:cdefg#111111:
