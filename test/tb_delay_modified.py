import cocotb
from cocotb.clock import Clock

# MUST BE MODIFIED IN NEWER VERSIONS OF 'cocotb'
from cocotb.triggers import Timer, ValueChange

TIME_UNIT = "us"


@cocotb.test()
async def main_test(dut):
    dut._log.info("Applying stimuli...")

    # DUT in reset
    dut.rst_n.value = 1

    # Default indata
    dut.indata.value = 0b00000000

    # Starting clock
    dut._log.info("Starting clock")
    cocotb.start_soon(Clock(dut.mclk, 100, unit=TIME_UNIT).start())

    await Timer(100, unit=TIME_UNIT)
    dut.rst_n.value = 0

    await Timer(100, unit=TIME_UNIT)
    dut.rst_n.value = 1

    await Timer(100, units=TIME_UNIT)
    dut.indata.value = 0b11110000

    await Timer(100, units=TIME_UNIT)
    dut.indata.value = 0b00001111

    # Waiting until dut.outdata changes.
    # MUST BE MODIFIED IN NEWER VERSIONS OF 'cocotb'
    await ValueChange(dut.outdata)

    dut._log.info("Stimuli done")
    await Timer(800, unit=TIME_UNIT)
