import serial           # import the module
import time
ComPort = serial.Serial('/dev/ttyUSB1') # open COM24
ComPort.baudrate = 115200 # set Baud rate to 9600
ComPort.bytesize = 8    # Number of data bits = 8
ComPort.parity   = 'N'  # No parity
ComPort.stopbits = 1    # Number of Stop bits = 1
# Write character 'A' to serial port
#data=bytearray(b'A')
print "enter a number:",
x=input()

ot= ComPort.write(bytes(chr(x)))    #for sending data to FPGA

it=(ComPort.read(1))                #for receiving data from FPGA

print "Encrypted data:",

print it.encode('hex')

it=(ComPort.read(1))                #for receiving data from FPGA

print "Decrypted data:",

print it.encode('hex')
    

ComPort.close()         # Close the Com port
