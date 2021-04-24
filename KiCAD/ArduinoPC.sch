EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 8268 11693 portrait
encoding utf-8
Sheet 1 1
Title "Minimal Terminal"
Date "2020-09-18"
Rev "1.5"
Comp ""
Comment1 ""
Comment2 "creativecommons.org/licenses/by-nc-sa/3.0/deed.en"
Comment3 "License: CC BY-NC-SA 3.0"
Comment4 "Author: Carsten Herting (Slu4)"
$EndDescr
$Comp
L power:PWR_FLAG #FLG01
U 1 1 5F54B507
P 6400 850
F 0 "#FLG01" H 6400 925 50  0001 C CNN
F 1 "PWR_FLAG" V 6400 1200 50  0000 C CNN
F 2 "" H 6400 850 50  0001 C CNN
F 3 "~" H 6400 850 50  0001 C CNN
	1    6400 850 
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR025
U 1 1 5F55E54F
P 5700 5650
F 0 "#PWR025" H 5700 5500 50  0001 C CNN
F 1 "+5V" V 5715 5823 50  0000 C CNN
F 2 "" H 5700 5650 50  0001 C CNN
F 3 "" H 5700 5650 50  0001 C CNN
	1    5700 5650
	0    1    1    0   
$EndComp
$Comp
L Connector:Mini-DIN-6 J2
U 1 1 5F5B16AD
P 2400 7000
F 0 "J2" H 2150 7200 50  0000 C CNN
F 1 "PS/2 Keyboard" H 2400 7300 50  0000 C CNN
F 2 "ArduinoPC:FP_MINI_DIN_6_PS2" H 2400 7000 50  0001 C CNN
F 3 "http://service.powerdynamics.com/ec/Catalog17/Section%2011.pdf" H 2400 7000 50  0001 C CNN
	1    2400 7000
	1    0    0    -1  
$EndComp
$Comp
L Connector:DB15_Female_HighDensity J3
U 1 1 5F5CC87F
P 5000 2650
F 0 "J3" V 4900 2100 50  0000 L CNN
F 1 "VGA DB15 HD Connector (Female)" V 4450 2050 50  0000 L CNN
F 2 "ArduinoPC:VGA DSUB15HD_female" H 4050 3050 50  0001 C CNN
F 3 " ~" H 4050 3050 50  0001 C CNN
	1    5000 2650
	0    -1   1    0   
$EndComp
NoConn ~ 2100 6900
NoConn ~ 2100 7100
$Comp
L power:GND #PWR05
U 1 1 5F5E1C5B
P 2700 7000
F 0 "#PWR05" H 2700 6750 50  0001 C CNN
F 1 "GND" V 2700 6900 50  0000 R CNN
F 2 "" H 2700 7000 50  0001 C CNN
F 3 "" H 2700 7000 50  0001 C CNN
	1    2700 7000
	0    -1   1    0   
$EndComp
$Comp
L power:+5V #PWR01
U 1 1 5F5E248C
P 2100 7000
F 0 "#PWR01" H 2100 6850 50  0001 C CNN
F 1 "+5V" V 2100 7200 50  0000 C CNN
F 2 "" H 2100 7000 50  0001 C CNN
F 3 "" H 2100 7000 50  0001 C CNN
	1    2100 7000
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR02
U 1 1 5F62AE04
P 2200 2800
F 0 "#PWR02" H 2200 2550 50  0001 C CNN
F 1 "GND" H 2205 2627 50  0000 C CNN
F 2 "" H 2200 2800 50  0001 C CNN
F 3 "" H 2200 2800 50  0001 C CNN
	1    2200 2800
	-1   0    0    -1  
$EndComp
$Comp
L power:+5V #PWR015
U 1 1 5F62BCE3
P 4100 2800
F 0 "#PWR015" H 4100 2650 50  0001 C CNN
F 1 "+5V" H 4115 2973 50  0000 C CNN
F 2 "" H 4100 2800 50  0001 C CNN
F 3 "" H 4100 2800 50  0001 C CNN
	1    4100 2800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4500 2350 4500 2300
Wire Wire Line
	4500 2300 4700 2300
Wire Wire Line
	4700 2300 4700 2350
Wire Wire Line
	4700 2300 4900 2300
Wire Wire Line
	4900 2300 4900 2350
Connection ~ 4700 2300
Wire Wire Line
	5300 2350 5300 2300
Wire Wire Line
	5300 2300 5400 2300
Wire Wire Line
	5400 2300 5400 2350
Wire Wire Line
	4900 2300 5300 2300
Connection ~ 4900 2300
Connection ~ 5300 2300
Wire Wire Line
	4600 2350 4600 2200
Wire Wire Line
	4600 2200 4800 2200
Wire Wire Line
	4800 2200 4800 2350
Wire Wire Line
	4800 2200 5000 2200
Wire Wire Line
	5000 2200 5000 2350
Connection ~ 4800 2200
$Comp
L Device:R R5
U 1 1 5FD394F8
P 4100 2200
F 0 "R5" V 4000 2150 50  0000 L CNN
F 1 "150" V 4100 2100 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4030 2200 50  0001 C CNN
F 3 "~" H 4100 2200 50  0001 C CNN
	1    4100 2200
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR018
U 1 1 5FD3A7D3
P 4500 2300
F 0 "#PWR018" H 4500 2050 50  0001 C CNN
F 1 "GND" V 4550 2100 50  0000 C CNN
F 2 "" H 4500 2300 50  0001 C CNN
F 3 "" H 4500 2300 50  0001 C CNN
	1    4500 2300
	0    1    1    0   
$EndComp
$Comp
L Device:R R7
U 1 1 5FD3AF20
P 5200 3100
F 0 "R7" H 5250 3100 50  0000 L CNN
F 1 "75" V 5200 3050 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 5130 3100 50  0001 C CNN
F 3 "~" H 5200 3100 50  0001 C CNN
	1    5200 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5FD3B485
P 5000 3100
F 0 "R6" H 4850 3100 50  0000 L CNN
F 1 "75" V 5000 3050 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 4930 3100 50  0001 C CNN
F 3 "~" H 5000 3100 50  0001 C CNN
	1    5000 3100
	1    0    0    -1  
$EndComp
NoConn ~ 5100 2350
NoConn ~ 5200 2350
NoConn ~ 4600 2950
NoConn ~ 4800 2950
NoConn ~ 5400 2950
$Comp
L power:GND #PWR012
U 1 1 5FE88422
P 3800 3300
F 0 "#PWR012" H 3800 3050 50  0001 C CNN
F 1 "GND" H 3700 3200 50  0000 C CNN
F 2 "" H 3800 3300 50  0001 C CNN
F 3 "" H 3800 3300 50  0001 C CNN
	1    3800 3300
	-1   0    0    -1  
$EndComp
Text Notes 3400 2200 0    50   ~ 0
SIGNAL
Text Notes 5200 4000 1    50   ~ 0
~VSYNC
Text Notes 5000 3750 3    50   ~ 0
~HSYNC
Text Notes 6150 2800 1    50   ~ 0
B3 /PE toggle
$Comp
L power:GND #PWR017
U 1 1 60033F15
P 6400 1150
F 0 "#PWR017" H 6400 900 50  0001 C CNN
F 1 "GND" H 6405 977 50  0000 C CNN
F 2 "" H 6400 1150 50  0001 C CNN
F 3 "" H 6400 1150 50  0001 C CNN
	1    6400 1150
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR07
U 1 1 5F62A048
P 2700 5750
F 0 "#PWR07" H 2700 5500 50  0001 C CNN
F 1 "GND" V 2705 5577 50  0000 C CNN
F 2 "" H 2700 5750 50  0001 C CNN
F 3 "" H 2700 5750 50  0001 C CNN
	1    2700 5750
	0    1    1    0   
$EndComp
Text Notes 4000 7100 2    50   ~ 0
DAT
Text Notes 4100 6900 2    50   ~ 0
CLK
Connection ~ 4500 2300
$Comp
L Device:R R3
U 1 1 5F7DE81D
P 3900 5000
F 0 "R3" V 3950 5100 50  0000 L CNN
F 1 "10k" V 3900 4950 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3830 5000 50  0001 C CNN
F 3 "~" H 3900 5000 50  0001 C CNN
	1    3900 5000
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR026
U 1 1 603E5A8C
P 5700 5750
F 0 "#PWR026" H 5700 5600 50  0001 C CNN
F 1 "+5V" V 5715 5923 50  0000 C CNN
F 2 "" H 5700 5750 50  0001 C CNN
F 3 "" H 5700 5750 50  0001 C CNN
	1    5700 5750
	0    1    1    0   
$EndComp
Wire Wire Line
	3600 5150 3600 3600
Wire Wire Line
	3500 5150 3500 3300
Wire Wire Line
	3400 5150 3400 3300
Wire Wire Line
	3300 5150 3300 3300
Wire Wire Line
	3200 5150 3200 3300
Wire Wire Line
	3100 5150 3100 4900
$Comp
L power:+5V #PWR013
U 1 1 603F327A
P 3900 4850
F 0 "#PWR013" H 3900 4700 50  0001 C CNN
F 1 "+5V" V 3915 5023 50  0000 C CNN
F 2 "" H 3900 4850 50  0001 C CNN
F 3 "" H 3900 4850 50  0001 C CNN
	1    3900 4850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 5150 5100 4500
Connection ~ 4600 2200
Wire Wire Line
	4250 2200 4600 2200
Wire Wire Line
	5000 3250 5000 5150
$Comp
L power:+5V #PWR027
U 1 1 6043F35F
P 5700 8650
F 0 "#PWR027" H 5700 8500 50  0001 C CNN
F 1 "+5V" V 5715 8823 50  0000 C CNN
F 2 "" H 5700 8650 50  0001 C CNN
F 3 "" H 5700 8650 50  0001 C CNN
	1    5700 8650
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR028
U 1 1 6043F842
P 5700 8750
F 0 "#PWR028" H 5700 8600 50  0001 C CNN
F 1 "+5V" V 5715 8923 50  0000 C CNN
F 2 "" H 5700 8750 50  0001 C CNN
F 3 "" H 5700 8750 50  0001 C CNN
	1    5700 8750
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR04
U 1 1 604401CB
P 2200 8150
F 0 "#PWR04" H 2200 7900 50  0001 C CNN
F 1 "GND" V 2205 7977 50  0000 C CNN
F 2 "" H 2200 8150 50  0001 C CNN
F 3 "" H 2200 8150 50  0001 C CNN
	1    2200 8150
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R4
U 1 1 60440617
P 3900 8000
F 0 "R4" V 3950 8100 50  0000 L CNN
F 1 "10k" V 3900 7950 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 3830 8000 50  0001 C CNN
F 3 "~" H 3900 8000 50  0001 C CNN
	1    3900 8000
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR014
U 1 1 60440AFB
P 3900 7850
F 0 "#PWR014" H 3900 7700 50  0001 C CNN
F 1 "+5V" V 3900 8050 50  0000 C CNN
F 2 "" H 3900 7850 50  0001 C CNN
F 3 "" H 3900 7850 50  0001 C CNN
	1    3900 7850
	1    0    0    -1  
$EndComp
Text Label 5400 8150 1    50   ~ 0
TR6
Text Label 5300 8150 1    50   ~ 0
TR7
Text Label 3500 8150 1    50   ~ 0
TR0
Text Label 3400 8150 1    50   ~ 0
TR1
Text Label 3300 8150 1    50   ~ 0
TR2
Text Label 3200 8150 1    50   ~ 0
TR3
Text Label 3100 8150 1    50   ~ 0
TR4
Text Label 3000 8150 1    50   ~ 0
TR5
Wire Wire Line
	4100 8150 4100 6900
Wire Wire Line
	4100 6900 2700 6900
Wire Wire Line
	4000 8150 4000 7100
Wire Wire Line
	4000 7100 2700 7100
NoConn ~ 4200 8150
NoConn ~ 4300 8150
NoConn ~ 5100 8150
NoConn ~ 5000 8150
$Comp
L power:+5V #PWR03
U 1 1 6048388E
P 2200 7950
F 0 "#PWR03" H 2200 7800 50  0001 C CNN
F 1 "+5V" V 2215 8123 50  0000 C CNN
F 2 "" H 2200 7950 50  0001 C CNN
F 3 "" H 2200 7950 50  0001 C CNN
	1    2200 7950
	0    1    1    0   
$EndComp
NoConn ~ 2200 8050
Wire Wire Line
	3700 8150 3700 7850
Wire Wire Line
	3700 7850 2200 7850
Wire Wire Line
	3600 8150 3600 7750
Wire Wire Line
	3600 7750 2200 7750
Wire Wire Line
	2200 7650 3600 7650
$Comp
L Device:C_Small C1
U 1 1 6048FE0A
P 3700 7650
F 0 "C1" V 3650 7550 50  0000 C CNN
F 1 ".1µ" V 3562 7650 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3700 7650 50  0001 C CNN
F 3 "~" H 3700 7650 50  0001 C CNN
	1    3700 7650
	0    1    1    0   
$EndComp
Wire Wire Line
	3900 8150 3800 8150
Wire Wire Line
	3800 8150 3800 7650
$Comp
L Device:C_Small C2
U 1 1 6049BED8
P 3900 4250
F 0 "C2" V 3750 4250 50  0000 C CNN
F 1 ".1µ" V 4038 4250 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 3900 4250 50  0001 C CNN
F 3 "~" H 3900 4250 50  0001 C CNN
	1    3900 4250
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3900 5150 3800 5150
Wire Wire Line
	5700 3600 3600 3600
Connection ~ 3600 3600
Wire Wire Line
	3600 3600 3600 3300
Wire Wire Line
	5700 3700 3700 3700
Connection ~ 3700 3700
Wire Wire Line
	3700 3700 3700 3300
$Comp
L power:+5V #PWR023
U 1 1 604A3536
P 5700 3800
F 0 "#PWR023" H 5700 3650 50  0001 C CNN
F 1 "+5V" V 5715 3973 50  0000 C CNN
F 2 "" H 5700 3800 50  0001 C CNN
F 3 "" H 5700 3800 50  0001 C CNN
	1    5700 3800
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR024
U 1 1 604A3C79
P 5700 4000
F 0 "#PWR024" H 5700 3750 50  0001 C CNN
F 1 "GND" V 5705 3827 50  0000 C CNN
F 2 "" H 5700 4000 50  0001 C CNN
F 3 "" H 5700 4000 50  0001 C CNN
	1    5700 4000
	0    1    1    0   
$EndComp
NoConn ~ 5700 3900
$Comp
L power:GND #PWR09
U 1 1 604A552A
P 2700 8750
F 0 "#PWR09" H 2700 8500 50  0001 C CNN
F 1 "GND" V 2705 8577 50  0000 C CNN
F 2 "" H 2700 8750 50  0001 C CNN
F 3 "" H 2700 8750 50  0001 C CNN
	1    2700 8750
	0    1    1    0   
$EndComp
$Comp
L Device:C C9
U 1 1 604AA35E
P 7000 1000
F 0 "C9" H 6850 1100 50  0000 L CNN
F 1 ".1µ" H 6850 900 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 7000 1000 50  0001 C CNN
F 3 "~" H 7000 1000 50  0001 C CNN
	1    7000 1000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 604AAA72
P 7200 1000
F 0 "C10" H 7050 1100 50  0000 L CNN
F 1 ".1µ" H 7050 900 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 7200 1000 50  0001 C CNN
F 3 "~" H 7200 1000 50  0001 C CNN
	1    7200 1000
	1    0    0    -1  
$EndComp
Connection ~ 6400 1150
Connection ~ 7000 1150
Connection ~ 7200 1150
Connection ~ 7000 850 
Connection ~ 7200 850 
$Comp
L power:+5V #PWR016
U 1 1 604AE63B
P 6400 850
F 0 "#PWR016" H 6400 700 50  0001 C CNN
F 1 "+5V" H 6415 1023 50  0000 C CNN
F 2 "" H 6400 850 50  0001 C CNN
F 3 "" H 6400 850 50  0001 C CNN
	1    6400 850 
	1    0    0    -1  
$EndComp
Connection ~ 6400 850 
$Comp
L power:PWR_FLAG #FLG02
U 1 1 604AF73A
P 6400 1150
F 0 "#FLG02" H 6400 1225 50  0001 C CNN
F 1 "PWR_FLAG" V 6400 1500 50  0000 C CNN
F 2 "" H 6400 1150 50  0001 C CNN
F 3 "~" H 6400 1150 50  0001 C CNN
	1    6400 1150
	0    -1   -1   0   
$EndComp
$Comp
L ArduinoPC:ATmega328P-PU U3
U 1 1 604B84A8
P 4200 8750
F 0 "U3" V 4200 8750 50  0000 C CNN
F 1 "ATmega328P (UART & PS/2)" V 4050 8750 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W7.62mm_Socket" H 4200 8750 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 4200 8750 50  0001 C CNN
	1    4200 8750
	0    1    -1   0   
$EndComp
Connection ~ 3900 8150
$Comp
L ArduinoPC:ATmega328P-PU U2
U 1 1 604BF066
P 4200 5750
F 0 "U2" V 3900 5750 50  0000 C CNN
F 1 "ATmega328P (VGA)" V 3800 5750 50  0000 C CNN
F 2 "Package_DIP:DIP-28_W7.62mm_Socket" H 4200 5750 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 4200 5750 50  0001 C CNN
	1    4200 5750
	0    1    -1   0   
$EndComp
Connection ~ 3900 5150
$Comp
L power:GND #PWR08
U 1 1 604C21BD
P 2700 5850
F 0 "#PWR08" H 2700 5600 50  0001 C CNN
F 1 "GND" V 2705 5677 50  0000 C CNN
F 2 "" H 2700 5850 50  0001 C CNN
F 3 "" H 2700 5850 50  0001 C CNN
	1    2700 5850
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR010
U 1 1 604C24A3
P 2700 8850
F 0 "#PWR010" H 2700 8600 50  0001 C CNN
F 1 "GND" V 2705 8677 50  0000 C CNN
F 2 "" H 2700 8850 50  0001 C CNN
F 3 "" H 2700 8850 50  0001 C CNN
	1    2700 8850
	0    1    1    0   
$EndComp
$Comp
L Connector:Conn_01x02_Female J4
U 1 1 604F731C
P 7550 1050
F 0 "J4" H 7442 725 50  0000 C CNN
F 1 "5V" H 7442 816 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x02_P2.54mm_Vertical" H 7550 1050 50  0001 C CNN
F 3 "~" H 7550 1050 50  0001 C CNN
	1    7550 1050
	1    0    0    1   
$EndComp
Wire Wire Line
	7350 1050 7350 1150
Wire Wire Line
	7350 950  7350 850 
Wire Wire Line
	7200 850  7350 850 
Wire Wire Line
	7200 1150 7350 1150
Text Label 2650 4900 2    50   ~ 0
TR6
Text Label 2650 4800 2    50   ~ 0
TR7
Text Label 4500 5150 1    50   ~ 0
TR0
Text Label 4400 5150 1    50   ~ 0
TR1
Text Label 4300 5150 1    50   ~ 0
TR2
Text Label 4200 5150 1    50   ~ 0
TR3
Text Label 4100 5150 1    50   ~ 0
TR4
Text Label 4000 5150 1    50   ~ 0
TR5
Text Label 5200 8150 1    50   ~ 0
DATA_NEW
Wire Wire Line
	2950 4900 3100 4900
Wire Wire Line
	3100 4900 3100 3300
$Comp
L Device:R R1
U 1 1 60459F09
P 2800 4900
F 0 "R1" V 2900 4850 50  0000 L CNN
F 1 "1k" V 2800 4850 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 2730 4900 50  0001 C CNN
F 3 "~" H 2800 4900 50  0001 C CNN
	1    2800 4900
	0    1    1    0   
$EndComp
Text Label 5300 5150 1    50   ~ 0
DATA_NEW
Wire Wire Line
	7000 850  7200 850 
Wire Wire Line
	7000 1150 7200 1150
$Comp
L ArduinoPC:74HC166 U1
U 1 1 60576D18
P 3200 2800
F 0 "U1" V 3200 3050 50  0000 L CNN
F 1 "74HC166" V 3200 2600 50  0000 L CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 3200 2800 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/sn74LS165" H 3200 2800 50  0001 C CNN
	1    3200 2800
	0    1    -1   0   
$EndComp
Wire Wire Line
	3000 2300 3000 2200
Wire Wire Line
	3000 2200 3950 2200
$Comp
L power:+5V #PWR06
U 1 1 6057D007
P 2700 2300
F 0 "#PWR06" H 2700 2150 50  0001 C CNN
F 1 "+5V" H 2715 2473 50  0000 C CNN
F 2 "" H 2700 2300 50  0001 C CNN
F 3 "" H 2700 2300 50  0001 C CNN
	1    2700 2300
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR011
U 1 1 6057D37B
P 2850 3300
F 0 "#PWR011" H 2850 3050 50  0001 C CNN
F 1 "GND" V 2850 3100 50  0000 C CNN
F 2 "" H 2850 3300 50  0001 C CNN
F 3 "" H 2850 3300 50  0001 C CNN
	1    2850 3300
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 4500 5100 4500
Wire Wire Line
	2850 2300 2850 2000
Wire Wire Line
	2850 2000 6150 2000
NoConn ~ 5400 6350
NoConn ~ 5400 9350
Text Notes 5700 3700 2    50   ~ 0
RX
Text Notes 5700 3600 2    50   ~ 0
TX
Text Notes 3600 5150 1    50   ~ 0
TX
Text Notes 3700 5150 1    50   ~ 0
RX
Text Notes 3700 8150 1    50   ~ 0
RX
Text Notes 3600 8150 1    50   ~ 0
TX
Text Notes 2200 7850 0    50   ~ 0
RX
Text Notes 2200 7750 0    50   ~ 0
TX
Text Label 5400 5150 1    50   ~ 0
CLKO
Text Label 2700 3300 3    50   ~ 0
CLKO
$Comp
L Device:Crystal_Small Y1
U 1 1 6069CF3C
P 4700 4800
F 0 "Y1" H 4700 4700 50  0000 C CNN
F 1 "24MHz" H 4450 4700 50  0000 C CNN
F 2 "Crystal:Crystal_HC18-U_Vertical" H 4700 4800 50  0001 C CNN
F 3 "~" H 4700 4800 50  0001 C CNN
	1    4700 4800
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C5
U 1 1 6069CF44
P 4600 4700
F 0 "C5" H 4450 4600 50  0000 L CNN
F 1 "22p" H 4400 4800 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 4600 4700 50  0001 C CNN
F 3 "~" H 4600 4700 50  0001 C CNN
	1    4600 4700
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C7
U 1 1 6069CF4B
P 4800 4700
F 0 "C7" H 4850 4600 50  0000 L CNN
F 1 "22p" H 4650 4800 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D5.0mm_W2.5mm_P2.50mm" H 4800 4700 50  0001 C CNN
F 3 "~" H 4800 4700 50  0001 C CNN
	1    4800 4700
	1    0    0    -1  
$EndComp
Connection ~ 4800 4800
$Comp
L power:GND #PWR019
U 1 1 6069CF52
P 4600 4600
F 0 "#PWR019" H 4600 4350 50  0001 C CNN
F 1 "GND" V 4600 4400 50  0000 C CNN
F 2 "" H 4600 4600 50  0001 C CNN
F 3 "" H 4600 4600 50  0001 C CNN
	1    4600 4600
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR021
U 1 1 6069CF58
P 4800 4600
F 0 "#PWR021" H 4800 4350 50  0001 C CNN
F 1 "GND" V 4800 4400 50  0000 C CNN
F 2 "" H 4800 4600 50  0001 C CNN
F 3 "" H 4800 4600 50  0001 C CNN
	1    4800 4600
	-1   0    0    1   
$EndComp
Wire Wire Line
	6150 2000 6150 4500
Wire Wire Line
	5200 3250 5200 5150
Wire Wire Line
	3700 3700 3700 5150
Connection ~ 3100 4900
NoConn ~ 4900 8150
NoConn ~ 4900 5150
Wire Wire Line
	6400 850  6600 850 
Wire Wire Line
	6400 1150 6600 1150
$Comp
L Device:C C4
U 1 1 6076CC5A
P 6800 1000
F 0 "C4" H 6400 1100 50  0000 L CNN
F 1 ".1µ" H 6650 900 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D3.8mm_W2.6mm_P2.50mm" H 6800 1000 50  0001 C CNN
F 3 "~" H 6800 1000 50  0001 C CNN
	1    6800 1000
	1    0    0    -1  
$EndComp
Connection ~ 6800 850 
Wire Wire Line
	6800 850  7000 850 
Connection ~ 6800 1150
Wire Wire Line
	6800 1150 7000 1150
$Comp
L Device:CP C3
U 1 1 60772B7A
P 6600 1000
F 0 "C3" H 6700 1100 50  0000 L CNN
F 1 "47µ" H 6400 900 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D6.3mm_P2.50mm" H 6600 1000 50  0001 C CNN
F 3 "~" H 6600 1000 50  0001 C CNN
	1    6600 1000
	1    0    0    -1  
$EndComp
Connection ~ 6600 850 
Wire Wire Line
	6600 850  6800 850 
Connection ~ 6600 1150
Wire Wire Line
	6600 1150 6800 1150
Text Label 4800 8150 1    50   ~ 0
CLKO
NoConn ~ 4700 8150
$Comp
L Connector_Generic:Conn_02x02_Top_Bottom J6
U 1 1 60708D5D
P 4500 7850
F 0 "J6" V 4550 7650 50  0000 R CNN
F 1 "SPEED" V 4550 8150 50  0000 R CNN
F 2 "ArduinoPC:PinHeader_2x02_P2.54mm_Vertical_Jumper" H 4500 7850 50  0001 C CNN
F 3 "~" H 4500 7850 50  0001 C CNN
	1    4500 7850
	0    1    1    0   
$EndComp
Wire Wire Line
	4400 7650 4500 7650
$Comp
L power:GND #PWR020
U 1 1 6070E0B6
P 4500 7650
F 0 "#PWR020" H 4500 7400 50  0001 C CNN
F 1 "GND" V 4505 7477 50  0000 C CNN
F 2 "" H 4500 7650 50  0001 C CNN
F 3 "" H 4500 7650 50  0001 C CNN
	1    4500 7650
	-1   0    0    1   
$EndComp
Connection ~ 4500 7650
$Comp
L Switch:SW_Push SW1
U 1 1 6074AA07
P 950 1000
F 0 "SW1" H 950 1285 50  0000 C CNN
F 1 "SW_Push" H 950 1194 50  0000 C CNN
F 2 "Button_Switch_THT:SW_PUSH_6mm" H 950 1200 50  0001 C CNN
F 3 "~" H 950 1200 50  0001 C CNN
	1    950  1000
	1    0    0    -1  
$EndComp
Text GLabel 1150 1000 2    50   Output ~ 0
~RESET
$Comp
L power:GND #PWR022
U 1 1 6074B559
P 750 1000
F 0 "#PWR022" H 750 750 50  0001 C CNN
F 1 "GND" V 755 827 50  0000 C CNN
F 2 "" H 750 1000 50  0001 C CNN
F 3 "" H 750 1000 50  0001 C CNN
	1    750  1000
	1    0    0    -1  
$EndComp
Text GLabel 3800 4100 1    50   Input ~ 0
~RESET
Text GLabel 3800 7450 1    50   Input ~ 0
~RESET
$Comp
L Connector:Conn_01x06_Female J1
U 1 1 60469F0C
P 2000 7950
F 0 "J1" H 2050 8300 50  0000 C CNN
F 1 "UART" H 1850 8300 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 2000 7950 50  0001 C CNN
F 3 "~" H 2000 7950 50  0001 C CNN
	1    2000 7950
	-1   0    0    1   
$EndComp
$Comp
L Connector:Conn_01x06_Female J5
U 1 1 604939FD
P 5900 3800
F 0 "J5" H 5700 3350 50  0000 C CNN
F 1 "VGA" H 5850 3350 50  0000 C CNN
F 2 "Connector_PinSocket_2.54mm:PinSocket_1x06_P2.54mm_Vertical" H 5900 3800 50  0001 C CNN
F 3 "~" H 5900 3800 50  0001 C CNN
	1    5900 3800
	1    0    0    1   
$EndComp
Wire Wire Line
	3800 7450 3800 7650
Connection ~ 3800 7650
Wire Wire Line
	4800 4800 4800 5150
Wire Wire Line
	3800 4250 3800 5150
Wire Wire Line
	3800 4100 3800 4250
Connection ~ 3800 4250
Wire Wire Line
	4000 4250 4000 3500
Wire Wire Line
	4000 3500 5700 3500
Wire Wire Line
	5400 8150 5400 6450
Wire Wire Line
	5400 6450 2350 6450
Wire Wire Line
	2350 6450 2350 4900
Wire Wire Line
	2350 4900 2650 4900
Wire Wire Line
	5300 8150 5300 6550
Wire Wire Line
	5300 6550 2250 6550
Wire Wire Line
	2250 6550 2250 4800
Connection ~ 3000 4800
Wire Wire Line
	3000 4800 3000 3300
Wire Wire Line
	3000 5150 3000 4800
Wire Wire Line
	2250 4800 2650 4800
Wire Wire Line
	2950 4800 3000 4800
$Comp
L Device:R R2
U 1 1 60456838
P 2800 4800
F 0 "R2" V 2700 4750 50  0000 L CNN
F 1 "1k" V 2800 4750 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0207_L6.3mm_D2.5mm_P7.62mm_Horizontal" V 2730 4800 50  0001 C CNN
F 3 "~" H 2800 4800 50  0001 C CNN
	1    2800 4800
	0    1    1    0   
$EndComp
Wire Wire Line
	5200 8150 5200 7300
Wire Wire Line
	5200 7300 6150 7300
Wire Wire Line
	6150 7300 6150 4750
Wire Wire Line
	6150 4750 5300 4750
Wire Wire Line
	5300 4750 5300 5150
Wire Wire Line
	4800 8150 4800 7200
Wire Wire Line
	4800 7200 6050 7200
Wire Wire Line
	6050 7200 6050 4850
Wire Wire Line
	6050 4850 5400 4850
Wire Wire Line
	5400 4850 5400 5150
Wire Wire Line
	4600 5150 4700 5150
Wire Wire Line
	4600 5150 4600 4800
Connection ~ 4600 4800
$EndSCHEMATC
