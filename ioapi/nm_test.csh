#!/bin/csh
#!/usr/local/bin/tcsh
#.........................................................................
# Version "$Id: nm_test.csh 100 2015-01-16 16:52:16Z coats $"
# EDSS/Models-3 I/O API.
# Copyright (C) 2003 Baron Advanced Meteorological Systems
# Distributed under the GNU Lesser PUBLIC LICENSE version 2.1
# See file "LGPL.txt" for conditions of use.
#.........................................................................
#  Script to test link-compatibility of "libioapi.a" and "libnetcdf.a"
#.........................................................................
#  USAGE
#       lib_test.csh
#.........................................................................
#  IBM NOTE
#       IBM's "csh" misbehaves, so you may need to substitute "tcsh"
#       as indicated above
#.........................................................................

if ( $# != 3 ) then
    echo( "Usage:  lib_test.csh <file> <file> <symbol>" 
    exit( 2 ) 
endif

set a1 = ${1}
set a2 = ${2}
set a3 = ${3}
set quote = '"'

set foo = \
`nm ${a1} | grep -i ${a3} | sort -u | sed -e 's/ *U *//'`

set bar = \
`nm ${a2} | grep -i ${a3} | grep T | sort -u | sed -e 's/[0-9]* *T *//'`

if ( ${foo} == '' ) then
   echo "Symbol ${a3} not found in ${a1}"
   exit( 2 )
endif

if ( ${bar} == '' ) then
   echo "Symbol ${a3} not found in ${a2}"
   exit( 2 )
endif

if ( ${foo} == ${bar} ) then
   echo "Name match OK"
   echo "Files ${a1} and ${a2}"
   echo "Symbol "${quote}${foo}${quote}"\n"
   exit( 0 )
endif

echo "\n***>>>  ERROR:  Library LINK-NAME MISMATCH  <<<"
echo "Compiler for ${a1}  uses linker-symbols like "${quote}${foo}${quote}
echo "Compiler for ${a2}  uses linker-symbols like "${quote}${bar}${quote}
echo "Probable compiler-mismatch or compiler-flag error\n"
exit( 1 )

