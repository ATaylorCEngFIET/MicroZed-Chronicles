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