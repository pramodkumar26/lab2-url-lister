#!/usr/bin/env python
"""url_mapper.py"""

import sys
import re

# Pattern to find URLs in href attributes
# This matches href="anything" and captures the "anything" part
url_pattern = r'href="([^"]*)"'


for line in sys.stdin:
    
    line = line.strip()
    
    
    urls = re.findall(url_pattern, line)
    
    for url in urls:
        if url:  
            # write the results to STDOUT (standard output);
            print('%s\t%s' % (url, 1))