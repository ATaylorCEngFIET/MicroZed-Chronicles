package require Tk
#declare the global consants
global f_id
global bmp
global header
global h_id
global o_id
global i_id
global data
global d_id

# ###########################################################################################################################
# proc ConvAscii { } {
# global f_id
# global d_id
# #read file in binary format
# fconfigure $f_id -translation binary

# #delete any header and data files present 
# file delete -force "$d_id/op.txt"
# file delete -force "$d_id/header.txt"
# file delete -force "$d_id/bmp_info.txt"

# #create the files for writing data and header info to 
# set outputname "$d_id/op.txt"
# set headerfile "$d_id/header.txt"
# set infofile   "$d_id/bmp_info.txt"


# #open the data destination file 
# if [catch {set o_id [open $outputname a]} msg] {
	# puts "failed to open output file, error = $msg"
	# exit
# }

# #open the header destination file 
# if [catch {set h_id [open $headerfile a]} msg] {
	# puts "failed to open header file, error = $msg"
	# exit
# }

# #open the header destination file 
# if [catch {set i_id [open $infofile a]} msg] {
	# puts "failed to open information file, error = $msg"
	# exit
# }

# # read the file and output the lines
# while { ! [ eof $f_id ] }  {
 
      	   # # Record the seek address. Read 16 bytes from the file.
           # set addr [tell $f_id ]
           # set s    [read $f_id 16]

           # # Convert the data to hex and to characters.
           # binary scan $s H*@0a* hex ascii

           # # Replace non-printing characters in the data.
           # regsub -all -- {[^[:graph:] ]} $ascii {.} ascii

           # # Split the 16 bytes into two 8-byte chunks
           # regexp -- {(.{0,16})(.{0,16})} $hex -> hex1 hex2

           # # Convert the hex to pairs of hex digits
           # regsub -all -- {..} $hex1 {&} hex1
           # regsub -all -- {..} $hex2 {&} hex2

	   # if {$addr == 16} {
		# set lnth $hex1$hex2
		# # extract the required data from the string and rearrange as it is LSByte first
		# #reads in 16 bytes at a time hence can pick elements at will from lnth between 0 and 31
		# set length [string range $lnth 4 11]
		# set height [string range $lnth 12 19]
		# set pixel  [string range $lnth 24 27]
		# set encode [string range $lnth 28 31]
		# set l7 [string index $length 7]
		# set l6 [string index $length 6]
		# set l5 [string index $length 5]
		# set l4 [string index $length 4]
		# set l3 [string index $length 3]
		# set l2 [string index $length 2]
		# set l1 [string index $length 1]
		# set l0 [string index $length 0]
		# set op_length $l6$l7$l5$l4$l2$l3$l0$l1
		# set h7 [string index $height 7]
		# set h6 [string index $height 6]
		# set h5 [string index $height 5]
		# set h4 [string index $height 4]
		# set h3 [string index $height 3]
		# set h2 [string index $height 2]
		# set h1 [string index $height 1]
		# set h0 [string index $height 0]
		# set op_height $h6$h7$h5$h4$h2$h3$h0$h1
        # set p3 [string index $pixel 3]
        # set p2 [string index $pixel 2]
        # set p1 [string index $pixel 1]
        # set p0 [string index $pixel 0] 
        # set op_pixel $p2$p3$p0$p1
        # set e7 [string index $encode 7]
		# set e6 [string index $encode 6]
		# set e5 [string index $encode 5]
		# set e4 [string index $encode 4]
		# set e3 [string index $encode 3]
		# set e2 [string index $encode 2]
		# set e1 [string index $encode 1]
		# set e0 [string index $encode 0]
		# set op_encode $e6$e7$e5$e4$e2$e3$e0$e1
		# #puts " picture width = $op_length Hexadecimal"
		# #puts " picture height = $op_height Hexadecimal "
		# #puts " bits per pixel = $op_pixel Hexadecimal" 
		# puts $i_id "$op_length picture width hexadecimal"
		# puts $i_id "$op_length picture height	hexadecimal"
		# puts $i_id "$op_pixel bits per pixel hexadecimal"
		# puts $i_id "$op_encode If this is not equal to zero file is compressed and cannot be used"
	   # } 
       # # Put the hex and Latin-1 data to the channel
	   # # this only puts out the image data here was 1072
	   # if { $addr == 36 } {
		# set ad $hex1$hex2
		# set head [string range $ad 0 11]
		# set data [string range $ad 12 31]
# #		puts $head
# #		puts $data
		# puts -nonewline $o_id $data
		# puts -nonewline $h_id $head
	   # }  elseif {$addr >= 52} {#was1088
                # puts -nonewline  $o_id [format {%s%s} \
                # $hex1 $hex2]
	   # } else {
		# #write the header file information to a seperate file for reconstruction later on
		# puts -nonewline $h_id [format {%s%s} \
                # $hex1 $hex2]
	   # }
# }
# close $o_id
# close $h_id
# close $i_id
# }

###########################################################################################################################
proc ConvBmp { } {
global o_id
global h_id
global d_id
global header
global data

set outputpic "$d_id/op.bmp"

file delete -force "$d_id/op.bmp"

#open the destination file 
if [catch {set o_pic [open $outputpic a]} msg] {
	puts "failed to open output picture file, error = $msg"
	exit
}

#open the destination file 
if [catch {set o_id [open $data r]} msg] {
	puts "failed to open output file, error = $msg"
	exit
}

#open the header destination file 
#if [catch {set h_id [open $header r]} msg] {
#	puts "failed to open header file, error = $msg"
#	exit
#}

fconfigure $o_id -translation binary
#fconfigure $h_id -translation binary
fconfigure $o_pic -translation binary

set raw 0

#while { ! [eof $h_id ] } {
     	
#	    set op    [read $h_id 2]
	   # puts "$op"
#  	    set raw [binary format H2 $op ]
#            puts -nonewline $o_pic $raw
#}

#close $o_pic
#open the destination file 
#if [catch {set o_pic [open $outputpic a]} msg] {
#	puts "failed to open output picture file, error = $msg"
#	exit
#}

while { ! [ eof $o_id ] }  {
 
	    set op    [read $o_id 2]
	    puts "$op"
#	    if {$op != 13 } {
	    set raw [binary format H2 $op ]
            puts -nonewline $o_pic $raw
#       }
}
#close the write file
close $o_id
#close the read file 
#close $h_id
#close the picture file
close $o_pic
}

###########################################################################################################################
proc GetDIR { } {
global d_id
global bmp
    set d_id [tk_chooseDirectory ] 
}

###########################################################################################################################
 proc GetBMP { } {
 global f_id
 global bmp
     set bmp [tk_getOpenFile]
    open the BMP file to be processed 
     if [catch {set f_id [open $bmp r]} msg] {
	 puts "failed to open $bmp, error = $msg"
	 exit
     }
 }

##########################################################################################################################
 proc GetHeader { } {
 global header
 global h_id
    set header [tk_getOpenFile]
     #open the BMP file to be processed 
     if [catch {set h_id [open $header r]} msg] {
	 puts "failed to open $header, error = $msg"
	 exit
     }
 } 

##########################################################################################################################
proc GetData { } {
global data
global o_id
    set data [tk_getOpenFile]
    #open the BMP file to be processed 
    if [catch {set o_id [open $data r]} msg] {
	puts "failed to open $data, error = $msg"
	exit
    }
} 

###########################################################################################################################
# MAIN BODY OF CODE 
###########################################################################################################################

set header_font [font create -family Courier -size 16]
set input_font [font create -family Courier -size 10]

#create new form 
#toplevel .newwindow 

#Title bar
wm title . "BMP <> ASCII"

#Create the windows
frame .fo -relief sunken -borderwidth 1
pack  .fo  -side left -fill both -expand 1

#Add the buttons and 
label .fo.tsttitle -font $header_font -text "FILE OPTIONS"
pack  .fo.tsttitle -padx 10 -pady 0 

#box for directory name 
label .fo.lbl4 -font $header_font -text "Working Directory"
entry .fo.ent4 -font $input_font  -textvariable d_id
#button pressed to get directory 
button .fo.dirname -text "Select Working Directory" -command GetDIR
pack	 .fo.lbl4 .fo.ent4 .fo.dirname  -padx 10 -pady 10

# # box for BMP name 
# label .fo.lbl1 -font $header_font -text "BMP To Convert"
# entry .fo.ent1 -font $input_font  -textvariable bmp
# # button pressed to get bmp file 
# button .fo.bmpname -text "Select BMP From File" -command GetBMP
# pack	 .fo.lbl1 .fo.ent1 .fo.bmpname   -padx 10 -pady 10

# # box for ASCII Header File
# label .fo.lbl2 -font $header_font -text "ASCII Header"
# entry .fo.ent2 -font $input_font  -textvariable header
# # button pressed to get header file 
# button .fo.hdrname -text "Select ASCII Header File" -command GetHeader
# pack	 .fo.lbl2 .fo.ent2 .fo.hdrname   -padx 10 -pady 10

#box for ASCII data File
label .fo.lbl3 -font $header_font -text "ASCII Data"
entry .fo.ent3 -font $input_font  -textvariable data
#button pressed to get header file 
button .fo.dataname -text "Select ASCII Data File" -command GetData
pack	 .fo.lbl3 .fo.ent3 .fo.dataname   -padx 10 -pady 10

# #button to convert the file header file and data file 
# button .fo.bmpconv -text "Convert To ASCII" -command ConvAscii
# pack	 .fo.bmpconv -padx 10 -pady 10

#button to convert the file header file and data file 
button  .fo.asciiconv -text "Convert To BMP" -command ConvBmp
pack	 .fo.asciiconv -padx 10 -pady 10

