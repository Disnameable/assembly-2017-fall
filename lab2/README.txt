Name: Bingxue Ouyang
Email: bouyang@ucsc.edu
CruzID: bouyang
Section 02F
TA: Nicholas Junius

Lab 2 Write-up

Purpose:
The purpose of this lab is to create a calculator that performs addition and subtraction based on binary numbers and logic circuits. It should also store the output (sum/difference) and perform on the stored value.

Process:
I built a 6-bit register using flip-flops, and sum/difference as inputs. And then I built a 6-bit full adder through drawing a full adder truth table and 2¡¯s complement subtraction. Finally, I built 4 inverters and use AddSub button to switch between addition (user input) and subtraction (inverted user input).

Analysis:
The 5-bit segment display is unable to present negative number. So when the user change to Subtraction Mode, the display will automatically show the inverted user input (eg: 3=3d), and decrease from the inverted value, which might confuse the user. The thing that surprised me was to set up the AddSub switch in the same way as the lab showed. I later found how convenient it was to use in the 6-bit Full Adder since it automatically ¡°+1¡±.

Result:
The logic circuits are correct, and the outputs are mostly what was expected, except for the negative number display.