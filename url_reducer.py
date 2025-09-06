#!/usr/bin/env python
"""url_reducer.py"""

from operator import itemgetter
import sys

current_url = None
current_count = 0
url = None

# input comes from STDIN
for line in sys.stdin:
    
    line = line.strip()

    
    url, count = line.split('\t', 1)

    # convert count (currently a string) to int
    try:
        count = int(count)
    except ValueError:
        continue

    if current_url == url:
        current_count += count
    else:
        if current_url:
            # ONLY write result to STDOUT if count > 5
            if current_count > 5:
                print('%s\t%s' % (current_url, current_count))
        current_count = count
        current_url = url
            

if current_url == url:
    # ONLY output if count > 5
    if current_count > 5:
        print('%s\t%s' % (current_url, current_count))