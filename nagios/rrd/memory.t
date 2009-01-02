--title=$HOSTNAME$ - memory used
--vertical-label=Percentage used
DEF:a=$RRD_FILENAME$:ram_used:AVERAGE
CDEF:cdefg=TIME,1229555708,GT,a,a,UN,0,a,IF,IF
AREA:a#9c3554:ram_used
GPRINT:a:LAST:Current\:%8.2lf %s
GPRINT:a:AVERAGE:Average\:%8.2lf %s
GPRINT:a:MAX:Maximum\:%8.2lf %s\n
LINE1:cdefg#111111:
