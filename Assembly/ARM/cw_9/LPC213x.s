;Vectored Interrupt Controller (VIC)
VICIRQStatus	equ	0xFFFFF000
VICFIQStatus	equ	0xFFFFF004
VICRawIntr	equ	0xFFFFF008
VICIntSelect	equ	0xFFFFF00C
VICIntEnable	equ	0xFFFFF010
VICIntEnClr	equ	0xFFFFF014
VICSoftInt	equ	0xFFFFF018
VICSoftIntClr	equ	0xFFFFF01C
VICProtection	equ	0xFFFFF020
VICVectAddr	equ	0xFFFFF030
VICDefVectAddr	equ	0xFFFFF034
VICVectAddr0	equ	0xFFFFF100
VICVectAddr1	equ	0xFFFFF104
VICVectAddr2	equ	0xFFFFF108
VICVectAddr3	equ	0xFFFFF10C
VICVectAddr4	equ	0xFFFFF110
VICVectAddr5	equ	0xFFFFF114
VICVectAddr6	equ	0xFFFFF118
VICVectAddr7	equ	0xFFFFF11C
VICVectAddr8	equ	0xFFFFF120
VICVectAddr9	equ	0xFFFFF124
VICVectAddr10	equ	0xFFFFF128
VICVectAddr11	equ	0xFFFFF12C
VICVectAddr12	equ	0xFFFFF130
VICVectAddr13	equ	0xFFFFF134
VICVectAddr14	equ	0xFFFFF138
VICVectAddr15	equ	0xFFFFF13C
VICVectCntl0	equ	0xFFFFF200
VICVectCntl1	equ	0xFFFFF204
VICVectCntl2	equ	0xFFFFF208
VICVectCntl3	equ	0xFFFFF20C
VICVectCntl4	equ	0xFFFFF210
VICVectCntl5	equ	0xFFFFF214
VICVectCntl6	equ	0xFFFFF218
VICVectCntl7	equ	0xFFFFF21C
VICVectCntl8	equ	0xFFFFF220
VICVectCntl9	equ	0xFFFFF224
VICVectCntl10	equ	0xFFFFF228
VICVectCntl11	equ	0xFFFFF22C
VICVectCntl12	equ	0xFFFFF230
VICVectCntl13	equ	0xFFFFF234
VICVectCntl14	equ	0xFFFFF238
VICVectCntl15	equ	0xFFFFF23C

;Pin Connect Block
PINSEL0	equ	0xE002C000
PINSEL1	equ	0xE002C004
PINSEL2	equ	0xE002C014

;General Purpose Input/Output (GPIO)
IOPIN0	equ	0xE0028000
IOSET0	equ	0xE0028004
IODIR0	equ	0xE0028008
IOCLR0	equ	0xE002800C
IOPIN1	equ	0xE0028010
IOSET1	equ	0xE0028014
IODIR1	equ	0xE0028018
IOCLR1	equ	0xE002801C
IO0PIN	equ	0xE0028000
IO0SET	equ	0xE0028004
IO0DIR	equ	0xE0028008
IO0CLR	equ	0xE002800C
IO1PIN	equ	0xE0028010
IO1SET	equ	0xE0028014
IO1DIR	equ	0xE0028018
IO1CLR	equ	0xE002801C
FIO0DIR	equ	0x3FFFC000
FIO0MASK	equ	0x3FFFC010
FIO0PIN	equ	0x3FFFC014
FIO0SET	equ	0x3FFFC018
FIO0CLR	equ	0x3FFFC01C
FIO1DIR	equ	0x3FFFC020
FIO1MASK	equ	0x3FFFC030
FIO1PIN	equ	0x3FFFC034
FIO1SET	equ	0x3FFFC038
FIO1CLR	equ	0x3FFFC03C

;Memory Accelerator Module (MAM)
MAMCR	equ	0xE01FC000
MAMTIM	equ	0xE01FC004
MEMMAP	equ	0xE01FC040

;Phase Locked Loop (PLL)
PLLCON	equ	0xE01FC080
PLLCFG	equ	0xE01FC084
PLLSTAT	equ	0xE01FC088
PLLFEED	equ	0xE01FC08C

;VPB Divider
VPBDIV	equ	0xE01FC100

;Power Control
PCON	equ	0xE01FC0C0
PCONP	equ	0xE01FC0C4

;External Interrupts
EXTINT	equ	0xE01FC140
INTWAKE	equ	0xE01FC144
EXTMODE	equ	0xE01FC148
EXTPOLAR	equ	0xE01FC14C

;Reset
RSID	equ	0xE01FC180

;Code Security / Debugging
CSPR	equ	0xE01FC184

;System Control and Status flags
SCS	equ	0xE01FC1A0

;Timer 0
T0IR	equ	0xE0004000
T0TCR	equ	0xE0004004
T0TC	equ	0xE0004008
T0PR	equ	0xE000400C
T0PC	equ	0xE0004010
T0MCR	equ	0xE0004014
T0MR0	equ	0xE0004018
T0MR1	equ	0xE000401C
T0MR2	equ	0xE0004020
T0MR3	equ	0xE0004024
T0CCR	equ	0xE0004028
T0CR0	equ	0xE000402C
T0CR1	equ	0xE0004030
T0CR2	equ	0xE0004034
T0CR3	equ	0xE0004038
T0EMR	equ	0xE000403C
T0CTCR	equ	0xE0004070

;Timer 1
T1IR	equ	0xE0008000
T1TCR	equ	0xE0008004
T1TC	equ	0xE0008008
T1PR	equ	0xE000800C
T1PC	equ	0xE0008010
T1MCR	equ	0xE0008014
T1MR0	equ	0xE0008018
T1MR1	equ	0xE000801C
T1MR2	equ	0xE0008020
T1MR3	equ	0xE0008024
T1CCR	equ	0xE0008028
T1CR0	equ	0xE000802C
T1CR1	equ	0xE0008030
T1CR2	equ	0xE0008034
T1CR3	equ	0xE0008038
T1EMR	equ	0xE000803C
T1CTCR	equ	0xE0008070

;Pulse Width Modulator (PWM)
PWMIR	equ	0xE0014000
PWMTCR	equ	0xE0014004
PWMTC	equ	0xE0014008
PWMPR	equ	0xE001400C
PWMPC	equ	0xE0014010
PWMMCR	equ	0xE0014014
PWMMR0	equ	0xE0014018
PWMMR1	equ	0xE001401C
PWMMR2	equ	0xE0014020
PWMMR3	equ	0xE0014024
PWMMR4	equ	0xE0014040
PWMMR5	equ	0xE0014044
PWMMR6	equ	0xE0014048
PWMPCR	equ	0xE001404C
PWMLER	equ	0xE0014050

;Universal Asynchronous Receiver Transmitter 0 (UART0)
U0RBR	equ	0xE000C000
U0THR	equ	0xE000C000
U0IER	equ	0xE000C004
U0IIR	equ	0xE000C008
U0FCR	equ	0xE000C008
U0LCR	equ	0xE000C00C
U0LSR	equ	0xE000C014
U0SCR	equ	0xE000C01C
U0DLL	equ	0xE000C000
U0DLM	equ	0xE000C004
U0ACR	equ	0xE000C020
U0FDR	equ	0xE000C028
U0TER	equ	0xE000C030

;Universal Asynchronous Receiver Transmitter 1 (UART1)
U1RBR	equ	0xE0010000
U1THR	equ	0xE0010000
U1IER	equ	0xE0010004
U1IIR	equ	0xE0010008
U1FCR	equ	0xE0010008
U1LCR	equ	0xE001000C
U1MCR	equ	0xE0010010
U1LSR	equ	0xE0010014
U1MSR	equ	0xE0010018
U1SCR	equ	0xE001001C
U1DLL	equ	0xE0010000
U1DLM	equ	0xE0010004
U1ACR	equ	0xE0010020
U1FDR	equ	0xE0010028
U1TER	equ	0xE0010030

;I2C Interface 0
I2C0CONSET	equ	0xE001C000
I2C0STAT	equ	0xE001C004
I2C0DAT	equ	0xE001C008
I2C0ADR	equ	0xE001C00C
I2C0SCLH	equ	0xE001C010
I2C0SCLL	equ	0xE001C014
I2C0CONCLR	equ	0xE001C018

;I2C Interface 1
I2C1CONSET	equ	0xE005C000
I2C1STAT	equ	0xE005C004
I2C1DAT	equ	0xE005C008
I2C1ADR	equ	0xE005C00C
I2C1SCLH	equ	0xE005C010
I2C1SCLL	equ	0xE005C014
I2C1CONCLR	equ	0xE005C018

;SPI0 (Serial Peripheral Interface 0)
S0SPCR	equ	0xE0020000
S0SPSR	equ	0xE0020004
S0SPDR	equ	0xE0020008
S0SPCCR	equ	0xE002000C
S0SPINT	equ	0xE002001C

;SSP Controller (SPI1)
SSPCR0	equ	0xE0068000
SSPCR1	equ	0xE0068004
SSPDR	equ	0xE0068008
SSPSR	equ	0xE006800C
SSPCPSR	equ	0xE0068010
SSPIMSC	equ	0xE0068014
SSPRIS	equ	0xE0068018
SSPMIS	equ	0xE006801C
SSPICR	equ	0xE0068020

;Real Time Clock
ILR	equ	0xE0024000
CTC	equ	0xE0024004
CCR	equ	0xE0024008
CIIR	equ	0xE002400C
AMR	equ	0xE0024010
CTIME0	equ	0xE0024014
CTIME1	equ	0xE0024018
CTIME2	equ	0xE002401C
SEC	equ	0xE0024020
MIN	equ	0xE0024024
HOUR	equ	0xE0024028
DOM	equ	0xE002402C
DOW	equ	0xE0024030
DOY		equ	0xE0024034
MONTH	equ	0xE0024038
YEAR	equ	0xE002403C
ALSEC	equ	0xE0024060
ALMIN	equ	0xE0024064
ALHOUR	equ	0xE0024068
ALDOM	equ	0xE002406C
ALDOW	equ	0xE0024070
ALDOY	equ	0xE0024074
ALMON	equ	0xE0024078
ALYEAR	equ	0xE002407C
PREINT	equ	0xE0024080
PREFRAC	equ	0xE0024084

;A/D Converter 0 (AD0)
AD0CR	equ	0xE0034000
AD0DR	equ	0xE0034004
AD0GDR	equ	0xE0034004
AD0STAT	equ	0xE0034030
AD0INTEN	equ	0xE003400C
AD0DR0	equ	0xE0034010
AD0DR1	equ	0xE0034014
AD0DR2	equ	0xE0034018
AD0DR3	equ	0xE003401C
AD0DR4	equ	0xE0034020
AD0DR5	equ	0xE0034024
AD0DR6	equ	0xE0034028
AD0DR7	equ	0xE003402C

;A/D Converter 1 (AD1)
AD1CR	equ	0xE0060000
AD1DR	equ	0xE0060004
AD1GDR	equ	0xE0060004
AD1STAT	equ	0xE0060030
AD1INTEN	equ	0xE006000C
AD1DR0	equ	0xE0060010
AD1DR1	equ	0xE0060014
AD1DR2	equ	0xE0060018
AD1DR3	equ	0xE006001C
AD1DR4	equ	0xE0060020
AD1DR5	equ	0xE0060024
AD1DR6	equ	0xE0060028
AD1DR7	equ	0xE006002C

;A/D Converter Global
ADGSR	equ	0xE0034008

;D/A Converter
DACR	equ	0xE006C000

;Watchdog
WDMOD	equ	0xE0000000
WDTC	equ	0xE0000004
WDFEED	equ	0xE0000008
WDTV	equ	0xE000000C

		END