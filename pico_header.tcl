# /*Copyright (c) 2015, Adam Taylor
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:

# 1. Redistributions of source code must retain the above copyright notice, this
   # list of conditions and the following disclaimer. 
# 2. Redistributions in binary form must reproduce the above copyright notice,
   # this list of conditions and the following disclaimer in the documentation
   # and/or other materials provided with the distribution.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# The views and conclusions contained in the software and documentation are those
# of the authors and should not be interpreted as representing official policies, 
# either expressed or implied, of the FreeBSD Project*/
#get file name to be converted
puts "Enter File Name for Conversion:"
gets stdin filename

puts "Enter File Name for Output:"
gets stdin outname

set f_id [open $filename r]

#delete output file if it already exists 	
file delete $outname 

set f_op [open $outname w]

regexp {(\w){1,}} $outname array_name 

puts $f_op "u32 $array_name\[4096\] = {"

while {[gets $f_id line]>=0} {
 regexp {(\w){5}} $line result
 #puts $result
 puts $f_op "0x$result,"
}

puts $f_op "};"

close $f_id
close $f_op