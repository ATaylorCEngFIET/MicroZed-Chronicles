#Copyright (c) 2016, Adam Taylor
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

import time
import cv2
 
camera = cv2.VideoCapture(0)
time.sleep(5)
 
(success,reference) = camera.read()
if not success:
 camera.release()
 cv2.destroyAllWindows()
 print("Error Opening Camera")
 
reference_grey = cv2.cvtColor(reference, cv2.COLOR_BGR2GRAY)
reference_blur = cv2.GaussianBlur(reference_grey, (5, 5), 0)

while True:

 (success, frame) = camera.read()
 if not success:
	 break
 grey = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
 #cv2.imshow("grey", grey) #uncomment to see the results of this stage
	
 blur = cv2.GaussianBlur(grey, (5, 5), 0)
 #cv2.imshow("blur", blur) #uncomment to see the results of this stage
	
 difference = cv2.absdiff(reference_blur, blur)
 #cv2.imshow("difference", difference) #uncomment to see the results of this stage
	
 threshold = cv2.threshold(difference, 25, 255, cv2.THRESH_BINARY)[1]
 #cv2.imshow("threshold", threshold) #uncomment to see the results of this stage
 
 dilated = cv2.dilate(threshold, None, iterations=2)
 #cv2.imshow("dilated", dilated) #uncomment to see the results of this stage
	
 (contours, hier) = cv2.findContours(threshold.copy(), cv2.RETR_EXTERNAL,cv2.CHAIN_APPROX_SIMPLE)
 #print(len(cnts)) #uncomment to see the results 
 #print(cnts[0]) #uncomment to see the results
 for i in contours:
  if cv2.contourArea(i) < 500:
   continue
  (x, y, w, h) = cv2.boundingRect(i)
  cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 0, 255), 2) 	
  cv2.imshow("Result", frame)
  key = cv2.waitKey(1) & 0xFF
  if key == ord("q"):
			break
	 
camera.release()
cv2.destroyAllWindows()