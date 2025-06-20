DIR=/usr/share/openocd/scripts

all: main.hex

main.o: main.s
	arm-none-eabi-as -g -mcpu=cortex-m4 -mthumb main.s -o main.o

gpio.o: gpio.s
	arm-none-eabi-as -g -mcpu=cortex-m4 -mthumb gpio.s -o gpio.o

main.elf: main.o gpio.o main.ld
	arm-none-eabi-ld main.o gpio.o -T ./main.ld -o main.elf

main.hex: main.elf
	arm-none-eabi-objcopy -O ihex main.elf main.hex

clean:
	rm *.hex
	rm *.o
	rm *.elf

flash: main.hex
	'C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI.exe' -c port=swd -ob rdp=0xAA
	'C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI.exe' -c port=SWD -e all
	'C:/Program Files/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin/STM32_Programmer_CLI.exe' -c port=SWD -w main.hex 0x08000000

debug:
	"C:\ST\STM32CubeIDE_1.15.1\STM32CubeIDE\plugins\com.st.stm32cube.ide.mcu.externaltools.stlink-gdb-server.win32_2.1.300.202403291623\tools\bin\ST-LINK_gdbserver.exe" -p 61611 -cp "C:\ST\STM32CubeIDE_1.15.1\STM32CubeIDE\plugins\com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.win32_2.1.201.202404072231\tools\bin" --frequency 8000 --swd -i 002A00233331511134333834 --shared



disas: main.elf
	arm-none-eabi-objdump -s -d main.elf
