#!/usr/bin/env python3
#
# Copyright (C) 2020 INTI
# Copyright (C) 2020 Rodrigo A. Melo
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
"""A CLI helper to get the ENTITY name."""

import argparse
import re
import sys


parser = argparse.ArgumentParser()
parser.add_argument('top')
args = parser.parse_args()

hdl = open(args.top, 'r').read()
matches = re.findall(r'entity\s+(\w+)\s+is', hdl)
if len(matches) > 0:
    top = matches[-1]
    if len(matches) > 1:
        print('WARNING: more than one top-level found, last selected.')
else:
    sys.exit('ERROR: top-level not found.')

print(top)
