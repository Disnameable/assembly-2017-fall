Name: Bingxue Ouyang
Email: bouyang@ucsc.edu
CruzID: bouyang
Section 02F
TA: Nicholas Junius

Lab 5 Write-up
Purpose:
The purpose of this lab is to create a en/decoder that performs encode/decode on certain text using keys, and print the result.

Process:
I read through the C code provided by instructors, and write out the structure for both methods. I created an array called enString to store the encoded string, and then implemented the encode function to fill in the array. And then I use this array to decode.

Analysis:
The similarities between encode/decode functions are very similar but in opposite logic. The encode function reads from program argument, which is already stored in $at, while the decode function reads from enString, which is an array created by me. Which makes their counters add in different ways (4 bytes for .space array).

Result:
The outputs are the same with the outputs given by cipher.c, but different with Lab5.pdf because space cannot be used in MARS.