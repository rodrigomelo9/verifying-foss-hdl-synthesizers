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
"""A CLI helper to run Yosys using the GHDL plugin."""

import argparse
import os
import re
import subprocess
import sys

parser = argparse.ArgumentParser()
parser.add_argument('top', metavar='TOPLEVEL')
parser.add_argument('-o', '--outdir', default='temp')
parser.add_argument('-f', '--file', metavar='FILE[,PACKAGE]', action='append')
args = parser.parse_args()

FLAGS="-fsynopsys -fexplicit -frelaxed -P{0} --std=08 --workdir={0}".format(args.outdir)
NOWARN="--warn-no-hide --warn-no-shared --warn-no-library"

files = []
if args.file is not None:
    files.extend(args.file)
files.append(args.top)

if os.path.isfile(args.top):
    hdl = open(args.top, 'r').read()
    matches = re.findall(r'entity\s+(\w+)\s+is', hdl)
    if len(matches) > 0:
        top = matches[-1]
        if len(matches) > 1:
            print('WARNING: more than one top-level found, last selected.')
    else:
        sys.exit('ERROR: top-level not found.')
else:
    top = args.top

for file in files:
    command = 'ghdl -a {} {} {}'.format(FLAGS, NOWARN, file)
    subprocess.run(command, shell=True)

command = "yosys -Q -m ghdl -p 'ghdl {} {}; ".format(FLAGS, top)
command += "synth_xilinx -family xc7; "
command += "write_edif -pvector bra yosys.edif'"
subprocess.run(command, shell=True)
