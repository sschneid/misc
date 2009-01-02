--title=$HOSTNAME$ - load average
--vertical-label=Processes in queue
DEF:a=$RRD_FILENAME$:load_15_min:AVERAGE
DEF:b=$RRD_FILENAME$:load_5_min:AVERAGE
DEF:c=$RRD_FILENAME$:load_1_min:AVERAGE
CDEF:cdefg=TIME,1229555708,GT,a,a,UN,0,a,IF,IF,TIME,1229555708,GT,b,b,UN,0,b,IF,IF,TIME,1229555708,GT,c,c,UN,0,c,IF,IF,+,+
AREA:a#756e5d:15 Minute Average
AREA:b#9c7d35:5 Minute Average:STACK
AREA:c#9c3554:1 Minute Average:STACK
LINE1:cdefg#111111:
