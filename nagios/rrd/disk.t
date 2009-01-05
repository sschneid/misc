--title=$HOSTNAME$ - $SERVICE$ space used
--vertical-label=Space used in MB
DEF:a=$RRD_FILENAME$:used:AVERAGE
CDEF:cdefg=TIME,1229555708,GT,a,a,UN,0,a,IF,IF
AREA:a#9c3554:used
GPRINT:a:LAST:Current\:%8.2lf %s
GPRINT:a:AVERAGE:Average\:%8.2lf %s
GPRINT:a:MAX:Maximum\:%8.2lf %s\n
LINE1:cdefg#111111:
